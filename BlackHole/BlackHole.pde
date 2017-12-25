
//==== constant ====
final int SCREEN_WIDTH=960;
final int SCREEN_HEIGHT=960;
final int MAX_HOLE_COUNT=20;

//==== Hole ====
final int HOLE_ELLIPSE_COLOR=#0057FF;
final int HOLE_ELLIPSE_COUNT=16;
final int HOLE_ELLIPSE_MAX_R=240;
final int HOLE_ELLIPSE_MIN_R=4;
final int HOLE_UPDATE_CYCLE=1;
final int HOLE_DELTA_R=HOLE_ELLIPSE_MAX_R/HOLE_ELLIPSE_COUNT;
final int MAX_R=0xff;
final int MIN_R=0x00;
final int MAX_G=0xff;
final int MIN_G=0x80;
final int DELTA_R=MAX_R/HOLE_ELLIPSE_COUNT;
final int DELTA_G=MAX_G/HOLE_ELLIPSE_COUNT;
final float HOLE_ELLIPSE_DELTA_R_MAX=4.0;
final float HOLE_ELLIPSE_DELTA_R_MIN=0.2;

//==== variables ====
ArrayList<Hole> holes=new ArrayList<Hole>();
boolean enableAddHole=true;
float hole_ellipse_delta_r=1;

//addHole
void addHole(){
  if(holes.size()>MAX_HOLE_COUNT) return;
  holes.add(new Hole(new Point(mouseX, mouseY)));
}

void clearScreen(){
  noStroke();
  fill(255);
  rect(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
  noFill();
}

//mouseWheel
void mouseWheel(MouseEvent event) {
  float e = event.getCount();
  if(e>0) hole_ellipse_delta_r-=0.2;
  else hole_ellipse_delta_r+=0.2;
  if(hole_ellipse_delta_r<HOLE_ELLIPSE_DELTA_R_MIN) hole_ellipse_delta_r=HOLE_ELLIPSE_DELTA_R_MIN;
  else if(hole_ellipse_delta_r>HOLE_ELLIPSE_DELTA_R_MAX) hole_ellipse_delta_r=HOLE_ELLIPSE_DELTA_R_MAX;
}

//mousePressed
void mousePressed(){
  if(enableAddHole) addHole();
  enableAddHole=false;
}

//mouseReleased
void mouseReleased(){
  enableAddHole=true;
}

//showText
void showText(){
  textSize(24);
  stroke(0);
  fill(0);
  text(hole_ellipse_delta_r, 20, 20);
}

//setup
void setup(){
  size(960, 960);
  background(255);
}

//draw
void draw(){
  clearScreen();
  showText();
  for(Hole h: holes) h.update();
}