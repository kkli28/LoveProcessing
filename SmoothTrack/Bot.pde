
//Bog
class Bot{
    Point pos;
    Point trackPos;
    ArrayList<Point> guns;
    float velocity;
    float radian;
    boolean enableRotate;

    //Bot
    Bot(){
        pos=new Point();
        trackPos=new Point();
        guns=new ArrayList<Point>();
        velocity=0.0f;
        radian=0.0f;
    }
    Bot(Point p){
        pos=new Point(p);
        trackPos=new Point();
        guns=new ArrayList<Point>();
        velocity=0.0f;
        radian=0.0f;

        initGuns();
    }

    //initGuns
    private void initGuns(){
        for(int i=0;i<BOT_GUN_COUNT;++i){
            guns.add(new Point(getPoint(pos, i*BOT_GUN_DELTA_RADIAN, BOT_SIDE_LENGTH)));
        }
    }

    //updateGun
    private void updateGuns(){
        radian+=BOT_ROTATE_DELTA_RADIAN;
        for(int i=0;i<BOT_GUN_COUNT;++i){
            Point p=getPoint(pos, radian+i*BOT_GUN_DELTA_RADIAN, BOT_SIDE_LENGTH);
            guns.set(i, p);
        }
    }

    //show
    private void show(){
        //side
        stroke(BOT_SIDE_COLOR);
        strokeWeight(BOT_SIDE_WEIGHT);
        Point p=guns.get(0);
        line(pos.x, pos.y, p.x, p.y);
        for(int i=1;i<BOT_GUN_COUNT;++i){
            p=guns.get(i);
            line(pos.x, pos.y, p.x, p.y);
        }

        //body
        noStroke();
        fill(BOT_BODY_COLOR);
        ellipse(pos.x, pos.y, BOT_BODY_RADIUS, BOT_BODY_RADIUS);

        //gun
        fill(BOT_GUN_COLOR);
        for(int i=0;i<BOT_GUN_COUNT;++i){
            p=guns.get(i);
            ellipse(p.x, p.y, BOT_GUN_RADIUS, BOT_GUN_RADIUS);
        }
    }

    
    //getAccelerate
    float getAccelerate(float distance){
        return 2*distance/(BOT_ARRIVE_TIME*BOT_ARRIVE_TIME)-velocity*2/BOT_ARRIVE_TIME;
    }

    //track
    void track(Point p){ trackPos=new Point(p);}

    //update
    void update(){
        float dx=pos.x-trackPos.x;
        float dy=pos.y-trackPos.y;
        if(!(abs(dx)<DISTANCE_DEVIATION && abs(dy)<DISTANCE_DEVIATION)){
            float accelerate=getAccelerate(getDistance(pos, trackPos));
            velocity+=accelerate;
            float radian=getRadian(pos, trackPos);
            pos.x+=cos(radian)*velocity;
            pos.y+=sin(radian)*velocity;
        }
        updateGuns();
        show();
    }
}