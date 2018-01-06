//======== constant ========

//screen
final int SCREEN_WIDTH=720;
final int SCREEN_HEIGHT=720;

//plane
final int PLANE_COLOR=#FC0000;
final int PLANE_LINE_COLOR=#00FC38;
final float PLANE_R=24;
final float PLANE_LINE_LENGTH=24;
final int PLANE_LINE_WEIGHT=2;

//======== variable ========
Plane plane=new Plane(new Point(SCREEN_WIDTH/2, 0), 0, 0);

//======== function ========

//clearScreen
void clearScreen(){
    fill(255);
    noStroke();
    rect(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
}

//setup
void setup(){
    size(720, 720);
    background(255);
}

//draw
void draw(){
    clearScreen();
    plane.update();
}