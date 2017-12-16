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