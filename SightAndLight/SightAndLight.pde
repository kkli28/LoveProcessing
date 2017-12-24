import java.util.Collections;
import java.util.Comparator;

// ==== constant ====
final int SCREEN_WIDTH=720;
final int SCREEN_HEIGHT=720;
final int IPR=8;
final int LINE_COUNT=2;

final int MOUSE_LINE_LENGTH=1200;
final float DEVIATION=0.000000001f;
final float INFINITY=100000000f;
final float EXTRA_LINE_OFFSETX=1f;
float beginX=SCREEN_WIDTH/2;
float beginY=SCREEN_HEIGHT/2;

boolean enableTriangle=false;
boolean enableIntersectionPoint=true;
boolean enableBorderLines=false;

//color
final int LINE_COLOR=#FF0004;
final int MOUSE_LINE_COLOR=#10FF00;
final int POINT_COLOR=#FF0D00;
final int POLYGON_LINE_COLOR=#0092FF;

int triangleCount=0;

ArrayList<Line> lines=new ArrayList<Line>();
ArrayList<Point> linesIntersectionPoints=new ArrayList<Point>();
ArrayList<Point> points=new ArrayList<Point>();
ArrayList<Line> mouseLines=new ArrayList<Line>();
boolean needRefresh=true;

void initLines(){
  lines.clear();
  
  if(enableBorderLines){
    lines.add(new Line(0,0,SCREEN_WIDTH, 0));
    lines.add(new Line(0,0, 0, SCREEN_HEIGHT));
    lines.add(new Line(0, SCREEN_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT));
    lines.add(new Line(SCREEN_WIDTH, 0, SCREEN_WIDTH, SCREEN_HEIGHT));
  }
  
  for(int i=0;i<LINE_COUNT;++i){
    float x1=random(SCREEN_WIDTH);
    float y1=random(SCREEN_HEIGHT);
    float x2=random(SCREEN_WIDTH);
    float y2=random(SCREEN_HEIGHT);
    lines.add(new Line(x1, y1, x2, y2));
  }
}

void updateMouseLines(){
  mouseLines.clear();
  processIntersectionsInLines();
  
  for(Line l: lines){
    //end point
    addMouseLine(l.p1);
    addMouseLine(l.p2);
    
    //+-end point
    addMouseLine(getCelta(l.p1)+0.01);
    addMouseLine(getCelta(l.p1)-0.01);
    addMouseLine(getCelta(l.p2)+0.01);
    addMouseLine(getCelta(l.p2)-0.01);
  }
  
  for(Point p: linesIntersectionPoints){
    addMouseLine(p);
  }
}

void addMouseLine(Point p){
  float deltaX=p.x-mouseX;
  float deltaY=p.y-mouseY;
  float tanCelta=deltaY/deltaX;
  float xLen=MOUSE_LINE_LENGTH;
  float yLen=tanCelta*MOUSE_LINE_LENGTH;
  if(deltaX<0){
    xLen=-xLen;
    yLen=-yLen;
  }
  mouseLines.add(new Line(mouseX, mouseY, mouseX+xLen, mouseY+yLen));
}

void addMouseLine(float celta){
  float xLen=0.0f;
  float yLen=0.0f;
  if(celta<PI/2 || celta>PI*3/2){
    xLen=MOUSE_LINE_LENGTH;
    yLen=tan(celta)*MOUSE_LINE_LENGTH;
  }
  else{
    xLen=-MOUSE_LINE_LENGTH;
    yLen=-tan(celta)*MOUSE_LINE_LENGTH;
  }
  mouseLines.add(new Line(mouseX, mouseY, mouseX+xLen, mouseY+yLen));
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

void processIntersectionsInLines(){
  linesIntersectionPoints.clear();
  int size=lines.size();
  for(int i=0;i<size-1;++i){
    for(int j=0;j<size;++j){
      Line l1=lines.get(i);
      Line l2=lines.get(j);
      Point p=__calcIntersection_aux(l1, l2);
      if(pointInLine(l1, p) && pointInLine(l2, p)) linesIntersectionPoints.add(p);
    }
  }
}

void processIntersection(){
  
  //mouseLines vs lines
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

float getCelta(Point p){
  float deltaX=p.x-mouseX;
  float deltaY=p.y-mouseY;
  float cosA=deltaX/sqrt(deltaX*deltaX+deltaY*deltaY);
  if(deltaY<0) return acos(cosA);
  else return 2*PI-acos(cosA);
}

void drawTriangles(){
  int size=points.size();
  if(size<3) return;
  
  ArrayList<PointWithCelta> pc=new ArrayList<PointWithCelta>();
  for(Point p: points) pc.add(new PointWithCelta(p, getCelta(p)));
  Collections.sort(pc, new Comparator(){
    public int compare(Object pc1, Object pc2){
      return (((PointWithCelta)pc1).celta<((PointWithCelta)pc2).celta)?1:0;
    }
  });
  
  //Triangle
  noStroke();
  fill(200);
  for(int i=0;i<size-1;++i){
    for(int j=1;j<size;++j){
      PointWithCelta pc1=pc.get(i);
      PointWithCelta pc2=pc.get(j);
      triangle(beginX, beginY, pc1.p.x, pc1.p.y, pc2.p.x, pc2.p.y);
      ++triangleCount;
    }
  }
  
  PointWithCelta pc1=pc.get(size-1);
  PointWithCelta pc2=pc.get(0);
  triangle(beginX, beginY, pc1.p.x, pc1.p.y, pc2.p.x, pc2.p.y);
  ++triangleCount;
  
  //Polygon
  stroke(POLYGON_LINE_COLOR);
  Point p1=pc.get(0).p;
  Point p2=new Point(0.0f, 0.0f);
  line(mouseX, mouseY, p1.x, p1.y);
  
  for(int i=0;i<size-1;++i){
    p1=pc.get(i).p;
    p2=pc.get(i+1).p;
    line(p1.x, p1.y, p2.x, p2.y);
  }
  
  p1=pc.get(size-1).p;
  line(mouseX, mouseY, p2.x, p2.y);
  
  for(int i=0;i<size;++i) {
    Point p=pc.get(i).p;
    fill(0);
    text(i,p.x, p.y);
  }
}

void showTips(){
  fill(POINT_COLOR);
  textSize(16);
  text("Press 'a' to reset", 10,20);
  text("Press 's' to enable/disable points", 10, 40);
  text("Press 'd' to enable/disable triangle", 10, 60);
  text("lines: "+mouseLines.size(), 10, SCREEN_HEIGHT-20);
  text("triangles: ", 120, SCREEN_HEIGHT-20);
  text(triangleCount, 200, SCREEN_HEIGHT-20);
  triangleCount=0;
}

void refresh(){
  noStroke();
  fill(255);
  rect(0,0,SCREEN_WIDTH,SCREEN_HEIGHT);
  
  processIntersection();
  drawIntersectionPoints();
  if(enableTriangle) drawTriangles();
  drawLines();
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
    enableIntersectionPoint=!enableIntersectionPoint;
  }
  else if(key=='d'){
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