class Point{
  int x;
  int y;
  int value;
  Point(int xx, int yy, int val)
  {
    x=xx;
    y=yy;
    if(x<0 || y<0 || x>=MAP_WIDTH || y>=MAP_HEIGHT) value = 0;
    else value =val;
  }
  Point(int xx, int yy){
    x=xx;
    y=yy;
    value = 0;
  }
}