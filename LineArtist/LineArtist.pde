
//==== constant ====
final int SCREEN_WIDTH=720;
final int SCREEN_HEIGHT=720;
final Point SCREEN_CENTER=new Point(SCREEN_WIDTH/2, SCREEN_HEIGHT/2);

final float ELEMENT_R_MAX=24;
final float ELEMENT_R_MIN=4;
final int ELEMENT_COLOR=#F00000;
final int SIDE_COUNT_MAX=64;

final int CIRCLE_GENERATE_RATE=6;
final float DELTA_RADIAN=0.2;

//==== variable ====
boolean clicked=false;
Side side=new Side();

//==== function ====

void mousePressed(){
    clicked=true;
}

void mouseReleased(){
    clicked=false;
}

void clearScreen(){
    fill(255);
    noStroke();
    rect(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
}

void keyPressed(){
    side.clear();
}

void setup(){
    size(720, 720);
    background(255);
}

void draw(){
    if(clicked){
        if(frameCount%CIRCLE_GENERATE_RATE==0) side.addElement(new Point(mouseX, mouseY));
        println("add element");
    }
    else{
        side.show();
    }
}