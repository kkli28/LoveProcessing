
//==== screen ====
final int SCREEN_WIDTH=720;
final int SCREEN_HEIGHT=720;

//==== color ====
final int BULLET_COLOR=#FC0000;
final int PLANE_COLOR=#037EFF;
final int TEXT_COLOR=#02B72A;

//==== plane ====
final int PLANE_WIDTH=20;
final Point PLANE_VELOCITY=new Point(random(6), random(6));

//==== bullet ====
final float DELTA_ROTATE_RADIAN=0.1;
final float BULLET_VELOCITY=10;
final int BULLET_LIFE=300;
final int BULLET_RADIUS=6;
final int MAX_BULLET_PER_FRAME_POWER=4;
final int MAX_BIG_BULLET_COUNT=int(pow(2, MAX_BULLET_PER_FRAME_POWER)*60);
final int SMALL_BULLET_PER_BIG_BULLET=8;
final int MAX_SMALL_BULLET_COUNT=MAX_BIG_BULLET_COUNT*SMALL_BULLET_PER_BIG_BULLET;
final int DISABLE_COLLISION_TIME=30;
final int BIG_BULLET_RADIUS=8;
final int SMALL_BULLET_RADIUS=4;
int bulletsPerFramePower=0;
int bulletsPerFrame=1;

//==== variables ====
ArrayList<Plane> planes=new ArrayList<Plane>();
ArrayList<Bullet> bigBullets=new ArrayList<Bullet>();
ArrayList<Bullet> smallBullets=new ArrayList<Bullet>();
Plane plane=new Plane(new Point(SCREEN_WIDTH/2, 40), PLANE_VELOCITY);
boolean generateBullet=false;

//initBullets
void initBullets(){
  //big bullets
  for(int i=0;i<MAX_BIG_BULLET_COUNT;++i) {
    Bullet b=new Bullet(new Point(0.0f, 0.0f), 0, BIG_BULLET_RADIUS);
    b.dead=true;
    bigBullets.add(b);
  }
  
  //small bullets
  for(int i=0;i<MAX_SMALL_BULLET_COUNT; ++i){
    Bullet b=new Bullet(new Point(0.0f, 0.0f), 0, SMALL_BULLET_RADIUS);
    b.dead=true;
    smallBullets.add(b);
  }
}

//addBigBullet
void addBigBullet(){
  Bullet b=new Bullet(new Point(mouseX, mouseY), BULLET_VELOCITY, BIG_BULLET_RADIUS);
  b.radian=random(2*PI);
  for(int i=0;i<MAX_BIG_BULLET_COUNT;++i){
    if(bigBullets.get(i).dead){
      bigBullets.set(i, b);
      break;
    }
  }
}

//addSmallBullets
void addSmallBullets(Point pos){
  float deltaRadian=2*PI/SMALL_BULLET_PER_BIG_BULLET;
  for(int i=0;i<SMALL_BULLET_PER_BIG_BULLET; ++i){
    Bullet b=new Bullet(new Point(pos.x, pos.y), BULLET_VELOCITY, SMALL_BULLET_RADIUS);
    b.radian=i*deltaRadian;
    
    for(int j=0;j<MAX_SMALL_BULLET_COUNT;++j){
      if(smallBullets.get(j).dead){
        smallBullets.set(j, b);
        break;
      }
    }
  }
}

//clearScreen
void clearScreen(){
  noStroke();
  fill(255);
  rect(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
}

//mousePressed
void mousePressed(){
  generateBullet=true;
}

//mouseReleased
void mouseReleased(){
  generateBullet=false;
}

//mouseWheel
void mouseWheel(MouseEvent event) {
  float e = event.getCount();
  bulletsPerFramePower-=e;
  if(bulletsPerFramePower<0) bulletsPerFramePower=0;
  else if(bulletsPerFramePower>MAX_BULLET_PER_FRAME_POWER) bulletsPerFramePower=MAX_BULLET_PER_FRAME_POWER;
  bulletsPerFrame=int(pow(2, bulletsPerFramePower));
}

//bigBulletsCollisionWithPlane
void bigBulletsCollisionWithPlane(){
  for(int i=0;i<MAX_BIG_BULLET_COUNT;++i){
    if(bigBullets.get(i).dead) continue;
    if(collisionDetection(plane, bigBullets.get(i))) {
      bigBullets.get(i).dead=true;
      addSmallBullets(bigBullets.get(i).pos);
    }
  }
}

//smallBulletsCollisionWithPlane
void smallBulletsCollisionWithPlane(){
  for(int i=0;i<MAX_SMALL_BULLET_COUNT;++i){
    if(smallBullets.get(i).dead) continue;
    if(collisionDetection(plane, smallBullets.get(i))) {
      smallBullets.get(i).dead=true;
    }
  }
}

void setup(){
  size(720, 720);
  background(255);
  initBullets();
  
  addSmallBullets(new Point(200,200));
}

void draw(){
  clearScreen();
  
  bigBulletsCollisionWithPlane();
  smallBulletsCollisionWithPlane();
  
  plane.update();
  
  //big bullets
  for(Bullet b: bigBullets) b.track(plane.pos);
  for(Bullet b: bigBullets) if(!b.dead) b.update();
  
  //small bullets
  for(Bullet b: smallBullets) if(b.enableCollision) b.track(plane.pos);
  for(Bullet b: smallBullets) if(!b.dead) b.update();
  
  if(generateBullet) {
    for(int i=0;i<bulletsPerFrame;++i) 
    addBigBullet();
  }
  
  fill(TEXT_COLOR);
  textSize(16);
  text("Scroll wheel to change bullets generate rate.", 20, 20);
  text("bullets/frame: "+new Integer(bulletsPerFrame).toString(), 20, SCREEN_HEIGHT-20);
  
  /*
  //test: print smallBullets's non-dead bullet size
  int c=0;
  for(int i=0;i<MAX_SMALL_BULLET_COUNT;++i) if(!smallBullets.get(i).dead) ++c;
  println(c);
  */
}