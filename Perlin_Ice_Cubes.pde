// Code for: https://youtu.be/QFLs5vgLoQM

int cols, rows;
int scale = 50;
int w = 3000;
int h = 1500;
float incr = 0.15;
float flying = 0;
int range = 600;
float[][] altitude;

void setup() {
  size(1280, 720, P3D);
  cols = w / scale;
  rows = h / scale;
  altitude = new float[cols][rows];
  colorMode(HSB);
}

void draw() {
  flying -= 0.02;
  float xoff = flying;
  
  for (int y = 0; y < rows; y++) {
    for (int x = 0; x < cols; x++) {
      altitude[x][y] = map(noise(xoff), 0, 1, -range, range);
      xoff += incr;
    }
  }
  
  background(0);
  translate(width/2, height/2);
  rotateX(PI);
  translate(-w/2, -h/2);
  
  for (int y = 0; y < rows-1; y++) {
    for (int x = 0; x < cols; x++) {
      stroke(map(altitude[x][y], -range, range, 100, 255) - 5, 255, 255);
      fill(map(altitude[x][y], -range, range, 100, 255), 255, 255);
      box(scale, scale, altitude[x][y]);
      translate(scale, 0, 0);
    }
    translate(-w, scale, 0);
  }
}
