/*
  This is sketch for rerief protter prototype. It use the Adafruit assembled Motor Shield v2.
  dafruit Motor Shield v2 ---->  http://www.adafruit.com/products/1438
*/


#include <Wire.h>
#include <Adafruit_MotorShield.h>
#include "utility/Adafruit_MS_PWMServoDriver.h"

#include "Keyboard.h"

// Z STEPPER MOTOR SPEED CONTROL
int APHASE = 4;
int AENBL = 5;
int BPHASE = 6;
int BENBL = 7;
int state = 1;
char inChar = 'r';


int x_pin = 8; //xイニシャライズボタンのピン
int y_pin = 9; //yイニシャライズボタンのピン




// Create the motor shield object with the default I2C address
Adafruit_MotorShield AFMS = Adafruit_MotorShield();
// Or, create it with a different I2C address (say for stacking)
// Adafruit_MotorShield AFMS = Adafruit_MotorShield(0x61);

// Connect a stepper motor with 200 steps per revolution (1.8 degree)
// to motor port #2 (M3 and M4)
Adafruit_StepperMotor *myMotorX = AFMS.getStepper(200, 2);
Adafruit_StepperMotor *myMotorY = AFMS.getStepper(200, 1);


//@@あとでデータの読み込み処理を書く


//データ入力
int dataX[] = {0,13,13,13,12,12,11,12,12,11,10,11,12,11,10,10,4,3,7,10,9,5,9,8,7,7,6,6,5,6,6,4,3,4,3,2,5,5,4,4,2,1,1,2,3,3,2}; //はじめは0から始める。0番地は飛ばし1番地からが目的地になる。（i）
int dataY[] = {0, 1, 2, 3, 3, 2, 3, 4, 6, 5, 5, 6, 7, 7, 7, 3, 8, 8, 4, 6, 5, 8, 6, 6, 6, 5, 4, 5, 4, 6, 7, 3, 3, 4, 4, 4, 6, 5, 5, 6, 5, 5, 6, 6, 5, 6, 7}; //はじめは0から始める。0番地は飛ばし1番地からが目的地になる。（i）
float dataZ[] = {0, 2.1}; //はじめは0から始める。0番地は飛ばし1番地からが目的地になる。（i）


// XYモーターののスピード
int step_perpin = 400; //一コマの移動量。ステップ数。400で16mm動く。


void setup() {
  Serial.begin(9600);           // set up Serial library at 9600 bps

  // for Z stepper motor
  pinMode(APHASE, OUTPUT);
  pinMode(AENBL, OUTPUT);
  pinMode(BPHASE, OUTPUT);
  pinMode(BENBL, OUTPUT);
  digitalWrite(AENBL, HIGH);
  digitalWrite(BENBL, HIGH);

  // for XY stepper motor
  AFMS.begin();  // create with the default frequency 1.6KHz
  //AFMS.begin(1000);  // OR with a different frequency, say 1KHz


  myMotorX->setSpeed(20);  // 20 rpm Xmotor
  myMotorY->setSpeed(20);  // 20 rpm Ymotor


  pinMode(x_pin, INPUT);
  pinMode(y_pin, INPUT);


}

//　Z軸モーターのパルス間の時間。
void DELAY_WAIT(void) {
  for (int i = 0; i < (1000) ; i++)
    delayMicroseconds(100);
}


void loop() {


  //キーボードから入力を判定しmove_motorへ
  if (Serial.available() > 0) {
    // read incoming serial data:
    char inChar = Serial.read();

    //ｒが押されたら動く
    switch (inChar) {
      case 'r':
        move_motor();
        break;

      // iが押されたら初期位置に動く　*割込みはしない*
      case 'i':
        initialize();
        break;
    }
  }
}


// 初期位置設定。モーターを動かして、スイッチに当たったらとめる。
void initialize() {
  int stateX = 0 ; //イニシャライズボタンが押されているかを格納する変数
  int stateY = 0 ; //

  while (stateX == 0 ) {  //ボタンが押されるまでXモーターを動かす
    myMotorX->step(20, FORWARD, SINGLE);
    stateX = digitalRead(x_pin);  // ピンよりデータ取得
    Serial.print(stateX);
  }

  while (stateY == 0) {
    myMotorY->step(20, FORWARD, SINGLE);
    stateY = digitalRead(y_pin);  // ピンよりデータ取得
    Serial.print(stateX);
  }
  void loop(); //終わったらループに戻る

}


