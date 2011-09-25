//*****************************************************************************
// TITLE:         POINT AND VECTOR UTILITIES OF THE GSB TEMPLATE  
// DESCRIPTION:   Classes and functions for manipulating points and vectors in the Geometry SandBox Geometry (GSB)  
// AUTHOR:        Prof Jarek Rossignac
// DATE CREATED:  September 2009
// EDITS:
//*****************************************************************************

/************************* SHORTCUT FUNCTIONS FOR POINTS and VECTORS ********************************************
Names of points: A, B, C, D, P, Q; coordinates (P.x,P.y)
Names of vectors: U, V, W, coordinates <V.x,V.y>
Names of scalars: s, t, a, b, c, d, x, y
The names of functions that return Points or Vectors starts with a an uppercase letter

Create or copy points and vectors 
P(): make point (0,0)
P(x,y): make point (x,y)
P(A): make copy of point A
V(V): make copy of vector V
V(x,y): make vector <x,y>
V(P,Q): PQ (make vector Q-P from P to Q
U(P,Q): PQ/||PQ| (Unit vector : from P towards Q)

Render points and vectors
v(P): next point when drawing polygons between beginShape(); and endShape();
cross(P,r): shows P as cross of length r
cross(P): shows P as small cross
show(P,r): draws circle of center r around P
show(P): draws small circle around point
show(P,Q): draws edge (P,Q)
show(P,Q,R): draws triangle (P,Q,R)
arrow(P,Q): draws arrow from P to Q
label(P,S): writes string S next to P on the screen ( for example label(P[i],str(i));)
label(P,V,S): writes string S at P+V
show(P,V): show V as line-segment from P 
show(P,s,V): show sV as line-segment from P 
arrow(P,V): show V as arrow from P 
arrow(P,s,V): show sV as arrow from P 
arrow(P,V,S): show V as arrow from P and print string S on its side

Transform: scale, rotate, translate, normalize
U(V): V/||V|| (Unit vector : normalized version of V)
R(V): V turned right 90 degrees (as seen on screen)
R(V,a): V rotated by a radians
S(s,V): sV
S(s,A): sA
S(s,A,B): B+sBA=(1+s)B-sA (scaling of A by s wrt fixed point B)
R(Q,a): Q rotated by angle a around the origin
R(Q,a,P): Q rotated by angle a around fixed point P (center of roatation)
T(P,V): P+V (P transalted by vector V)
T(P,s,V): P+sV (P translated by vector sV)
T(P,s,Q): P+sU(PQ) (translated P by absolute distance (not ratio) s towards Q)

Averages and linear interpolations of points
L(A,s,B): A+sAB (linear interpolation between points)
A(A,B): (A+B)/2 (average)
A(A,B,C): (A+B+C)/3 (average)
S(A,B): A+B
S(A,B,C): A+B+C
S(A,B,C,D): A+B+C+D
S(A,s,B): A+sB (used in summations of center of mass and in circle inversion)
S(a,A,b,B): aA+bB 
S(a,A,b,B,c,C): aA+bB+cC 
S(a,A,b,B,c,C,d,D): aA+bB+cC+dD (used in smoothing and subdivision)
S(U,V): U+V 
S(a,U,b,V): aU+bV (Linear combination)
S(U,s,V): U+sV
A(U,V): (U+V)/2 (average)
L(U,s,V): (1-s)U+sV (Linear interpolation between vectors)
R(U,s,V): interpolation (of angle and length) between U and V

Measures 
isSame(A,B): A==B (Boolean)
isSame(A,B,e): ||A-B||<e (Boolean)
d(A,B): ||AB|| (Distance)
d2(A,B): AB*AB (Distance squared)
dot(U,V): U*V (dot product U*V)
n(V): ||V|| (norm: length of V)
n2(V): V*V (norm squared)
parallel(U,V): U//V (Boolean) 
angle(V): angle between <1,0> and V (between -PI and PI)
angle(U,V): angle <U,V> (between -PI and PI)
angle(A,B,C): angle <BA,BC>
turnAngle(A,B,): angle <AB,BC> (positive when right turn as seen on screen)
toDeg(a): convert radians to degrees
toRad(a): convert degrees to radians 
positive(a): returns angle between 0 and 2PI (adds 2PI if a is negative)
cw(B,C): true if smallest angle turn from OB to OC is cloclwise (cw), where O=(0,0) (defined in TAB tri)
cw(A,B,C): true if A-B-C makes a clockwise turn at B (defined in TAB tri)

GUI mouse & canvas (left part [height,height] of window, assuming width>=height)
Mouse(): returns point at current mouse location
Pmouse(): returns point at previous mouse location
MouseDrag(): vector representing recent mouse displacement
drag(P) adjusts P by mouse drag vector
ScreenCenter(): point in center of square canvas
mouseIsInWindow(): if mouse is in square canvas (Boolean)
MouseInWindow(): point in square canvas nearest to mouse (snapped to border if Mouse was out)

Often used methods that transform points or vectors
P.reset(): P=(0,0)
P.set(x,y): P=(x,y)
P.set(Q): P=Q (copy)
P.add(u,v): P+=<u,v>
P.add(V): P+=V
P.add(s,V): P+=sV
P.add(Q): P+=Q
P.scale(s): P*=s
P.scale(s,C): P=L(C,s,P);
P.rotate(a): rotate P around origin by angle a in radians
P.rotate(a,G): rotate P around G by angle a in radians

Intersections of edges or lines
edgesIntersect(A,B,C,D): if edge(A,B) intersects edge(C,D)
edgesIntersect(A,B,C,D,e): if edge(A,B) intersects edge(C,D)or touches it within distance e
pt linesIntersection(A,B,C,D): if line(A,B) intersects line(C,D)

*********************************************************************************************************************************************/

