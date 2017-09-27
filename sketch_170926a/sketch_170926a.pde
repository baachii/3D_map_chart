/*/////////////////////////////
 [3D_map_chart]
 @author : daijiy
 coding  : UTF-8
 ・Processingのコード
 ・初期画面、各詳細画面を行き来する
 ・初期画面にて詳細画面への遷移ボタンをクリックすると、コンソール上にボタンに対応したコードが出力される
 //////////////////////////////*/

PImage img1;
PImage img2;
PImage img3;
int stat = 0; //画面状態を表す状態変数

void setup()
{
  size(800, 600);
  //初期画像を設定する
  img1 = loadImage("apple-off.jpg");
  img2 = loadImage("mikan-off.jpg");
  img3 = loadImage("return.jpg");
}

void draw()
{
  background(200);//初期背景色設定
  switch(stat)
  {
  case 0://状態変数が0(初期画面)のときの動作
    fill(0);//文字色の設定
    text("立体地図グラフ　初期画面　種類選択", 50, 50, 200, 50);
    text("好きな果物を選んでね♪", 70, 100, 150, 30);
    image(img1, 50, 150);
    image(img2, 200, 150);
    break;
  case 1://詳細画面1(りんご)のときの動作
    fill(255, 0, 0);//文字色の設定
    text("立体地図グラフ　りんご選択画面", 50, 50, 200, 30);
    text("政府統計ポータルサイトより都道府県単位の平成26年りんご収穫量を取得。\n収穫量によって、都道府県が上に浮き上がるようになっている。上位5位までの実データとグラフを用意した。やはり、りんごといえば青森県が2位を突き放して堂々の1位となっている。ちなみに、一日に一個のりんごは医者を遠ざける（イギリス）ということわざがありますが、青森県の人は医者がいらないほど健康なのでしょうか・・・", 200, 150, 400, 400);
    image(img1, 200, 300);
    image(img2, 50, 150);
    image(img3, 50, 450);
    text("出典：政府統計ポータルサイト http://www.e-stat.go.jp/SG1/estat/List.do?lid=000001139363", 620, 550, 200, 50);
    break;
  case 2://詳細画面2(みかん)のときの動作
    fill(243, 152, 0);//文字色の設定
    text("立体地図グラフ　みかん詳細画面", 50, 50, 200, 30);
    text("政府統計ポータルサイトより都道府県単位の平成26年みかん収穫量を取得。\n収穫量によって、都道府県が上に浮き上がるようになっている。上位5位までの実データとグラフを用意した。みかんといえば、蛇口からみかんジュースが出ると言われる愛媛県が有名ですが、和歌山県・愛媛県とならんで静岡県の3強が突出しています。ちなみに、みかんを食べ過ぎると手が黄色くなると言われますが、じつは柑皮症という立派な症状となります。", 200, 150, 400, 400);
    image(img1, 200, 300);
    image(img2, 50, 150);
    image(img3, 50, 450);
    text("出典：政府統計ポータルサイト http://www.e-stat.go.jp/SG1/estat/List.do?lid=000001139363", 620, 550, 200, 50);
    break;
  }//switch(stat)
}//void draw()

void mousePressed()
{
  switch(stat)
  {
  case 0://初期画面のときのクリック制御
    //りんごの画像をクリックした時
    if(mouseX>=50 && mouseX<=150 && mouseY>=150 && mouseY<=250)
    {
      stat = 1;
      println("0");//コンソール出力を指定
      img1 = loadImage("apple-data.jpg");
      img2 = loadImage("apple-off.jpg");
    }
    //みかんの画像をクリックした時
    if(mouseX>=200 && mouseX<=300 && mouseY>=150 && mouseY<=250)
    {
      stat = 2;
      println("1");//コンソール出力を指定
      img1 = loadImage("mikan-data.jpg");
      img2 = loadImage("mikan-off.jpg");
    }
    break;
  case 1://詳細画面1(りんご)のときのクリック制御
    //戻る画像をクリックした時
    if (mouseX>=50 && mouseX<=150 && mouseY>=450 && mouseY<=550)
    {
      stat = 0;
      img1 = loadImage("apple-off.jpg");
      img2 = loadImage("mikan-off.jpg");
    }
    break;
  case 2://詳細画面2(みかん)のときのクリック制御
    //戻る画像をクリックした時
    if (mouseX>=50 && mouseX<=150 && mouseY>=450 && mouseY<=550)
    {
      stat = 0;
      img1 = loadImage("apple-off.jpg");
      img2 = loadImage("mikan-off.jpg");
    }
    break;
  }//switch(stat)
}//void mousePressed()
