import fisica.*;
import ddf.minim.*;

Minim minim;
AudioPlayer bounce;

//modes
final int INTRO = 1;
final int PLAYING = 2;
final int PAUSE = 3;
final int GAMEOVER = 4;
int mode = INTRO;

//pallete
color blue   = color(29, 178, 242);
color black  = #000000;
color white  = #FFFFFF;
color darkblue = #3B8686;
color lightaqua = #9DE0AD;
color aqua = #79BD9A;

//fisica
FWorld world;

float dx, dy;
float dx2, dy2;
FBox p1;
FBox p2;
FCircle myball;

boolean w, a, s, d, upkey, leftkey, rightkey, downkey;

int score1, score2;

void setup() {
  //make window
  size(600, 600, FX2D);

  minim = new Minim(this);
  bounce = minim.loadFile("bounce.mp3");

  //init world
  Fisica.init(this);
  world = new FWorld();
  world.setGravity(0, 0);

  //set paddles
  setPaddle1();
  setPaddle2();

  //set ball
  setMyBall();

  //set walls
  makeTopBorder();
  makeBottomBorder();
  makeLeftTopBorder();
  makeLeftBottomBorder();
  makeRightTopBorder();
  makeRightBottomBorder();
}


//=====================================================================================================================================

void draw() {
  //println("x: " + mouseX + " y: " + mouseY);
  println(mode);
  background(lightaqua);
  
  //stop moving paddles
  if (w == false) dy = 0;
  if (a == false) dx = 0;
  if (s == false) dy = 0;
  if (d == false) dx = 0;
  if (upkey == false) dy2 = 0;
  if (leftkey == false) dx2 = 0;
  if (downkey == false) dy2 = 0;
  if (rightkey == false) dx2 = 0;

  //move paddles
  if (w == true) dy -= 200;
  if (a == true) dx -= 200;
  if (s == true) dy += 200;
  if (d == true) dx += 200;
  if (upkey == true) dy2 -= 200;
  if (leftkey == true) dx2 -= 200;
  if (downkey == true) dy2 += 200;
  if (rightkey == true) dx2 += 200;
  p1.setVelocity(dx, dy);
  p2.setVelocity(dx2, dy2);

  //contacting array
  ArrayList<FContact> contacts;
  contacts = myball.getContacts();
  for (FContact c : contacts) {
    if (c.contains("paddle1") || c.contains("paddle2") || c.contains("wall")) {
      bounce.play();
      bounce.rewind();
    }
  }


  //mode framework
  if (mode == INTRO) {
    drawIntro();
  } else if (mode == PLAYING) {
    world.step();
    world.draw();
    drawPlaying();
  } else if (mode == PAUSE) {
    world.draw();
    drawPlaying();
    drawPause();
  } else if (mode == GAMEOVER) {
    world.draw();
    drawPlaying();
    drawGameover();
  }
}

//=====================================================================================================================================

void setPaddle1() {
  p1 = new FBox(20, 80);
  p1.setPosition(100, height/2);
  p1.setFillColor(aqua);
  p1.setStrokeColor(aqua);
  p1.setRotatable(false);
  p1.setName("paddle1");
  world.add(p1);
}

//=====================================================================================================================================

void setPaddle2() {
  p2 = new FBox(20, 80);
  p2.setPosition(width - 100, height/2);
  p2.setFillColor(aqua);
  p2.setStrokeColor(aqua);
  p2.setRotatable(false);
  p2.setName("paddle2");
  world.add(p2);
}

//=====================================================================================================================================

void setMyBall() {
  myball = new FCircle(25);
  myball.setPosition(287.5, 287.5);
  myball.setFillColor(blue);
  myball.setStrokeColor(blue);
  myball.setDensity(0.001);
  myball.setFriction(0.001);
  myball.setRestitution(0.99);
  myball.setGrabbable(false);
  myball.setName("myBall");
  world.add(myball);
}

//=====================================================================================================================================

