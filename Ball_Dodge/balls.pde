vec G=V(0,300); // constant acceleration
vec O=V(0,0);  // nil vector
float r=25;



BALL BB [] = new BALL[9];       // table of balls
void makeBalls() {
  //BB[0]= new BALL(ScreenCenter(),O,O,r,orange,0); BB[0].m=100;
  BB[1]= new BALL(L,O,G,r,magenta,0, false);  
  BB[2]= new BALL(R,O,G,r,magenta,15, false);
  BB[3]= new BALL(L,O,G,r,magenta,30, false); 
  BB[4]= new BALL(R,O,G,r,magenta,45, false);
  BB[5]= new BALL(L,O,G,r,magenta,60, false); 
  BB[6]= new BALL(R,O,G,r,magenta,75, false);
  BB[7]= new BALL(L,O,G,r,magenta,90, false); 
  BB[8]= new BALL(R,O,G,r,magenta,105, false);
}
void moveBalls() {
  for(int i=1; i<BB.length; i++)  BB[i].move(1./30,predict(),i);
}
void showBalls() {
  for(int i=1; i<BB.length; i++) BB[i].showBall();
}

class BALL {   // class ball used for fighters and the ring
  pt H; 
  pt C ; 
  vec V; 
  vec G; 
  float r; 
  float m=1; 
  color c; 
  int f; 
  boolean collide;
  // center, velocity, acceleration; radius, mass, color of ball frame; frame coont , home position
  BALL (pt pH, vec pV, vec pG, float pr, color pc, int pf, boolean collz) {
    H=P(pH); 
    V=V(pV); 
    G=V(pG); 
    r=pr; 
    c=pc; 
    f=pf; 
    C=P(H);
    collide = collz;
  }
  void showBall() {
    fill(c); 
    show(C,r);
  }
  void track(pt A) { 
    C=P(A);
  }
  void move(float t, pt T, int i) {
    f++; 
    if(f>=120) {
      C.setTo(H); 
      V=aim(H,T,i);  
      f=0;
    } 
    else {

      V.y = V.y+t*(G.y);
      C.x = C.x+t*(V.x);
      C.y = C.y+(1./2)*(G.y)*(t*t)+t*(V.y);
    }
  };  
  //void showFace(pt P, float s,  PImage pic) {beginShape(); texture(pic); for (float a=-PI; a<PI; a+=PI/18) { vertex(C.x+r*cos(a),C.y+r*sin(a),P.x+s*cos(a),P.y+s*sin(a));} endShape(CLOSE); }
} // end calss BALL

// The code for the following 4 procedures/functions muyst be provided by the student 
// furthernmore, the student should provide additional code to turn this into a fun game

pt predict() {  // predicts where the target will be in 2 seconds
  pt TC = P(springs[0].tempxpos, springs[0].tempypos);
  pt pTC = P(mouseX, mouseY);
  vec PREDICT = V(TC, pTC);
  T(pTC, 2, PREDICT);

  return Mouse();
} 

vec aim(pt H, pt T, int i) {  // computes initial velocity V of ball to reach target T from point H assuming constant acceleration G exactly in 2 seconds

  if(i%2 == 0) {
    float Vx = (T.x-width)*(1./2);
    float Vy = (T.y-height-2.*(G.y))*(1./2);
    vec Vo = V(Vx,Vy);
    return Vo;
  }

  if(i%2 == 1) { 
    float Vx = T.x*(1./2);
    float Vy = (T.y-height-2.*(G.y))*(1./2); 
    vec Vo = V(Vx,Vy);
    return Vo;
  }

  return S(.5,V(H,T));
}

void processCollisions() { // detects and processes (bounce?) collisions and increments points each time BB[0] collides with another ball (avoid double counting!)
  pt TC = P(springs[0].tempxpos, springs[0].tempypos);
  for (int i=1; i<BB.length; i++) {
    if (d(TC,BB[i].C)< BB[i].r*2 && springs[0].collide != true && BB[i].collide != true) {
      points++;
      springs[0].collide = true;
      BB[i].collide = true;
      BB[i].c = black;
    }
    if (d(TC, BB[i].C)>BB[i].r*2) {
      springs[0].collide = false;
      BB[i].collide = false;
      BB[i].c = magenta;
    }
  }
}

