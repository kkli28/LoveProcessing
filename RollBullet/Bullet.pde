class Bullet{
  Point p1;
  Point p2;
  Point p3;
  Point p4;
  Point velocity;
  float sideLength;
  float deltaRadian;
  float radian;
  
  Bullet(Point p, Point v, float len, float dr){
    p1=new Point(p);
    velocity=new Point(v);
    sideLength=len;
    deltaRadian=dr;
    radian=0;
    updatePoints();
  }
  
  private void updatePoints(){
    p2=getPoint(p1, radian, sideLength);
    p3=getPoint(p1, radian+TWO_PI/3, sideLength);
    p4=getPoint(p1, radian+TWO_PI*2/3, sideLength);
  }
  
  private void show(){
    stroke(BULLET_LINE_COLOR);
    line(p1.x, p1.y, p2.x, p2.y);
    line(p1.x, p1.y, p3.x, p3.y);
    line(p1.x, p1.y, p4.x, p4.y);
    noStroke();
    fill(BULLET_POINT_COLOR1);
    ellipse(p1.x, p1.y, BULLET_POINT_R1, BULLET_POINT_R1);
    fill(BULLET_POINT_COLOR2);
    ellipse(p2.x, p2.y, BULLET_POINT_R2, BULLET_POINT_R2);
    ellipse(p3.x, p3.y, BULLET_POINT_R2, BULLET_POINT_R2);
    ellipse(p4.x, p4.y, BULLET_POINT_R2, BULLET_POINT_R2);
  }
  
  void update(){
    p1.x+=velocity.x;
    p1.y+=velocity.y;
    if(p1.x<0) {
      p1.x=0;
      velocity.x=-velocity.x;
    }
    else if(p1.x>SCREEN_WIDTH) {
      p1.x=SCREEN_WIDTH;
      velocity.x=-velocity.x;
    }
    if(p1.y<0) {
      p1.y=0;
      velocity.y=-velocity.y;
    }
    else if(p1.y>SCREEN_HEIGHT) {
      p1.y=SCREEN_HEIGHT;
      velocity.y=-velocity.y;
    }
    
    updatePoints();
    show();
    
    radian+=deltaRadian;
    if(radian>TWO_PI) radian-=TWO_PI;
  }
}