ghost[] gs;

void setup(){
  fullScreen();
  smooth();
  gs=new ghost[GHOST_COUNT];
  for(int i=0;i<GHOST_COUNT;++i){
    gs[i]=new ghost();
  }
  noStroke();
}

void draw(){
  if(mousePressed){
    for(int i=0;i<GHOST_COUNT;++i){
      gs[i]=new ghost();
    }
    background(0);
    return;
  }
  background(0);
  for(int i=0;i<GHOST_COUNT;++i){
    gs[i].move();
    gs[i].display();
  }
}