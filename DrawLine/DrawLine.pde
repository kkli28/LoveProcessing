//======== constant ========
final int WIDTH=720;
final int HEIGHT=720;
final int MAX_WEIGHT=8;
final int LINE_COUNT=24;

//======== color ========
final int LINE_COLOR=#00F51A;

//======== control ========
int lineWeight=1;

//======== config ========

//======== variables ========
ArrayList<Line> lines=new ArrayList<Line>();

//initLines
void initLines(){
  lines.clear();
  for(int i=0;i<LINE_COUNT;++i){
    float x1=random(WIDTH-1);
    float y1=random(HEIGHT-1);
    float x2=random(WIDTH-1);
    float y2=random(HEIGHT-1);
    lines.add(new Line(new Point(x1, y1), new Point(x2, y2), lineWeight));
  }
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

//setup
void setup(){
  size(720,720);
  background(255);
}

//draw
void draw(){
  noStroke();
  fill(255);
  rect(0, 0, WIDTH, HEIGHT);
  initLines();
  for(Line l: lines) l.draw(LINE_COLOR);
  
  textSize(14);
  fill(LINE_COLOR);
  text("line weight: "+ new Integer(lineWeight).toString(), 10, HEIGHT-20);
}