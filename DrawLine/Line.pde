//Line
class Line{
  Point beg;
  Point end;
  int weight;
  float a;
  float b;
  float c;
  float k;
  float cb;
  
  Line(Point _beg, Point _end, int _weight){
    beg=new Point(_beg.x, _beg.y);
    end=new Point(_end.x, _end.y);
    weight=_weight;
    a=end.y-beg.y;
    b=beg.x-end.x;
    c=end.x*beg.y-beg.x*end.y;
    k=-a/b;
    cb=-c/b;
  }
  
  private int getInteger(float num){
    int n1=int(num);
    int n2=int(num-0.5f);
    if(n1!=n2) return n1;
    else return n1+1;
  }
  
  private void drawVerticallyUp(int x, int begY, int count, int c){
    int pos=begY*WIDTH+x;
    if(count==0) pixels[pos]=c;
    else{
      while(count!=0){
        pixels[pos]=c;
        pos-=WIDTH;
        --count;
      }
    }
  }
  
  private void drawVerticallyDown(int x, int begY, int count, int c){
    int pos=begY*WIDTH+x;
    if(count==0) pixels[pos]=c;
    else{
      while(count!=0){
        pixels[pos]=c;
        pos+=WIDTH;
        --count;
      }
    }
  }
  
  void draw(int c){
    int begX=getInteger(beg.x);
    int endX=getInteger(end.x);
    int nowY=getInteger(beg.y);
    if(begX>endX){
      int tempX=begX;
      begX=endX;
      endX=tempX;
      nowY=getInteger(end.y);
    }
    int count=0;
    
    loadPixels();
    
    //k < 0
    if(k<0){
      for(int i=begX;i<=endX;++i){
        count=nowY-getInteger(k*i+cb);
        if(count<0){
          updatePixels();
          stroke(#000AFC);
          line(beg.x, beg.y, end.x, end.y);
          println(begX, endX, count);
          return;
        }
        drawVerticallyUp(i, nowY, count, c);
        nowY-=count;
      }
    }
    
    //k > 0
    else{
      for(int i=begX;i<=endX;++i){
        count=getInteger(k*i+cb)-nowY;
        if(count<0){
          updatePixels();
          stroke(#000AFC);
          line(beg.x, beg.y, end.x, end.y);
          println(begX, endX, count);
          return;
        }
        drawVerticallyDown(i, nowY, count, c);
        nowY+=count;
      }
    }
    updatePixels();
  }
}