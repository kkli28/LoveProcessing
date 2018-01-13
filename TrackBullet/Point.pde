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

float getSquareDistance(Point p1, Point p2){
  float deltaX=p1.x-p2.x;
  float deltaY=p1.y-p2.y;
  return deltaX*deltaX+deltaY*deltaY;
}

Point getPoint(Point p, float radian, float len){
  float x=len*cos(radian);
  float y=len*sin(radian);
  return new Point(p.x+x, p.y-y);
}