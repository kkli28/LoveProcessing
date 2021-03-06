 
//getTrackRadian
float getTrackRadian(Point p1, Point p2){
    float deltaX=p2.x-p1.x;
    float deltaY=p2.y-p1.y;
    float cosA=deltaX/sqrt(deltaX*deltaX+deltaY*deltaY);
    if(deltaY>0) return 2*PI-acos(cosA);
    else return acos(cosA);
}

//getNormalizeRadian
float getNormalizeRadian(float radian){
  if(radian>0 && radian<2*PI) return radian;
  
  if(radian<0){
    int c=int((-radian)/(2*PI))+1;
    radian+=c*2*PI;
  }
  
  //radian >= 2*PI
  else{
    int c=int(radian/(2*PI));
    radian-=c*2*PI;
  }
  
  return radian;
}

//collisionDetection
boolean collisionDetection(Plane plane, Bullet bullet){
  float halfPW=PLANE_WIDTH/2;
  float halfBW=bullet.radius/2;
  
  //plane
  float pLeft=plane.pos.x-halfPW;
  float pRight=plane.pos.x+halfPW;
  float pTop=plane.pos.y+halfPW;
  float pBottom=plane.pos.y-halfPW;
  
  //bullet
  float bLeft=bullet.pos.x-halfBW;
  float bRight=bullet.pos.x+halfBW;
  float bTop=bullet.pos.y+halfBW;
  float bBottom=bullet.pos.y-halfBW;
  
  if(pRight > bLeft && pLeft < bRight && pTop > bBottom && pBottom < bTop) return true;
  else return false;
}