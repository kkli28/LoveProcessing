class Particle{
    Point pos;
    Point velocity;

    Particle(){
        pos=new Point(random(SCREEN_WIDTH), random(SCREEN_HEIGHT));
        float vx=random(PARTICLE_VELOCITY_MAX);
        float vy=PARTICLE_VELOCITY_MAX-vx;
        if(random(-1, 1)<0) vx=-vx;
        if(random(-1, 1)<0) vy=-vy;
        velocity=new Point(vx, vy);
    }

    private void show(){
        noStroke();
        fill(PARTICLE_COLOR);
        ellipse(pos.x, pos.y, PARTICLE_RADIUS*2, PARTICLE_RADIUS*2);
    }

    void update(){
        pos.x+=velocity.x;
        pos.y+=velocity.y;
        if(pos.x<0) {
          pos.x=0;
          velocity.x=-velocity.x;
        }
        else if(pos.x>SCREEN_WIDTH) {
          pos.x=SCREEN_WIDTH;
          velocity.x=-velocity.x;
        }
        if(pos.y<0) {
          pos.y=0;
          velocity.y=-velocity.y;
        }
        else if(pos.y>SCREEN_HEIGHT){
          pos.y=SCREEN_HEIGHT;
          velocity.y=-velocity.y;
        }

        show();
    }
}
