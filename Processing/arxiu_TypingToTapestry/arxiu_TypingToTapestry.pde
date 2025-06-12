//arxiu_TextToTapestry - Oriol Colomer Delgado, 2025
//
//arxiu | Treball Final de Postgrau. Postgrau en Escena i Tecnologia Digital, Institut del Teatre (2024-2025)

String dictionary = "abcdefghijklmnopqrstuvwxyz1234567890.,'- ";


//Parameters------------
int tileSize = 25;
boolean drawText = true;

//----------------------

String[] file;
String text = "";

int x = 0;
int y = 0;

void setup() {
  size(1500, 1500);
  colorMode(HSB, 100.0, 100.0, 100.0);
  background(0);
  println("dictionary length: " + dictionary.length());
}

void draw() {
}

void keyPressed() {
  drawTapestryRect(key);
}

void drawTapestryRect(char c) {
  int index = 0;

  noStroke();
  fill(getColorAtValue(c));
  rect(x*tileSize, y*tileSize, tileSize, tileSize);

  if (drawText) {
    fill(0);
    textSize(tileSize);
    text(c, x*tileSize, y*tileSize+tileSize);
  }

  index ++;
  if (x < width/tileSize - 1) {
    x++;
  } else {
    x = 0;
    y++;
  }
}

void mousePressed(){
  saveFrame("media/"+day()+"-"+month()+"-"+year()+"_"+hour()+"-"+minute()+"-"+second()+".png");
}

color getColorAtValue(char val) {
  int index = 0;
  for (int i = 0; i < dictionary.length(); i++) {
    if (dictionary.charAt(i) == val) {
      index = i;
    }
  }
  color col;
  float hue = 0;
  if (index > 0) {
    hue = (index * 100)/ dictionary.length();
  }

  //println("hue at " + val + " | " + dictionary.charAt(index) + ", " + val + " = " + hue);
  col = color(hue, 100.0, 100.0);

  return col;
}
