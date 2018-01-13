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
  
  private void showLineBullet(){
    float lineLength=isBigBullet?BIG_BULLET_LINE_LENGTH: SMALL_BULLET_LINE_LENGTH;
    stroke(isBigBullet?BIG_BULLET_LINE_COLOR: SMALL_BULLET_LINE_COLOR);
    strokeWeight(isBigBullet? BIG_BULLET_LINE_WEIGHT: SMALL_BULLET_LINE_WEIGHT);
    Point p1=getPoint(pos, radian, lineLength/2);
    Point p2=getPoint(pos, PI+radian, lineLength/2);
    line(p1.x, p1.y, p2.x, p2.y);
  }
  
  private void showRoundBullet(){
    noStroke();
    fill(isBigBullet?BIG_BULLET_COLOR: SMALL_BULLET_COLOR);
    ellipse(pos.x, pos.y, radius, radius);
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
    if(isLineBullet) showLineBullet();
    else showRoundBullet();
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