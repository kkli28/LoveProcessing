class BoomerangBullet{
    Point pos;
    Point trackPos;
    float maxVelocity;
    float velocity;
    float radian;
    float rotateRadian;
    boolean dead;
    boolean isTrack;
    boolean back;
    
    BoomerangBullet(Point p, float maxV){
        pos=new Point(p);
        maxVelocity=maxV;
        velocity=maxVelocity;
        radian=random(TWO_PI);
        rotateRadian=0.0f;
        dead=false;
        isTrack=false;
        back=false;
    }
    
    private void drawShape(){
      float r=TWO_PI/3;
      Point p1=getPoint(pos, rotateRadian, BULLET_SIDE_LEN1);
      Point p2=getPoint(pos, rotateRadian+r, BULLET_SIDE_LEN2);
      Point p3=getPoint(pos, rotateRadian-r, BULLET_SIDE_LEN2);
      
      noStroke();
      fill(BULLET_COLOR);
      triangle(pos.x, pos.y, p1.x, p1.y, p2.x, p2.y);
      triangle(pos.x, pos.y, p1.x, p1.y, p3.x, p3.y);
    }
    
    private void updateVelocity(){
      if(!back && velocity>-maxVelocity){
        velocity-=BULLET_DELTA_VELOCITY;
        if(velocity<=0){
          back=true;
          radian+=PI;
        }
      }
      else{
        if(velocity<maxVelocity) velocity+=BULLET_DELTA_VELOCITY;
      }
    }
    
    private void updatePosition(){
      if(isTrack){
        float aimRadian=getTrackRadian(pos, trackPos);
        float diff=getNormalizeRadian(aimRadian-radian);
        if(diff<BULLET_DELTA_ROTATE) radian+=diff;
        else if(diff<PI) radian+=BULLET_DELTA_ROTATE;
        else radian-=BULLET_DELTA_ROTATE;
      }
      
      pos.x+=velocity*cos(radian);
      pos.y-=velocity*sin(radian);
    }
    
    void track(Point p){ trackPos=p; isTrack=true; }
    
    void update(){
      if(dead) return;
      
      //update rotateRadian
      rotateRadian+=BULLET_DELTA_ROTATE;
      if(rotateRadian>TWO_PI) rotateRadian-=TWO_PI;
      
      //update velocity
      updateVelocity();
      
      //update position
      updatePosition();
      
      if(isTrack && (abs(pos.x-trackPos.x) <BULLET_TRACK_DELTA_DISTANCE)
        && (abs(pos.y-trackPos.y) < BULLET_TRACK_DELTA_DISTANCE)){
        dead=true;
        return;
      }
      
      drawShape();
    }
}

Point getPoint(Point p, float radian, float len){
  float x=p.x+len*cos(radian);
  float y=p.y+len*sin(radian);
  return new Point(x, y);
}