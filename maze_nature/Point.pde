class Point {
  int x;
  int y;
  Point(int _x, int _y) {
    x = _x;
    y = _y;
  }
  Point(Point p){
    x = p.x;
    y = p.y;
  }
  void set(int _x, int _y) {
    x = _x;
    y = _y;
  }
  boolean equal(Point p) {
    return x == p.x && y == p.y;
  }
};