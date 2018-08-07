
//==== constant ====

final int SCREEN_WIDTH=720;
final int SCREEN_HEIGHT=720;

final float DELTA_RADIAN=0.12;
final int DELTA_LENGTH=12;
final float POINT_R=8;
final float DEFAULT_RADIAN=PI/2;
final int LINE_COLOR=#03FA5B;
final int POINT_COLOR=#FA0303;

final Point DEFAULT_POINT=new Point(SCREEN_WIDTH/2, SCREEN_HEIGHT/2);

//==== variable ====
C c=new C();//DEFAULT_POINT, new Point(1, 1));

//==== function ====

void clearScreen(){
    noStroke();
    fill(255);
    rect(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
}

void setup(){
    size(720, 720);
    background(255);
    c=new C(DEFAULT_POINT, new Point(1, 1));
}

void draw(){
    clearScreen();
   // if(mousePressed){
       c=new C(DEFAULT_POINT, new Point(mouseX, mouseY));
   // }
    println(c.points.size());
    c.draw();
}