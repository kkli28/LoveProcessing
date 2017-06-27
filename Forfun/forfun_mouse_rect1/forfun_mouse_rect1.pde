void setup(){
  size(400,400);
  background(255);
}

int r=0;
int g=0;
int b=0;
color c=color(r,g,b);

boolean dr=false;
boolean cl=false;

void mousePressed(){
  if(mouseButton==LEFT) dr=true;
  else if(mouseButton==RIGHT) cl=true;
}

void mouseReleased(){
  if(mouseButton==LEFT) dr=false;
  else if(mouseButton==RIGHT) cl=false;
}

void draw(){
  if(dr||cl){
  int w=int(mouseX);
  int h=int(mouseY);
  w-=w%4;
  h-=h%4;
  if(dr)
  fill(color(#00FF00));
  else fill(color(#FFFFFF));
  rect(w,h,4,4);
  }
}