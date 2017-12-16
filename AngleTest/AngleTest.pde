class Point{
  float x;
  float y;
  
  Point(float _x, float _y){
    x=_x;
    y=_y;
  }
  
  Point(Point p){
    x=p.x;
    y=p.y;
  }
}

void setup(){
  size(640,640);
  background(255);
}

//getTrackAngle
float getTrackAngle(Point p1, Point p2){
    float deltaX=p2.x-p1.x;
    float deltaY=p2.y-p1.y;
    float cosA=deltaX/sqrt(deltaX*deltaX+deltaY*deltaY);
    float A=acos(cosA);
    if(deltaY<0) return A;
    else return 2*PI-A;
}

void draw(){
  fill(255);
  noStroke();
  rect(0,0,640,640);
  Point p1=new Point(320, 320);
  Point p2=new Point(mouseX, mouseY);
  fill(200);
  stroke(200);
  line(p1.x, p1.y, p2.x, p2.y);
  float angle=getTrackAngle(p1, p2);
  text(angle, 20, 620);
}