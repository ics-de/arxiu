String text = "graner";
String textA = "L’arxiu és la voluntat i sovint la necessitat de mantenir constància de l’existència d’una informació puntual.";
String textB = "Sorgeix d’un desig intrínsec humà de preservar coneixements i deixar constància o evidència del passat col·lec";
String textAscii;
int tiles = 8;
int scale;
int[] map;

boolean trimBinary = true;
int style = 0;

void setup() {
  //text = textA;
  size(1000, 1000);
  background(0);
  calculateTiles();
  scale = int(width/tiles);
  map = new int[tiles*tiles];
  setMap();
  render();

  delay(100);
  saveFrame("media/"+day()+"-"+month()+"-"+year()+"_"+hour()+"-"+minute()+"-"+second()+".png");
}

void draw() {
  background(0);
  delay(50);

  //style = int(random(0,4));
  setMap();
  render();
}

void render() {

  for (int y = 0; y < tiles; y++)
  {
    for (int x = 0; x < tiles; x++)
    {

      //style = int(random(0, 4));
      drawShape(x, y);
    }
  }
}


void setMap() {

  textAscii = "";

  for (int l = 0; l < text.length(); l++) {

    if (trimBinary) {
      textAscii += binary(text.charAt(l)).substring(8);
    } else {
      textAscii += binary(text.charAt(l));
    }
  }


  for (int i = 0; i < tiles*tiles; i++)
  {
    int val = 0;
    if (i < text.length()*8) {
      val = int(textAscii.charAt(i))-48;
      //println(i + " " + val);
    }
    map[i] = val;
  }
}

void calculateTiles() {
  //tiles = text.length();
}

void drawShape(int x, int y) {
  switch(style) {
  case 0:
    noStroke();
    fill(map[tiles * y + x]*255);
    rect(scale*x, scale*y, scale, scale);
    break;

  case 1:
    stroke(map[tiles * y + x]*255);
    fill(0, 0);
    rect(scale*x, scale*y, scale, scale);
    break;

  case 2:
    stroke(255);
    fill(map[tiles * y + x]*255);
    ellipse(scale*x+(scale/2), scale*y+(scale/2), scale, scale);
    break;

  case 3:
    stroke(255);
    line(scale*x, scale*y, scale*x+(scale*map[tiles * y + x]), scale*y+(scale*map[tiles * y + x]));
    break;
  }
}