// create or copy points 
pt P() {return P(0,0); };                                                                            // P(): make point (0,0)
pt P(float x, float y) {return new pt(x,y); };                                                       // P(x,y): make point (x,y)
pt P(pt P) {return P(P.x,P.y); };                                                                    // P(A): make copy of point A
// create vectors
vec V(vec V) {return new vec(V.x,V.y); };                                                             // V(V): make copy of vector V
vec V(float x, float y) {return new vec(x,y); };                                                      // V(x,y): make vector (x,y)
vec V(pt P, pt Q) {return new vec(Q.x-P.x,Q.y-P.y);};                                                 // V(P,Q): PQ (make vector Q-P from P to Q

// render points
void v(pt P) {vertex(P.x,P.y);};                                                                      // v(P): next point when drawing polygons between beginShape(); and endShape();
void cross(pt P, float r) {line(P.x-r,P.y,P.x+r,P.y); line(P.x,P.y-r,P.x,P.y+r);};                    // cross(P,r): shows P as cross of length r
void cross(pt P) {cross(P,2);};                                                                       // cross(P): shows P as small cross
void show(pt P, float r) {ellipse(P.x, P.y, 2*r, 2*r);};                                              // show(P,r): draws circle of center r around P
void show(pt P) {ellipse(P.x, P.y, 4,4);};                                                            // show(P): draws small circle around point
void show(pt P, pt Q) {line(P.x,P.y,Q.x,Q.y); };                                                      // show(P,Q): draws edge (P,Q)
void arrow(pt P, pt Q) {arrow(P,V(P,Q)); }                                                            // arrow(P,Q): draws arrow from P to Q
void label(pt P, String S) {text(S, P.x-4,P.y+6.5); }                                                   // label(P,S): writes string S next to P on the screen ( for example label(P[i],str(i));)
void label(pt P, vec V, String S) {text(S, P.x-3.5+V.x,P.y+7+V.y); }                                    // label(P,V,S): writes string S at P+V
// render vectors
void show(pt P, vec V) {line(P.x,P.y,P.x+V.x,P.y+V.y); }                                              // show(P,V): show V as line-segment from P 
void show(pt A, pt B, pt C) { beginShape(); v(A); v(B); v(C); endShape(CLOSE); }                      // show triangle
void show(pt A, pt B, pt C, pt D) { beginShape(); v(A); v(B); v(C); v(D); endShape(CLOSE); }                      // show triangle
void show(pt P, float s, vec V) {show(P,S(s,V));}                                                     // show(P,s,V): show sV as line-segment from P 
void arrow(pt P, vec V) {show(P,V);  float n=n(V); if(n<0.01) return; float s=max(min(0.2,20./n),6./n);                  // arrow(P,V): show V as arrow from P 
     pt Q=T(P,V); vec U = S(-s,V); vec W = R(S(.3,U)); beginShape(); v(T(T(Q,U),W)); v(Q); v(T(T(Q,U),-1,W)); endShape(CLOSE);}; 
