
class Bullet{
  Point pos;
  float radian;
  float velocity;
  int life;
  boolean enable;

  Bullet(){
    pos=new Point();
    radian=0.0f;
    velocity=0.0f;
    life=0;
    enable=false;
  }

  Bullet(Point _pos, float _v, float r){
    pos=new Point(_pos);
    radian=r;
    velocity=_v;
    life=0;
    enable=true;
  }
  
  private void show(){
    noStroke();
    fill(BULLET_COLOR);
    ellipse(pos.x, pos.y, BULLET_R, BULLET_R);
  }
  
  void update(){
    if(++life>BULLET_LIFE) enable=false;
    if(!enable) return;
    
    //update pos
    pos.x+=velocity*cos(radian);
    pos.y-=velocity*sin(radian);
    if(pos.x>0 && pos.x<SCREEN_WIDTH && pos.y>0 && pos.y<SCREEN_HEIGHT) show();
    else enable=false;
  }
}