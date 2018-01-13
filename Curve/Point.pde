class Point{
    float x;
    float y;
    Point(){}
    Point(float xx, float yy){
        x=xx;
        y=yy;
    }
    Point(Point p){
        x=p.x;
        y=p.y;
    }
}

//getRadian
float getRadian(Point p1, Point p2){
    float deltaX=p2.x-p1.x;
    float deltaY=p2.y-p1.y;
    float cosA=deltaX/sqrt(deltaX*deltaX+deltaY*deltaY);
    if(deltaY>0) return TWO_PI-acos(cosA);
    else return acos(cosA);
}

//getPoint
Point getPoint(Point p1, float radian, float len){
    float x=len*cos(radian);
    float y=len*sin(radian);
    return new Point(p1.x+x, p1.y-y);
}

//getDistance
float getDistance(Point p1, Point p2){
    float x=p1.x-p2.x;
    float y=p1.y-p2.y;
    return sqrt(x*x+y*y);
}


//getNormalizeRadian
float getNormalizeRadian(float radian){
  if(radian>0 && radian<2*PI) return radian;
  
  if(radian<0){
    int c=int((-radian)/(2*PI))+1;
    radian+=c*2*PI;
  }
  
  //radian >= 2*PI
  else{
    int c=int(radian/(2*PI));
    radian-=c*2*PI;
  }
  
  return radian;
}

class C{
    Point start;
    Point end;
    ArrayList<Point> points;
    boolean finished;

    C(){ points=new ArrayList<Point>(); finished=true; }
    C(Point s, Point e){
        start=new Point(s);
        end=new Point(e);
        points=new ArrayList<Point>();
        points.add(start);
        int i=0;
        while(!finished) {
          println(i++);
          if(i==40) break;
          calcPoints();
        }
    }

    private void calcPoints(){
        float old_radian=DEFAULT_RADIAN;
        int size=points.size();
        if(size==0) {
          return;
        }
        if(size!=1){
            old_radian=getRadian(points.get(size-2), points.get(size-1));
        }
        
        float new_radian=getRadian(points.get(size-1), end);
        old_radian=getNormalizeRadian(old_radian);
        new_radian=getNormalizeRadian(new_radian);
        float diff_radian=old_radian>new_radian? old_radian-new_radian: new_radian-old_radian;
        
        boolean neg=false;
        if(old_radian>new_radian){
          if(diff_radian>PI) diff_radian=TWO_PI-diff_radian;
          else neg=true;
        }
        else{
          //old_radian<new_radian
          if(diff_radian>PI){
            diff_radian=TWO_PI-diff_radian;
            neg=true;
          }
        }
        if(diff_radian<DELTA_RADIAN) {
            old_radian=new_radian;
            if(getDistance(points.get(size-1), end)<=DELTA_LENGTH){
              points.add(end);
              finished=true;
              return;
            }
        }
        else{
          old_radian=neg?old_radian-DELTA_RADIAN: old_radian+DELTA_RADIAN;
        }
        
        points.add(getPoint(points.get(size-1), old_radian, DELTA_LENGTH));
    }

    void draw(){
        int size=points.size();
        if(size==0) {
          return;
        }
        if(size==1) {
          return;
        }
        --size;
        Point p1=new Point();
        Point p2=new Point();
        for(int i=0;i<size;++i){
            stroke(LINE_COLOR);
            p1=points.get(i);
            p2=points.get(i+1);
            line(p1.x, p1.y, p2.x, p2.y);
        }
        noStroke();
        fill(POINT_COLOR);
        for(int i=0;i<=size;++i){
            p1=points.get(i);
            ellipse(p1.x, p1.y, POINT_R, POINT_R);
            //text(i, p1.x, p1.y);
        }
    }
}