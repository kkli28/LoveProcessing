
//==== Screen ====
final int SCREEN_WIDTH=960;
final int SCREEN_HEIGHT=960;

//==== Bullet ====
final int BULLET_COLOR=#080000;
final int BULLET_LIFE=300;
final int BULLET_VELOCITY=8;
final int BULLET_MAX_COUNT=600;
final float BULLET_R=4;

//==== Plane ====
final int PLANE_COLOR=#0046FF;
final int PLANE_WIDTH=32;
final int PLANE_MAX_V=2;
final int PLANE_MIN_V=1;
final int PLANE_MAX_COUNT=20;

//==== Bot ====
final int BOT_TRACK_DISTANCE_MAX=48;
final int BOT_TRACK_DISTANCE_MIN=12;
final int BOT_WANDER_TIME_MAX=60;
final int BOT_WANDER_TIME_MIN=10;
final int BOT_COLOR=#FF0303;
final int BOT_R=8;
final int BOT_MAX_COUNT=128;
final int BOT_VELOCITY=4;
final float BOT_WANDER_VELOCITY_MAX=2;
final float BOT_WANDER_VELOCITY_MIN=0.5;
final int BOT_SHOOT_CD=30;

//==== variables ====
ArrayList<Plane> planes=new ArrayList<Plane>();
ArrayList<Bot> bots=new ArrayList<Bot>();
ArrayList<Bullet> bullets=new ArrayList<Bullet>();

boolean enableAddPlane=false;
boolean enableAddBot=false;

//initWTF
void initWTF(){

    //init planes
    for(int i=0;i<PLANE_MAX_COUNT;++i){
        planes.add(new Plane());
    }

    //init bots
    for(int i=0;i<BOT_MAX_COUNT;++i){
        bots.add(new Bot());
    }

    //init bullets
    for(int i=0;i<BULLET_MAX_COUNT;++i){
        bullets.add(new Bullet());
    }

    addPlane();
    addBot();
}

//addPlane
void addPlane(){
  for(int i=0;i<planes.size();++i){
      if(!planes.get(i).enable) {
          Point pos=new Point(random(SCREEN_WIDTH), random(SCREEN_HEIGHT));
          float vx=random(PLANE_MIN_V, PLANE_MAX_V);
          float vy=random(PLANE_MIN_V, PLANE_MAX_V);
          if(random(-1, 1)<0) vx=-vx;
          if(random(-1, 1)<0) vy=-vy;
          planes.set(i, new Plane(pos, new Point(vx, vy)));
          return;
      }
   }
}

//addBot
void addBot(){
  for(int i=0;i<BOT_MAX_COUNT;++i){
        if(!bots.get(i).enable){
            bots.set(i, new Bot(new Point(mouseX, mouseY), BOT_VELOCITY));
            return;
        }
    }
}

//addBullet
void addBullet(Bullet bullet){
  for(int i=0;i<BULLET_MAX_COUNT; ++i){
        if(!bullets.get(i).enable) {
          bullets.set(i, bullet);
          return;
        }
    }
}

//getMinDistancePlane
Plane getMinDistancePlane(Point pos){
    float minDistance=10000000000000000f;
    Plane plane=new Plane();
    for(Plane p: planes){
        if(!p.enable) continue;
        float dis=getSquareDistance(pos, p.pos);
        if(dis<minDistance){
            minDistance=dis;
            plane=p;
        }
    }
    return plane;
}

//collision
void collision(){
    int planeCount=planes.size();
    int bulletCount=bullets.size();
    Bullet bullet=new Bullet();
    Plane plane=new Plane();
    for(int i=0;i<bulletCount;++i){
        for(int j=0;j<planeCount;++j){
            bullet=bullets.get(i);
            plane=planes.get(j);
            if(bullet.enable && plane.enable){
                if(collisionDetection(plane, bullet)) bullet.enable=false;
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

//countValidThings
void countValidThings(){
  int planeCount=0;
  int botCount=0;
  int bulletCount=0;
  for(Plane p: planes) if(p.enable) ++planeCount;
  for(Bot b: bots) if(b.enable) ++botCount;
  for(Bullet b: bullets) if(b.enable) ++bulletCount;
  println("Planes: ", planeCount);
  println("Bots: ", botCount);
  println("Bullets: ", bulletCount);
}

//mouseReleased
void mouseReleased(){
  enableAddPlane=true;
  enableAddBot=true;
}

//setup
void setup(){
    size(960, 960);
    background(255);
    initWTF();
    //countValidThings();
}

void keyReleased(){
  loop();
}

//draw
void draw(){
    clearScreen();
  
    if(keyPressed) noLoop();
    
    if(mousePressed){
      if(mouseButton==LEFT && enableAddPlane) {
        addPlane();
        enableAddPlane=false;
      }
      else if(mouseButton==RIGHT && enableAddBot){
        addBot();
        bots.get(0).pos=new Point(mouseX, mouseY);
        enableAddBot=false;
      }
    }
    
    for(Plane p: planes) p.update();
    for(Bot b: bots) {
        Plane plane=getMinDistancePlane(b.pos);
        fill(#FF0000);
        ellipse(plane.pos.x, plane.pos.y, 28, 28);
        b.track(plane.pos);
        b.update();
        Bullet bullet=b.shoot();
        if(bullet.enable) addBullet(bullet);
    }
    
    collision();
    for(Bullet b: bullets) b.update();
}