void arrow(pt P, float s, vec V) {arrow(P,S(s,V));}                                                   // arrow(P,s,V): show sV as arrow from P 
void arrow(pt P, vec V, String S) {arrow(P,V); T(T(P,0.70,V),15,R(U(V))).showLabel(S,V(-5,4));}      // arrow(P,V,S): show V as arrow from P and print string S on its side

// averages and linear interpolations of points
pt L(pt A, float s, pt B) {return P(A.x+s*(B.x-A.x),A.y+s*(B.y-A.y)); };                             // L(A,s,B): A+sAB (linear interpolation between points)
pt A(pt A, pt B) {return P((A.x+B.x)/2.0,(A.y+B.y)/2.0); };                                          // A(A,B): (A+B)/2 (average)
pt A(pt A, pt B, pt C) {return P((A.x+B.x+C.x)/3.0,(A.y+B.y+C.y)/3.0); };                            // A(A,B,C): (A+B+C)/3 (average)
// weighted sums of points 
pt S(pt A, pt B) {return new pt(A.x+B.x,A.y+B.y); };                                                 // S(A,B): A+B
pt S(pt A, pt B, pt C) {return S(A,S(B,C)); };                                                       // S(A,B,C): A+B+C
pt S(pt A, pt B, pt C, pt D) {return S(S(A,B),S(C,D)); };                                            // S(A,B,C,D): A+B+C+D
pt S(pt A, float s, pt B) {return S(A,S(s,B)); };                                                    // S(A,s,B): A+sB (used in summations of center of mass and in circle inversion)
pt S(float a, pt A, float b, pt B) {return S(S(a,A),S(b,B));}                                        // S(a,A,b,B): aA+bB 
pt S(float a, pt A, float b, pt B, float c, pt C) {return S(S(a,A),S(b,B),S(c,C));}                  // S(a,A,b,B,c,C): aA+bB+cC 
pt S(float a, pt A, float b, pt B, float c, pt C, float d, pt D){return A(S(a,A,b,B),S(c,C,d,D));}   // S(a,A,b,B,c,C,d,D): aA+bB+cC+dD (used in smoothing and subdivision)
// combinations of vectors
vec S(vec U, vec V) {return new vec(U.x+V.x,U.y+V.y);}                                                // S(U,V): U+V 
vec S(float s,vec V) {return new vec(s*V.x,s*V.y);};                                                  // S(s,V): sV
vec S(float a, vec U, float b, vec V) {return S(S(a,U),S(b,V));}                                      // S(a,U,b,V): aU+bV )Linear combination)
vec S(vec U,float s,vec V) {return new vec(U.x+s*V.x,U.y+s*V.y);};                                    // S(U,s,V): U+sV
vec A(vec U, vec V) {return new vec((U.x+V.x)/2.0,(U.y+V.y)/2.0); };                                  // A(U,V): (U+V)/2 (average)
vec L(vec U,float s,vec V) {return new vec(U.x+s*(V.x-U.x),U.y+s*(V.y-U.y));};                        // L(U,s,V): (1-s)U+sV (Linear interpolation between vectors)
vec R(vec U, float s, vec V) {float a = angle(U,V); vec W = U.makeRotatedBy(s*a);                     // R(U,s,V): interpolation (of angle and length) between U and V
    float u = n(U); float v=n(V); S((u+s*(v-u))/u,W); return W ; };

