
// Utilities

boolean IsParallel(Segment seg1, Segment seg2)
{
  boolean sameDx = seg1.dx == seg2.dx;
  boolean sameDy = seg1.dy == seg2.dy;
  return (sameDx && sameDy) || (!sameDx && !sameDy);
}


void DrawSegment(Segment seg, int weight, color c)
{
  strokeWeight(weight);
  fill(c);
  line(seg.start.x, seg.start.y, seg.end.x, seg.end.y);
}


void DrawSegment(Segment seg)
{
  DrawSegment(seg, 1, #000000);
}


ArrayList<Segment> DrawMouseSegments(int segNum)
{
  ArrayList<Segment> segments = new ArrayList<Segment>();
  float deltaAngle = TWO_PI / segNum;
  float currAngle = 0;
  for (int i = 0; i < segNum; ++i)
  {
    float dx = cos(currAngle);
    float dy = sin(currAngle);
    Segment seg = new Segment(new Point(mouseX + dx * 20, mouseY + dy * 20), dx, dy, 10000);
    segments.add(seg);
    currAngle += deltaAngle;
    
    DrawSegment(seg);
  }
  return segments;
}


ArrayList<Polygon> InitObstacles()
{
  ArrayList<Polygon> obstacles = new ArrayList<Polygon>();
  
  Polygon window = new Polygon();
  window.Add(new Point(0, 0));
  window.Add(new Point(SCREEN_WIDTH, 0));
  window.Add(new Point(SCREEN_WIDTH, SCREEN_HEIGHT));
  window.Add(new Point(0, SCREEN_HEIGHT));
  obstacles.add(window);

  ArrayList<ArrayList<int>> datas = new ArrayList<ArrayList<int>>();
  for (i = 0; i < 8; ++i)
  {
    datas[i] = new ArrayList<int>();
  }
  int[] data1 = {700, 200, 900, 100, 900, 300};
  int[] data2 = {400, 300, 500, 800, 300, 700};
  int[] data3 = {300, 200, 500, 100, 500, 200};
  int[] data4 = {700, 600, 900, 500, 800, 700};
  int[] data5 = {500, 300, 600, 300, 700, 500, 500, 400};
  int[] data6 = {500, 900, 600, 800, 600, 700, 800, 900};
  int[] data7 = {100, 200, 200, 100, 200, 200, 300, 300, 200, 500, 100, 400};
  int[] data8 = {100, 900, 100, 700, 200, 600, 300, 800, 400, 900};
  ArrayList<int[]> datas = new ArrayList<int[]>();
  for (int i = 0; i < 8; ++i)
  {
    
  }
  
  Polygon polygon = new Polygon();
  polygon.Add(new Point(20, 20));
  polygon.Add(new Point(400, 80));
  polygon.Add(new Point(600, 400));
  polygon.Add(new Point(400, 360));
  polygon.Add(new Point(200, 200));
  polygon.Draw(true, #FFFFFF);
}