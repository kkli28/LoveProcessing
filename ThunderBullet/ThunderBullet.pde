
//==== constant ====
final int SCREEN_WIDTH=720;
final int SCREEN_HEIGHT=720;

final int PARTICLE_COLOR=#898686;
final int PARTICLE_VELOCITY_MAX=2;
final int PARTICLE_RADIUS=3;
final int PARTICLE_MAX_COUNT=120;

final int BULLET_COLOR=#0052FF;
final int BULLET_LINK_COLOR=#38FF03;
final int BULLET_VELOCITY_MAX=4;
final int BULLET_RADIUS=4;
final int BULLET_MAX_COUNT=24;
final int BULLET_LINK_MAX=8;

//==== variable ====
ArrayList<Particle> particles=new ArrayList<Particle>();
ArrayList<Bullet> bullets=new ArrayList<Bullet>();
boolean enableAddBullet=true;

void initParticles(){
    for(int i=0;i<PARTICLE_MAX_COUNT;++i) particles.add(new Particle());
}

void addBullet(){
    if(bullets.size()<BULLET_MAX_COUNT){
        bullets.add(new Bullet(new Point(mouseX, mouseY)));
    }
}

void clearScreen(){
    noStroke();
    fill(255);
    rect(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
}

void mousePressed(){
  enableAddBullet=true;
}

void setup(){
    size(720, 720);
    background(255);
    initParticles();
}

void draw(){
    clearScreen();
    if(keyPressed) bullets.clear();
    if(mousePressed && enableAddBullet) {
      addBullet();
      //enableAddBullet=false;
    }
    
    for(Particle p: particles) p.update();
    for(int i=0;i<PARTICLE_MAX_COUNT;++i){
        for(Bullet b: bullets) b.tryGetNearerParticles(particles.get(i).pos);
    }
    for(Bullet b: bullets) b.update();
}