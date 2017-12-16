class Bullet{
  final int r=6;
  final int life=120;
  
  Point pos;
  Point trackPos;
  int count;
  float angle;
  
  Bullet(Point _p){
    pos=new Point(_p);
    count=0;
    trackPos=new Point(random(SCREEN_WIDTH), random(SCREEN_HEIGHT));
  }
  
  void show(){
    stroke(BULLET_COLOR);
    noFill();
    ellipse(pos.x, pos.y, r, r);
  }
  
  void track(Point p){
    trackPos=new Point(p);
  }
  
  void update(){
    
  }
}