// measure points (equality, distance)
boolean isSame(pt A, pt B) {return (A.x==B.x)&&(A.y==B.y) ;}                                         // isSame(A,B): A==B
boolean isSame(pt A, pt B, float e) {return ((abs(A.x-B.x)<e)&&(abs(A.y-B.y)<e));}                   // isSame(A,B,e): ||A-B||<e
float d(pt P, pt Q) {return sqrt(d2(P,Q));  };                                                       // d(A,B): ||AB|| (Distance)
float d2(pt P, pt Q) {return sq(Q.x-P.x)+sq(Q.y-P.y); };                                             // d2(A,B): AB*AB (Distance squared)
// measure vectors (dot product,  norm, parallel)
float dot(vec U, vec V) {return U.x*V.x+U.y*V.y; };                                                    // dot(U,V): U*V (dot product U*V)
float n(vec V) {return sqrt(dot(V,V));};                                                               // n(V): ||V|| (norm: length of V)
float n2(vec V) {return sq(V.x)+sq(V.y);};                                                             // n2(V): V*V (norm squared)
boolean parallel (vec U, vec V) {return dot(U,R(V))==0; }; 

// GUI mouse & canvas (left part [height,height] of window, assuming width>=height)
pt Mouse() {return P(mouseX,mouseY);};                                                                 // Mouse(): returns point at current mouse location
pt Pmouse() {return P(pmouseX,pmouseY);};                                                              // Pmouse(): returns point at previous mouse location
vec MouseDrag() {return new vec(mouseX-pmouseX,mouseY-pmouseY);};                                      // MouseDrag(): vector representing recent mouse displacement
pt MouseInWindow() {float x=mouseX, y=mouseY; x=max(x,0); y=max(y,0); x=min(x,height); y=min(y,height);  return P(x,y);}; // mouseInWindow(): nearest square canvas point to mouse 
pt ScreenCenter() {return P(height/2,height/2);}                                                       // mouseInWindow(): point in center of square canvas
boolean mouseIsInWindow() {return(((mouseX>0)&&(mouseX<height)&&(mouseY>0)&&(mouseY<height)));};       // mouseIsInWindow(): if mouse is in square canvas
void drag(pt P) { P.x+=mouseX-pmouseX; P.y+=mouseY-pmouseY; }                                          // drag(P) adjusts P by mouse drag vector

// Scale, rotate, translate points
pt S(float s, pt A) {return new pt(s*A.x,s*A.y); };                                                                      // S(s,A): sA
pt S(float s, pt A, pt B) {return new pt((s+1)*B.x-s*A.x,(s+1)*B.y-s*A.y); };                                            // S(s,A,B): B+sBA=(1+s)B-sA (scaling of A by s wrt fixed point B)
pt R(pt Q, float a) {float dx=Q.x, dy=Q.y, c=cos(a), s=sin(a); return new pt(c*dx+s*dy,-s*dx+c*dy); };                   // R(Q,a): Q rotated by angle a around the origin
pt R(pt Q, float a, pt P) {float dx=Q.x-P.x, dy=Q.y-P.y, c=cos(a), s=sin(a); return P(P.x+c*dx-s*dy, P.y+s*dx+c*dy); };  // R(Q,a,P): Q rotated by angle a around point P
pt T(pt P, vec V) {return P(P.x + V.x, P.y + V.y); }                                                 // T(P,V): P+V (P transalted by vector V)
pt T(pt P, float s, vec V) {return T(P,S(s,V)); }                                                    // T(P,s,V): P+sV (P transalted by sV)
pt T(pt P, float s, pt Q) { return T(P,s,U(V(P,Q))); };                                              // T(P,s,Q): P+sU(PQ) (transalted P by distance s towards Q)
// transform vectors
vec U(vec V) {float n = n(V); if (n==0) return new vec(0,0); else return new vec(V.x/n,V.y/n);};      // U(V): V/||V|| (Unit vector : normalized version of V)
vec U(pt P, pt Q) {return U(V(P,Q));};                                                                // U(P,Q): PQ/||PQ| (Unit vector : from P towards Q)
vec R(vec V) {return new vec(-V.y,V.x);};                                                             // R(V): V turned right 90 degrees (as seen on screen)
vec R(vec U, float a) {vec W = U.makeRotatedBy(a);  return W ; };                                     // R(V,a): V rotated by a radians

