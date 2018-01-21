
//Bog
class Bot{
    Point pos;
    Point trackPos;
    float velocity;
    boolean stop;

    //Bot
    Bot(){
        pos=new Point();
        trackPos=new Point();
        velocity=0.0f;
        stop=true;
    }
    
    Bot(Point p){
        pos=new Point(p);
        trackPos=new Point();
        velocity=0.0f;
        stop=true;
    }

    //show
    private void show(){
        fill(BOT_COLOR);
        noStroke();
        ellipse(pos.x, pos.y, BOT_WIDTH, BOT_WIDTH);
    }

    //track
    void track(Point p){
        //float distance=getDistance(p, pos);
        if(stop)
            trackPos=p;
    }

    //update
    void update(){
        float dx=pos.x-trackPos.x;
        float dy=pos.y-trackPos.y;
        //if(!(abs(dx)<BOT_TRACK_LENGTH && abs(dy)<BOT_TRACK_LENGTH )){
            float accelerate=getAccelerate(getDistance(pos, trackPos), velocity, BOT_ARRIVE_TIME);
            velocity+=accelerate;
            float radian=getRadian(pos, trackPos);
            pos.x+=cos(radian)*velocity;
            pos.y+=sin(radian)*velocity;
        if(velocity<BOT_VELOCITY_DEVIATION) stop=true;
        else stop=false;
        //}
        show();
    }
}