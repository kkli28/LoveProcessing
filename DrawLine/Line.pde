//Line
class Line{
  Point beg;
  Point end;
  int weight;
  double a;
  double b;
  double c;
  double k;
  double cb;
  
  boolean wtf;
  
  ArrayList<Integer> deltaYs;
  ArrayList<Integer> ys;
  
  Line(Point _beg, Point _end, int _weight){
    beg=new Point(_beg.x, _beg.y);
    end=new Point(_end.x, _end.y);
    weight=_weight;
    a=end.y-beg.y;
    b=beg.x-end.x;
    c=end.x*beg.y-beg.x*end.y;
    k=-a/b;
    cb=-c/b;
    
    wtf=false;
    
    deltaYs=new ArrayList<Integer>();
    ys=new ArrayList<Integer>();
  }
  
  private int getInteger(double num){
    
    //if num -> [num, num+0.5) then return num
    //if num -> [num+0.5, num+1) then return num+1
    int n1=(int)num;
    if(n1!=(int)(num-0.5)) return n1;
    else return n1+1;
  }
  
  private void drawUp(int x, int begY, int count, int c){
    int pos=begY*WIDTH+x;
    if(pos<0 || pos>=WIDTH*HEIGHT) {println("begin wtf"); wtf=true; return;}
    if(count==0) pixels[pos]=c;
    else{
      while(count!=0){
        pixels[pos]=c;
        pos-=WIDTH;
        --count;
        if(pos<0 || pos>=WIDTH*HEIGHT) {wtf=true; return;}
      }
    }
  }
  
  private void drawDown(int x, int begY, int count, int c){
    int pos=begY*WIDTH+x;
    if(pos<0 || pos>=WIDTH*HEIGHT) {println("begin wtf"); wtf=true; return;}
    if(count==0) pixels[pos]=c;
    else{
      while(count!=0){
        pixels[pos]=c;
        pos+=WIDTH;
        --count;
        if(pos<0 || pos>=WIDTH*HEIGHT) {wtf=true;return;}
      }
    }
  }
  
  double getY(double x){return k*x+cb;}
  
  void draw(int c){
    int begX=getInteger(beg.x);
    int endX=getInteger(end.x);
    
    if(begX>endX){
      int tempX=begX;
      begX=endX;
      endX=tempX;
    }
    int deltaY=0;
    
    int nowY=abs(getInteger(getY(begX)));
    for(int i=begX+1;i<=endX;++i){
      int y=abs(getInteger(getY(i)));
      ys.add(y);
      
      deltaY=abs(nowY-y);
      deltaYs.add(deltaY);
      
      if(k<0) drawUp(i, nowY, deltaY, c);
      else drawDown(i, nowY, deltaY, c);
      
      if(wtf){
        stroke(#000AFC);
        line((float)beg.x, (float)beg.y, (float)end.x, (float)end.y);
        println("beg.x: ", beg.x, "    beg.y: ", beg.y, "    end.x: ", end.x, "    end.y: ", end.y, "    k: ", k, "    -c/b: ", cb);
        println("begX: ", begX, "    endX: ", endX, "    i: ", i,"    nowY: ", nowY);
        println("y: ", k*i+cb, "    getInteger(y): ", y, "    deltaY: ", deltaY);
        print("deltaYs: ");
        for(int j=0;j<deltaYs.size();++j) print(deltaYs.get(j), "  ");
        print("ys: ");
        for(int j=0;j<ys.size();++j) print(ys.get(j), " ");
        println();
        stopDraw=true;
        noLoop();
        return;
      }
      
      nowY=y;
    }
    
    println("done");
  }
}