//************************************************************************
//**** ANGLES
//************************************************************************
float angle (vec U, vec V) {return atan2(dot(R(U),V),dot(U,V)); };                                   // angle(U,V): angle <U,V> (between -PI and PI)
float angle(vec V) {return(atan2(V.y,V.x)); };                                                       // angle(V): angle between <1,0> and V (between -PI and PI)
float angle(pt A, pt B, pt C) {return  angle(V(B,A),V(B,C)); }                                       // angle(A,B,C): angle <BA,BC>
float turnAngle(pt A, pt B, pt C) {return  angle(V(A,B),V(B,C)); }                                   // turnAngle(A,B,): angle <AB,BC> (positive when right turn as seen on screen)
int toDeg(float a) {return int(a*180/PI);}                                                           // convert radians to degrees
float toRad(float a) {return(a*PI/180);}                                                             // convert degrees to radians 
float positive(float a) { if(a<0) return a+TWO_PI; else return a;}                                   // adds 2PI to make angle positive

//************************************************************************
//**** POINT CLASS
//************************************************************************
class pt { float x=0,y=0; 
  // CREATE
  pt () {}
  pt (float px, float py) {x = px; y = py;};
  pt (pt P) {x = P.x; y = P.y;};
  pt (pt P, vec V) {x = P.x+V.x; y = P.y+V.y;};
  pt (pt P, float s, vec V) {x = P.x+s*V.x; y = P.y+s*V.y;};
  pt (pt A, float s, pt B) {x = A.x+s*(B.x-A.x); y = A.y+s*(B.y-A.y);};

  // MODIFY
  void reset() {x = 0; y = 0;}                                       // P.reset(): P=(0,0)
  void set(float px, float py) {x = px; y = py;}                     // P.set(x,y): P=(x,y)
  void set(pt Q) {x = Q.x; y = Q.y;}                                 // P.set(Q): P=Q (copy)
  void add(float u, float v) {x += u; y += v;}                       // P.add(u,v): P+=<u,v>
  void add(vec V) {x += V.x; y += V.y;}                              // P.add(V): P+=V
  void add(float s, vec V) {x += s*V.x; y += s*V.y;}                 // P.add(s,V): P+=sV
  void add(pt Q) {x += Q.x; y += Q.y;}                               // P.add(Q): P+=Q
  void scale(float s) {x*=s; y*=s;}                                  // P.scale(s): P*=s
  void scale(float s, pt C) {x*=C.x+s*(x-C.x); y*=C.y+s*(y-C.y);}    // P.scale(s,C): P=L(C,s,P);
  void rotate(float a) {float dx=x, dy=y, c=cos(a), s=sin(a); x=c*dx+s*dy; y=-s*dx+c*dy; };     // P.rotate(a): rotate P around origin by angle a in radians
  void rotate(float a, pt P) {float dx=x-P.x, dy=y-P.y, c=cos(a), s=sin(a); x=P.x+c*dx+s*dy; y=P.y-s*dx+c*dy; };   // P.rotate(a,G): rotate P around G by angle a in radians
 
