void setup(){
  size(600,600);
  background(0);
}

void draw(){
  PVector mouse=new PVector(mouseX,mouseY);
  int w=int(mouse.x);
  int h=int(mouse.y);
  w=w-w%4;
  h=h-h%4;
  fill(255);
  rect(w,h,4,4);
}