class Point{
  float x;
  float y;
  Point(){
    x=0;
    y=0;
  }
  Point(float _x, float _y){
    x=_x;
    y=_y;
  }
  Point(Point p){
    x=p.x;
    y=p.y;
  }
}

Point getPoint(Point src, float radian, float len){
  return new Point(src.x+cos(radian)*len, src.y+sin(radian)*len);
}