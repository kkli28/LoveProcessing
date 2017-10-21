//============================================================
// constant
//============================================================

final int DEFAULT_BALL_VX=4;
final int DEFAULT_BALL_VY=-4;
final int DEFAULT_BALL_V=12;
final int DEFAULT_BALL_R=8;
final int DEFAULT_BAR_WIDTH=72;
final int DEFAULT_BAR_HEIGHT=12;
final int DEFAULT_BAR_VX=8;
final int MAX_BAR_VX=16;
final int MIN_BAR_VX=2;
final int MAX_BAR_WIDTH=256;
final int MIN_BAR_WIDTH=12;
final int SCREEN_WIDTH=1280;
final int SCREEN_HEIGHT=800;
final int DEFAULT_BRICK_WIDTH=80;
final int DEFAULT_BRICK_HEIGHT=24;
final int DEFAULT_BRICK_R=16;
final int ACCELERATE_FACTOR=4;
final int MAX_LIFE=6;
final int MAX_DAMAGE=6;

final int RECT_TYPE=0;
final int BALL_TYPE=1;

final float PROP_OCCUR_CHANCE=0.5;

final int PROP_INCREASE_BAR_WIDTH=0;
final int PROP_DECREASE_BAR_WIDTH=1;
final int PROP_INCREASE_BAR_VX=2;
final int PROP_DECREASE_BAR_VX=3;
final int PROP_INCREASE_BALL_DAMAGE=4;

final int PROP_RECT_WIDTH=64;
final int PROP_RECT_HEIGHT=24;
final int PROP_BALL_R=12;
final int PROP_TEXT_SIZE=12;

final int PROP_DELTA_INCREASE_WIDTH=12;
final int PROP_DELTA_INCREASE_VX=4;
final int PROP_DELTA_INCREASE_DAMAGE=1;

final int DEFAULT_WAGGLE_TIME=60;
final float DEFAULT_WAGGLE_R=0.1;
final float DEFAULT_WAGGLE_X=0.2;

//============================================================
// Brick
//============================================================

class RectType {
}
class BallType {
}

class Prop {
  float x;
  float y;
  float w;
  float h;
  float vy;
  int type;

  Prop(float _x, float _y) {
    x=_x;
    y=_y;
    vy=2;
    w=PROP_RECT_WIDTH;
    h=PROP_RECT_HEIGHT;
    type=(int)random(PROP_INCREASE_BALL_DAMAGE+1);
    if (type==PROP_INCREASE_BALL_DAMAGE) type=(int) random(PROP_INCREASE_BALL_DAMAGE+1);
  }

  void move() {
    y+=vy;
  }

