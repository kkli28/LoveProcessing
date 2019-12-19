int SCREEN_WIDTH = 760;
int SCREEN_HEIGHT = 760;
ArrayList<Polygon> obstacles;
ArrayList<Segment> mouseSegments;


void setup()
{
  size(760, 760);
}


void draw()
{
  background(255);
  obstacles = InitObstacles();
  for (Polygon polygon: obstacles)
  {
    polygon.Draw(true, #FFFFFF);
  }
  mouseSegments = DrawMouseSegments(obstacles);
}
