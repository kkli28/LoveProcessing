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

int screenX=1920;
int screenY=1080;
final int MIN_POINTS=2;
final int MAX_POINTS=20;
int points=0;
int pointLen=7;
boolean canPress=true;
float scale=0.0;
float scale_increment=0.002;
color bgColor=color(255, 255, 255);
color pointColor=#3BFF6A;
color lineColor=#818181;
color bezierColor=#FF4040;

color getColor(int i) {
  return color(200, 200, 200);
}

float distance(Point p1, Point p2) {
  return sqrt(pow(p1.x-p2.x, 2)+pow(p1.y-p2.y, 2));
}

void clearScreen() {
  fill(bgColor);
  rect(-1, -1, screenX+1, screenY+1);
}

void showBasePoint(int len) {
  for (int i=0; i<points; ++i) {
    fill(pointColor);
    noStroke();
    Point p=mainArray.get(i);
    rect(p.x-len/2, p.y-len/2, len, len);
  }
}

void printArrays() {
  print("printArrays\n");
  int size1=arrays.size();
  for (int i=0; i<size1; ++i) {
    ArrayList<Point> arr=arrays.get(i);
    if (arr.isEmpty()) continue;
    int size2=arr.size();
    for (int j=0; j<size2; ++j) {
      Point p=arr.get(j);
      print("["+p.x+","+p.y+"]\n");
    }
  }
}

/////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////
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
  print("updateArrays\n");
  resetArrays();
  int size=points-1;
  updateArray(arrays.get(0), mainArray);
  for (int i=0; i<size; ++i) {
    updateArray(arrays.get(i+1), arrays.get(i));
  }
  updateArray(bezierArray, arrays.get(size));
}

void drawLines(ArrayList<Point> array, color c, int thick) {
  if (array.size()<2) return;
  int size=array.size()-1;
  for (int i=0; i<size; ++i) {
    Point p1=array.get(i);
    Point p2=array.get(i+1);
    stroke(c);
    strokeWeight(thick);
    line(p1.x, p1.y, p2.x, p2.y);
  }
}

void drawNewLines() {
  drawLines(mainArray, lineColor, 2);
  for (int i=0; i<points; ++i) {
    drawLines(arrays.get(i), 200, 1);
  }
  drawLines(bezierArray, bezierColor, 2);
}

void drawNext() {
  print("drawNext\n");
  scale+=scale_increment;
  if (scale>1) {
    scale=-60*scale_increment;
    bezierArray.clear();
    return;
  }
  if (scale<0) return;
  clearScreen();
  updateArrays();
  printArrays();
  showBasePoint(pointLen);
  drawNewLines();
}

/////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

void initArrays() {
  for (int i=0; i<MAX_POINTS; ++i) {
    arrays.add(new ArrayList<Point>());
  }
}

void setup() {
  fullScreen();
  background(bgColor);
  initArrays();
}

void resetAll() {
  resetArrays();
  mainArray.clear();
  bezierArray.clear();

  canPress=true;
  points=0;
}

void mousePressed() {
  if (canPress && points<MAX_POINTS) {
    mainArray.add(new Point(mouseX, mouseY));
    ++points;
    fill(bgColor);
    noStroke();
    rect(mouseX-2, mouseY-2, 5, 5);
    canPress=false;

    drawLines(mainArray, bgColor, 1);
  }
  showBasePoint(pointLen);
}

void mouseReleased() {
  canPress=true;
}

void keyPressed() {
  resetAll();
  clearScreen();
}

void draw() {
  if (points<MIN_POINTS) return;
  drawNext();
}