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
