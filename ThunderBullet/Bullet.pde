class Bullet{
    Point pos;
    Point velocity;
    ArrayList<Point> nears;

    Bullet(Point p){
        pos=new Point(p);
        float vx=random(BULLET_VELOCITY_MAX);
        float vy=PARTICLE_VELOCITY_MAX-vx;
        if(random(-1, 1)<0) vx=-vx;
        if(random(-1, 1)<0) vy=-vy;
        velocity=new Point(vx, vy);
        nears=new ArrayList<Point>();
        resetNears();
    }

    private void resetNears(){
        nears.clear();
        for(int i=0;i<BULLET_LINK_MAX;++i) nears.add(new Point(10000, 10000));
    }
    private void show(){
        noStroke();
        fill(BULLET_COLOR);
        ellipse(pos.x, pos.y, BULLET_RADIUS*2, BULLET_RADIUS*2);
        stroke(BULLET_LINK_COLOR);
        for(int i=0;i<BULLET_LINK_MAX;++i){
            Point p=nears.get(i);
            if(p.x>=0 && p.x<=SCREEN_WIDTH) {
              line(pos.x, pos.y, p.x, p.y);
            }
        }
        resetNears();
    }
    
    void tryGetNearerParticles(Point p){
        float distance=getDistance(pos, p);
        for(int i=0;i<BULLET_LINK_MAX;++i){
            if(getDistance(pos, nears.get(i))>distance){
                for(int j=BULLET_LINK_MAX-1;j>i;--j){
                    nears.set(j, nears.get(j-1));
                }
                nears.set(i, new Point(p));
                return;
            }
        }
        
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