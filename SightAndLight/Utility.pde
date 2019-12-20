
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


ArrayList<Segment> DrawMouseSegments(ArrayList<Polygon> obstacles)
{
  ArrayList<Segment> segments = new ArrayList<Segment>();
  Point mousePos = new Point(mouseX, mouseY);
  for (Polygon polygon: obstacles)
  {
    for (Point p: polygon.vertexs)
    {
      float dx = p.x - mousePos.x;
      float dy = p.y - mousePos.y;
      Segment seg = new Segment(new Point(mousePos.x, mousePos.y), dx, dy, 1);
      segments.add(seg);
      DrawSegment(seg);
    }
  }
  return segments;
  
  ArrayList<Segment> segments = new ArrayList<Segment>();
  Point startPos = new Point(SCREEN_WIDTH / 2, SCREEN_HEIGHT / 2);
  Point mousePos = new Point(mouseX, mouseY);
  float dx = mousePos.x - startPos.x;
  float dy = mousePos.y - startPos.y;
  float t = 10000;
  for (Polygon polygon: obstacles)
  {
    ArrayList<Segment> segments = polygon.segments;

    // T2 = (r_dx*(s_py-r_py) + r_dy*(r_px-s_px))/(s_dx*r_dy - s_dy*r_dx)
    // 带入 T2 得到 T1
    // T1 = (s_px+s_dx*T2-r_px)/r_dx
    // 求出最小的 t
  }
  Segment mouseSeg = new Segment(startPos, dx, dy, t);
}


ArrayList<Polygon> InitObstacles()
{
  ArrayList<Polygon> obstacles = new ArrayList<Polygon>();
  
  Polygon window = new Polygon();
  window.Add(new Point(2, 2));
  window.Add(new Point(SCREEN_WIDTH - 2, 2));
  window.Add(new Point(SCREEN_WIDTH - 2, SCREEN_HEIGHT - 2));
  window.Add(new Point(2, SCREEN_HEIGHT - 2));
  window.isBorder = true;
  obstacles.add(window);
  
  int[] data1 = {560, 160, 720, 80, 720, 240};
  int[] data2 = {320, 240, 400, 640, 240, 560};
  int[] data3 = {240, 160, 400, 80, 400, 160};
  int[] data4 = {560, 480, 720, 540, 640, 560};
  int[] data5 = {400, 240, 480, 240, 560, 400, 400, 320};
  int[] data6 = {400, 720, 480, 640, 480, 560, 640, 720};
  int[] data7 = {80, 160, 160, 80, 160, 160, 240, 240, 160, 400, 80, 320};
  int[] data8 = {80, 720, 80, 560, 160, 480, 240, 640, 320, 720};
  int[] data9 = {640, 320, 960, 240, 880, 320, 1040, 320, 1120, 400, 960, 480, 1120, 480, 960, 560, 880, 480, 800, 560, 880, 400};
  int[] data10 = {960, 80, 1200, 80, 1200, 160, 960, 160};
  int[] data11 = {1040, 240, 1200, 240, 1240, 320, 1240, 400, 1120, 480, 1200, 400};
  int[] data12 = {720, 640, 880, 560, 960, 640, 1040, 560, 1120, 640, 1200, 560, 1200, 720, 1120, 720, 1040, 640, 960, 720, 880, 640, 800, 720};
  int[] data13 = {480, 320, 640, 400, 560, 560};
  
  ArrayList<int[]> datas = new ArrayList<int[]>();
  datas.add(data1);
  datas.add(data2);
  datas.add(data3);
  datas.add(data4);
  datas.add(data5);
  datas.add(data6);
  datas.add(data7);
  datas.add(data8);
  datas.add(data9);
  datas.add(data10);
  datas.add(data11);
  datas.add(data12);
  datas.add(data13);

  for (int i = 0; i < 13; ++i)
  {
    int[] data = datas.get(i);
    int length = data.length / 2;
    Polygon polygon = new Polygon();
    for (int j = 0; j < length; ++j)
    {
      polygon.Add(new Point(data[j*2], data[j*2+1]));
    }
    polygon.GenerateSegments();
    obstacles.add(polygon);
  }
  return obstacles;
}