  void show() {
    String str="";
    switch(type) {
    case PROP_INCREASE_BAR_WIDTH:
      str="<-->";
      break;
    case PROP_DECREASE_BAR_WIDTH:
      str=">--<";
      break;
    case PROP_INCREASE_BAR_VX:
      str="<< >>";
      break;
    case PROP_DECREASE_BAR_VX:
      str=">> <<";
      break;
    case PROP_INCREASE_BALL_DAMAGE:
      str="DAMAGE";
      break;
    default:
      str="wtf?";
      break;
    }
    fill(#FFC400);
    textSize(PROP_TEXT_SIZE);
    textAlign(CENTER);
    noFill();
    stroke(#FFC400);
    strokeWeight(1);
    rect(x, y, w, h);
    text(str, x+w/2, y+h*2/3);
    noStroke();
  }
}

class Brick {
  float x;
  float y;

  float w;
  float h;

  float r;
  float vx;
  float vy;
  private int damage;

  int waggleTime;
  float deltaWaggleR;
  float deltaWaggleX;
  int type;
  private int life;

  Brick(float _x, float _y, RectType t) {
    setRect(_x, _y, DEFAULT_BRICK_WIDTH, DEFAULT_BRICK_HEIGHT);
    type=RECT_TYPE;
    initWaggle();
  }

  Brick(float _x, float _y, BallType t) {
    setBall(_x, _y, DEFAULT_BRICK_R, DEFAULT_BALL_VX, DEFAULT_BALL_VY);
    type=BALL_TYPE;
    initWaggle();
    deltaWaggleR=DEFAULT_WAGGLE_R;
    r+=(DEFAULT_WAGGLE_TIME-waggleTime)*deltaWaggleR;
  }

  void initWaggle() {
    waggleTime=(int)random(0, DEFAULT_WAGGLE_TIME);
    deltaWaggleX=DEFAULT_WAGGLE_X;
    x+=(DEFAULT_WAGGLE_TIME-waggleTime)*deltaWaggleX;
  }

  void waggle() {
    x+=deltaWaggleX;
    if(type==BALL_TYPE) r+=deltaWaggleR;
    --waggleTime;
    if (waggleTime<=0) {
      waggleTime=60;
      deltaWaggleR=-deltaWaggleR;
      deltaWaggleX=-deltaWaggleX;
    }
  }

  void setRect(float _x, float _y, float _w, float _h) {
    x=_x;
    y=_y;
    w=_w;
    h=_h;
  }

  void setBall(float _x, float _y, float _r, float _vx, float _vy) {
    x=_x;
    y=_y;
    r=_r;
    vx=_vx;
    vy=_vy;
    damage=1;
    if (vy==0) vy=0.2;
  }

  int getLife() {
    return life;
  }

  void setLife(int lf) {
    life=max(0, min(lf, MAX_LIFE));
  }

  int getDamage() {
    return damage;
  }

  void setDamage(int d) {
    damage=max(0, min(d, MAX_DAMAGE));
  }

  void show() {
    if (type==RECT_TYPE) rect(x, y, w, h);
    else ellipse(x, y, r+r, r+r);
  }

  boolean behindScreen() {
    return y>SCREEN_HEIGHT+r;
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
      vy=-vy;
    }
  }

  private boolean checkRectHit(Brick b) {
    if ((x+r)>b.x && (x-r)<(b.x+b.w)) {
      if ((y-r)<(b.y+b.h) && (y+r)>b.y) {
        float enterXDepth=0;
        float enterYDepth=0;
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

  private void rebound(Brick b) {
    float v1x=x-b.x;
    float v1y=y-b.y;
    float v2x=1;
    float cosCelta=(v1x*v2x)/(sqrt(v1x*v1x+v1y*v1y)*sqrt(v2x*v2x));
    float sinCelta=sin(acos(cosCelta));
    float b1V=sqrt(vx*vx+vy*vy);

    vx=b1V*cosCelta;
    if (v1y<0) vy=-b1V*sinCelta;
    else  vy=b1V*sinCelta;

    if (vx==0) vx=0.4;
    if (vy==0) vy=0.4;
  }

  private boolean checkBallHit(Brick b) {
    float sumR=r+b.r;
    sumR=sumR*sumR;
    float disX=x-b.x;
    float disY=y-b.y;
    float squareDis=disX*disX+disY*disY;

    if (squareDis<sumR) {
      rebound(b);
      return true;
    }
    return false;
  }

  boolean checkHit(Brick b) {
    if (b.type==RECT_TYPE) return checkRectHit(b);
    else return checkBallHit(b);
  }

  void showWithLife() {
    switch(life) {
    case 1: 
      fill(#86FFFC);
      break;
    case 2: 
      fill(#FF003C);
      break;
    case 3: 
      fill(#004AFF);
      break;
    case 4: 
      fill(#F6FF00);
      break;
    case 5: 
      fill(#FFBC00);
      break;
    case 6: 
      fill(#FF4800);
      break;
    default: 
      break;
    }
    if (type==RECT_TYPE) rect(x, y, w, h);
    else ellipse(x, y, r+r, r+r);
  }
}

//============================================================
// variable
//============================================================

ArrayList<Brick> bricks=new ArrayList<Brick>();
ArrayList<Prop> props=new ArrayList<Prop>();
Brick ball=new Brick(SCREEN_WIDTH/2, SCREEN_HEIGHT-220, new BallType());
Brick bar=new Brick(SCREEN_WIDTH/2-60, SCREEN_HEIGHT-100, new RectType());
int barV=DEFAULT_BAR_VX;
int barVSign=0;
int[] keys=new int[2];
boolean gameStart=false;
boolean gameOver=false;
boolean gameStop=false;
boolean gameWin=false;
boolean showGameInit=false;
int score=0;

//============================================================
// function
//============================================================

void showStartTip() {
  fill(#FF030B);
  textAlign(CENTER);
  textSize(36);
  text("Press any key to start.", SCREEN_WIDTH/2, SCREEN_HEIGHT/2-80);
  text("Use <-- and --> to control the bar.", SCREEN_WIDTH/2, SCREEN_HEIGHT/2);
  text("Use UP key to stop game.", SCREEN_WIDTH/2, SCREEN_HEIGHT/2+80);
}

void clearScreen() {
  noStroke();
  fill(255);
  rect(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
}

void initBricks() {
  bricks.clear();
  float rand=random(0, 1);
  int sameType=0;   //random type
  if (rand<0.3) sameType=1;   //ball type
  if (rand>0.7) sameType=2;   //rect type

  for (int i=100; i<=SCREEN_WIDTH-100; i+=DEFAULT_BRICK_WIDTH+40) {

    int offset=26;
    for (int j=DEFAULT_BRICK_HEIGHT*4; j<SCREEN_HEIGHT-300; j+=DEFAULT_BRICK_HEIGHT+30) {
      Brick b;
      int type;
      if (sameType==1) type=BALL_TYPE;
      else if (sameType==2)  type=RECT_TYPE;
      else {
        type=(int)random(2);
      }

      if (type==RECT_TYPE) b=new Brick(i-DEFAULT_BRICK_WIDTH/2, j-DEFAULT_BRICK_HEIGHT/2, new RectType());
      else {
        int x=i;
        int y=j;
        if (sameType==1) {
          x+=offset;
          offset=-offset;
        }
        b=new Brick(x, y, new BallType());
      }
      b.setLife((int)random(1, 7));
      bricks.add(b);
    }
  }
}

void initBall() {
  ball.setBall((float)SCREEN_WIDTH/2, (float)SCREEN_HEIGHT-160, (float)DEFAULT_BALL_R, (float)DEFAULT_BALL_VX, (float)DEFAULT_BALL_VY);
  ball.damage=1;
  ball.vx=random(2, 6);
  if (random(1)<0.5) ball.vx=-ball.vx;
  ball.vy=abs(ball.vx)-8;
}

void initBar() {
  bar.setRect(SCREEN_WIDTH/2-60, SCREEN_HEIGHT-100, (float)DEFAULT_BAR_WIDTH, (float)DEFAULT_BAR_HEIGHT);
  barV=DEFAULT_BAR_VX;
  barVSign=0;
}

void gameInit() {
  clearScreen();
  bricks.clear();
  props.clear();
  initBricks();
  initBall();
  initBar();
  score=0;
  showStartTip();
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
  //win
  if (gameWin) return;

  //game over
  if (gameOver) {
    gameOver=false;
    showGameInit=true;
    loop();
    return;
  }

  //stop game
  if (keyCode==UP) {
    gameStop=true;
    noLoop();
    return;
  }

  //other situations
  loop();
  gameStop=false;
  gameStart=true;

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

void showBallDamage() {
  textSize(16);
  fill(#FF3639);
  textAlign(LEFT);
  text("Damage: "+new Integer(ball.damage).toString(), 128, 24);
}

void gameOver() {
  //change status
  noLoop();
  gameOver=true;

  clearScreen();
  textSize(72);
  fill(#FF030B);
  textAlign(CENTER);
  text("Game Over!", SCREEN_WIDTH/2, SCREEN_HEIGHT/2-60);
  textSize(48);
  text("Score: "+ new Integer(score).toString(), SCREEN_WIDTH/2, SCREEN_HEIGHT/2+40);
}

void processBallBrickHit() {
  for (int i=0; i<bricks.size(); ++i) {
    Brick b=bricks.get(i);
    if (ball.checkHit(b)) {
      b.setLife(b.getLife()-ball.getDamage());
      if (b.getLife()==0) {
        bricks.remove(i);
        if (random(1)<PROP_OCCUR_CHANCE) {
          props.add(new Prop(b.x, b.y));
        }
        ++score;
        --i;
      }
    }
  }
}

void updateProps() {
  for (int i=0; i<props.size(); ++i) {
    Prop p=props.get(i);
    p.move();
    if (p.y>SCREEN_HEIGHT+12) {
      props.remove(i);
      --i;
    }
  }
}

void showProps() {
  for (Prop p : props) p.show();
}

void processBarEatProp() {
  for (int i=0; i<props.size(); ++i) {
    Prop p=props.get(i);
    if ((p.x+p.w)>bar.x && p.x<(bar.x+bar.w)) {
      if (p.y<(bar.y+bar.h) && (p.y+p.h)>bar.y) {
        switch(p.type) {
        case PROP_INCREASE_BAR_WIDTH:
          bar.w=min(MAX_BAR_WIDTH, bar.w+PROP_DELTA_INCREASE_WIDTH);
          break;
        case PROP_DECREASE_BAR_WIDTH:
          bar.w=max(MIN_BAR_WIDTH, bar.w-PROP_DELTA_INCREASE_WIDTH);
          break;
        case PROP_INCREASE_BAR_VX:
          barV=min(MAX_BAR_VX, barV+PROP_DELTA_INCREASE_VX);
          break;
        case PROP_DECREASE_BAR_VX:
          barV=max(MIN_BAR_VX, barV-PROP_DELTA_INCREASE_VX);
        case PROP_INCREASE_BALL_DAMAGE:
          ball.damage=min(MAX_DAMAGE, ball.damage+PROP_DELTA_INCREASE_DAMAGE);
        default: 
          break;
        }
        props.remove(i);
        --i;
      }
    }
  }
}

void Win() {
  clearScreen();
  textSize(128);
  fill(#FF0900);
  textAlign(CENTER);
  text("You Win!", SCREEN_WIDTH/2, SCREEN_HEIGHT/2);
}

void showBar() {
  stroke(#0088FC);
  strokeWeight(2);
  fill(255);
  bar.show();
  noStroke();
}

void updateBricks() {
  for (Brick b : bricks) b.waggle();
}

//============================================================
// setup && draw
//============================================================

void setup() {
  size(1280, 800);
  //fullScreen();
  background(255);
  noStroke();
  showGameInit=true;
}

int frame=0;

void draw() {
  if (showGameInit) {
    gameInit();
    noLoop();
    showGameInit=false;
    return;
  }

  if (!gameStart) return;

  clearScreen();

  showScore();
  showBallDamage();

  updateBar();
  showBar();

  updateBricks();

  ball.move();
  if (ball.behindScreen()) {
    gameOver();
    return;
  }

  if (ball.checkHit(bar)) {
    ball.vx+=barVSign*barV/ACCELERATE_FACTOR;
    if (ball.vx==0) ball.vx=0.4;
  }
  processBallBrickHit();

  fill(#FF2E2E);
  ball.show();

  showBricks();

  updateProps();
  processBarEatProp();
  showProps();

  if (bricks.size()==0) {
    noLoop();
    gameWin=true;
    Win();
  }
}