class Point{
    float x; 
    float y;
    Point(){
        x=0.0f;
        y=0.0f;
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

//getRadian
float getRadian(Point p1, Point p2){
    float dx=p2.x-p1.x;
    float dy=p2.y-p1.y;
    float cosA=dx/sqrt(dx*dx+dy*dy);
    float A=acos(cosA);
    if(dy<0) A=TWO_PI-A;
    return A;
}

//getDistance
float getDistance(Point p1, Point p2){
    float dx=p1.x-p2.x;
    float dy=p1.y-p2.y;
    return sqrt(dx*dx+dy*dy);
}

//getPoint
Point getPoint(Point src, float radian, float len){
    return new Point(src.x+cos(radian)*len, src.y+sin(radian)*len);
}

//getAccelerate
float getAccelerate(float distance, float velocity){
    return 2*distance/(ARRIVE_TIME*ARRIVE_TIME)-velocity*2/ARRIVE_TIME;
}