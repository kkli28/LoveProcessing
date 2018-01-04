class Bullet{
  Point pos;
  Point velocity;
  boolean dead;
  
  Bullet(){
    pos=new Point();
    velocity=new Point();
    dead=true;
  }
  
  Bullet(Point p, Point v){
    pos=new Point(p);
    velocity=new Point(v);
    dead=false;
  }
  
  private float get8DirectionRadian(float r){
    float PI8=PI/8;
    if(r<PI8 || r>TWO_PI-PI8) return 0;
    if(r<PI8*3) return PI8*2;
    if(r<PI8*5) return PI8*4;
    if(r<PI8*7) return PI8*6;
    if(r<PI8*9) return PI8*8;
    if(r<PI8*11) return PI8*10;
    if(r<PI8*13) return PI8*12;
    if(r<PI8*15) return PI8*14;
    return 0;
  }

  private void show(){
    float radian=getNormalizeRadian(atan(velocity.y/velocity.x));
    if(only8Directions) radian=get8DirectionRadian(radian);
    if(velocity.x<0) radian+=PI;
    Point backP=getPoint(pos, radian+PI, BULLET_LINE1);
    Point sideP1=getPoint(pos, radian+0.75*PI, BULLET_LINE2);
    Point sideP2=getPoint(pos, radian-0.75*PI, BULLET_LINE2);
    fill(0);
    stroke(BULLET_COLOR1);
    line(pos.x, pos.y, backP.x, backP.y);
    stroke(BULLET_COLOR2);
    line(pos.x, pos.y, sideP1.x, sideP1.y);
    line(pos.x, pos.y, sideP2.x, sideP2.y);
  }
  
  void update(){
    if(dead) return;
    pos.x+=velocity.x;
    pos.y+=velocity.y;
    
    if(pos.x<0 || pos.x>SCREEN_WIDTH) {
      dead=true;
      return;
    }
    if(pos.y>SCREEN_HEIGHT) {
      if(enableBounce) velocity.y=-velocity.y;
      else {
        dead=true;
        return;
      }
    }
    
    velocity.y+=GRAVITY/2;
    if(velocity.y>0) velocity.y-=0.1;
    else velocity.y+=0.1;
    if(pos.y>SCREEN_HEIGHT*0.9 && abs(velocity.y)<0.1) dead=true;
    if(pos.x<-100 || pos.x>SCREEN_WIDTH+100 || pos.y<-100 || pos.y>SCREEN_HEIGHT+100) dead=true;
    show();
  }
}