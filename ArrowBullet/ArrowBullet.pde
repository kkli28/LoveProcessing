
//==== constant ====
final int SCREEN_WIDTH=1200;
final int SCREEN_HEIGHT=720;

final int BULLET_COLOR1=#00FF1F;
final int BULLET_COLOR2=#FF4646;
final float BULLET_LINE1=48;
final float BULLET_LINE2=BULLET_LINE1/4;
final float GRAVITY=0.98;
final int BULLET_COUNT=480;
final float BULLET_VELOCITY_X_MAX=12;
final float BULLET_VELOCITY_X_MIN=6;

final int SHOOT_LEFT=0;
final int SHOOT_RIGHT=1;
final int SHOOT_RANDOM=2;
final int SHOOT_COUNT_MAX=24;
final int SHOOT_COUNT_MIN=1;

final int TEXT_COLOR=#2476FF;

//==== variable ====
ArrayList<Bullet> bullets=new ArrayList<Bullet>();
boolean canAddBullet=true;
boolean continuousAdd=false;
boolean enableBounce=true;
boolean only8Directions=true;
int shootDirection=SHOOT_RANDOM;
int shootCount=SHOOT_COUNT_MIN;

//==== function ====
void initBullet(){
    for(int i=0;i<BULLET_COUNT;++i){
        bullets.add(new Bullet());
    }
}

void addBullet(){
  for(int c=0;c<shootCount;++c){
    for(int i=0;i<BULLET_COUNT;++i){
        if(bullets.get(i).dead){
            float vx=random(BULLET_VELOCITY_X_MIN,BULLET_VELOCITY_X_MAX);
            float vy=-random(BULLET_VELOCITY_X_MIN,BULLET_VELOCITY_X_MAX);
            
            switch(shootDirection){
              case SHOOT_LEFT: vx=-vx; break;
              case SHOOT_RIGHT: break;
              case SHOOT_RANDOM: if(random(-1, 1)<0) vx=-vx; break;
              default: break;
            }
            
            Bullet b=new Bullet(new Point(mouseX, mouseY), new Point(vx, vy));
            bullets.set(i, b);
            break;
        }
    }
  }
}

int bulletNonDeadSize(){
  int count=0;
  for(int i=0;i<BULLET_COUNT;++i) if(!bullets.get(i).dead) ++count;
  return count;
}

void mouseClicked(){
  if(mouseButton==RIGHT) continuousAdd=!continuousAdd;
}

void mouseReleased(){
    canAddBullet=true;
}

void mouseWheel(MouseEvent event) {
  if(event.getCount()<0) shootCount+=2;
  else shootCount-=2;
  if(shootCount>SHOOT_COUNT_MAX) shootCount=SHOOT_COUNT_MAX;
  else if(shootCount<SHOOT_COUNT_MIN) shootCount=SHOOT_COUNT_MIN;
}

void keyPressed(){
  if(key=='a') shootDirection=SHOOT_LEFT;
  else if(key=='d') shootDirection=SHOOT_RIGHT;
  else if(key=='w') shootDirection=SHOOT_RANDOM;
  else if(key=='s') enableBounce=!enableBounce;
  else if(key=='q') only8Directions=!only8Directions;
}

void showText(){
  textSize(16);
  fill(TEXT_COLOR);
  text("Press A/D/W to set shoot direction LEFT/RIGHT/RANDOM", 20, 40);
  text("Press S to enable/disable bounce", 20, 80);
  text("Press Q to enable/disable 8-direction shoot", 20, 120);
  text("Scroll wheel to increase/reduce shoot count", 20, 160);
  
  int h=SCREEN_HEIGHT-40;
  
  //shoot direction
  String str="LEFT";
  if(shootDirection==SHOOT_RIGHT) str="RIGHT";
  else if(shootDirection==SHOOT_RANDOM) str="RANDOM";
  text(str, 20, h);
  
  //bounce
  str="NON-BOUNCE";
  if(enableBounce) str="BOUNCE";
  text(str, 220, h);
  
  //continuous
  str="NON-CONTINUOUS";
  if(continuousAdd) str="CONTINUOUS";
  text(str, 420, h);
  
  //shoot count
  text(shootCount, 620, h);
  
  //8-direction
  str="ALL-DIRECTION";
  if(only8Directions) str="8-DIRECTION";
  text(str, 820, h);
}

void clearScreen(){
    fill(255);
    noStroke();
    rect(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
}

void setup(){
    size(1200, 720);
    background(255);
    initBullet();
}

void draw(){
    clearScreen();
    if(mousePressed){
      if(continuousAdd) addBullet();
      else if(canAddBullet){
        addBullet();
        canAddBullet=false;
      }
    }
    for(Bullet b: bullets) b.update();
    
    showText();
}