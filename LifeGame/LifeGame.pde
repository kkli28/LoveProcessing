final int MAP_WIDTH = 240;
final int MAP_HEIGHT = 135;
final float RECT_WIDTH = 8;
final float RECT_HEIGHT = 8;
final int GENERATION_PER_SECOND = 60;

Map map = new Map();
boolean canReset = true;

void reset(){
  map.setRandomValue();
}

void setup(){
  //size(1024, 1024);
  fullScreen();
  background(255);
  reset();
  frameRate(GENERATION_PER_SECOND);
}

void mouseReleased()
{
  canReset = true;
}

void draw(){
  map.show();
  if(mousePressed){
    reset();
    canReset = false;
  }
}