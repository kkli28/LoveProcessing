
// Class Definition

class Point
{
  float x;
  float y;
  
  Point(float _x, float _y)
  {
    x = _x;
    y = _y;
  }
}


class Segment
{
  Point start;
  Point end;
  float dx;
  float dy;
  float t;
  float radian;
  
  Segment(Point _start, float _dx, float _dy, float _t)
  {
    start = _start;
    dx = _dx;
    dy = _dy;
    t = _t;
    end = new Point(start.x + dx * t, start.y + dy * t);
    radian = atan2(dy, dx);
  }
  
  Segment(Point _start, Point _end)
  {
    start = _start;
    end = _end;
    dx = end.x - start.x;
    dy = end.y - start.y;
    t = 1;
    radian = atan2(dy, dx);
  }

  public void SetT(float _t)
  {
    t = _t;
    end = new Point(start.x + dx * t, start.y + dy * t);
  }
}


class Polygon
{
  ArrayList<Point> vertexs;
  ArrayList<Segment> segments;
  boolean isBorder;
  
  Polygon()
  {
    vertexs = new ArrayList<Point>();
    segments = new ArrayList<Segment>();
    isBorder = false;
  }
  
  void Add(Point point)
  {
    vertexs.add(point);
  }
  
  void Draw(boolean fill, color c)
  {
    if (fill)
    {
      PShape s = createShape();
      s.beginShape();
      if (isBorder)
      {
        s.fill(255);
      }
      else
      {
        s.fill(0, 0, 0, 128);
      }
      //s.noStroke();
      for (Point point: vertexs)
      {
        s.vertex(point.x, point.y);
      }
      s.endShape(CLOSE);
      shape(s);
    }
  }

  void GenerateSegments()
  {
    int endI = vertexs.size() - 1;
    for (int i = 0; i < endI; ++i)
    {
      Point p1 = vertexs.get(i);
      Point p2 = vertexs.get(i + 1);
      Segment seg = new Segment(p1, p2.x - p1.x, p2.y - p1.y, 1);
      segments.add(seg);
    }
    Point p1 = vertexs.get(endI);
    Point p2 = vertexs.get(0);
    Segment seg = new Segment(p1, p2.x - p1.x, p2.y - p1.y, 1);
    segments.add(seg);
  }
}
