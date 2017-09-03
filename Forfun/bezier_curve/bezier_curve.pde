class Point {
  float x;
  float y;
  Point(float posX, float posY) {
    x=posX;
    y=posY;
  }
};

ArrayList<Point> mainArray=new ArrayList<Point>();
ArrayList<Point> bezierArray=new ArrayList<Point>();
ArrayList<ArrayList<Point>> arrays=new ArrayList<ArrayList<Point>>();

int screenWidth=1920;
int screenHeight=1080;

final int MIN_POINTS=2;
final int MAX_POINTS=24;

int points=0;
int rectLen=7; //rect's side length

boolean canPress=true;
boolean canDraw=true;
boolean hasLine=true;

float scale=0.0;
float scale_increment=0.005;

color bgColor=#FFFFFF; //background color
color pointColor=#4B4B4B; //point where mouse clicked
color lineColor=#818181; //temp line
color bezierColor=#FF4040; //bezier curve color
color textColor=#989090; //text's color

float distance(Point p1, Point p2) {
  return sqrt(pow(p1.x-p2.x, 2)+pow(p1.y-p2.y, 2));
}

color getColor(int i){
  switch(i%4){
    case 0: return #FC5757;
    case 1: return #57ABFC;
    case 2: return #59FC57;
    case 3: return #FCB557;
  }
  return #000000;
}

void drawRect(color c, Point start, int width, int height) {
  fill(c);
  noStroke();
  rect(start.x, start.y, width, height);
}

void showPoint(int len) {
  for (int i=0; i<points; ++i) {
    Point p=mainArray.get(i);
    drawRect(pointColor, new Point(p.x-len/2, p.y-len/2), len, len);
  }
}

/////////////////////////////////////////////////////////////////

void updateArray(ArrayList<Point> array, ArrayList<Point> prev_array) {
  if (prev_array.size()==0) return;
  if (prev_array.size()==1) {
    bezierArray.add(prev_array.get(0));
    return;
  }
  int size=prev_array.size()-1;
  for (int i=0; i<size; ++i) {
    Point p1=prev_array.get(i);
    Point p2=prev_array.get(i+1);
    float disX=p2.x-p1.x;
    float disY=p2.y-p1.y;
    float x=p1.x+disX*scale;
    float y=p1.y+disY*scale;
    array.add(new Point(x, y));
  }
}

void resetArrays() {
  for (int i=0; i<MAX_POINTS; ++i) {
    arrays.get(i).clear();
  }
}

void updateArrays() {
  resetArrays();
  int size=points-1;
  updateArray(arrays.get(0), mainArray);
  for (int i=0; i<size; ++i) {
    updateArray(arrays.get(i+1), arrays.get(i));
  }
  updateArray(bezierArray, arrays.get(size));
}

void drawLines(ArrayList<Point> array, color c, int thick, boolean haveLine) {
  if (array.size()<2) return;
  int size=array.size()-1;
  for (int i=0; i<size; ++i) {
    Point p1=array.get(i);
    Point p2=array.get(i+1);
    
    //show line
    if(!haveLine) continue;
    stroke(c);
    strokeWeight(thick);
    line(p1.x, p1.y, p2.x, p2.y);
  }
}

void drawNewLines() {
  drawLines(mainArray, lineColor, 3, true);
  for (int i=0; i<points; ++i) {
    drawLines(arrays.get(i), getColor(i), 1, hasLine);
  }
  drawLines(bezierArray, bezierColor, 3, true);
  
  //show bezier curve's rect
  fill(bezierColor);
  Point p=bezierArray.get(bezierArray.size()-1);
  rect(p.x-1, p.y-1, 3, 3);
}

void drawNext() {
  scale+=scale_increment;
  if (scale>1) {
    scale=-60*scale_increment;
    bezierArray.clear();
    bezierArray.add(mainArray.get(0));
    return;
  }
  if (scale<0) return;
  drawRect(bgColor, new Point(0, 0), screenWidth, screenHeight); //clear screen
  updateArrays();
  showPoint(rectLen);
  drawNewLines();
}

/////////////////////////////////////////////////////////////////

void initArrays() {
  for (int i=0; i<MAX_POINTS; ++i) {
    arrays.add(new ArrayList<Point>(MAX_POINTS+4));
  }
}

void setup() {
  fullScreen();
  background(bgColor);
  initArrays();
  textAlign(LEFT);
}

void resetAll() {
  resetArrays();
  mainArray.clear();
  bezierArray.clear();

  canPress=true;
  canDraw=true;
  points=0;
}

void mousePressed() {
  if (canPress && points<MAX_POINTS) {
    mainArray.add(new Point(mouseX, mouseY));
    ++points;
    drawRect(bgColor, new Point(mouseX-rectLen/2, mouseY-rectLen/2), rectLen, rectLen);
    canPress=false;
    drawLines(mainArray, bgColor, 1, true);
  }
  showPoint(rectLen);
}

void mouseReleased() {
  canPress=true;
}

void keyPressed() {
  if(key=='s'){ //stop
    canDraw=!canDraw;
    return;
  }
  if(key=='l'){ //no line
    hasLine=!hasLine;
    return;
  }
  resetAll();
  drawRect(bgColor, new Point(0, 0), screenWidth, screenHeight); //clear screen
}

void draw() {
  if (points>=MIN_POINTS && canDraw) drawNext();
  fill(textColor);
  textSize(48);
  text("[Bezier Curve]", 64, 64);
  textSize(24);
  text("Max: "+MAX_POINTS+"    Now: "+points, 64, 128);
  text("Press 'S' to stop", 64, 192);
  text("Press 'L' to set no lines", 64, 256);
  text("Press others to restart", 64, 320);
}