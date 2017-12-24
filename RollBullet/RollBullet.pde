
//==== screen ====
final int SCREEN_WIDTH=720;
final int SCREEN_HEIGHT=720;

//==== bullet ====
final int BULLET_LINE_COLOR=#00FF57;
final int BULLET_POINT_COLOR1=#FF0000;
final int BULLET_POINT_COLOR2=#FF8181;
final int BULLET_POINT_R1=8;
final int BULLET_POINT_R2=4;
final int BULLET_MIN_VELOCITY=2;
final int BULLET_MAX_VELOCITY=6;
final int BULLET_SIDE_LENGTH=12;
final float BULLET_DELTA_RADIAN=0.15f;
final int MAX_BULLET_COUNT=120;

//==== variables ====
ArrayList<Bullet> bullets=new ArrayList<Bullet>();

//addBullet
void addBullet() {
  if (bullets.size()>MAX_BULLET_COUNT) return;
  Bullet bullet=new Bullet(new Point(mouseX, mouseY), 
    new Point(random(BULLET_MIN_VELOCITY, BULLET_MAX_VELOCITY), random(BULLET_MIN_VELOCITY, BULLET_MAX_VELOCITY)), 
    BULLET_SIDE_LENGTH, BULLET_DELTA_RADIAN);
  float r1=random(-1, 1);
  float r2=random(-1, 1);
  if(r1<0) bullet.velocity.x=-bullet.velocity.x;
  if(r2<0) bullet.velocity.y=-bullet.velocity.y;
  bullets.add(bullet);
}

//clearScreen
void clearScreen() {
  noStroke();
  fill(255);
  rect(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
}

void setup() {
  size(720, 720);
  background(255);
}

void draw() {
  clearScreen();

  if (mousePressed) {
    if(mouseButton==LEFT) addBullet();
    else if(mouseButton==RIGHT) bullets.clear();
  }
  for (Bullet b : bullets) b.update();
}