class Rect{
    Point topLeft;
    boolean topWall;
    boolean rightWall;
    boolean bottomWall;
    boolean leftWall;
    boolean isBorder;

    Rect(Point tl, boolean tw, boolean rw, boolean bw, boolean lw){
        topLeft=new Point(tl);
        topWall=tw;
        rightWall=rw;
        bottomWall=bw;
        leftWall=lw;
        isBorder=false;
    }

    Rect(){}

    boolean isNeighbor(Rect r){
        Point rtl=r.topLeft;
        ir(rtl.x==topLeft.x && rtl.y==topLeft.y) return false; //self
        if((abs(topLeft.x-rtl.x)<=RECT_WIDTH) && (abs(topLeft.y-rtl.y)<=RECT_HEIGHT) return true;
        return false;
    }

    void show(){
        fill(RECT_COLOR);
        rect(topLeft.x, topLeft.y, RECT_WIDTH, RECT_HEIGHT);
        stroke(WALL_COLOR);
        strokeWeight(WALL_STROKE_WEIGHT);
        if(topWall) line(topLeft.x, topLeft.y, topLeft.x+RECT_WIDTH, topLeft.y);
        if(rightWall) line(topLeft.x+RECT_WIDTH, topLeft.y, topLeft.x+RECT_WIDTH, topLeft.y+HEIGHT);
        if(bottomWall) line(topLeft.x, topLeft.y+HEIGHT, topLeft.x+WIDTH, topLeft.y+HEIGHT);
        if(leftWall) line(topLeft.x, topLeft.y, topLeft.x, topLeft.y+HEIGHT);
    }
}