void move_motor() {

  // X関連の変数

  int locationX = 0;// 今いる位置の変数
  int destinationX = 0;//次に動くピンの位置
  int differenceX = 0;// 今いる位置と目的地の差分を入れる用の変数
  int dataX_size = sizeof(dataX) / sizeof(dataX[0]);//配列のサイズを取得。参考http://garretlab.web.fc2.com/arduino/reverse_lookup/index.html

  // Y関連の変数

  int locationY = 0;// 今いる位置の変数
  int destinationY = 0;//次に動くピンの位置
  int differenceY = 0;// 今いる位置と目的地の差分を入れる用の変数
  int dataY_size = sizeof(dataY) / sizeof(dataY[0]);//配列のサイズを取得。参考http://garretlab.web.fc2.com/arduino/reverse_lookup/index.html

  //Z関連の変数
  float push_distance = 0; //Zプッシュのながさ

  //データがおかしい時にはエラーを返して動かない
  if (dataY_size != dataX_size) {
    Serial.println("error data");
    void loop();
  }

  //X軸を動かす
  for (int i = 0; i < dataX_size - 1 ; i = i + 1) { //dataXの中に入っているデータの個数-1回動かす（XとYは同じ数を前提
    destinationX = dataX[i + 1];
    locationX = dataX[i];
    differenceX = destinationX - locationX;

    //移動方向が正ならBACKWORD方向に、負ならFORWARD方向に進む
    if ( differenceX >= 0 ) {
      myMotorX->step(step_perpin * differenceX, BACKWARD, SINGLE);
    } else {
      myMotorX->step(-1 * differenceX * step_perpin, FORWARD, SINGLE);
    }

    //動くのを待つ処理を入れる
    //delay(500);

    //Y軸を動かす
    destinationY = dataY[i + 1];
    locationY = dataY[i];
    differenceY = destinationY - locationY;

    //移動方向が正ならBACKWORD方向に、負ならFORWARD方向に進む
    if ( differenceY >= 0 ) {
      myMotorY->step(step_perpin * differenceY, BACKWARD, SINGLE);
    } else {
      myMotorY->step( -1 * differenceY * step_perpin, FORWARD, SINGLE);
    }

    //動くのを待つ処理を入れる
    // delay(500);


    //Z軸モーターを動かしてラックを下に下げる

    push_distance = dataZ[i];
    for (int k = 0; k < (push_distance); k ++) {
      digitalWrite(APHASE, HIGH);
      DELAY_WAIT();
      digitalWrite(BPHASE, HIGH);
      DELAY_WAIT();
      digitalWrite(APHASE, LOW);
      DELAY_WAIT();
      digitalWrite(BPHASE, LOW);
      DELAY_WAIT();
    }

    //Z軸モーターを動かしてラックを上にあげる
    for (int k = 0; k < (push_distance); k ++) {
      digitalWrite(BPHASE, HIGH);
      DELAY_WAIT();
      digitalWrite(APHASE, HIGH);
      DELAY_WAIT();
      digitalWrite(BPHASE, LOW);
      DELAY_WAIT();
      digitalWrite(APHASE, LOW);
      DELAY_WAIT();
    }

    //     delay(500);

    //動くのを待つ処理を入れる

    //test
    Serial.print( "i : " );
    Serial.println(  i );
    Serial.print( "dataX_size : " );
    Serial.print( dataX_size );
    Serial.print( "differenceX : " );
    Serial.print( differenceX );
    Serial.print( ": differenceY : " );
    Serial.println( differenceY );
    Serial.print( "location: " );
    Serial.print( locationX );
    Serial.print( " , " );
    Serial.println(locationY );

  }

  //データの最後まで終わったら初期位置に戻して待機ループに戻る

  myMotorX->step(step_perpin * locationX, FORWARD, SINGLE);
  myMotorY->step(step_perpin * locationY, FORWARD, SINGLE);

  void loop();
}
