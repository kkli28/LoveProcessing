class Walker{
  int x;
  int y;
  Walker(){
    x=width/2;
    y=height/2;
  }
  void step(){
    int stepx=int(random(3))-1;
    int stepy=int(random(3))-1;
    x+=stepx*4;
    y+=stepy*4;
    if(x<0) x+=width;
    else if(x>=width) x-=width;
    if(y<0) y+=height;
    else if(y>=height) y-=height;
  }
  void display(){
    stroke(0);
    point(x,y);
    point(x,y+1);
    point(x+1,y);
    point(x+1,y+1);
  }
};

Walker walker;

void setup(){
  size(640,320);
  background(255);
  walker=new Walker();
}

void draw(){
  walker.step();
  walker.display();
}