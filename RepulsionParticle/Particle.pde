class Particle{
    Point pos;
    Point velocity;

    Particle(){
        pos=new Point(random(SCREEN_WIDTH), random(SCREEN_HEIGHT));
        velocity=new Point(0.0f, 0.0f);
    }

    void addForce(Point f){
        velocity.x+=f.x;
        velocity.y+=f.y;
    }
    
    void update(){
        pos.x+=velocity.x;
        pos.y+=velocity.y;
        if(pos.x<BORDER) {
          pos.x=BORDER;
          velocity.x=-velocity.x;
        }
        else if(pos.x>SCREEN_WIDTH-BORDER) {
          pos.x=SCREEN_WIDTH-BORDER;
          velocity.x=-velocity.x;
        }
        if(pos.y<BORDER) {
          pos.y=BORDER;
          velocity.y=-velocity.y;
        }
        else if(pos.y>SCREEN_HEIGHT-BORDER){
          pos.y=SCREEN_HEIGHT-BORDER;
          velocity.y=-velocity.y;
        }
        
        if(velocity.x>=0){
          velocity.x-=PARTICLE_DEACCELERATE;
          if(velocity.x<0) velocity.x=0;
        }
        else{
          velocity.x+=PARTICLE_DEACCELERATE;
          if(velocity.x>0) velocity.x=0;
        }
        if(velocity.y>=0){
          velocity.y-=PARTICLE_DEACCELERATE;
          if(velocity.y<0) velocity.y=0;
        }
        else{
          velocity.y+=PARTICLE_DEACCELERATE;
          if(velocity.y>0) velocity.y=0;
        }
    }
}