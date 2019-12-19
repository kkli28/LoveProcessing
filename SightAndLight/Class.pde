
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
  
  Segment(Point _start, float _dx, float _dy, float _t)
  {
    start = _start;
    dx = _dx;
    dy = _dy;
    t = _t;
    end = new Point(start.x + dx * t, start.y + dy * t);
  }
  
  Segment(Point _start, Point _end)
  {
    start = _start;
    end = _end;
    dx = end.x - start.x;
    dy = end.y - start.y;
    t = 1;
  }
}


class Polygon
{
  ArrayList<Point> vertexs;
  
  Polygon()
  {
    vertexs = new ArrayList<Point>();
  }
  
  void Add(Point point)
  {
    vertexs.add(point);
  }
  
  void Draw(boolean fill, color c)
  {
    int size = vertexs.size();
    if (fill)
    {
      PShape s = createShape();
      s.beginShape();
      s.fill(c);
      //s.noStroke();
      for (int i = 0; i < size; ++i)
      {
        Point p = vertexs.get(i);
        s.vertex(p.x, p.y);
      }
      s.endShape(CLOSE);
      shape(s);
    }
  }
}