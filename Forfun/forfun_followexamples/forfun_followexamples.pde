void setup(){
  size(200,200);
  background(255);
}

void draw(){
  if(mouseX<50) cursor(CROSS);
  else cursor(HAND);
}