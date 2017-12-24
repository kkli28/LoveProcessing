
//==== constant ====
final int SCREEN_WIDTH=960;
final int SCREEN_HEIGHT=960;
final int MAX_HOLE_COUNT=20;

//==== variable ====
ArrayList<Hole> holes=new ArrayList<Hole>();
boolean enableAddHole=true;
int c=#FFFFFF;

//addHole
void addHole(){
  if(holes.size()>MAX_HOLE_COUNT) return;
  holes.add(new Hole(new Point(mouseX, mouseY)));
}

//clearScreen
void clearScreen(){
  noStroke();
  fill(255);
  rect(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
}

//mousePressed
void mousePressed(){
  addHole();
  enableAddHole=false;
}

//mouseReleased
void mouseReleased(){
  enableAddHole=true;
}

//setup
void setup(){
  size(960, 960);
  background(255);
}

//draw
void draw(){
  clearScreen();
  for(Hole h: holes) h.update();
}