  void setTo(float px, float py) {x = px; y = py;};  
  void setTo(pt P) {x = P.x; y = P.y;}; 
  void setToMouse() { x = mouseX; y = mouseY; }; 
  void moveWithMouse() { x += mouseX-pmouseX; y += mouseY-pmouseY; }; 
  void addVec(vec V) {x += V.x; y += V.y;};   
  void translateBy(vec V) {x += V.x; y += V.y;};   
  void translateBy(float u, float v) {x += u; y += v;};
  void translateBy(float s, vec V) {x += s*V.x; y += s*V.y;};  
  void translateToTrack(float s, pt P) {setTo(T(P,s,V(P,this)));};       // translate by distance s towards P
  void translateTowards(float s, pt P) {x+=s*(P.x-x);  y+=s*(P.y-y); };  // transalte by ratio s towards P
  void translateTowardsBy(float s, pt P) {vec V = this.makeVecTo(P); V.normalize(); this.translateBy(s,V); };
  void track(float s, pt P) {setTo(T(P,s,V(P,this)));};
  void scaleBy(float f) {x*=f; y*=f;};
  void scaleBy(float u, float v) {x*=u; y*=v;};
  void addPt(pt P) {x += P.x; y += P.y;};        // incorrect notation, but useful for computing weighted averages
  void addScaled(float s, vec V) {x += s*V.x; y += s*V.y;};  
  void addScaled(float s, pt P)   {x += s*P.x; y += s*P.y;};   
  void addScaledPt(float s, pt P) {x += s*P.x; y += s*P.y;};        // incorrect notation, but useful for computing weighted averages
  void rotateBy(float a) {float dx=x, dy=y, c=cos(a), s=sin(a); x=c*dx+s*dy; y=-s*dx+c*dy; };     // around origin
  void rotateBy(float a, pt P) {float dx=x-P.x, dy=y-P.y, c=cos(a), s=sin(a); x=P.x+c*dx+s*dy; y=P.y-s*dx+c*dy; };   // around point P
  void rotateBy(float s, float t, pt P) {float dx=x-P.x, dy=y-P.y; dx-=dy*t; dy+=dx*s; dx-=dy*t; x=P.x+dx; y=P.y+dy; };   // s=sin(a); t=tan(a/2);
  void clipToWindow() {x=max(x,0); y=max(y,0); x=min(x,height); y=min(y,height); }
  
  // OUTPUT POINT
  pt clone() {return new pt(x,y); };
  pt make() {return new pt(x,y); };
  pt makeClone() {return new pt(x,y); };
  pt makeTranslatedBy(vec V) {return(new pt(x + V.x, y + V.y));};
  pt makeTranslatedBy(float s, vec V) {return(new pt(x + s*V.x, y + s*V.y));};
  pt makeTransaltedTowards(float s, pt P) {return(new pt(x + s*(P.x-x), y + s*(P.y-y)));};
  pt makeTranslatedBy(float u, float v) {return(new pt(x + u, y + v));};
  pt makeRotatedBy(float a, pt P) {float dx=x-P.x, dy=y-P.y, c=cos(a), s=sin(a); return(new pt(P.x+c*dx+s*dy, P.y-s*dx+c*dy)); };
  pt makeRotatedBy(float a) {float dx=x, dy=y, c=cos(a), s=sin(a); return(new pt(c*dx+s*dy, -s*dx+c*dy)); };
  pt makeProjectionOnLine(pt P, pt Q) {float a=dot(P.makeVecTo(this),P.makeVecTo(Q)), b=dot(P.makeVecTo(Q),P.makeVecTo(Q)); return(P.makeTransaltedTowards(a/b,Q)); };
  pt makeOffset(pt P, pt Q, float r) {
    float a = angle(vecTo(P),vecTo(Q))/2;
    float h = r/tan(a); 
    vec T = vecTo(P); T.normalize(); vec N = T.left();
    pt R = new pt(x,y); R.translateBy(h,T); R.translateBy(r,N);
    return R; };

