
float ratio = 1.61803398875;
float offset = 0.01;
float rotAngle = 360 / 20; // 360 * ratio;

float initialDistanceX = 0;
float initialDistanceY = 10;
float distance = 10;

Point centerPoint;
Point goldenPals[];

int pointCount = 100;

void setup() {

  size(900, 900);
  background(255);

  centerPoint = new Point(width / 2, height / 2);
  goldenPals = new Point[pointCount];

  goldenPals[0] = centerPoint.clone();
  goldenPals[0].x += initialDistanceX;
  goldenPals[0].y += initialDistanceY;

  for (int i = 1; i < pointCount; i++) {

    // Copy previous point
    // if (goldenPals[i] == null && i > 0) {
    //   goldenPals[i - 1].clone();
    // }

    goldenPals[i] = goldenPals[i - 1].clone();

    // Move away from center a lil more
    goldenPals[i].translateFrom( centerPoint, distance );

    // Rotate around center
    goldenPals[i].rotateAround( centerPoint, rotAngle );


  }

  drawCenterPoint( centerPoint );

  drawPoint( goldenPals[0] );

  for (int i = 1; i < pointCount; i++) {
    drawLineSegment( goldenPals[i - 1 ], goldenPals[i] );
    drawPoint( goldenPals[i] );
  }

}

void draw() {


}

void drawPoint( Point p ) {
  fill(0);
  ellipse(p.x, p.y, 3, 3);
}

void drawCenterPoint( Point p ) {
  fill(255,0,0);
  ellipse(p.x, p.y, 6, 6);
}

void drawLineSegment( Point startPoint, Point endPoint ) {
  fill(0);
  strokeWeight(1);
  line(startPoint.x, startPoint.y, endPoint.x, endPoint.y);
}

// float distance(Point point0, Point point1) {
//   return sqrt( pow( point0.x - point1.x, 2.0f ) + pow( point0.y - point1.y, 2.0f ) );
// }

// // on a line defined by point 1, moving towards point 2, find a point a certain distance past point 2
// // Point translatePoint(Point point0, Point point1, float distance) {
// // }
//
// Point rotatePoint(Point targetPoint, Point rotationPoint, float rotateDegrees) {
//
//   double newX;
//   double newY;
//
//   newX = rotationPoint.x + (targetPoint.x - rotationPoint.x) * Math.cos(rotateDegrees) - (targetPoint.y - rotationPoint.y) * Math.sin(rotateDegrees);
//   newY = rotationPoint.y + (targetPoint.x - rotationPoint.x) * Math.sin(rotateDegrees) + (targetPoint.y - rotationPoint.y) * Math.cos(rotateDegrees);
//
//   return new Point((float) newX, (float) newY);
//
// }

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

    // println( "rotate" , this.x, this.y, newX, newY );
    println( this.distanceTo(centerPoint) );

    this.moveTo((float) newX, (float) newY);

  }

  /**
   * Move translateDistance on a ray through our current point, wich originates at originPoint
   */
  void translateFrom(Point originPoint, float translateDisance) {

    float newX;
    float newY;

    // Find slope
    float yDiff = this.y - originPoint.y;
    float xDiff = this.x - originPoint.x;

    // Slope is 0 -- move right or left
    if (yDiff == 0) {
      // if (xDiff < 0)
      //   translateDisance *= -1;
      newX = this.x + translateDisance;
      newY = this.y;
    }

    // Slope is 'infinte' - move up or down
    else if (xDiff == 0) {
      // if (yDiff < 0)
      //   translateDisance *= -1; // something like this
      newX = this.x;
      newY = this.y + translateDisance;
    }

    else {
      float slope = yDiff / xDiff;
      float dx = (translateDisance / sqrt(1 + (slope * slope)));
      float dy = slope * dx;
      newX = this.x + dx;
      newY = this.y + dy;
    }

    // float newX = this.x;
    // float newY = this.y;

    // float totalDistance = this.distanceTo(originPoint) + translateDistance;
    //
    // // Assume:
    // float dx = originPoint.x − this.x;
    // float dy = originPoint.y − this.y;
    // // Assume:
    // // dx=x2−x1
    // // dy=y2−y1
    //
    // // Then,
    // // x3=x1+dx∗k
    // // y3=y1+dy∗k
    // // The square of distance between p1 and p3 is:
    // x3=x1+dx∗k
    // y3=y1+dy∗k
    //
    // // ummmm
    // (dx ^ 2 + dy ^ 2) ∗ k ^ 2 = pow(totalDistance, 2);
    //

    //. println( "translate" , this.x, this.y, newX, newY );
    println( this.distanceTo(centerPoint) );

    this.moveTo(newX,newY);



  }

  float distanceTo(Point targetPoint) {
    return sqrt( pow( targetPoint.x - this.x, 2.0f ) + pow( targetPoint.y - this.y, 2.0f ) );
  }

}
