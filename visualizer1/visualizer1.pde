double lastTimeMS = 0;
double addDiffMS  = 100;
int currentObject = 0;

int arrowCount = 2000;
Arrow[] arrows;

float friction = 0.9;
float gravity = 0.1;

void setup() {

  // size(640,480,P3D);
  fullScreen(P3D);
  frameRate(60);
  
  arrows = new Arrow[arrowCount];
  
  for(int i = 0; i < arrowCount; i++) {
    arrows[i] = new Arrow();
  }

  lastTimeMS = millis();

}

void draw() {

  fill(color(0,255,255,10));
  noStroke();
  rect(0,0,width,height);
  
  for(int i = 0; i < arrowCount; i++) {
    if (arrows[i].isActive()) {
      arrows[i].update();
      arrows[i].draw();
    }
  }

  if (currentObject < arrowCount && millis() - lastTimeMS > addDiffMS) {
    arrows[currentObject].active = true;
    currentObject++;
    lastTimeMS = millis();
  }

}

class Arrow {

  boolean active = false;
  
  int size = 10;
  
  float x = 0;
  float y = 0;
  float velX = 0;
  float velY = 0;

  Arrow() {
    init();
  }
  
  //void accelerate(float x, float y, float z) {
  //}

  void init() {
    size = (int) random(10,40);
    velX = 0;
    velY = 0;
    x = random(0, width);
    y = -100;
  }

  void update() {
    x += velX;
    y += velY;

    velX *= friction;
    velY += gravity;

    if (x > width || y > height)
      active = false;

  }

  void draw() {
    fill(0);
    ellipseMode(CENTER);
    ellipse(x,y,size,size);
  }

  boolean isActive() {
    return active;
  }

}
