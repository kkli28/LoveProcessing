
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
final int MAX_BULLET_PER_FRAME_POWER=6;
final int MAX_BULLET_COUNT=int(pow(2, MAX_BULLET_PER_FRAME_POWER)*60);
int bulletPerFramePower=0;

//==== variables ====
ArrayList<Plane> planes=new ArrayList<Plane>();
ArrayList<Bullet> bullets=new ArrayList<Bullet>();
Plane plane=new Plane(new Point(SCREEN_WIDTH/2, 40), PLANE_VELOCITY);
Point prevMouse=new Point(0.0f, 0.0f);
boolean generateBullet=false;

//initBullets
void initBullets(){
  for(int i=0;i<MAX_BULLET_COUNT;++i) {
    Bullet b=new Bullet(new Point(0.0f, 0.0f), 0);
    b.dead=true;
    bullets.add(b);
  }
}

//createBullet
void addBullet(){
  Bullet b=new Bullet(new Point(mouseX, mouseY), BULLET_VELOCITY);
  b.radian=random(2*PI);
  for(int i=0;i<MAX_BULLET_COUNT;++i){
    if(bullets.get(i).dead){
      bullets.set(i, b);
      break;
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
  bulletPerFramePower-=e;
  if(bulletPerFramePower<0) bulletPerFramePower=0;
  else if(bulletPerFramePower>MAX_BULLET_PER_FRAME_POWER) bulletPerFramePower=MAX_BULLET_PER_FRAME_POWER;
}

void setup(){
  size(720, 720);
  background(255);
  initBullets();
}

void draw(){
  clearScreen();
  
  for(int i=0;i<MAX_BULLET_COUNT;++i) 
    if(collisionDetection(plane, bullets.get(i))) bullets.get(i).dead=true;
  
  plane.update();
  for(Bullet b: bullets) b.track(plane.pos);
  for(Bullet b: bullets) b.update();
  
  int size=int(pow(2, bulletPerFramePower));
  if(generateBullet) {
    for(int i=0;i<size;++i) 
    addBullet();
  }
  
  fill(TEXT_COLOR);
  textSize(16);
  text("Scroll wheel to change bullets generate rate.", 20, 20);
  text("bullets/frame: "+new Integer(size).toString(), 20, SCREEN_HEIGHT-20);
}