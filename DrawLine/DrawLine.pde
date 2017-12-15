//======== constant ========
final int WIDTH=720;
final int HEIGHT=720;
final int MAX_WEIGHT=8;
final int LINE_COUNT=24;

//======== color ========
final int LINE_COLOR=#00F51A;

//======== control ========
int lineWeight=1;
boolean stopDraw=false;

//======== config ========

//======== variables ========
ArrayList<Line> lines=new ArrayList<Line>();

//initLines
void initLines(){
  lines.clear();
  for(int i=0;i<LINE_COUNT;++i){
    double x1=random(WIDTH-1);
    double y1=random(HEIGHT-1);
    double x2=random(WIDTH-1);
    double y2=random(HEIGHT-1);
    lines.add(new Line(new Point(x1, y1), new Point(x2, y2), lineWeight));
  }
}

//setup
void setup(){
  size(720,720);
  background(255);
  
  initLines();
}

//draw
void draw(){
  clearScreen();
  
  stopDraw=false;
  loadPixels();
  for(Line l: lines) if(!stopDraw) l.draw(LINE_COLOR); else break;
  updatePixels();
  
  textSize(14);
  fill(LINE_COLOR);
  text("line weight: "+ new Integer(lineWeight).toString(), 10, HEIGHT-20);
  text("k: "+new Double(lines.get(0).k).toString(), 120, HEIGHT-20);
  
  initLines();
  //noLoop();
}

//mousePressed
void mousePressed(){
 //loop(); 
}

//clearScreen
void clearScreen(){
  noStroke();
  fill(255);
  rect(0,0,WIDTH, HEIGHT);
}

//mouseWheel
void mouseWheel(MouseEvent e){
  lineWeight-=e.getCount();
  lineWeight=min(MAX_WEIGHT, max(lineWeight, 1));
}