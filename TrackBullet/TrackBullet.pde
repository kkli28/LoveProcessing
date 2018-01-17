
//==== screen ====
final int SCREEN_WIDTH=960;
final int SCREEN_HEIGHT=960;

//==== color ====
final int PLANE_COLOR=#0017FF;
final int TEXT_COLOR=#02B72A;

final int BIG_BULLET_COLOR=#FF0000;
final int SMALL_BULLET_COLOR=#FF00E6;
final int BIG_BULLET_LINE_COLOR=#02BC00;
final int SMALL_BULLET_LINE_COLOR=#00D16A;

final int BIG_BULLET_LINE_LENGTH=24;
final int SMALL_BULLET_LINE_LENGTH=12;
final int BIG_BULLET_LINE_WEIGHT=4;
final int SMALL_BULLET_LINE_WEIGHT=2;

//==== plane ====
final int PLANE_WIDTH=20;
final int MAX_PLANE_COUNT=20;

//==== bullet ====
final float DELTA_ROTATE_RADIAN=0.1;
final float BULLET_VELOCITY=10;
final boolean BIG_BULLET=true;
final boolean SMALL_BULLET=false;
final int BULLET_LIFE=600;

final int MAX_BULLET_PER_FRAME_POWER=6;
final int MAX_BIG_BULLET_COUNT=int(pow(2, MAX_BULLET_PER_FRAME_POWER)*60);

final int SMALL_BULLET_PER_BIG_BULLET=3;
final int MAX_SMALL_BULLET_COUNT=MAX_BIG_BULLET_COUNT*SMALL_BULLET_PER_BIG_BULLET;

final int DISABLE_COLLISION_TIME=4;
final int BIG_BULLET_RADIUS=12;
final int SMALL_BULLET_RADIUS=6;

//==== variables ====
ArrayList<Plane> planes=new ArrayList<Plane>();
ArrayList<Bullet> bigBullets=new ArrayList<Bullet>();
ArrayList<Bullet> smallBullets=new ArrayList<Bullet>();

boolean generateBullet=false;
boolean isLineBullet=false;
boolean continuousGenerateBullet=false;
boolean canAddPlane=false;
boolean enableBulletExplosion=true;

int bulletsPerFramePower=0;
int bulletsPerFrame=1;

//reset
void reset(){
  planes.clear();
  addPlane();
  for(Bullet b: bigBullets) b.dead=true;
  for(Bullet b: smallBullets) b.dead=true;
  generateBullet=false;
  isLineBullet=false;
  continuousGenerateBullet=false;
  canAddPlane=false;
  enableBulletExplosion=true;
  bulletsPerFramePower=0;
  bulletsPerFrame=1;
}

//initBullets
void initBullets() {
  //big bullets
  for (int i=0; i<MAX_BIG_BULLET_COUNT; ++i) {
    Bullet b=new Bullet(new Point(0.0f, 0.0f), 0, BIG_BULLET_RADIUS, BIG_BULLET);
    b.dead=true;
    bigBullets.add(b);
  }

  //small bullets
  for (int i=0; i<MAX_SMALL_BULLET_COUNT; ++i) {
    Bullet b=new Bullet(new Point(0.0f, 0.0f), 0, SMALL_BULLET_RADIUS, SMALL_BULLET);
    b.dead=true;
    smallBullets.add(b);
  }
}

//getPlaneVelocity
Point getPlaneVelocity(){
  return new Point(random(2 ,4), random(2, 4));
}

//addBigBullet
void addBigBullet() {
  Bullet b=new Bullet(new Point(mouseX, mouseY), BULLET_VELOCITY, BIG_BULLET_RADIUS, BIG_BULLET);
  b.radian=random(2*PI);
  for (int i=0; i<MAX_BIG_BULLET_COUNT; ++i) {
    if (bigBullets.get(i).dead) {
      bigBullets.set(i, b);
      break;
    }
  }
}

//addSmallBullets
void addSmallBullets(Point pos) {
  float deltaRadian=2*PI/SMALL_BULLET_PER_BIG_BULLET;
  for (int i=0; i<SMALL_BULLET_PER_BIG_BULLET; ++i) {
    Bullet b=new Bullet(new Point(pos.x, pos.y), BULLET_VELOCITY, SMALL_BULLET_RADIUS, SMALL_BULLET);
    b.radian=i*deltaRadian+random(-1, 1);
    for (int j=0; j<MAX_SMALL_BULLET_COUNT; ++j) {
      if (smallBullets.get(j).dead) {
        smallBullets.set(j, b);
        break;
      }
    }
  }
}

