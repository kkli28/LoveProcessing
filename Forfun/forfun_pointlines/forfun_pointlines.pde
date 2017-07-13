class pt{
  int x;
  int y;
  pt(int _x,int _y){
    x=_x;
    y=_y;
  }
};

ArrayList list=new ArrayList<pt>();

void setup(){
  size(800,800);
  smooth();
}

void draw(){
  background(255);
  if(mousePressed){
    list.add(new pt(mouseX,mouseY));
    if(list.size()>12) list.remove(0);
  }
  for(int i=list.size()-1;i>=0;--i){
    for(int j=list.size()-1;j>=0;--j){
      if(i==j) continue;
      pt point1=(pt)list.get(i);
      pt point2=(pt)list.get(j);
      line(point1.x,point1.y,point2.x,point2.y);
    }
  }
}