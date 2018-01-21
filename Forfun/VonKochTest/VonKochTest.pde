color getRandomColor(){
  return color(random(256),random(256),random(256));
}

class Point {
  float x;
  float y;
  Point(float _x, float _y) {
    x=_x;
    y=_y;
  }
};

class VonKoch {
  float side;
  float angle;
  int level;
  Point currPt;
  Point prevPt;

  private void rotateLeft(float x) {
    angle-=x;
  }

  private void rotateRight(float x) {
    angle+=x;
  }

  private void drawFourLines(float s, int l) {
    if (l==0) {
      prevPt.x=currPt.x+(float)(cos(angle/180*PI)*s);
      prevPt.y=currPt.y+(float)(sin(angle/180*PI)*s);
      stroke(lineColor);
      line(currPt.x, currPt.y, prevPt.x, prevPt.y);
      currPt.x=prevPt.x;
      currPt.y=prevPt.y;
    } else {
      drawFourLines(s/3, l-1);
      rotateLeft(60);
      drawFourLines(s/3, l-1);
      rotateRight(120);
      drawFourLines(s/3, l-1);
      rotateLeft(60);
      drawFourLines(s/3, l-1);
    }
  }

  //Construct
  public VonKoch(float s, int l) {
    side=s;
    angle=0;
    level=l;
    currPt=new Point(width/3,height/3);
    prevPt=new Point(0, 0);
  }

  public void draw() {
    for (int i=0; i<3; ++i) {
      drawFourLines(side, level);
      rotateRight(120);
    }
  }
};

color red=#FF0D0D;
color green=#3FFF00;
color blue=#0052FF;
int white=255;
int black=0;

color lineColor=green;
int back=black;

void setup() {
  fullScreen();
  background(back);
  strokeWeight(3);
  VonKoch vk=new VonKoch(640, 4);
  vk.draw();
  String imageName="kkli_"+(back==white?"white":"black")+"_";
  if(lineColor==red) imageName+="red";
  else if(lineColor==green) imageName+="green";
  else imageName+="blue";
  save(imageName);
}

void draw() {
  if (keyPressed) {
    exit();
  }
}