String dictionary = "abcdefghijklmnopqrstuvwxyz1234567890.,'- ";
String[] file;
String text = "";

int tileSize = 50;
boolean drawText = true;

void setup() {
  size(900, 900);
  colorMode(HSB, 100.0, 100.0, 100.0);
  background(0);
  println("dictionary length: " + dictionary.length());

  file = loadStrings("text.txt");
  text = join(file, "");
  drawTapestryRect();
  if(drawText){
   drawText(); 
  }

  delay(100);
  saveFrame("media/"+day()+"-"+month()+"-"+year()+"_"+hour()+"-"+minute()+"-"+second()+".png");
}

void draw() {
}

void drawTapestryPixel() {
  loadPixels();
  for (int i = 0; i < (width*height/2)-width/2 && i < text.length(); i++) {
    pixels[i] = getColorAtValue(text.charAt(i));
  }
  updatePixels();
}

void drawTapestryRect() {
  int index = 0;

  for (int y = 0; y < width/tileSize; y++) {
    for (int x = 0; x < width/tileSize; x++) {
      if (index < text.length()) {
        noStroke();
        fill(getColorAtValue(text.charAt(index)));
        rect(x*tileSize, y*tileSize, tileSize, tileSize);
        
        index ++;
      }
    }
  }
}

void drawText() {
  int index = 0;

  for (int y = 0; y < width/tileSize; y++) {
    for (int x = 0; x < width/tileSize; x++) {
      if (index < text.length()) {

        fill(0);
        textSize(tileSize);
        text(text.charAt(index), x*tileSize, y*tileSize+tileSize);

        index ++;
      }
    }
  }
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
