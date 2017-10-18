//============================================================
// constant
//============================================================

final int DEFAULT_BALL_VX=4;
final int DEFAULT_BALL_VY=-4;
final int DEFAULT_BAR_VX=8;
final int SCREEN_WIDTH=1200;
final int SCREEN_HEIGHT=800;
final int BRICK_WIDTH=80;
final int BRICK_HEIGHT=24;
final int ACCELERATE_FACTOR=4;
final int MAX_LIFE=6;

//============================================================
// Brick
//============================================================

class Brick {
  int x;
  int y;
  int w;
  int h;
  private int life;

  Brick(int _x, int _y, int _w, int _h) {
    set(_x, _y, _w, _h, 1);
  }

  void set(int _x, int _y, int _w, int _h, int _l) {
    x=_x;
    y=_y;
    w=_w;
    h=_h;
    life=_l;
  }

  int getLife() {
    return life;
  }

  void setLife(int lf) {
    life=max(0, min(lf, MAX_LIFE));
  }

  void show() {
    rect(x, y, w, h);
  }

  void showWithLife() {
    switch(life) {
    case 1: 
      fill(#0EFF03);
      break; //green
    case 2: 
      fill(#03FFD3);
      break; //light blue
    case 3: 
      fill(#FEFF03);
      break; //goden
    case 4: 
      fill(#FF0303);
      break; //orange
    case 5: 
      fill(#5A03FF);
      break; //blue
    case 6: 
      fill(#FF03C9);
      break; //purple
    default: 
      break;
    }
    rect(x, y, w, h);
  }
}

//============================================================
// Ball
//============================================================

class Ball {
  int x;
  int y;
  int r;
  int vx;
  int vy;
  boolean behindScreen=false;

  Ball(int _x, int _y, int _r) {
    set(_x, _y, _r, DEFAULT_BALL_VX, DEFAULT_BALL_VY);
  }

  void set(int _x, int _y, int _r, int _vx, int _vy) {
    x=_x;
    y=_y;
    r=_r;
    vx=_vx;
    vy=_vy;
  }

  void move() {
    x+=vx;
    if (x-r<0) {
      x=r;
      vx=-vx;
    } else if (x>SCREEN_WIDTH-r) {
      x=SCREEN_WIDTH-r;
      vx=-vx;
    }
    y+=vy;
    if (y-r<0) {
      y=r;
      vy=-vy;
    } else if (y>SCREEN_HEIGHT+r) {
      behindScreen=true;
      vy=-vy;
    }
  }

  void show() {
    fill(#FF030B);
    ellipse(x, y, r, r);
  }

  boolean checkHit(Brick b) {
    if ((x+r)>b.x && (x-r)<(b.x+b.w)) {
      if ((y-r)<(b.y+b.h) && (y+r)>b.y) {
        int enterXDepth=0;
        int enterYDepth=0;
        if (vx>0) enterXDepth=x+r-b.x;
        else enterXDepth=b.x+b.w-(x-r);
        if (vy>0) enterYDepth=y+r-b.y;
        else enterYDepth=b.y+b.h-(y-r);

        if (enterXDepth>enterYDepth) {
          if (vy>0) y=b.y-r;
          else y=b.y+b.h+r;
          vy=-vy;
        } else if (enterXDepth<enterYDepth) {
          if (vx>0) x=b.x-r;
          else x=b.x+b.w+r;
          vx=-vx;
        } else {
          vx=-vx;
          vy=-vy;
        }

        return true;
      }
    }
    return false;
  }
}

//============================================================
// variable
//============================================================

ArrayList<Brick> bricks=new ArrayList<Brick>();
Ball ball=new Ball(SCREEN_WIDTH/2, SCREEN_HEIGHT-220, 16);
Brick bar=new Brick(SCREEN_WIDTH/2-60, SCREEN_HEIGHT-100, 120, 20);
int barV=DEFAULT_BAR_VX;
int barVSign=0;
int[] keys=new int[2];
boolean gameStart=false;
int score=0;

//============================================================
// function
//============================================================

void clearScreen() {
  noStroke();
  fill(255);
  rect(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
}

void initBricks() {
  for (int i=BRICK_WIDTH; i<SCREEN_WIDTH-200; i+=BRICK_WIDTH+20) {
    for (int j=BRICK_HEIGHT*3; j<SCREEN_HEIGHT-400; j+=BRICK_HEIGHT+30) {
      Brick b=new Brick(i, j, BRICK_WIDTH, BRICK_HEIGHT);
      b.setLife((int)random(1, 7));
      bricks.add(b);
    }
  }
}

void updateBar() {
  if (keys[0]==1) {
    bar.x-=barV;
    if (bar.x<0) bar.x=0;
  } else if (keys[1]==1) {
    bar.x+=barV;
    if (bar.x+bar.w>SCREEN_WIDTH) bar.x=SCREEN_WIDTH-bar.w;
  }
}

void showBricks() {
  for (Brick b : bricks) b.showWithLife();
}

void keyPressed() {
  gameStart=true;
  loop();
  if (keyCode==LEFT) keys[0]=1;
  else if (keyCode==RIGHT) keys[1]=1;

  if (keys[0]==1 && keys[1]==1) barVSign=0;
  else if (keys[0]==1) barVSign=-1;
  else if (keys[1]==1) barVSign=1;
  else barVSign=0;
}

void keyReleased() {
  if (keyCode==LEFT) keys[0]=0;
  else if (keyCode==RIGHT) keys[1]=0;

  if (keys[0]==1 && keys[1]==1) barVSign=0;
  else if (keys[0]==1) barVSign=-1;
  else if (keys[1]==1) barVSign=1;
  else barVSign=0;
}

void showScore() {
  textSize(16);
  fill(#FF030B);
  textAlign(LEFT);
  text("Score: "+new Integer(score).toString(), 24, 24);
}

void gameStartTip() {
  fill(#FF030B);
  textAlign(CENTER);
  textSize(36);
  text("Press any key to start.", SCREEN_WIDTH/2, SCREEN_HEIGHT/2-40);
  text("Use <-- and --> to control the bar.", SCREEN_WIDTH/2, SCREEN_HEIGHT/2+40);
}

void gameOver() {
  clearScreen();
  textSize(72);
  fill(#FF030B);
  textAlign(CENTER);
  text("Game Over!\nScore: "+new Integer(score).toString(), SCREEN_WIDTH/2, SCREEN_HEIGHT/2-100);
  noLoop();
}

void processBallBrickHit(){
  for (int i=0; i<bricks.size(); ++i) {
    Brick b=bricks.get(i);
    if (ball.checkHit(b)) {
      b.setLife(b.getLife()-1);
      if (b.getLife()==0) {
        bricks.remove(i);
        ++score;
        --i;
      }
    }
  }
}

//============================================================
// setup && draw
//============================================================

void setup() {
  size(1200, 800);
  //fullScreen();
  background(255);
  noStroke();
  initBricks();
  gameStartTip();
  noLoop();
}

void draw() {
  if (!gameStart) return;
  clearScreen();

  showScore();

  updateBar();
  fill(#767676);
  bar.show();

  ball.move();
  if (ball.behindScreen) {
    gameOver();
    return;
  }

  if (ball.checkHit(bar)) ball.vx+=barVSign*barV/ACCELERATE_FACTOR;
  processBallBrickHit();
  
  ball.show();
  showBricks();
}