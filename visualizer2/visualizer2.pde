
float curColorR = 0.0f;
float curColorG = 0.0f;
float curColorB = 0.0f;

float ratio = 1.61803398875f;
float offset = 0.01;
float rotAngle = 360 / ratio; // 10; // 360 * ratio;

float initialDistanceX = .1;
float initialDistanceY = 0;
float distance = 2;

Point centerPoint;
Point goldenPals[];

int pointCount = 900;

// color[] lineColors = new color[16];

void setup() {

  // size(900, 900);
  fullScreen(P3D);
  background(255);

  centerPoint = new Point(width / 2, height / 2);
  goldenPals = new Point[pointCount];

}

void draw() {

  background(255);

  curColorR = cos(millis() * colorRateR) * 255;
  curColorG = cos(millis() * colorRateG) * 255;
  curColorB = cos(millis() * colorRateB) * 255;

  float xness = (float) mouseX / (float) width;
  float yness = (float) mouseY / (float) height;
  // rotAngle = ((360 / ratio) * 2) * xness;
  // distance = 10 * yness;
  // println(xness, yness, mouseX, mouseY);

  // ratio += 0.0000001f;
  distance = 20 * yness;
  ratio += 0.000005f * xness;
  rotAngle = 360 / ratio; // ratio =

  initPoints();
  drawAllPoints();

}

void drawAllPoints() {

  // drawCenterPoint( centerPoint );

  drawPoint( goldenPals[0] );

  for (int i = 1; i < pointCount; i++) {
    drawLineSegment( goldenPals[i - 1 ], goldenPals[i] );
    // drawLineSegment( goldenPals[i], centerPoint );
    // drawPoint( goldenPals[i] );
    // drawEllipse( goldenPals[i] );
  }

}

void initPoints() {

  goldenPals[0] = centerPoint.clone();
  goldenPals[0].x += initialDistanceX;
  goldenPals[0].y += initialDistanceY;

  for (int i = 1; i < pointCount; i++) {

    goldenPals[i] = goldenPals[i - 1].clone();

    // Move away from center a lil more
    goldenPals[i].translateFrom( centerPoint, distance );

    // Rotate around center
    goldenPals[i].rotateAround( centerPoint, rotAngle );

  }

}

void drawEllipse( Point p ) {

  fill(curColorR, curColorG, curColorB, 50);
  stroke(curColorR, curColorG, curColorB);
  ellipse(p.x, p.y, 20, 20);

}

void drawPoint( Point p ) {
  fill(255,0,0);
  // noStroke();
  stroke(255,0,0);
  ellipse(p.x, p.y, 3, 3);
}

void drawCenterPoint( Point p ) {
  fill(255,0,0);
  /// noStroke();
  ellipse(p.x, p.y, 6, 6);
}

float colorRateR = 0.0001;
float colorRateG = 0.0002;
float colorRateB = 0.0003;


void drawLineSegment( Point startPoint, Point endPoint ) {

  curColorR = (curColorR + 0.1) % 255;
  curColorG = (curColorG + 0.2) % 255;
  curColorB = (curColorB + 0.3) % 255;


  fill(0);
  strokeWeight(2);
  stroke(curColorR, curColorG, curColorB);
  line(startPoint.x, startPoint.y, endPoint.x, endPoint.y);
}

/**
 * Define a point in space, and do various operations relative to other points
 */
class Point {

  // where we were like a sec ago
  float lastX = 0;
  float lastY = 0;

  // where are we now
  float x = 0;
  float y = 0;

  Point(float x, float y) {
    this.x = x;
    this.y = y;
    this.moveTo(x,y);
  }

  Point clone() {
    return new Point(this.x, this.y);
  }

  void moveTo(float x, float y) {
    this.lastX = this.x;
    this.lastY = this.y;
    this.x = x;
    this.y = y;
  }

  void rotateAround(Point rotationPoint, float rotateDegrees) {

    double newX;
    double newY;

    newX = rotationPoint.x + (this.x - rotationPoint.x) * Math.cos(rotateDegrees) - (this.y - rotationPoint.y) * Math.sin(rotateDegrees);
    newY = rotationPoint.y + (this.x - rotationPoint.x) * Math.sin(rotateDegrees) + (this.y - rotationPoint.y) * Math.cos(rotateDegrees);

    this.moveTo((float) newX, (float) newY);

  }

  /**
   * Move translateDistance on a ray through our current point, wich originates at originPoint
   */
  void translateFrom(Point originPoint, float translateDistance) {

    /*
    float startDistance = this.distanceTo( originPoint );
    float newX = this.x;
    float newY = this.y;


      // Find slope
      float yDiff = this.y - originPoint.y;
      float xDiff = this.x - originPoint.x;

      // Slope is 0 -- move right or left
      if (yDiff == 0) {
        // if (xDiff < 0)
        //   translateDisance *= -1;
        newX = this.x + translateDistance;
        newY = this.y;
      }

      // Slope is 'infinte' - move up or down
      else if (xDiff == 0) {
        // if (yDiff < 0)
        //   translateDisance *= -1; // something like this
        newX = this.x;
        newY = this.y + translateDistance;
      }

      else {
        float slope = yDiff / xDiff;
        float dx = (translateDistance / sqrt(1 + (pow(slope,2))));
        float dy = slope * dx;
        newX = this.x + dx;
        newY = this.y + dy;
      }

      this.moveTo(newX,newY);


    } */
    // fuck this bullshit ^

    float angle = atan2(this.y - originPoint.y, this.x - originPoint.x);
    float xMove = translateDistance * cos(angle);
    float yMove = translateDistance * sin(angle);
    // fuck this shit too ^

    this.moveTo(this.x + xMove, this.y + yMove);
  }

  float distanceTo(Point targetPoint) {
    return sqrt( pow( targetPoint.x - this.x, 2.0f ) + pow( targetPoint.y - this.y, 2.0f ) );
  }

}
