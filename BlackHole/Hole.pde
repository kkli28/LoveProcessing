
final int HOLE_ELLIPSE_COLOR=#0057FF;
final int HOLE_ELLIPSE_COUNT=8;
final int HOLE_ELLIPSE_MAX_R=240;
final int HOLE_ELLIPSE_MIN_R=4;
final int HOLE_ATTRACTION=4;
final int HOLE_UPDATE_CYCLE=1;
final float HOLE_ELLIPSE_DELTA_R=0.5;

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
    stroke(HOLE_ELLIPSE_COLOR);
    noFill();
    for(Radius radius: rs) {
      ellipse(pos.x, pos.y, radius.r, radius.r);
    }
  }
  
  void update(){
    if(++cycle>=HOLE_UPDATE_CYCLE){
      cycle=0;
      for(Radius radius: rs) {
        radius.r-=HOLE_ELLIPSE_DELTA_R;
        if(radius.r<HOLE_ELLIPSE_MIN_R) radius.r+=HOLE_ELLIPSE_MAX_R;
      }
    }
    show(); 
  }
}