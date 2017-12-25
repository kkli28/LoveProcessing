
//==== Constant ====
final int ARRIVE_TIME=10;
final float DEVIATION=1.0f;

//==== Variable ====
Point bot=new Point(360, 360);
float velocity=0.0f;

//getDistance
float getDistance(Point p1, Point p2){
    float dx=p1.x-p2.x;
    float dy=p1.y-p2.y;
    return sqrt(dx*dx+dy*dy);
}

//getAccelerate
float getAccelerate(float distance, float velocity){
    return 2*distance/(ARRIVE_TIME*ARRIVE_TIME)-velocity*2/ARRIVE_TIME;
}

//drawBot
void drawBot(){
    noStroke();
    fill(0);
    ellipse(bot.x, bot.y, 12, 12);
}

//updateBot
void updateBot(){
    float dx=bot.x-mouseX;
    float dy=bot.y-mouseY;
    if(abs(dx)<DEVIATION && abs(dy)<DEVIATION) return;

    Point mouseP=new Point(mouseX, mouseY);
    float distance=getDistance(bot, mouseP);
    float accelerate=getAccelerate(distance, velocity);
    velocity+=accelerate;
    float radian=getRadian(bot, mouseP);
    bot.x+=cos(radian)*velocity;
    bot.y+=sin(radian)*velocity;
}

//textShow
void textShow(){
    textSize(24);
    stroke(0);
    fill(0);
    text("["+new Float(bot.x).toString()+","+new Float(bot.y).toString()+"]", 10, 20);
}

//setup
void setup(){
    size(720, 720);
    background(255);
}

//draw
void draw(){
    fill(255);
    noStroke();
    rect(0, 0, 720, 720);
  
    updateBot();
    drawBot();
    
    textShow();
}