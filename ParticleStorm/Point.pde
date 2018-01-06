class Point{
  float x;
  float y;
  Point(){}
  Point(float _x, float _y){
    x=_x;
    y=_y;
  }
  
  Point(Point p){
    x=p.x;
    y=p.y;
  }
}

//getPoint
Point getPoint(Point p, float r, float len){
    float x=p.x+len*cos(r);
    float y=p.y+len*sin(r);
    return new Point(x, y);
}

//getNormalizeRadian
float getNormalizeRadian(float radian){
  if(radian>0 && radian<2*PI) return radian;
  
  if(radian<0){
    int c=int((-radian)/(2*PI))+1;
    radian+=c*2*PI;
  }
  
  //radian >= 2*PI
  else{
    int c=int(radian/(2*PI));
    radian-=c*2*PI;
  }
  
  return radian;
}