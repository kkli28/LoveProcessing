
//==== constant ====
final int SCREEN_WIDTH=720;
final int SCREEN_HEIGHT=720;

final int BORDER=120;

final int PARTICLE_MAX_COUNT=2400;
final int PARTICLE_RADIUS=4;
final int PARTICLE_STATIC_COLOR=#B2B2B2;
final int PARTICLE_DYNAMIC_COLOR=#00F212;
final int ARRIVE_TIME=60;
final float PARTICLE_DEACCELERATE=0.2f;

final int FORCE_MAX=4;
final int FORCE_MIN=1;

final int MOUSE_ELLIPSE_COLOR=#008EFF;
int MOUSE_MAX_RADIUS=64;
final int MOUSE_MIN_RADIUS=4;

//==== variable ====

ArrayList<Particle> particles=new ArrayList<Particle>();

//==== function ====

void initParticles(){
    for(int i=0;i<PARTICLE_MAX_COUNT;++i) {
        particles.add(new Particle());
    }
}

void updateParticles(){
    Point mousePos=new Point(mouseX, mouseY);
    for(int i=0;i<PARTICLE_MAX_COUNT;++i){
        Particle particle=particles.get(i);
        float distance=getDistance(mousePos, particle.pos);
        if(distance<MOUSE_MAX_RADIUS){
            float radian=getRadian(mousePos, particle.pos);
            if(distance<MOUSE_MIN_RADIUS) distance=MOUSE_MIN_RADIUS;
            float force=map(distance, MOUSE_MIN_RADIUS, MOUSE_MAX_RADIUS, FORCE_MIN, FORCE_MAX);
            force=FORCE_MAX+FORCE_MIN-force;
            Point f=new Point(force*cos(radian), force*sin(radian));
            particle.addForce(f);
        }
    }
    for(int i=0;i<PARTICLE_MAX_COUNT;++i) particles.get(i).update();
}

void showParticles(){
    noStroke();
    Point mousePos=new Point(mouseX, mouseY);
    for(int i=0;i<PARTICLE_MAX_COUNT;++i){
        Point p=particles.get(i).pos;
        if(getDistance(mousePos, p)<MOUSE_MAX_RADIUS) fill(PARTICLE_DYNAMIC_COLOR);
        else fill(PARTICLE_STATIC_COLOR);
        ellipse(p.x, p.y, PARTICLE_RADIUS, PARTICLE_RADIUS);
    }
}

void showMouse(){
    stroke(MOUSE_ELLIPSE_COLOR);
    noFill();
    ellipse(mouseX, mouseY, MOUSE_MAX_RADIUS*2, MOUSE_MAX_RADIUS*2);
    //ellipse(mouseX, mouseY, MOUSE_MIN_RADIUS*2, MOUSE_MIN_RADIUS*2);
}

void mouseWheel(MouseEvent event) {
  if(event.getCount()<0) MOUSE_MAX_RADIUS+=4;
  else MOUSE_MAX_RADIUS-=4;
  if(MOUSE_MAX_RADIUS>128) MOUSE_MAX_RADIUS=128;
  else if(MOUSE_MAX_RADIUS<MOUSE_MIN_RADIUS+2) MOUSE_MAX_RADIUS=MOUSE_MIN_RADIUS+2;
  
}

void clearScreen(){
    noStroke();
    fill(255);
    rect(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
}

void setup(){
    size(720, 720);
    background(255);
    initParticles();
}

void draw(){
    clearScreen();
    updateParticles();
    showParticles();
    showMouse();
}