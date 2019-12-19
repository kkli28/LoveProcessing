
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



ArrayList<Segment> InitSegments()
{
  return null;
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