class Plane{
    Point pos;
    float vx;
    float vy;
    boolean dead;

    final int COUNTX_MAX=60;
    final int COUNTY_MAX=240;
    final float DELTA_VX=0.04;
    final float DELTA_VY=0.04;
    int countX;
    int countY;

    Plane(Point p, float _vx, float _vy){
        pos=new Point(p);
        vx=_vx;
        vy=_vy;
        countX=COUNTX_MAX/2;
        countY=COUNTY_MAX/2;
        dead=false;
    }

    Plane(){
        dead=true;
    }

    private void show(){
        fill(PLANE_COLOR);
        ellipse(pos.x, pos.y, PLANE_R, PLANE_R);
        stroke(PLANE_LINE_COLOR);
        strokeWeight(PLANE_LINE_WEIGHT);
        Point p=getPoint(pos, atan2(vy, vx), PLANE_LINE_LENGTH);
        line(pos.x, pos.y, p.x, p.y);
    }

    private void fly(){
        ++countX;
        if(countX<=COUNTX_MAX*2){
          if((countX/COUNTX_MAX)%2==0) vx+=DELTA_VX;
          else vx-=DELTA_VX;
        }
        ++countY;
        if((countY/COUNTY_MAX)%2==0) vy+=DELTA_VY;
        else {
          vy-=DELTA_VY;
          countY=COUNTY_MAX+1;
        }
        
        pos.x+=vx;
        pos.y+=vy;
        if(pos.x<0 || pos.x>SCREEN_WIDTH) dead=true;
        if(pos.y<0 || pos.y>SCREEN_HEIGHT) dead=true;
    }

    void update(){
        fly();
        if(!dead) show();
    }
}