   // OUTPUT VEC
  vec vecTo(pt P) {return(new vec(P.x-x,P.y-y)); };
  vec makeVecTo(pt P) {return(new vec(P.x-x,P.y-y)); };
  vec makeVecToCenter () {return(new vec(x-height/2.,y-height/2.)); };
  vec makeVecToAverage (pt P, pt Q) {return(new vec((P.x+Q.x)/2.0-x,(P.y+Q.y)/2.0-y)); };
  vec makeVecToAverage (pt P, pt Q, pt R) {return(new vec((P.x+Q.x+R.x)/3.0-x,(P.y+Q.y+R.x)/3.0-y)); };
  vec makeVecToMouse () {return(new vec(mouseX-x,mouseY-y)); };
  vec makeVecToBisectProjection (pt P, pt Q) {float a=this.disTo(P), b=this.disTo(Q);  return(this.makeVecTo(L(P,a/(a+b),Q))); };
  vec makeVecToNormalProjection (pt P, pt Q) {float a=dot(P.makeVecTo(this),P.makeVecTo(Q)), b=dot(P.makeVecTo(Q),P.makeVecTo(Q)); return(this.makeVecTo(L(P,a/b,Q))); };
  vec makeVecTowards(pt P, float d) {vec V = makeVecTo(P); float n = V.norm(); V.normalize(); V.scaleBy(d-n); return V; };
 
  // OUTPUT TEST OR MEASURE
  float disTo(pt P) {return(sqrt(sq(P.x-x)+sq(P.y-y))); };
  float disToMouse() {return(sqrt(sq(x-mouseX)+sq(y-mouseY))); };
  boolean isInWindow() {return(((x>0)&&(x<height)&&(y>0)&&(y<height)));};
  boolean projectsBetween(pt P, pt Q) {float a=dot(P.makeVecTo(this),P.makeVecTo(Q)), b=dot(P.makeVecTo(Q),P.makeVecTo(Q)); return((0<a)&&(a<b)); };
  float ratioOfProjectionBetween(pt P, pt Q) {float a=dot(P.makeVecTo(this),P.makeVecTo(Q)), b=dot(P.makeVecTo(Q),P.makeVecTo(Q)); return(a/b); };
  float disToLine(pt P, pt Q) {float a=dot(P.makeVecTo(this),P.makeVecTo(Q).makeUnit().makeTurnedLeft()); return(abs(a)); };
  boolean isLeftOf(pt P, pt Q) {boolean l=dot(P.makeVecTo(this),P.makeVecTo(Q).makeTurnedLeft())>0; return(l);  };
  boolean isLeftOf(pt P, pt Q, float e) {boolean l=dot(P.makeVecTo(this),P.makeVecTo(Q).makeTurnedLeft())>e; return(l);  };  boolean isInTriangle(pt A, pt B, pt C) { boolean a = this.isLeftOf(B,C); boolean b = this.isLeftOf(C,A); boolean c = this.isLeftOf(A,B); return((a&&b&&c)||(!a&&!b&&!c));};
  boolean isInCircle(pt C, float r) {return d(this,C)<r; }  // returns true if point is in circle C,r
  
  // DRAW , PRINT
  void show() {ellipse(x, y, height/200, height/200); }; // shows point as small dot
  void show(float r) {ellipse(x, y, 2*r, 2*r); }; // shows point as disk of radius r
  void showCross(float r) {line(x-r,y,x+r,y); line(x,y-r,x,y+r);}; 
  void v() {vertex(x,y);};  // used for drawing polygons between beginShape(); and endShape();
  void write() {print("("+x+","+y+")");};  // writes point coordinates in text window
  void showLabel(String s, vec D) {text(s, x+D.x-5,y+D.y+4);  };  // show string displaced by vector D from point
  void showLabel(String s) {text(s, x+5,y+4);  };
  void showLabel(int i) {text(str(i), x+5,y+4);  };  // shows integer number next to point
  void showLabel(String s, float u, float v) {text(s, x+u, y+v);  };
  void showSegmentTo (pt P) {line(x,y,P.x,P.y); }; // draws edge to another point
  void to (pt P) {line(x,y,P.x,P.y); }; // draws edge to another point

  } // end of pt class

//************************************************************************
//**** VECTORS
//************************************************************************
class vec { float x=0,y=0; 
 // CREATE
  vec () {};
  vec (vec V) {x = V.x; y = V.y;};
  vec (float s, vec V) {x = s*V.x; y = s*V.y;};
  vec (float px, float py) {x = px; y = py;};
  vec (pt P, pt Q) {x = Q.x-P.x; y = Q.y-P.y;};
 
