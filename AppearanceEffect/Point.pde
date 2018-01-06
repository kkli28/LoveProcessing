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

    Point(){}
}

//getRadian
float getRadian(Point p1, Point p2){
    float dx=p2.x-p1.x;
    float dy=p2.y-p1.y;
    float cosA=dx/sqrt(dx*dx+dy*dy);
    float A=acos(cosA);
    if(dy<0) A=TWO_PI-A;
    return A;
}

//getPoint
Point getPoint(Point p, float radian, float len){
    float x=p.x+cos(radian)*len;
    float y=p.y+sin(radian)*len;
    return new Point(x, y);
}