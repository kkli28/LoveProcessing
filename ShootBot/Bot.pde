
class Bot{
    Point pos;
    Point trackPos;
    float v;
    boolean enable;
    
    int wanderTimeTotal;
    int wanderTimeCount;
    Point wanderV;
    int shootCount;

    Bot(){
        pos=new Point();
        trackPos=new Point();
        v=0;
        wanderTimeTotal=0;
        wanderTimeCount=0;
        wanderV=new Point();
        enable=false;
    }

    Bot(Point _pos, float _v){
        pos=new Point(_pos);
        trackPos=new Point();
        v=_v;
        wanderTimeTotal=0;
        wanderTimeCount=0;
        wanderV=new Point();
        enable=true;
        shootCount=0;
    }
    
    void track(Point p){
        trackPos=p;
    }

    private void wander(){
        if(wanderTimeCount>=wanderTimeTotal){
            wanderTimeTotal=int(random(BOT_WANDER_TIME_MIN, BOT_WANDER_TIME_MAX));
            wanderTimeCount=0;
            wanderV.x=random(BOT_WANDER_VELOCITY_MIN, BOT_WANDER_VELOCITY_MAX);
            wanderV.y=random(BOT_WANDER_VELOCITY_MIN, BOT_WANDER_VELOCITY_MAX);
            if(random(-1, 1)<0) wanderV.x=-wanderV.x;
            if(random(-1, 1)<0) wanderV.y=-wanderV.y;
        }
        pos.x+=wanderV.x;
        pos.y+=wanderV.y;
        ++wanderTimeCount;
    }
    
    private void show(){
        noStroke();
        fill(BOT_COLOR);
        ellipse(pos.x, pos.y, BOT_R, BOT_R);
    }
    
    Bullet shoot(){
      if(++shootCount>=BOT_SHOOT_CD){
        shootCount=0;
        return new Bullet(pos, BULLET_VELOCITY, getTrackRadian(pos, trackPos));
      }
      else return new Bullet();
    }
    
    void update(){
        if(!enable) return;
        float distance=getSquareDistance(pos, trackPos);
        if(distance>BOT_TRACK_DISTANCE_MAX*BOT_TRACK_DISTANCE_MAX){
            float radian=getTrackRadian(pos, trackPos);
            pos.x+=cos(radian)*v;
            pos.y-=sin(radian)*v;
            wanderTimeTotal=0;
        }
        else{
            //wander();
        }
        
        show();
    }
}