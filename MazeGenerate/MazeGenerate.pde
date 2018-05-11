import java.util.*;

int WIDTH = 804;
int HEIGHT = 804;
int width = 201;
int height = 201;
int w = WIDTH / width;
int h = HEIGHT / height;
color tryGenRoomCount = 1000;
int runRate = 1;
int routeColor = #0AFF45;
int headColor = #FF0533;
int roomColor = #0580FF;
int[][] array = new int[width][height];
int[] dirs = new int[4];
Stack<Point> stack = new Stack<Point>();

void initArray(){
  for(int i = 0; i < width; ++i){
    for(int j = 0; j < height; ++j){
      array[i][j] = 0;
    }
  }
}

void addRoom(int x, int y, int w, int h){
  for(int i = x-1; i < x + w+1; ++i){
    for(int j = y-1; j < y + h+1; ++j){
      if(isValid(i, j) && array[i][j] != 0) return;
    }
  }
  for(int i = x; i < x + w; ++i){
    for(int j = y; j < y + h; ++j){
      array[i][j] = 3;
    }
  }
}

void initRoom(){
  for(int i = 0; i < tryGenRoomCount; ++i){
    int x = int(random(width));
    int y = int(random(height));
    int w = int(random(12, 48));
    int h = int(random(12, 48));
    if(x % 2 == 0) x +=1;
    if(y % 2 == 0) y +=1;
    if(w % 2 == 0) w +=1;
    if(h % 2 == 0) h +=1;
    if(isValid(x+w, y+h)) addRoom(x, y, w, h);
  }
}

boolean isValid(int x, int y){
    return !(x < 0 || x >=width || y < 0 || y >= height);
}

void gen(){
    Point p = stack.peek();
    array[p.x][p.y] = 1;
    dirs[0] = 0;
    dirs[1] = 0;
    dirs[2] = 0;
    dirs[3] = 0;
    int index = 0;
    if(isValid(p.x-2, p.y) && array[p.x-2][p.y] == 0){
      dirs[index++] = 1;
    }
    if(isValid(p.x+2, p.y) && array[p.x+2][p.y] == 0){
      dirs[index++] = 2;
    }
    if(isValid(p.x, p.y-2) && array[p.x][p.y-2] == 0){
      dirs[index++] = 3;
    }
    if(isValid(p.x, p.y+2) && array[p.x][p.y+2] == 0){
      dirs[index++] = 4;
    }
    if(index == 0) {
      stack.pop();
      if(!stack.empty()){
        p = stack.peek();
        array[p.x][p.y] = 2;
      }
      return;
    }
    int dir = dirs[int(random(index-0.5f))];
    if(dir == 1){
      array[p.x-1][p.y] = 1;
      array[p.x-2][p.y] = 2;
      stack.push(new Point(p.x-2, p.y));
    }
    else if(dir == 2){
      array[p.x+1][p.y] = 1;
      array[p.x+2][p.y] = 2;
      stack.push(new Point(p.x+2, p.y));
    }
    else if(dir == 3){
      array[p.x][p.y-1] = 1;
      array[p.x][p.y-2] = 2;
      stack.push(new Point(p.x, p.y-2));
    }
    else {
      array[p.x][p.y+1] = 1;
      array[p.x][p.y+2] = 2;
      stack.push(new Point(p.x, p.y+2));
    }
}

void clearScreen(){
    fill(255);
    noStroke();
    rect(0, 0, WIDTH, HEIGHT);
}

void showMaze(){
    for(int i = 0; i < width; ++i){
        for(int j = 0; j < height; ++j){
            if(array[i][j] == 0) continue;
            if(array[i][j] == 1){
                fill(routeColor);
            }
            else if(array[i][j] == 2){
                fill(headColor);
            }
            else if(array[i][j] == 3){
                fill(roomColor);
            }
            rect(i*w, j*h, w, h);
        }
    }
}

void setup(){
    size(804, 804);
    background(255);
    noStroke();
    initArray();
    stack.push(new Point(1, 1));
    array[1][1] = 1;
    initRoom();
    //frameRate(120);
    
    /*
    //show maze directely
    while(!stack.empty()){
        gen();
        //showMaze();
    }
    showMaze();
    */
}

void draw(){
  boolean needShowMaze = false;
  for(int i = 0; i < runRate; ++i){
    if(!stack.empty()){
        needShowMaze = true;
        gen();
    }
  }
  if(needShowMaze){
    clearScreen();
    showMaze();
  }
  else{
    noLoop();
  }
}