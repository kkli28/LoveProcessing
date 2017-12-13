class Constant{
  final static int POLYGON_LINE_COLOR=#038BFF;
  final static int POLYGON_FILL_COLOR=#36FF00;
}

class Point{
  float x;
  float y;
  Point(float _x, float _y){
    x=_x;
    y=_y;
  }
}

class Polygon{
  ArrayList<Point> points;
  
  Polygon(){
    points=new ArrayList<Point>();
  }
  
  void add(Point p){
    points.add(p);
  }
  
  int pointSize(){return points.size();}
  
  int edgeCount(){
    int size=points.size();
    if(size==0 || size==1) return 0;
    if(size==2) return 1;
    else return size;
  }
  
  boolean valid(){return edgeCount()==3;}
  
  void show(){
    if(!valid()) return;
    int size=points.size();
    for(int i=1;i<size;++i){
      Point p1=points.get(i-1);
      Point p2=points.get(i);
      
      stroke(Constant.POLYGON_LINE_COLOR);
      line(p1.x, p1.y, p2.x, p2.y);
    }
    
    Point p1=points.get(size-1);
    Point p2=points.get(0);
    stroke(Constant.POLYGON_LINE_COLOR);
    line(p1.x, p1.y, p2.x, p2.y);
  }
  
  void fill(){
    
  }
}