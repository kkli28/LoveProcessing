 
// ==== constant ====
final int SCREEN_WIDTH=720;
final int SCREEN_HEIGHT=720;
final int IPR=8;
final int LINE_COUNT=16;

int mouseLineIndex=1;
final int MOUSE_LINE_MAX_INDEX=4;
final int MOUSE_LINE_COUNT0=5;
final int MOUSE_LINE_COUNT1=16;
final int MOUSE_LINE_COUNT2=64;
final int MOUSE_LINE_COUNT3=128;
final int MOUSE_LINE_COUNT4=512;

final int MOUSE_LINE_LENGTH=1200;
final float DEVIATION=0.000000001f;
final float INFINITY=100000000f;
float beginX=SCREEN_WIDTH/2;
float beginY=SCREEN_HEIGHT/2;

boolean enableTriangle=false;
boolean enableIntersectionPoint=true;

int count=0;

//color
final int LINE_COLOR=200;
final int MOUSE_LINE_COLOR=#10FF00;
final int POINT_COLOR=#FF0D00;

ArrayList<Line> lines=new ArrayList<Line>();
ArrayList<Point> points=new ArrayList<Point>();
ArrayList<Line> mouseLines=new ArrayList<Line>();
boolean needRefresh=true;

void initLines(){
  lines.clear();
  
  lines.add(new Line(0,0,SCREEN_WIDTH, 0));
  lines.add(new Line(0,0, 0, SCREEN_HEIGHT));
  lines.add(new Line(0, SCREEN_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT));
  lines.add(new Line(SCREEN_WIDTH, 0, SCREEN_WIDTH, SCREEN_HEIGHT));
  
  for(int i=0;i<LINE_COUNT;++i){
    float x1=random(SCREEN_WIDTH);
    float y1=random(SCREEN_HEIGHT);
    float x2=random(SCREEN_WIDTH);
    float y2=random(SCREEN_HEIGHT);
    lines.add(new Line(x1, y1, x2, y2));
  }
}

int getMouseLineCount(){
  switch(mouseLineIndex){
    case 0: return MOUSE_LINE_COUNT0;
    case 1: return MOUSE_LINE_COUNT1;
    case 2: return MOUSE_LINE_COUNT2;
    case 3: return MOUSE_LINE_COUNT3;
    case 4: return MOUSE_LINE_COUNT4;
    default: return MOUSE_LINE_COUNT0;
  }
}

void updateMouseLines(){
  mouseLines.clear();
  int lineCount=getMouseLineCount();
  
  float celta=0.001;
  float deltaCelta=2*PI/lineCount;
  for(int i=0;i<lineCount;++i){
    celta+=deltaCelta;
    float endX=beginX+cos(celta)*MOUSE_LINE_LENGTH;
    float endY=beginY+sin(celta)*MOUSE_LINE_LENGTH;
    mouseLines.add(new Line(beginX, beginY, endX, endY));
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
  for(Line l: mouseLines) l.points.clear();
  
  int size1=lines.size();
  int size2=mouseLines.size();
  for(int i=0;i<size1;++i){
    for(int j=0;j<size2;++j){
      Line l1=lines.get(i);
      Line l2=mouseLines.get(j);
       Point p=__calcIntersection_aux(l1, l2);
       if(pointInLine(l1, p) && pointInLine(l2, p)){
         mouseLines.get(j).points.add(p);
       }
    }
  }
  processIntersectionPoints();
}

void processIntersectionPoints(){
  boolean find=false;
  float minLength=INFINITY-100;
  
  for(Line l: mouseLines){
    find=false;
    minLength=INFINITY-100;
    
    Point point=new Point(0,0);
    for(Point p: l.points){
      if(p.x<0 || p.x>SCREEN_WIDTH) continue;
      if(p.y<0 || p.y>SCREEN_HEIGHT) continue;
      float deltaX=p.x-beginX;
      float deltaY=p.y-beginY;
      float squareLength=deltaX*deltaX+deltaY*deltaY;
      if(squareLength<minLength){
          minLength=squareLength;
          point.x=p.x;
          point.y=p.y;
          find=true;
      }
    }
    if(find){
      points.add(point);
      l.p2.x=point.x;
      l.p2.y=point.y;
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
  if(!enableIntersectionPoint) return;
  
  stroke(POINT_COLOR);
  fill(255);
  //for(Line l: mouseLines) for(Point p: l.points) ellipse(p.x, p.y, IPR, IPR);
  for(Point p: points) ellipse(p.x, p.y, IPR, IPR);
}

void drawTriangles(){
  int size=points.size();
  if(size<2) return;
  
  noStroke();
  fill(200);
  for(int i=0;i<size-1;++i){
    for(int j=1;j<size;++j){
      Point p1=points.get(i);
      Point p2=points.get(j);
      triangle(beginX, beginY, p1.x, p1.y, p2.x, p2.y);
    }
  }
  Point p1=points.get(size-1);
  Point p2=points.get(0);
  triangle(beginX, beginY, p1.x, p1.y, p2.x, p2.y);
}

void showTips(){
  fill(POINT_COLOR);
  textSize(16);
  text("Press 'a' to reset", 10,20);
  text("Press 's' to change line count", 10, 40);
  text("Press 'd' to enable/disable points", 10, 60);
  text("Press 'f' to enable/disable triangle", 10, 80);
  text("lines: "+getMouseLineCount(), 10, SCREEN_HEIGHT-20);
}

void refresh(){
  noStroke();
  fill(255);
  rect(0,0,SCREEN_WIDTH,SCREEN_HEIGHT);
  
  processIntersection();
  drawLines();
  drawIntersectionPoints();
  if(enableTriangle) drawTriangles();
  showTips();
}

void mouseMoved(){
  beginX=mouseX;
  beginY=mouseY;
  updateMouseLines();
  needRefresh=true;
}

void keyPressed(){
    needRefresh=true;
  if(key=='a'){
    initLines();
  }
  else if(key=='s'){
    ++mouseLineIndex;
    if(mouseLineIndex>1) enableTriangle=false;
    if(mouseLineIndex>MOUSE_LINE_MAX_INDEX) mouseLineIndex=0;
    updateMouseLines();
  }
  else if(key=='d'){
    enableIntersectionPoint=!enableIntersectionPoint;
  }
  else if(key=='f' && mouseLineIndex<=1){
    enableTriangle=!enableTriangle;
  }
}

void setup(){
  size(720,720);
  background(255);
  
  initLines();
  updateMouseLines();
  refresh();
}

void draw(){
  if(needRefresh) refresh();
  needRefresh=false;
}