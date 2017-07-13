void setup(){
  size(640,320);
}

void draw(){
  float num=(float)randomGaussian();
  float sd=60;
  float mean=320;
  float x=sd*num+mean;
  noStroke();
  fill(255,10);
  ellipse(x,180,16,16);
}