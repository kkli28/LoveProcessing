int w =  8;
int h = 8;
int wid = 1912 / w;
int hei = 1080 / h;
int rate = 10;

int WHITE = 0;
int YELLOW = 1;
int BLUE = 2;
int RED = 3;
int RESULT = 4;

int white = #FFFFFF;
int yellow = #E9FF00;
int blue = #0057FF;
int red = #FF0808;
int resultColor = #FA6E03;

int[][] array = new int[wid][hei];
ArrayList<Point> gaps = new ArrayList<Point>();
boolean success = false;

void initArray() {
  for (int i = 0; i < wid; ++i) {
    for (int j = 0; j < hei; ++j) {
      if (i % 2 == 0 && j % 2 == 0) {
        array[i][j] = YELLOW;  // yellow
      }
      else {
        array[i][j] = WHITE;  // white
      }
    }
  }
  array[1][0] = BLUE;
  array[0][1] = BLUE;
  gaps.add(new Point(1, 0));
  gaps.add(new Point(0, 1));
  array[0][0] = RED;
}

void nextStep() {
  if (success) return;
  if (gaps.size() == 0) {
    success = true;
    return;
  }

  // select yellow to red
  int num = (int)random(0, gaps.size());
  Point p = gaps.get(num);
  setRed(p);
}

void setRed(Point p) {
  Point pL = new Point(p.x-1, p.y);
  Point pR = new Point(p.x+1, p.y);
  Point pU = new Point(p.x, p.y-1);
  Point pD = new Point(p.x, p.y+1);
  array[p.x][p.y] = RED;
  throwe(p.x, p.y);
  if (valid(pL) && isRed(pL)) {
    array[p.x+1][p.y] = RED;
    setB1(new Point(p.x+1, p.y));
  }
  else if (valid(pR) && isRed(pR)) {
    array[p.x-1][p.y] = RED;
    setB1(new Point(p.x-1, p.y));
  }
  else if (valid(pU) && isRed(pU)) {
    array[p.x][p.y+1] = RED;
    setB1(new Point(p.x, p.y+1));
  }
  else if (valid(pD) && isRed(pD)) {
    array[p.x][p.y-1] = RED;
    setB1(new Point(p.x, p.y-1));
  }
}

void setB1(Point p) {
  Point pL = new Point(p.x-1, p.y);
  Point pR = new Point(p.x+1, p.y);
  Point pU = new Point(p.x, p.y-1);
  Point pD = new Point(p.x, p.y+1);
  setB2(pL);
  setB2(pR);
  setB2(pU);
  setB2(pD);
}

void setB2(Point p) {
  if (!valid(p)) return;
  if (array[p.x][p.y] == RED) return;
  if (array[p.x][p.y] == BLUE) {
    array[p.x][p.y] = WHITE;
    throwe(p.x, p.y);
  }
  else {
    array[p.x][p.y] = BLUE;
    gaps.add(new Point(p.x, p.y));
  }
}

void throwe(int x, int y) {
  int size = gaps.size();
  for (int i = 0; i < size; ++i){
    Point p = gaps.get(i);
    if (p.x == x && p.y == y) {
      gaps.remove(i);
      break;
    }
  }
}

boolean isRed(Point p) {
  return array[p.x][p.y] == RED;
}

boolean notRed(Point p) {
  return array[p.x][p.y] != RED;
}

boolean valid(Point p) {
  if (p.x < 0 || p.x >= wid) return false;
  if (p.y < 0 || p.y >= hei) return false;
  return true;
}

void update() {
  for (int i = 0; i < wid; ++i){
    for (int j = 0; j < hei; ++j){
      if (array[i][j] == WHITE) fill(white);
      else if (array[i][j] == YELLOW) fill(yellow);
      else if (array[i][j] == BLUE) fill(blue);
      else if (array[i][j] == RED) fill(red);
      else if (array[i][j] == RESULT) fill(resultColor);
      rect(i*w, j*h, w, h);
    }
  }
}

boolean next = false;
boolean released = false;
void keyPressed() {
  gaps.clear();
  initArray();
}

void clearScreen() {
  fill(255);
  rect(0, 0, 1920, 1080);
  background(0);
}

void setup(){
  background(0);
  fullScreen();
  noStroke();
  initArray();
}

void draw(){
  clearScreen();
  for (int i =  0; i < rate; ++i) {
    nextStep();
  }
  update();
}