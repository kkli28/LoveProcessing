
//==== constant ====
final int SCREEN_WIDTH=720;
final int SCREEN_HEIGHT=720;

final int BOT_GUN_COUNT=4;
final float BOT_GUN_DELTA_RADIAN=TWO_PI/BOT_GUN_COUNT;
final int BOT_SIDE_LENGTH=24;
final float BOT_VELOCITY_MAX=4.0f;
final float BOT_VELCOITY_MIN=0.0f;
final float BOT_ACCELERATE=0.1f;
final float BOT_ARRIVE_TIME=20;
final float DISTANCE_DEVIATION=1.0f;
final float BOT_ROTATE_DELTA_RADIAN_MAX=0.5f;
float BOT_ROTATE_DELTA_RADIAN=0.1f;

final float BOT_BODY_RADIUS=16;
final float BOT_GUN_RADIUS=8;
final float BOT_SIDE_WEIGHT=3;

final int BOT_BODY_COLOR=#FF0000;
final int BOT_GUN_COLOR=#006CFF;
final int BOT_SIDE_COLOR=#4BFF00;

//==== variable ====
Bot bot=new Bot(new Point(SCREEN_WIDTH/2, SCREEN_HEIGHT/2));

//mouseWheel
void mouseWheel(MouseEvent event) {
  if(event.getCount()<0) BOT_ROTATE_DELTA_RADIAN+=0.02f;
  else BOT_ROTATE_DELTA_RADIAN-=0.02f;
  if(BOT_ROTATE_DELTA_RADIAN>BOT_ROTATE_DELTA_RADIAN_MAX) BOT_ROTATE_DELTA_RADIAN=BOT_ROTATE_DELTA_RADIAN_MAX;
  else if(BOT_ROTATE_DELTA_RADIAN<-BOT_ROTATE_DELTA_RADIAN_MAX) BOT_ROTATE_DELTA_RADIAN=-BOT_ROTATE_DELTA_RADIAN_MAX;
}

//showText
void showText(){
  textSize(24);
  fill(0);
  text(BOT_ROTATE_DELTA_RADIAN, 10, 20);
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
    rect(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    
    bot.track(new Point(mouseX, mouseY));
    bot.update();
    showText();
}