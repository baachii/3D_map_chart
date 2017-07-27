//画面中央に四角い枠を書く
//size(800, 600);
//colorMode(RGB,256);
//fill(0,200,200);
//rectMode(CENTER);
//rect(width/2, height/2, 200, 100);

//コンソールに文字と数字を出力する
//println(9999); 
//println("テスト");

//マウスクリックしたら四角の色を変える
void setup(){
  size(800, 600);
  colorMode(RGB,256);
  fill(0,158,150);
  rectMode(CENTER);
  rect(width/2, height/2, 200, 100);
}

void draw() {
  if (mousePressed == true){
  fill(228,24,132);
  rectMode(CENTER);
  rect(width/2, height/2, 200, 100);
  }
}

void mouseReleased() {
  fill(0,158,150);
  rectMode(CENTER);
  rect(width/2, height/2, 200, 100);
}