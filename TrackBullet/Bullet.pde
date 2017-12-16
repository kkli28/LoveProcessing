class Bullet{
  Point pos;
  Point trackPos;
  float radian;
  float velocity;
  int life;
  boolean dead;
  
  Bullet(Point _pos, float _v){
    pos=new Point(_pos);
    trackPos=new Point(random(SCREEN_WIDTH), random(SCREEN_HEIGHT));
    radian=0.0f;
    velocity=_v;
    life=0;
    dead=false;
  }
  
  private void show(){
    stroke(BULLET_COLOR);
    noFill();
    ellipse(pos.x, pos.y, BULLET_RADIUS, BULLET_RADIUS);
  }
  
  void track(Point p){ trackPos=p; }
  
  void update(){
    if(++life>BULLET_LIFE) dead=true;
    if(dead) return;
    
    //update radian
    float aimRadian=getTrackRadian(pos, trackPos);
    float diff=getNormalizeRadian(aimRadian-radian);
    if(diff<DELTA_ROTATE_RADIAN) radian+=diff;
    else if(diff<PI) radian+=DELTA_ROTATE_RADIAN;
    else radian-=DELTA_ROTATE_RADIAN;
    
    //update pos
    pos.x+=velocity*cos(radian);
    pos.y-=velocity*sin(radian);
    
    /*
    pos.x+=2*cos(aimRadian);
    pos.y+=2*sin(aimRadian);
    */
    
    //show
    show();
  }
}