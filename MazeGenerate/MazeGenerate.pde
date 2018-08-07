import java.util.*;
//import android.view.MotionEvent;

//int wid = 135;
//int hei = 239;
//int w = 1080/wid;
//int h = 1920/hei;
int wid = 239;
int hei = 135;
int w = 1920/wid;
int h = 1080/hei;

color tryGenRoomCount = 1000;
int showResultIndex = 0;

int runRate = 50;

int routeNum = 1;
int headNum = 2;
int roomNum = 3;
int resultNum = 4;
int routeColor = #0AFF45;
int headColor = #FF0533;
int roomColor = #0580FF;
int resultColor = #FFB700;

int[][] array = new int[wid][hei];
int[] dirs = new int[4];
ArrayList<Point> result = new ArrayList<Point>();
Stack<Point> stack = new Stack<Point>();
Point entrance = new Point(1, 1);
Point exit = new Point(wid-2, hei-2);
Point resultBeg = new Point(entrance);
Point resultEnd = new Point(exit);
Point resultMid = new Point(0, 0);

void initArray(){
  for(int i = 0; i < wid; ++i){
    for(int j = 0; j < hei; ++j){
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
      array[i][j] = roomNum;
    }
  }
}

void initRoom(){
  for(int i = 0; i < tryGenRoomCount; ++i){
    int x = int(random(wid));
    int y = int(random(hei));
    int w = int(random(12, 48));
    int h = int(random(12, 48));
    if(x % 2 == 0) x +=1;
    if(y % 2 == 0) y +=1;
    if(w % 2 == 0) w +=1;
    if(h % 2 == 0) h +=1;
    if(isValid(x+w, y+h)) addRoom(x, y, w, h);
  }
}

void setResultToArray(){
    if(showResultIndex < result.size()){
        resultBeg = resultEnd;
        resultEnd = result.get(showResultIndex++);
        resultMid.x = (resultBeg.x + resultEnd.x)/2;
        resultMid.y = (resultBeg.y + resultEnd.y)/2;
        array[resultBeg.x][resultBeg.y] = resultNum;
        array[resultEnd.x][resultEnd.y] = resultNum;
        array[resultMid.x][resultMid.y] = resultNum;
    }
}

void setResult(){
    Stack<Point> stk = new Stack<Point>();
    while(!stack.empty()){
        stk.push(stack.peek());
        stack.pop();
    }
    while(!stk.empty()){
        result.add(new Point(stk.peek()));
        stack.push(stk.peek());
        stk.pop();
    }
}

boolean isValid(int x, int y){
    return !(x < 0 || x >=wid || y < 0 || y >= hei);
}

void gen(){
    if(stack.empty()) return;
    Point p = stack.peek();
    array[p.x][p.y] = routeNum;
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
        array[p.x][p.y] = headNum;
      }
      return;
    }
    int dir = dirs[int(random(index-0.5f))];
    if(dir == 1){
      array[p.x-1][p.y] = routeNum;
      array[p.x-2][p.y] = headNum;
      stack.push(new Point(p.x-2, p.y));
      if(p.x-2 == exit.x && p.y == exit.y){
        setResult();
      }
    }
    else if(dir == 2){
      array[p.x+1][p.y] = routeNum;
      array[p.x+2][p.y] = headNum;
      stack.push(new Point(p.x+2, p.y));
      if(p.x+2 == exit.x && p.y == exit.y){
        setResult();
      }
    }
    else if(dir == 3){
      array[p.x][p.y-1] = routeNum;
      array[p.x][p.y-2] = headNum;
      stack.push(new Point(p.x, p.y-2));
      if(p.x == exit.x && p.y-2 == exit.y){
        setResult();
      }
    }
    else {
      array[p.x][p.y+1] = routeNum;
      array[p.x][p.y+2] = headNum;
      stack.push(new Point(p.x, p.y+2));
      if(p.x == exit.x && p.y+2 == exit.y){
        setResult();
      }
    }
}

void clearScreen(){
    fill(255);
    noStroke();
    rect(0, 0, width, height);
}

void showMaze(){
    for(int i = 0; i < wid; ++i){
        for(int j = 0; j < hei; ++j){
            if(array[i][j] == 0) continue;
            if(array[i][j] == routeNum){
                fill(routeColor);
            }
            else if(array[i][j] == headNum){
                fill(headColor);
            }
            else if(array[i][j] == roomNum){
                fill(roomColor);
            }
            else if(array[i][j] == resultNum){
                fill(resultColor);
            }
            rect(i*w, j*h, w, h);
        }
    }
}

void reset(){
    clearScreen();
    stack.clear();
    result.clear();
    initArray();
    stack.push(entrance);
    array[entrance.x][entrance.y] = 1;
    initRoom();
    showResultIndex = 0;
}

void setup(){
    fullScreen();
    background(255);
    noStroke();
    reset();
}

/*
public boolean surfaceTouchEvent(MotionEvent me) {
  reset();
  return super.surfaceTouchEvent(me);
}
*/

void keyPressed(){
    reset();
    loop();
}

void draw(){
  boolean needShowMaze = false;
  if(!stack.empty()){
    needShowMaze = true;
    for(int i = 0; i < runRate; ++i){
        gen();
    }
  }
  
  if(needShowMaze){
    clearScreen();
    showMaze();
  }
  else{
    noLoop();
    /*
    for(int i = 0; i < runRate; ++i){
        setResultToArray();
    }
    showMaze();
    if(showResultIndex >= result.size()) noLoop();
    */
  }
}