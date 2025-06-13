String text = "";
String textAscii;
int tiles = 8;
int scale;
int[] map;

void setup() {
  //text = textA;
  size(1000, 1000);
  background(0);
  scale = int(width/tiles);
  map = new int[tiles*tiles];
  setMap();
  render();
}

void draw() {
  background(0);
  delay(50);

  render();
}

void mousePressed() {
  int x = mouseX/scale;
  int y = mouseY/scale;
  map[tiles * y + x] = 1 - map[tiles * y + x];
}

void keyPressed() {
  if (key == 'p' || key == 'P') {
    saveFrame("media/"+day()+"-"+month()+"-"+year()+"_"+hour()+"-"+minute()+"-"+second()+".png");
  }
  if (key == 'i' || key == 'I') {
    interpret();
  }
}

void render() {

  for (int y = 0; y < tiles; y++)
  {
    for (int x = 0; x < tiles; x++)
    {
      drawShape(x, y);
    }
  }
}

void setMap() {

  for (int i = 0; i < tiles*tiles; i++)
  {
    int val = 0;
    map[i] = val;
  }
}

void drawShape(int x, int y) {

  stroke(255);
  fill(map[tiles * y + x]*255);
  rect(scale*x, scale*y, scale, scale);
}

void interpret() {
  for (int y = 0; y < tiles; y++) {
    String s = "";
    for (int x = 0; x < tiles; x++) {
      s += str(map[tiles * y + x]);
    }
    text += char(unbinary(s));
  }
  fill(255,0,0);
  textSize(15);
  text(text,0,0);
  println(text);
}
