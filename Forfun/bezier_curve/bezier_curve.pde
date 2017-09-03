class Point {
  float x;
  float y;
  Point() {
    x=0;
    y=0;
  }
  Point(float posX, float posY) {
    x=posX;
    y=posY;
  }
};

ArrayList<Point> mainArray=new ArrayList<Point>();
ArrayList<Point> bezierArray=new ArrayList<Point>();
ArrayList<Point> array1=new ArrayList<Point>();
ArrayList<Point> array2=new ArrayList<Point>();
ArrayList<Point> array3=new ArrayList<Point>();
ArrayList<Point> array4=new ArrayList<Point>();
ArrayList<Point> array5=new ArrayList<Point>();
ArrayList<Point> array6=new ArrayList<Point>();
ArrayList<Point> array7=new ArrayList<Point>();
ArrayList<Point> array8=new ArrayList<Point>();

int screenX=800;
int screenY=800;
int max_points=10;
boolean canPress=true;
float scale=0.0;
float scale_increment=0.01;
color bgColor=color(255, 255, 255);
color rectColor=#0070FF;
color baseColor=#818181;
color bezierColor=#FF0000;

color getColor(int i) {
  switch(i){
    case 1: return #FF8183;
    case 2: return #FF81F7;
    case 3: return #B181FF;
    case 4: return #81FF97;
    case 5: return #F0FF81;
    case 6: return #FF8181;
    case 7: return #81A5FF;
    case 8: return #81FFE7;
  }
  return #000000; 
}

float distance(Point p1, Point p2) {
  return sqrt(pow(p1.x-p2.x, 2)+pow(p1.y-p2.y, 2));
}

void showBasePoint(color c, int len){
  int size=mainArray.size();
  for(int i=0;i<size;++i){
    fill(baseColor);
    noStroke();
    Point p=mainArray.get(i);
    rect(p.x-len/2, p.y-len/2, len, len);
  }
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

void resetTempArrays() {
  array1.clear();
  array2.clear();
  array3.clear();
  array4.clear();
  array5.clear();
  array6.clear();
  array7.clear();
  array8.clear();
}

void drawNewLines() {
  drawLines(array1, getColor(1), 1);
  drawLines(array2, getColor(2), 1);
  drawLines(array3, getColor(3), 1);
  drawLines(array4, getColor(4), 1);
  drawLines(array5, getColor(5), 1);
  drawLines(array6, getColor(6), 1);
  drawLines(array7, getColor(7), 1);
  drawLines(array8, getColor(8), 1);
  drawLines(mainArray, baseColor, 1);
  drawLines(bezierArray, bezierColor, 2);
}

void updateArray(ArrayList<Point> array, ArrayList<Point> prev_array) {
  if(prev_array.size()==0) return;
  if (prev_array.size()==1){
    print("add bezier");
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

void updateArrays() {
  updateArray(array1, mainArray);
  updateArray(array2, array1);
  updateArray(array3, array2);
  updateArray(array4, array3);
  updateArray(array5, array4);
  updateArray(array6, array5);
  updateArray(array7, array6);
  updateArray(array8, array7);
  updateArray(bezierArray, array8);
}

void drawNext() {
  scale+=scale_increment;
  if (scale>1) {
    scale=scale_increment;
    bezierArray.clear();
    return;
  }
  if(scale<0) return;
  fill(bgColor);
  rect(-1, -1, screenX+1, screenY+1);
  resetTempArrays();
  updateArrays();
  showBasePoint(baseColor, 5);
  drawNewLines();
}

void setup() {
  size(800, 800);
  background(bgColor);
}

void mousePressed() {
  if (max_points!=0 && canPress) {
    mainArray.add(new Point(mouseX, mouseY));
    --max_points;
    fill(baseColor);
    noStroke();
    rect(mouseX-2, mouseY-2, 5, 5);
    canPress=false;
    
    drawLines(mainArray, baseColor, 1);
  }
}

void mouseReleased(){
  canPress=true;
}

void keyPressed() {
  drawNext();
}

void draw() {
  if (max_points!=0) return;
  //drawNext();
}