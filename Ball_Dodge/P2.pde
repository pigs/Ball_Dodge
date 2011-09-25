pt A, B, C, X, L, R; // points edted by user and also left and right corners of screen
color red=#FF0000, magenta=#FF79FD, blue=#79BBFF, green=#79FF7A, orange=#FFBC79, black= #000000;// colors
int pctr=0; // counts pictures taken
int points=0; // tracks how many time your face was slapped by a flying ball
PImage pic; // picture of author's face that is displayed in the help pane, read from file pic.jpg in data folder

Spring[] springs = new Spring[1]; 

void setup()
{
  size(600,600);

  PFont font = loadFont("AppleCasual-36.vlw"); 
  textFont(font, 36);      // load font for writing on the canvas
  pic = loadImage("data/pic.jpg");                                  // load image names pic from file pic.jpg in folder data
  C=P(pic.width/2,pic.height/2); 
  B=P(pic.width/2,pic.height*0.9); 
  A=P(width/2,height/2);  // set up initial values for all 3 points 
  X=A; // picked point is A
  L=P(0,height); 
  R=P(width,height); // left and right corner starting positions for balls
  makeBalls(); // declares all balls
  frameRate(30); // slows down to 30 frames per second when possible

  noStroke(); 
  smooth();
  springs[0] = new Spring(300, 300, 50, 0.95, 40, 0.1, springs, 0, false);
}

void draw() 
{  
  background(pic); 
  springs[0].update(); 
  springs[0].display();  


  moveBalls();  // updates the position and velocity of balls
  processCollisions();  // detects collisions, processes them, and keeps track of ho wmany times the player's face was hit: make it react to the hit
  noFill(); 
  noStroke();
  showBalls(); 
  fill(red); 
  text(Format0(points,3)+" hits",20,40); // prints game status: change this as desired
  String name="Hannah Yu";  
  fill(0);
  text(name, 420, 40);
  String dog_name="(and Rylai)";  
  fill(0);
  text(dog_name, 420, 80);
}

void keyPressed() {
  if (key=='x')  saveFrame("data/images/p"+Format0(pctr++,4)+".tif");
}  // saves current screen as image (use for your report/web page)

class Spring 
{ 
  // Screen values 
  float xpos, ypos;
  float tempxpos, tempypos; 
  int size = 20; 
  boolean move = false; 
  boolean collide = false;

  // Spring simulation constants 
  float mass;       // Mass 
  float k = 0.2;    // Spring constant 
  float damp;       // Damping 
  float rest_posx;  // Rest position X 
  float rest_posy;  // Rest position Y 

  // Spring simulation variables 
  //float pos = 20.0; // Position 
  float velx = 0.0;   // X Velocity 
  float vely = 0.0;   // Y Velocity 
  float accel = 0;    // Acceleration 
  float force = 0;    // Force 

  Spring[] friends;
  int me;

  // Constructor
  Spring(float x, float y, int s, float d, float m, 
  float k_in, Spring[] others, int id, boolean collz) 
  { 
    xpos = tempxpos = x; 
    ypos = tempypos = y;
    rest_posx = mouseX;
    rest_posy = mouseY;
    size = s;
    damp = d; 
    mass = m; 
    k = k_in;
    friends = others;
    me = id;
    collide = collz;
  } 

  void update() 
  { 
    rest_posy = mouseY; 
    rest_posx = mouseX;


    force = -k * (tempypos - rest_posy);  // f=-ky 
    accel = force / mass;                 // Set the acceleration, f=ma == a=f/m 
    vely = damp * (vely + accel);         // Set the velocity 
    tempypos = tempypos + vely;           // Updated position 

    force = -k * (tempxpos - rest_posx);  // f=-ky 
    accel = force / mass;                 // Set the acceleration, f=ma == a=f/m 
    velx = damp * (velx + accel);         // Set the velocity 
    tempxpos = tempxpos + velx;           // Updated position
  } 

  void display() 
  { 
    fill(green); 
    ellipse(tempxpos, tempypos, size, size);
  }
} 


String  Format0(int v, int n) {
  String s=str(v); 
  String spaces = "00000000000000000000000000"; 
  int L = max(0,n-s.length()); 
  String front = spaces.substring(0, L); 
  return(front+s);
}; // fixed format scripting

