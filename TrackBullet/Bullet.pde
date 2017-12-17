class Bullet{
  Point pos;
  Point trackPos;
  float radian;
  float velocity;
  int life;
  int disableCollisionCount;
  int radius;
  boolean dead;
  boolean isTrack;
  boolean enableCollision;
  boolean isBigBullet;
  
  Bullet(Point _pos, float _v, int r, boolean big){
    pos=new Point(_pos);
    trackPos=new Point(random(SCREEN_WIDTH), random(SCREEN_HEIGHT));
    radian=0.0f;
    velocity=_v;
    life=0;
    disableCollisionCount=0;
    radius=r;
    dead=false;
    isTrack=false;
    enableCollision=false;
    isBigBullet=big;
  }
  
  private void show(){
    /*
    if(isBigBullet) {
      noStroke();
      fill(BIG_BULLET_COLOR);
    }
    else{
      stroke(SMALL_BULLET_COLOR);
      fill(255);
    }
    */
    noStroke();
    fill(isBigBullet?BIG_BULLET_COLOR: SMALL_BULLET_COLOR);
    ellipse(pos.x, pos.y, radius, radius);
  }
  
  void track(Point p){ trackPos=p; isTrack=true; }
  
  void update(){
    if((!enableCollision) && (++disableCollisionCount>DISABLE_COLLISION_TIME)) enableCollision=true;
    if(++life>BULLET_LIFE) dead=true;
    if(dead) return;
    
    if(isTrack){
      //update radian
      float aimRadian=getTrackRadian(pos, trackPos);
      float diff=getNormalizeRadian(aimRadian-radian);
      if(diff<DELTA_ROTATE_RADIAN) radian+=diff;
      else if(diff<PI) radian+=DELTA_ROTATE_RADIAN;
      else radian-=DELTA_ROTATE_RADIAN;
    }
    
    //update pos
    pos.x+=velocity*cos(radian);
    pos.y-=velocity*sin(radian);
    
    //show
    show();
  }
}