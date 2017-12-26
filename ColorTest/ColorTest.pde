
final int DELTA_R=#100000;
final int DELTA_G=#000C00;
final int MIN_R=#000000;
final int MAX_R=#FF0000;
final int SLICE_COUNT=16;
final int SCREEN_WIDTH=720;
final int SCREEN_HEIGHT=720;
final int DELTA_WIDTH=SCREEN_WIDTH/SLICE_COUNT;

int c=#00FFFF;

void drawRect(int index){
  c-=DELTA_R;
  c-=DELTA_G;
  fill(c);
  float w=index*DELTA_WIDTH;
  rect(w+DELTA_WIDTH/2, SCREEN_HEIGHT/2, w, SCREEN_HEIGHT);
}

void setup(){
  size(720, 720);
  background(255);
  noStroke();
  for(int i=0;i<SLICE_COUNT;++i) drawRect(i);
}