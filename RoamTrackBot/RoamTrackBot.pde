
//==== constant ====
final int SCREEN_WIDTH=960;
final int SCREEN_HEIGHT=960;
final int PLANE_COLOR=#DE0202;
final float PLANE_ARRIVE_TIME=60; //frame
final float PLANE_DISTANCE_DEVIATION=2; //pixel
final float PLANE_WIDTH=24;
final float PLANE_VELOCITY=48;

final float SURROUND_LENGTH_MIN=4;
final float SURROUND_LENGTH_MAX=24;

final int BOT_COLOR=#020BDE;
final float BOT_WIDTH=12;
final float BOT_ARRIVE_TIME=30;
final float BOT_VELOCITY_DEVIATION=0.1;
final float BOT_TRACK_LENGTH=SURROUND_LENGTH_MAX*4;

//==== variable ====

Plane plane=new Plane(new Point(SCREEN_WIDTH/2, SCREEN_HEIGHT/2), PLANE_VELOCITY);

//==== function ====

void clearScreen(){
    fill(255);
    noStroke();
    rect(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
}

void setup(){
    size(960, 960);
    background(255);
}

void draw(){
    clearScreen();
    plane.track(new Point(mouseX, mouseY));
    plane.update();
}