int SCREEN_WIDTH = 960;
int SCREEN_HEIGHT = 960;
ArrayList<Polygon> obstacles;
ArrayList<Segment> mouseSegments;


void setup()
{
  size(960, 960);
}


void draw()
{
  background(255);
  obstacles = InitObstacles(12);
  mouseSegments = DrawMouseSegments(12);
  text("x: " + new Integer(mouseX).toString() + "  y:" + new Integer(mouseY).toString(), 100, 800);
}