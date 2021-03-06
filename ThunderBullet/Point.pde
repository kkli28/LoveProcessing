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

//getDistance
float getDistance(Point p1, Point p2){
    float dx=p1.x-p2.x;
    float dy=p1.y-p2.y;
    return sqrt(dx*dx+dy*dy);
}
