int SCREEN_WIDTH = 1280;
int SCREEN_HEIGHT = 760;
ArrayList<Polygon> obstacles;
ArrayList<Segment> mouseSegments;


void setup()
{
  size(1281, 761);
}


void draw()
{
  background(255);
  obstacles = InitObstacles();
  for (Polygon polygon: obstacles)
  {
    polygon.Draw(true, #FFFFFF);
  }
  //mouseSegments = DrawMouseSegments(obstacles);
}