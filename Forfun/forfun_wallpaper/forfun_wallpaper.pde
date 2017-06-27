  
void setup() {
  fullScreen();
}

int x1=0;
int y1=0;
int stepx1=16;
int stepy1=16;
int x2=1920;
int y2=1080;
int stepx2=-16;
int stepy2=-16;

void draw() {
  color c=color(0,int(random(120,256)),int(random(120,256)));
  fill(c);
  ellipse(x1,y1,16,16);
  x1+=stepx1;
  y1+=stepy1;
  if(x1<0 || x1>1920) stepx1*=-1;
  if(y1<0 || y1>1080) stepy1*=-1;
  
  c=color(0,int(random(120,256)),int(random(120,256)));
  fill(c);
  ellipse(x2,y2,16,16);
  x2+=stepx2;
  y2+=stepy2;
  if(x2<0 || x2>1920) stepx2*=-1;
  if(y2<0 || y2>1080) stepy2*=-1;
}