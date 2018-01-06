class Particle{
    Point pos;
    float radian;
    float deltaRadian;
    float len;

    Particle(){}
    Particle(Point p, float r, float dr, float l){
        pos=new Point(p);
        radian=r;
        deltaRadian=dr;
        len=l;
    }
    
    private void show(){
        Point p=getPoint(pos, radian, len);
        fill(PARTICLE_COLOR);
        noStroke();
        float halfW=PARTICLE_WIDTH/2;
        rect(p.x-halfW, p.y-halfW, PARTICLE_WIDTH, PARTICLE_WIDTH);
    }

    void multi(float factor){
        if(len<PARTICLE_LENGTH_MIN && factor<1) return;
        if(len>PARTICLE_LENGTH_MAX && factor>1) return;
        len*=factor;
    }
    
    void update(){
        radian+=deltaRadian;
        if(radian>TWO_PI) radian-=TWO_PI;
        show();
    }
}