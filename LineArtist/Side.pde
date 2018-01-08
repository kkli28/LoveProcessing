class Circle{
    Point pos;
    float r_max;
    float r;

    Circle(Point p, float rr){
        pos=p;
        if(rr>ELEMENT_R_MAX) rr=ELEMENT_R_MAX;
        else if(rr<ELEMENT_R_MIN) rr=ELEMENT_R_MIN;
        r=rr;
        r_max=rr;
    }

    void show(){
        fill(ELEMENT_COLOR);
        noStroke();
        ellipse(pos.x, pos.y, r, r);
        r-=DELTA_RADIAN;
        if(r<ELEMENT_R_MIN) r=ELEMENT_R_MIN;
    }

    void reset(){
        r=r_max;
    }
}

class Side{
    private int side_count;
    int element_index;
    private ArrayList<Circle> circles;

    void validCount(int count){
        if(count<=0 || count>SIDE_COUNT_MAX){
            println("Wrong count!");
            return;
        }
    }

    Side(){
        circles=new ArrayList<Circle>();
        setCount(1);
    }

    Side(int count){
        circles=new ArrayList<Circle>();
        setCount(count);
    }
    
    void clear(){
        circles.clear();
    }

    void setCount(int count){
        validCount(count);
        circles.clear();
        circles=new ArrayList<Circle>();
    }

    void addElement(Point p){
        circles.add(new Circle(p, ELEMENT_R_MAX));
    }
    
    private void show(){
        if(circles.size()==0) return;
        if(element_index==circles.size()){
            for(Circle c: circles) c.reset();
            element_index=0;
            return;
        }

        float delta_radian=TWO_PI/side_count;
        for(int i=0;i<element_index;++i){
            Circle c=circles.get(i);
            float r=getRadian(SCREEN_CENTER, c.pos);
            float len=getLength(SCREEN_CENTER, c.pos);
            for(int j=0;j<side_count;++j) {
                Circle cc=new Circle(new Point(getPoint(c.pos, r+j*delta_radian, len)), c.r);
                cc.show();
            }
        }
        ++element_index;
    }
}