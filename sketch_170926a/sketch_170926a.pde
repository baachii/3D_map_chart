/*/////////////////////////////
 [polygon_map_graph]
 @author : daijiy
 coding  : UTF-8
 ・Processingのコード
 ・それぞれのボタンを配置し、ボタンをクリックすると、コンソール上にボタンに対応したコードが出力される
 //////////////////////////////*/

PImage img1;
PImage img2;
PImage img3;
int stat = 0; //画面状態を表す状態変数
int x1 = 0, y1;

void setup()
{
  size(800, 600);
  img1 = loadImage("apple-off.jpg");
  img2 = loadImage("mikan-off.jpg");
  img3 = loadImage("return.jpg");
}

void draw()
{
  background(200);
  switch(stat)
  {
  case 0: //状態変数が0(つまり画面がTitle)のときの動作
    fill(0);
    text("立体地図グラフ　初期画面　種類選択", 50, 50, 200, 50);
    text("種類：りんご", 50, 180, 150, 30);
    image(img1, 50, 150);
    image(img2, 200, 150);
    break;
  case 1://ゲーム画面1(りんご)のときの動作
    fill(255, 0, 0);
    text("立体地図グラフ　りんご選択画面", 50, 50, 200, 30);
    text("政府統計ポータルサイトより都道府県単位の平成26年りんご収穫量を取得。収穫量によって、都道府県が上に浮き上がるようになっている。上位5位までの実データとグラフを用意した。やはり、りんごといえば青森県が2位を突き放して堂々の1位となっている。ちなみに、一日に一個のりんごは医者を遠ざける（イギリス）ということわざがありますが、青森県の人は医者がいらないほど健康なのでしょうか・・・", 200, 150, 400, 400);
    image(img2, 50, 150);
    image(img1, 200, 300);
    image(img3, 50, 450);
    x1 %= width;
    break;
  case 2://ゲーム画面2(みかん)のときの動作
    fill(0, 0, 255);
    text("立体地図グラフ　みかん詳細画面", 50, 50, 200, 30);
    text("政府統計ポータルサイトより都道府県単位の平成26年みかん収穫量を取得。収穫量によって、都道府県が上に浮き上がるようになっている。上位5位までの実データとグラフを用意した。みかんといえば、蛇口からみかんジュースが出ると言われる愛媛県が有名ですが、和歌山県・愛媛県とならんで静岡県の3強が突出しています。ちなみに、みかんを食べ過ぎると手が黄色くなると言われますが、じつは柑皮症という立派な症状となります。", 200, 150, 400, 400);
    image(img1, 50, 150);
    image(img2, 200, 300);
    image(img3, 50, 450);
    if (y1<0)
    {
      y1 = height;
    }
    break;
  }
}

void mousePressed()
{
  switch(stat)
  {
  case 0:
    //"ボタン"が必要なら適宜範囲を決めて画を描いて、ここで位置の検査をまじめにやる。今回は単に左右半分に分けただけ
    if (mouseX>=50 && mouseX<=150 && mouseY>=150 && mouseY<=250)
    {
      stat = 1;
      println("0");
      img1 = loadImage("apple-data.jpg");
      img2 = loadImage("apple-off.jpg");
    }
    if (mouseX>=200 && mouseX<=300 && mouseY>=150 && mouseY<=250)
    {
      stat = 2;
      println("1");
      img1 = loadImage("mikan-off.jpg");
      img2 = loadImage("mikan-data.jpg");
    }
    break;
    //if(mouseX<width/2)
    //{ 
    //  //左半分がクリックされたら
    //  x1=0; //次の状態で必要な変数の初期化
    //  stat=1;//ゲーム画面1状態に移る
    //}else{
    //  //右半分がクリックされたら
    //  y1=height;
    //  stat=2;//ゲーム画面2状態に移る
    //}
    //break;
  case 1://ゲーム画面1(りんご)のときの動作
    if (mouseX>=50 && mouseX<=150 && mouseY>=450 && mouseY<=550)
    {
      stat = 0;
      img1 = loadImage("apple-off.jpg");
      img2 = loadImage("mikan-off.jpg");
      img3 = loadImage("return.jpg");
    }
    break;
    ////位置の検査はしない。つまり画面のどこでもクリックされたら。
    //stat=0; //タイトル画面に移動する
    //break;
  case 2://ゲーム画面2(みかん)のときの動作
    if (mouseX>=50 && mouseX<=150 && mouseY>=450 && mouseY<=550)
    {
      stat = 0;
      img1 = loadImage("apple-off.jpg");
      img2 = loadImage("mikan-off.jpg");
    }
    break;
  }
}