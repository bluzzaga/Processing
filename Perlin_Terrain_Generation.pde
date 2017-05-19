int cols, rows;
int scl = 20;
int w = 3000;        // width of world
int h = 1500;        // height of world
int z = -10;         // height of water
float incr = 0.15;
float flying = 0;
float [][] terrain;
float [][] clouds;

void setup() {
  size(1280, 720, P3D);
  cols = w / scl;
  rows = h / scl;
  terrain = new float[cols][rows];
  clouds = new float [cols][rows];
}

void draw() {
  flying -= 0.1;      // 'Moves' the terrain towards the screen
  float yoff = flying;
  
  for (int y = 0; y < rows; y++) {
    float xoff = 0;
    for (int x = 0; x < cols; x++) {
      terrain[x][y] = map(noise(xoff, yoff), 0, 1, -100, 100);  // z-coordinate of terrain
      clouds[x][y] = map(noise(xoff, yoff), 0, 1, 70, 130);     // alpha of clouds
      xoff += incr;
    }
    yoff += incr;
  }
  
  background(0, 255, 180);
  translate(width/2, height/2);  // Centers forthcoming rotation about x-axis
  rotateX(PI/3);
  translate(-w/2, -h/2);
  
  // Create terrain
  for (int y = 0; y < rows-1; y++) {
    beginShape(TRIANGLE_STRIP);
    for (int x = 0; x < cols; x++) {
      stroke(0+(y*2), 0, 20);  // Gets brighter as terrain moves towards screen
      fill(80+(y*2), 0, 50);   // Also gets brighter
      vertex(x*scl, y*scl, terrain[x][y]);
      vertex(x*scl, (y+1)*scl, terrain[x][y+1]);
    }
    endShape();
  }
    
    // Create clouds
    for (int y = 6; y < rows-1; y++) {
      beginShape(QUAD_STRIP);
      for (int x = 0; x < cols; x++) {
        fill(0, 150+(y*2), 255, clouds[x][y]);
        noStroke();
        vertex(x*scl, y*scl, z);
        vertex(x*scl, (y+1)*scl, z);
        vertex((x+1)*scl, y*scl, z);
        vertex((x+1)*scl, (y+1)*scl, z);
      }
    endShape();
  }
}
