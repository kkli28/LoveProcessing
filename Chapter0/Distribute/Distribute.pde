float[] randomCounts;
void setup(){
  size(640,320);
  randomCounts=new float[20];
}

void draw(){
  background(255);
  int index=int(random(randomCounts.length));
  ++randomCounts[index];
  stroke(0);
  fill(64);
  int w=width/randomCounts.length;
  for(int i=0;i<randomCounts.length;++i){
    rect(i*w,height-randomCounts[i],w-1,randomCounts[i]);
  }
}