void makeTopBorder() {
  FBox p = new FBox(width, 25);
  p.setPosition(width/2, 12.5);
  p.setStatic(true);
  p.setFillColor(darkblue);
  p.setStrokeColor(darkblue);
  p.setFriction(0.1);
  p.setGrabbable(false);
  p.setName("wall");
  world.add(p);
}

//=====================================================================================================================================

void makeBottomBorder() {
  FBox p = new FBox(width, 25);
  p.setPosition(width/2, height - 12.5);
  p.setStatic(true);
  p.setFillColor(darkblue);
  p.setStrokeColor(darkblue);
  p.setFriction(0);
  p.setGrabbable(false);
  p.setName("wall");
  world.add(p);
} 

//=====================================================================================================================================

void makeLeftTopBorder() {
  FBox p = new FBox(25, 225);
  p.setPosition(12.5, 112.5);
  p.setStatic(true);
  p.setFillColor(darkblue);
  p.setStrokeColor(darkblue);
  p.setFriction(0.1);
  p.setGrabbable(false);
  p.setName("wall");
  world.add(p);
}
//=====================================================================================================================================

void makeLeftBottomBorder() {
  FBox p = new FBox(25, 225);
  p.setPosition(12.5, height - 112.5);
  p.setStatic(true);
  p.setFillColor(darkblue);
  p.setStrokeColor(darkblue);
  p.setFriction(0.1);
  p.setGrabbable(false);
  p.setName("wall");
  world.add(p);
}
//=====================================================================================================================================

void makeRightTopBorder() {
  FBox p = new FBox(25, 225);
  p.setPosition(width - 12.5, 112.5);
  p.setStatic(true);
  p.setFillColor(darkblue);
  p.setStrokeColor(darkblue);
  p.setFriction(0.1);
  p.setGrabbable(false);
  p.setName("wall");
  world.add(p);
}
//=====================================================================================================================================

void makeRightBottomBorder() {
  FBox p = new FBox(25, 225);
  p.setPosition(width - 12.5, height - 112.5);
  p.setStatic(true);
  p.setFillColor(darkblue);
  p.setStrokeColor(darkblue);
  p.setFriction(0.1);
  p.setGrabbable(false);
  p.setName("wall");
  world.add(p);
}

//===================================================================================================================================

void keyPressed() {
  if (key == 'w' || key == 'W') w = true;
  if (key == 'a' || key == 'A') a = true;
  if (key == 's' || key == 'S') s = true;
  if (key == 'd' || key == 'D') d = true;
  if (keyCode == UP) upkey = true;
  if (keyCode == LEFT) leftkey = true;
  if (keyCode == DOWN) downkey = true;
  if (keyCode == RIGHT) rightkey = true;
}


void keyReleased() {
  if (key == 'w' || key == 'W') w = false;
  if (key == 'a' || key == 'A') a = false;
  if (key == 's' || key == 'S') s = false;
  if (key == 'd' || key == 'D') d = false;
  if (keyCode == UP) upkey = false;
  if (keyCode == LEFT) leftkey = false;
  if (keyCode == DOWN) downkey = false;
  if (keyCode == RIGHT) rightkey = false;
}

void mouseReleased() {
  if (mode == INTRO) {
    if (dist(mouseX, mouseY, width/2, height/2) < 50) mode = PLAYING;
  }
  if (mode == PLAYING) {
    if (mouseX >= 580 && mouseX <= 594 && mouseY >= 4 && mouseY <= 24) mode = PAUSE;
  }
  if (mode == PAUSE && mouseX >= 261 && mouseX <= 327 && mouseY >= 327 && mouseY <= 351) mode = PLAYING;
  if (mode == PAUSE && mouseX >= 251 && mouseX <= 336 && mouseY >= 367 && mouseY <= 391) mode = INTRO;
  if (mode == GAMEOVER && mouseX >= 240 && mouseX <= 349 && mouseY >= 365 && mouseY <= 415) mode = INTRO;
}