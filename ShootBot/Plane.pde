
class Plane{
  Point pos;
  Point velocity;
  boolean enable;
  
  Plane(){
    pos=new Point();
    velocity=new Point();
    enable=false;
  }

  Plane(Point _pos, Point _v){
    pos=new Point(_pos);
    velocity=_v;
    enable=true;
  }
  
  private void show(){
    noStroke();
    fill(PLANE_COLOR);
    ellipse(pos.x, pos.y, PLANE_WIDTH, PLANE_WIDTH);
  }
  
  void update(){
    if(!enable) return;
    pos.x+=velocity.x;
    pos.y+=velocity.y;
    if(pos.x<PLANE_WIDTH){
      pos.x=PLANE_WIDTH;
      velocity.x=-velocity.x;
    }
    else if(pos.x>SCREEN_WIDTH-PLANE_WIDTH){
      pos.x=SCREEN_WIDTH-PLANE_WIDTH;
      velocity.x=-velocity.x;
    }
    if(pos.y<PLANE_WIDTH){
      pos.y=PLANE_WIDTH;
      velocity.y=-velocity.y;
    }
    else if(pos.y>SCREEN_HEIGHT-PLANE_WIDTH){
      pos.y=SCREEN_HEIGHT-PLANE_WIDTH;
      velocity.y=-velocity.y;
    }
    show();
  }
}