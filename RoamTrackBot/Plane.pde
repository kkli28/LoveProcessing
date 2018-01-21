class Plane{
    Point pos;
    Point trackPos;
    float velocity;
    Bot bot;

    Plane(Point p, float v){
        pos=new Point(p);
        trackPos=new Point();
        velocity=v;
        bot=new Bot(getSurroundPos());
    }

    void track(Point p){
        trackPos=p;
    }

    Point getSurroundPos(){
        float radian=random(0, TWO_PI);
        float len=random(SURROUND_LENGTH_MIN, SURROUND_LENGTH_MAX);
        return getPoint(pos, radian, len);
    }

    private void show(){
        fill(PLANE_COLOR);
        noStroke();
        ellipse(pos.x, pos.y, PLANE_WIDTH, PLANE_WIDTH);
    }

    void update(){
        float dx=pos.x-trackPos.x;
        float dy=pos.y-trackPos.y;
        if(!(abs(dx)<PLANE_DISTANCE_DEVIATION && abs(dy) < PLANE_DISTANCE_DEVIATION)){
            float accelerate=getAccelerate(getDistance(pos, trackPos), velocity, PLANE_ARRIVE_TIME);
            float radian=getRadian(pos, trackPos);
            velocity+=accelerate;
            pos.x+=cos(radian)*velocity;
            pos.y+=sin(radian)*velocity;
        }
        bot.track(getSurroundPos());
        bot.update();
        show();
    }
}