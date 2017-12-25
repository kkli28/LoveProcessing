
class Radius{
  float r;
  Radius(float _r){
    r=_r;
  }
}

class Hole{
  Point pos;
  ArrayList<Radius> rs;
  int cycle;
  
  Hole(Point p){
    pos=new Point(p);
    rs=new ArrayList<Radius>();
    cycle=0;
    float deltaR=HOLE_ELLIPSE_MAX_R/HOLE_ELLIPSE_COUNT;
    for(int i=1;i<=HOLE_ELLIPSE_COUNT;++i){
      rs.add(new Radius(i*deltaR));
    }
  }
  
  private void show(){
    noFill();
    for(Radius radius: rs) {
      int i=HOLE_ELLIPSE_COUNT-int(radius.r/HOLE_DELTA_R);
      stroke(MAX_R-i*DELTA_R, MAX_G-i*DELTA_G, 0xff);
      ellipse(pos.x, pos.y, radius.r, radius.r);
    }
  }
  
  void update(){
    if(++cycle>=HOLE_UPDATE_CYCLE){
      cycle=0;
      for(Radius radius: rs) {
        radius.r-=hole_ellipse_delta_r;
        if(radius.r<HOLE_ELLIPSE_MIN_R) radius.r+=HOLE_ELLIPSE_MAX_R;
      }
    }
    show(); 
  }
}