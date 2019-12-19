int SCREEN_WIDTH = 960;
int SCREEN_HEIGHT = 960;
ArrayList<Segment> segments = InitSegments();
ArrayList<Segment> mouseSegments;



void setup()
{
  size(960, 960);
}



void draw()
{
  background(255);
  Polygon polygon = new Polygon();
  polygon.Add(new Point(20, 20));
  polygon.Add(new Point(400, 80));
  polygon.Add(new Point(600, 400));
  polygon.Add(new Point(400, 360));
  polygon.Add(new Point(200, 200));
  polygon.Draw(true, #FFFFFF);
  mouseSegments = DrawMouseSegments(72);
}