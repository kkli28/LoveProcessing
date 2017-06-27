int rand_num;
final int GHOST_BODY_COUNT=360;
final int GHOST_COUNT=16;
final int BLOCK_CORE_OFFSET=1;
final int BLOCK_LENGTH=BLOCK_CORE_OFFSET*2+1;
final int RANDOM_RANGE_MAX=240;
final int RANDOM_RANGE_MIN=60;

int rand(){
  rand_num=int(random(RANDOM_RANGE_MIN, RANDOM_RANGE_MAX));
  return int(random(rand_num));
}

class ghost{
  float x;
  float y;
  int directX;
  int directY;
  int time;
  float[][] body;
  int head_index;
  
  ghost(){
    //x=width/2;
    //y=height/2;
    x=int(random(0,width));
    y=int(random(0,height));
    update_direct();
    time=rand();
    body=new float[GHOST_BODY_COUNT][2];
    head_index=0;
  }
  
  private void update_direct(){
    int r=int(random(2));
    if(r==0) r=-1;
    if(directX==0){
      directX=r;
      directY=0;
    }
    else{
      directY=r;
      directX=0;
    }
    //directX=int(random(3))-1;
    //directY=int(random(3))-1;
  }
  
  private void update_body(){
    ++head_index;
    if(head_index==GHOST_BODY_COUNT) head_index=0;
    body[head_index][0]=x;
    body[head_index][1]=y;
  }
  
  private void display(){
    int cl;
    for(int i=head_index+1;i<GHOST_BODY_COUNT;++i){
      cl=i-head_index;
      fill(int(map(cl,0,GHOST_BODY_COUNT,60,255)));
      rect(body[i][0]+BLOCK_CORE_OFFSET,body[i][1]+BLOCK_CORE_OFFSET,BLOCK_LENGTH,BLOCK_LENGTH);
      //stroke(int(map(cl,0,GHOST_BODY_COUNT,60,255)));
      //point(body[i][0],body[i][1]);
    }
    for(int i=0;i<=head_index;++i){
      cl=head_index-i;
      fill(int(map(cl,0,GHOST_BODY_COUNT,255,60)));
      rect(body[i][0]+BLOCK_CORE_OFFSET,body[i][1]+BLOCK_CORE_OFFSET,BLOCK_LENGTH,BLOCK_LENGTH);
      //stroke(int(map(cl,0,GHOST_BODY_COUNT,255,60)));
      //point(body[i][0],body[i][1]);
    }
  }
  
  void move(){
    if(time<=0){
      time=rand();
      update_direct();
    }
    
    --time;
    x+=directX*2;
    y+=directY*2;
    if(x>=width) x-=width;
    else if(x<0) x+=width;
    if(y>=height) y-=height;
    else if(y<0) y+=height;
    update_body();
  }
};