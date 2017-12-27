
//==== screen ====
final int SCREEN_WIDTH=720;
final int SCREEN_HEIGHT=720;

//==== bullet ====
final float BULLET_DELTA_ROTATE=0.4f;
final float BULLET_SIDE_LEN1=12;
final float BULLET_SIDE_LEN2=BULLET_SIDE_LEN1;
final int BULLET_COLOR=#07810F;
final int BULLET_MAX_VELOCITY=16;
final int BULLET_MIN_VELOCITY=8;
final float BULLET_DELTA_VELOCITY=0.3f;
final float BULLET_TRACK_DELTA_DISTANCE=8;

//==== others ====
final int MAX_BULLET_COUNT=120;
final int TEXT_COLOR=#0372FF;

//==== variables ====
ArrayList<BoomerangBullet> bullets=new ArrayList<BoomerangBullet>();

boolean enableGenerate=false;
boolean enableContinuousGenerate=false;

//initBullets
void initBullets(){
  for(int i=0;i<MAX_BULLET_COUNT;++i){
    BoomerangBullet b=new BoomerangBullet(new Point(0.0f, 0.0f), 0);
    b.dead=true;
    bullets.add(b);
  }
}

//addBullet
void addBullet(){
  BoomerangBullet b=new BoomerangBullet(new Point(mouseX, mouseY), random(BULLET_MIN_VELOCITY, BULLET_MAX_VELOCITY));
  for(int i=0;i<MAX_BULLET_COUNT;++i){
    if(bullets.get(i).dead) {
      bullets.set(i, b);
      return;
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
void mousePressed(){
  if(mouseButton==RIGHT) enableContinuousGenerate=!enableContinuousGenerate;
  enableGenerate=true;
}

//mouseReleased
void mouseReleased(){
  enableGenerate=false;
}

//showText
void showText(){
  fill(#0372FF);
  textSize(16);
  text("Right click to enable/disable continuouse generate", 20, 20);
}

//setup
void setup() {
  size(720, 720);
  background(255);
  initBullets();
}

//draw
void draw() {
  clearScreen();
  
  if(enableGenerate) {
    addBullet();
    if(!enableContinuousGenerate) enableGenerate=false;
  }
  
  for(int i=0;i<bullets.size();++i) {
    BoomerangBullet b=bullets.get(i);
    if(b.dead) continue;
    if(b.back) b.track(new Point(mouseX, mouseY));
    b.update();
  }
  
  showText();
}