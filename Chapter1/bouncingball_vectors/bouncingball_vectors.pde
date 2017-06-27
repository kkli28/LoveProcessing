class PVector{
  float x;
  float y;
  PVector(float _x,float _y){
    x=_x;
    y=_y;
  }
  void add(PVector v){
    x+=v.x;
    y+=v.y;
  }
};

PVector location;
PVector velocity;

void setup(){
  size(600,600);
  smooth();
  location=new PVector(100,100);
  velocity=new PVector(5,10);
}

void draw(){
  background(255);
  location.add(velocity);
  if((location.x>width-16) || (location.x<0+16)){
    velocity.x*=-1;
  }
  if((location.y>height-16) || (location.y<0+16)){
    velocity.y*=-1;
  }
  stroke(0);
  fill(175);
  ellipse(location.x,location.y,16,16);
}