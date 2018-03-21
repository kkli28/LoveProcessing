class Map {
  Point[][] prev = new Point[MAP_WIDTH][MAP_HEIGHT];
  Point[][] next = new Point[MAP_WIDTH][MAP_HEIGHT];
  Map(){
    for(int i=0;i<MAP_WIDTH;++i){
      for(int j=0;j<MAP_HEIGHT;++j){
        prev[i][j]=new Point(i, j);
        next[i][j]=new Point(i, j);
      }
    }
  }
  boolean validXY(int x, int y){
    return x>=0 && x<MAP_WIDTH && y>=0 && y<MAP_HEIGHT;
  }
  int getValue(int x, int y){
    if(validXY(x, y)) return prev[x][y].value;
    else return 0;
  }
  
  int getNeighborValue(int x, int y)
  {
    int value = 0;
    value += getValue(x-1, y-1);
    value += getValue(x-1, y);
    value += getValue(x-1, y+1);
    value += getValue(x, y-1);
    value += getValue(x, y+1);
    value += getValue(x+1, y-1);
    value += getValue(x+1, y);
    value += getValue(x+1, y+1);
    return value;
  }
  void setRandomValue() {
    for(int i=0;i<MAP_WIDTH;++i){
      for(int j=0;j<MAP_HEIGHT;++j){
        next[i][j].value = int(random(100))%2;
      }
    }
  }
  void show(){
    noStroke();
    for(int i=0;i<MAP_WIDTH;++i){
      for(int j=0;j<MAP_HEIGHT;++j){
        if(next[i][j].value==1) fill(0);
        else fill(255);
        rect(i*RECT_WIDTH, j*RECT_HEIGHT, RECT_WIDTH, RECT_HEIGHT);
        prev[i][j].value = next[i][j].value;
      }
    }
    nextGen();
  }
  
  void nextGen() {
    for(int i=0;i<MAP_WIDTH;++i){
      for(int j=0;j<MAP_HEIGHT;++j){
        int value = getNeighborValue(i, j);
        if(value == 3){
          next[i][j].value=1;
        }
        else if(value == 2) ;
        else next[i][j].value = 0;
      }
    }
  }
}