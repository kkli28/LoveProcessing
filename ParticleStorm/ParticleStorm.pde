
//==== constant ====
final int SCREEN_WIDTH=720;
final int SCREEN_HEIGHT=720;

final float DELTA_RADIAN_MAX=0.1;
final float DELTA_RADIAN_MIN=0.01;

final int PARTICLE_WIDTH=2;
final int PARTICLE_COLOR=#000000;
final int PARTICLE_COUNT=1200;
final float PARTICLE_LENGTH_MAX=360;
final float PARTICLE_LENGTH_MIN=24;
final float DECREASE_FACTOR=0.99;
final float INCREASE_FACTOR=1.01;

//==== variable ====
ArrayList<Particle> particles=new ArrayList<Particle>();

//==== function ====
void initParticles(){
    for(int i=0;i<PARTICLE_COUNT;++i){
        Point pos=new Point(SCREEN_WIDTH/2, SCREEN_HEIGHT/2);
        Particle p=new Particle(pos, random(0, TWO_PI), random(DELTA_RADIAN_MIN, DELTA_RADIAN_MAX), random(PARTICLE_LENGTH_MIN+20, PARTICLE_LENGTH_MAX-20));
        particles.add(p);
    }
}

void setup(){
    size(720, 720);
    background(255);
    initParticles();
}

void draw(){
    noStroke();
    fill(255);
    rect(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    if(mousePressed){
        float factor=DECREASE_FACTOR;
        if(mouseButton==RIGHT) factor=INCREASE_FACTOR;
        for(Particle p: particles) p.multi(factor);
    }
    for(Particle p: particles) p.update();
}