//addPlane
void addPlane(){
  if(planes.size()>MAX_PLANE_COUNT) return;
  planes.add(new Plane(new Point(random(SCREEN_WIDTH), random(SCREEN_HEIGHT)), getPlaneVelocity()));
}

//trackPlane
void trackPlane(Bullet b){
  float minDis=1000000;
  for(Plane p: planes){
    float dis=getSquareDistance(b.pos, p.pos);
    if(dis<minDis){
      minDis=dis;
      b.track(p.pos);
    }
  }
}

//clearScreen
void clearScreen() {
  noStroke();
  fill(255);
  rect(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
}

//mousePressed
void mousePressed() {
  generateBullet=true;
}

//mouseReleased
void mouseReleased() {
  if (mouseButton==RIGHT) continuousGenerateBullet=!continuousGenerateBullet;
  generateBullet=false;
}

//mouseWheel
void mouseWheel(MouseEvent event) {
  float e = event.getCount();
  bulletsPerFramePower-=e;
  if (bulletsPerFramePower<0) bulletsPerFramePower=0;
  else if (bulletsPerFramePower>MAX_BULLET_PER_FRAME_POWER) bulletsPerFramePower=MAX_BULLET_PER_FRAME_POWER;
  bulletsPerFrame=int(pow(2, bulletsPerFramePower));
}

//keyPressed
void keyPressed(){
  if(key=='a' && canAddPlane) addPlane();
  else if(key=='s') enableBulletExplosion=!enableBulletExplosion;
  else if(key=='d') isLineBullet=!isLineBullet;
  else if(key=='f') reset();
  canAddPlane=false;
}

//keyReleased
void keyReleased(){
  canAddPlane=true;
}

//bigBulletsCollisionWithPlane
void bigBulletsCollisionWithPlane() {
  for (int i=0; i<MAX_BIG_BULLET_COUNT; ++i) {
    if (bigBullets.get(i).dead) continue;
    for(Plane plane: planes){
      if (collisionDetection(plane, bigBullets.get(i))) {
        bigBullets.get(i).dead=true;
        if(enableBulletExplosion) addSmallBullets(bigBullets.get(i).pos);
        break;
      }
    }
  }
}

//smallBulletsCollisionWithPlane
void smallBulletsCollisionWithPlane() {
  for (int i=0; i<MAX_SMALL_BULLET_COUNT; ++i) {
    Bullet b=smallBullets.get(i);
    if (b.dead) continue;
    for(Plane plane: planes){
      if (b.enableCollision && collisionDetection(plane, b)) {
        smallBullets.get(i).dead=true;
        break;
      }
    }
  }
}

//showTexts
void showTexts() {
  fill(TEXT_COLOR);
  textSize(16);
  text("Left click to generate bullet.", 20, 20);
  text("Right click to enable/disable continuous generate.", 20, 40);
  text("Scroll wheel to change bullet generate rate.", 20, 60);
  text("Press A to add plane.", 20, 70);
  text("Press S to enable/disable bullet explosion.", 20, 100);
  text("Press D to exchange bullet type.", 20, 120);
  text("Press F to reset.", 20, 140);
  
  text("bullets/click: "+new Integer(bulletsPerFrame).toString(), 20, SCREEN_HEIGHT-20);
}

//setup
void setup() {
  size(960, 960);
  background(255);
  initBullets();
  addPlane();
}

//draw
void draw() {
  clearScreen();

  //collisions
  bigBulletsCollisionWithPlane();
  smallBulletsCollisionWithPlane();

  //planes
  for(Plane p: planes) p.update();

  //big bullets
  for (Bullet b : bigBullets) trackPlane(b);
  for (Bullet b : bigBullets) if (!b.dead) b.update();

  //small bullets
  for (Bullet b : smallBullets) if (!b.dead && b.enableCollision) trackPlane(b);
  for (Bullet b : smallBullets) if (!b.dead) b.update();

  //generate bullets
  if (generateBullet) {
    for (int i=0; i<bulletsPerFrame; ++i) 
      addBigBullet();
    if (!continuousGenerateBullet) generateBullet=false;
  }

  //show texts
  showTexts();
}