 // MODIFY
  void setTo(float px, float py) {x = px; y = py;}; 
  void setTo(pt P, pt Q) {x = Q.x-P.x; y = Q.y-P.y;}; 
  void setTo(vec V) {x = V.x; y = V.y;}; 
  void scaleBy(float f) {x*=f; y*=f;};
  void back() {x=-x; y=-y;};
  void mul(float f) {x*=f; y*=f;};
  void div(float f) {x/=f; y/=f;};
  void scaleBy(float u, float v) {x*=u; y*=v;};
  void normalize() {float n=sqrt(sq(x)+sq(y)); if (n>0.000001) {x/=n; y/=n;};};
  void add(vec V) {x += V.x; y += V.y;};   
  void add(float s, vec V) {x += s*V.x; y += s*V.y;};   
  void addScaled(float s, vec V) {x += s*V.x; y += s*V.y;};  
  void add(float u, float v) {x += u; y += v;};
  void turnLeft() {float w=x; x=-y; y=w;};
  void rotateBy (float a) {float xx=x, yy=y; x=xx*cos(a)-yy*sin(a); y=xx*sin(a)+yy*cos(a); };
  void clip (float m) {float n=norm(); if(n>m) scaleBy(m/n);};

  
  // OUTPUT VEC
  vec make() {return(new vec(x,y));}; 
  vec clone() {return(new vec(x,y));}; 
  vec makeClone() {return(new vec(x,y));}; 
  vec makeUnit() {float n=sqrt(sq(x)+sq(y)); if (n<0.000001) n=1; return(new vec(x/n,y/n));}; 
  vec unit() {float n=sqrt(sq(x)+sq(y)); if (n<0.000001) n=1; return(new vec(x/n,y/n));}; 
  vec makeScaledBy(float s) {return(new vec(x*s, y*s));};
  vec makeTurnedLeft() {return(new vec(-y,x));};
  vec left() {return(new vec(-y,x));};
  vec makeOffsetVec(vec V) {return(new vec(x + V.x, y + V.y));};
  vec makeOffsetVec(float s, vec V) {return(new vec(x + s*V.x, y + s*V.y));};
  vec makeOffsetVec(float u, float v) {return(new vec(x + u, y + v));};
  vec makeRotatedBy(float a) {float c=cos(a), s=sin(a); return(new vec(x*c-y*s,x*s+y*c)); };
  vec makeReflectedVec(vec N) { return makeOffsetVec(-2.*dot(this,N),N);};

  // OUTPUT TEST MEASURE
  float norm() {return(sqrt(sq(x)+sq(y)));}
  boolean isNull() {return((abs(x)+abs(y)<0.000001));}
  float angle() {return(atan2(y,x)); }

  // DRAW, PRINT
  void write() {println("("+x+","+y+")");};
  void show (pt P) {line(P.x,P.y,P.x+x,P.y+y); }; 
  void showAt (pt P) {line(P.x,P.y,P.x+x,P.y+y); }; 
  void showArrowAt (pt P) {line(P.x,P.y,P.x+x,P.y+y); 
      float n=min(this.norm()/10.,height/50.); 
      pt Q=P.makeTranslatedBy(this); 
      vec U = this.makeUnit().makeScaledBy(-n);
      vec W = U.makeTurnedLeft().makeScaledBy(0.3);
      beginShape(); Q.makeTranslatedBy(U).makeTranslatedBy(W).v(); Q.v(); 
                    W.scaleBy(-1); Q.makeTranslatedBy(U).makeTranslatedBy(W).v(); endShape(CLOSE); }; 
  void showLabel(String s, pt P) {pt Q = P.makeTranslatedBy(0.5,this); 
           vec N = makeUnit().makeTurnedLeft(); Q.makeTranslatedBy(3,N).showLabel(s); };
  } // end vec class
 


