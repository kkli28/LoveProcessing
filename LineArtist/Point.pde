class Point{
    float x;
    float y;
    Point(){}
    Point(float xx, float yy){
        x=xx;
        y=yy;
    }
    Point(Point p){
        x=p.x;
        y=p.y;
    }
}

Point getPoint(Point p, float r, float len){
    float vx=p.x+cos(r)*len;
    float vy=p.y+sin(r)*len;
    return new Point(vx, vy);
}

float getRadian(Point p1, Point p2){
    float deltaX=p2.x-p1.x;
    float deltaY=p2.y-p1.y;
    float cosA=deltaX/sqrt(deltaX*deltaX+deltaY*deltaY);
    if(deltaY>0) return TWO_PI-acos(cosA);
    else return acos(cosA);
}

float getLength(Point p1, Point p2){
    return sqrt(pow(p1.x-p2.x, 2)+pow(p1.y-p2.y, 2));
}