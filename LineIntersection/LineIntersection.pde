
final int IPR=8;

ArrayList<Line> lines=new ArrayList<Line>();
ArrayList<Point> points=new ArrayList<Point>();
Point p1=new Point(0,0);
Point p2=new Point(0,0);
int mouseStatus=0;
boolean needRefresh=false;

void initLines(){
  lines.add(new Line(100,100,200,200));
  lines.add(new Line(200,100,100,200));
}

boolean pointInLine(Line l, Point p){
  if(l.p1.x<l.p2.x){
    if(p.x<l.p1.x || p.x>l.p2.x) return false;
  }
  else{
    if(p.x<l.p2.x || p.x>l.p1.x) return false;
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
  int size=lines.size();
  int j=size-1;
  for(int i=0;i<j;++i){
     Point p=__calcIntersection_aux(lines.get(i), lines.get(j));
     if(pointInLine(lines.get(i), p) && pointInLine(lines.get(j), p)){
       points.add(p);
     }
  }
}

void clearLinesAndPoints(){
  lines.clear();
  points.clear();
}

void drawLines(){
  stroke(200);
  for(Line l: lines) line(l.p1.x, l.p1.y, l.p2.x, l.p2.y);
}

void drawIntersectionPoints(){
  stroke(#FF0000);
  fill(255);
  for(Point p: points) ellipse(p.x, p.y, IPR, IPR);
}

void refresh(){
  noStroke();
  fill(255);
  rect(0,0,640,640);
  
  processIntersection();
  drawLines();
  drawIntersectionPoints();
}

void mousePressed(){
  if(mouseStatus!=0) return;
  p1.x=mouseX;
  p1.y=mouseY;
  mouseStatus=1;
  needRefresh=true;
}

void mouseReleased(){
  if(mouseStatus!=1) return;
  p2.x=mouseX;
  p2.y=mouseY;
  lines.add(new Line(p1.x, p1.y, p2.x, p2.y));
  mouseStatus=0;
}

void keyPressed(){
  if(key=='s') lines.clear();
  refresh();
}

void setup(){
  size(640,640);
  background(255);
  
  //initLines();
  refresh();
}

void draw(){
  if(needRefresh) refresh();
  if(mouseStatus==1) {
    stroke(200);
    line(p1.x, p1.y, mouseX, mouseY);
  }
  else needRefresh=false;
}