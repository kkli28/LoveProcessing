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

//getTrackRadian
float getTrackRadian(Point p1, Point p2){
    float deltaX=p2.x-p1.x;
    float deltaY=p2.y-p1.y;
    float cosA=deltaX/sqrt(deltaX*deltaX+deltaY*deltaY);
    if(deltaY>0) return 2*PI-acos(cosA);
    else return acos(cosA);
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