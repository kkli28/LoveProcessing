class Point{
    float x;
    float y;
    Point(){}
    Point(float xx, float yy){
        x=xx;
        y=yy;
    }
    Point(Point p){
        x=p.x;
        y=p.y;
    }
}

class Brick{
    int id;
    Point pos;
    int type;
    boolean canMove;
    boolean moveLeft;
    int brickColor;
    float velocity;
    boolean dead;
    
    Brick(Point p, int t){
        id=getID();
        pos=new Point(p);
        type=t;
        switch(type){
            case BRICK_NORMAL: {
                setAttr(false, BRICK_NORMAL_COLOR);
                nowHeight=pos.y;
                reachHeight=nowHeight-PLAYER_JUMP_HEIGHT; break;
            }
            case BRICK_JUMP: {
                setAttr(false, BRICK_JUMP_COLOR);
                nowHeight=pos.y;
                reachHeight=nowHeight-BRICK_JUMP_HEIGHT; break;
            }
            case BRICK_VIRTUAL: setAttr(false, BRICK_VIRTUAL_COLOR); break;
            case BRICK_NORMAL_MOVE: {
                setAttr(true, BRICK_NORMAL_COLOR);
                nowHeight=pos.y;
                reachHeight=nowHeight-PLAYER_JUMP_HEIGHT; break;
            }
            case BRICK_JUMP_MOVE: {
                setAttr(true, BRICK_JUMP_COLOR);
                nowHeight=pos.y;
                reachHeight=nowHeight-BRICK_JUMP_HEIGHT; break;
            }
            case BRICK_VIRTUAL_MOVE: setAttr(true, BRICK_VIRTUAL_COLOR); break;
            default: break;
        }
        dead=false;
    }

    private void setAttr(boolean cm, int bc){
        canMove=cm;
        brickColor=bc;
        if(canMove) velocity=random(BRICK_MOVE_VELOCITY_MIN, BRICK_MOVE_VELOCITY_MAX);
    }

    private void show(){
        fill(brickColor);
        noStroke();
        float hbw=BRICK_WIDTH/2;
        float hbh=BRICK_HEIGHT/2;
        rect(pos.x-hbw, pos.y-hbh, BRICK_WIDTH, BRICK_HEIGHT);
        textSize(14);
        text(id, pos.x, pos.y);
    }

    void update(){
        if(dead) return;
        if(canMove){
            if(moveLeft) pos.x-=velocity;
            else pos.x+=velocity;
            float hbw=BRICK_WIDTH/2;
            if(pos.x<hbw){
                pos.x=hbw;
                moveLeft=!moveLeft;
            }
            else if(pos.x>SCREEN_WIDTH-hbw){
                pos.x=SCREEN_WIDTH-hbw;
                moveLeft=!moveLeft;
            }
        }
        pos.y+=BRICK_DOWN_HEIGHT;
        if(pos.y>SCREEN_HEIGHT+BRICK_HEIGHT) dead=true;
        else show();
    }
}