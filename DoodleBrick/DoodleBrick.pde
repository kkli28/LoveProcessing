import java.util.Collection;  
import java.util.HashMap;  
import java.util.Iterator;  
import java.util.Map;  
import java.util.Map.Entry;  
import java.util.Set; 
//==== constant ====

final int SCREEN_WIDTH=540;
final int SCREEN_HEIGHT=960;

final int BRICK_NORMAL=0;
final int BRICK_JUMP=1;
final int BRICK_VIRTUAL=2;
final int BRICK_NORMAL_MOVE=3;
final int BRICK_JUMP_MOVE=4;
final int BRICK_VIRTUAL_MOVE=5;

final float BRICK_JUMP_HEIGHT=128;
final float BRICK_DOWN_HEIGHT=2;

final float BRICK_MOVE_VELOCITY_MAX=2;
final float BRICK_MOVE_VELOCITY_MIN=1;

final int BRICK_NORMAL_COLOR=#EA0707;
final int BRICK_JUMP_COLOR=#07EA32;
final int BRICK_VIRTUAL_COLOR=#797B81;

final float BRICK_MOVE_RATE=0.2;

final float BRICK_WIDTH=48;
final float BRICK_HEIGHT=12;

final float PLAYER_JUMP_HEIGHT=96;

final float MIN_HEIGHT=-1000;
final float MAX_HEIGHT=1000;

final int BRICK_COUNT=40;

final float HARD_MAX=10*60;

//==== variable ====
float nowHeight=SCREEN_HEIGHT;
float reachHeight=SCREEN_HEIGHT+BRICK_JUMP_HEIGHT;
Map<Integer, Brick> bricks=new HashMap<Integer, Brick>();
ArrayList<Integer> ids=new ArrayList<Integer>();
int brickID=0;

float hard=0.0f;

//==== function ====

int getID() {
  return ++brickID;
}

void initBricks() {
  for (int i=0; i<BRICK_COUNT || nowHeight>MAX_HEIGHT; ++i) addBrick();
}

float getHardYOffset(){
  return map(hard, 0.0f, HARD_MAX, 0, PLAYER_JUMP_HEIGHT-48);
}

int getRandomType(){
  boolean move=false;
  int type=BRICK_NORMAL;
  if(random(0.0f, 1.0f)<BRICK_MOVE_RATE) move=true;
  float r=random(0.0f, 1.0f);
  if(r<0.1){
    if(move) type=BRICK_VIRTUAL_MOVE;
    else type=BRICK_VIRTUAL;
  }
  else if(r<0.3){
    if(move) type=BRICK_JUMP_MOVE;
    else type=BRICK_JUMP;
  }
  else if(move) type=BRICK_NORMAL_MOVE;
  return type;
}

void addBrick() {
  if (bricks.size()>=BRICK_COUNT) return;
  float y=random(reachHeight+BRICK_HEIGHT/2, nowHeight-BRICK_HEIGHT-getHardYOffset());
  float x=random(BRICK_WIDTH/2, SCREEN_WIDTH-BRICK_WIDTH/2);
  int type=getRandomType();
  Brick b=new Brick(new Point(x, y), type);
  bricks.put(b.id, b);
}

void clearScreen() {
  fill(255);
  noStroke();
  rect(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
}

void setup() {
  size(540, 960);
  background(255);
  initBricks();
}

void draw() {
  clearScreen();
  println(nowHeight, reachHeight);
  Set<Integer> keys=bricks.keySet();
  for (Integer k : keys) {
    Brick b=bricks.get(k);
    if (b.dead) ids.add(k);
    else b.update();
  }

  for (Integer i : ids) bricks.remove(i);
  ids.clear();
  while(bricks.size()<BRICK_COUNT) addBrick();
  
  nowHeight+=BRICK_DOWN_HEIGHT;
  reachHeight+=BRICK_DOWN_HEIGHT;
  hard+=1;
  if(hard>HARD_MAX) hard=HARD_MAX;
}