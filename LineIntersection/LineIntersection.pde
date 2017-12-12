
// ==== constant ====
final int SCREEN_WIDTH=640;
final int SCREEN_HEIGHT=640;
final int IPR=8;
final int LINE_COUNT=32;
final int MOUSE_LINE_COUNT=8;
final int MOUSE_LINE_LENGTH=400;

//color
final int LINE_COLOR=200;
final int MOUSE_LINE_COLOR=#10FF00;
final int POINT_COLOR=#FF0D00;

ArrayList<Line> lines=new ArrayList<Line>();
ArrayList<Point> points=new ArrayList<Point>();
Point p1=new Point(0,0);
Point p2=new Point(0,0);
ArrayList<Line> mouseLines=new ArrayList<Line>();
boolean needRefresh=true;

void initLines(){
  lines.clear();
  for(int i=0;i<LINE_COUNT;++i){
    float x1=random(SCREEN_WIDTH);
    float y1=random(SCREEN_HEIGHT);
    float x2=random(SCREEN_WIDTH);
    float y2=random(SCREEN_HEIGHT);
    lines.add(new Line(x1, y1, x2, y2));
  }
}

void initMouseLines(float celta, float length){
  mouseLines.clear();
  float deltaCelta=2*PI/MOUSE_LINE_COUNT;
  float begX=SCREEN_WIDTH/2;
  float begY=SCREEN_HEIGHT/2;
  for(int i=0;i<MOUSE_LINE_COUNT;++i){
    celta+=deltaCelta;
    float endX=begX+cos(celta)*length;
    float endY=begY+sin(celta)*length;
    mouseLines.add(new Line(begX, begY, endX, endY));
  }
}

boolean pointInLine(Line l, Point p){
  if(l.p1.x<l.p2.x){
    if(p.x<l.p1.x || p.x>l.p2.x) return false;
  }
  else{
    if(p.x<l.p2.x || p.x>l.p1.x) return false;
  }
  
  if(l.p1.y<l.p2.y){
    if(p.y<l.p1.y || p.y>l.p2.y) return false;
  }
  else{
    if(p.y<l.p2.y || p.y>l.p1.y) return false;
  }
  
  return true;
}

Point __calcIntersection_aux(Line line1, Line line2){
  float a1=line1.p1.y-line1.p2.y;
  float b1=line1.p2.x-line1.p1.x;
  float c1=line1.p1.x*line1.p2.y-line1.p2.x*line1.p1.y;
  float a2=line2.p1.y-line2.p2.y;
  float b2=line2.p2.x-line2.p1.x;
  float c2=line2.p1.x*line2.p2.y-line2.p2.x*line2.p1.y;
  float D=a1*b2-a2*b1;
  float x=(b1*c2-b2*c1)/D;
  float y=(a2*c1-a1*c2)/D;
  return new Point(x, y);
}

void processIntersection(){
  points.clear();
  int size1=lines.size();
  int size2=mouseLines.size();
  for(int i=0;i<size1;++i){
    for(int j=0;j<size2;++j){
       Point p=__calcIntersection_aux(lines.get(i), mouseLines.get(j));
       if(pointInLine(lines.get(i), p) && pointInLine(mouseLines.get(j), p)){
         points.add(p);
       }
    }
  }
}

void drawLines(){
  stroke(LINE_COLOR);
  for(Line l: lines) line(l.p1.x, l.p1.y, l.p2.x, l.p2.y);
  stroke(MOUSE_LINE_COLOR);
  for(Line ml: mouseLines) line(ml.p1.x, ml.p1.y, ml.p2.x, ml.p2.y);
}

void drawIntersectionPoints(){
  stroke(POINT_COLOR);
  fill(255);
  for(Point p: points) ellipse(p.x, p.y, IPR, IPR);
}

void refresh(){
  noStroke();
  fill(255);
  rect(0,0,SCREEN_WIDTH,SCREEN_HEIGHT);
  
  processIntersection();
  drawLines();
  drawIntersectionPoints();
}

void mouseMoved(){
  float deltaX=mouseX-SCREEN_WIDTH/2;
  float deltaY=mouseY-SCREEN_HEIGHT/2;
  float celta=atan(deltaY/deltaX);
  float length=sqrt(deltaX*deltaX + deltaY*deltaY);
  initMouseLines(celta, length);
  needRefresh=true;
}

void keyPressed(){
  if(key=='s'){
    initLines();
    initMouseLines(0.0, MOUSE_LINE_LENGTH);
    refresh();
  }
}

void setup(){
  size(640,640);
  background(255);
  
  initLines();
  initMouseLines(0.0, MOUSE_LINE_LENGTH);
  refresh();
}

void draw(){
  if(needRefresh) refresh();
  else needRefresh=false;
}