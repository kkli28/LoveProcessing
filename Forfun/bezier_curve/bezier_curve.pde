class Point{
  float x;
  float y;
  Point(){
    x=0;
    y=0;
  }
  Point(float posX, float posY){
    x=posX;
    y=posY;
  }
};

ArrayList<Point> mainArray=new ArrayList<Point>();
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
int max_points=8;
float scale=0.0;
float scale_increment=0.01;
color bgColor=color(255,255,255);
color rectColor=#0070FF;
color baseColor=color(100,100,100);

color getColor(int i){
  return color(200-i*10,200-i*10,200-i*10);
}

float distance(Point p1, Point p2){
  return sqrt(pow(p1.x-p2.x, 2)+pow(p1.y-p2.y, 2));
}

void drawLines(ArrayList<Point> array, color c){
  if(array.size()<2) return;
  int size=array.size()-1;
  for(int i=0;i<size;++i){
    Point p1=array.get(i);
    Point p2=array.get(i+1);
    stroke(c);
    line(p1.x,p1.y,p2.x,p2.y);
  }
}

void erasePreviousLines(){
  drawLines(array1, bgColor);
  drawLines(array2, bgColor);
  drawLines(array3, bgColor);
  drawLines(array4, bgColor);
  drawLines(array5, bgColor);
  drawLines(array6, bgColor);
  drawLines(array7, bgColor);
  drawLines(array8, bgColor);
}

void resetTempArrays(){
  array1.clear();
  array2.clear();
  array3.clear();
  array4.clear();
  array5.clear();
  array6.clear();
  array7.clear();
  array8.clear();
}

void drawNewLines(){
  drawLines(mainArray, rectColor);
  drawLines(array1, #05FF34); //change to getColor(i)
  drawLines(array2, #05FF34);
  drawLines(array3, #05FF34);
  drawLines(array4, #05FF34);
  drawLines(array5, #05FF34);
  drawLines(array6, #05FF34);
  drawLines(array7, #05FF34);
  drawLines(array8, #05FF34);
}

void updateArray(ArrayList<Point> array, ArrayList<Point> prev_array){
  if(prev_array.size()<2) return;
  int size=prev_array.size()-1;
  for(int i=0;i<size;++i){
    Point p1=prev_array.get(i);
    Point p2=prev_array.get(i+1);
    float disX=p2.x-p1.x;
    float disY=p2.y-p1.y;
    float x=p1.x+disX*scale;
    float y=p1.y+disY*scale;
    array.add(new Point(x,y));
  }
}

void updateArrays(){
  updateArray(array1, mainArray);
  updateArray(array2, array1);
  updateArray(array3, array2);
  updateArray(array4, array3);
  updateArray(array5, array4);
  updateArray(array6, array5);
  updateArray(array7, array6);
  updateArray(array8, array7);
}

void drawNext(){
  if(scale>0.99){
    scale=0;
    return;
  }
  scale+=scale_increment;
  //erasePreviousLines();
  fill(bgColor);
  rect(0,0,screenX,screenY);
  resetTempArrays();
  updateArrays();
  drawNewLines();
}

void setup(){
  size(800, 800);
  background(bgColor);
}

void mouseClicked(){
  if(max_points!=0){
    mainArray.add(new Point(mouseX,mouseY));
    --max_points;
    fill(200);
    rect(mouseX-1,mouseY-1,3,3);
  }
}

void keyPressed(){
  drawNext();
}

void draw(){
  if(max_points!=0) return;
  //drawNext();
}