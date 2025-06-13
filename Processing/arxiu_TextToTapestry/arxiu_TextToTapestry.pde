//arxiu_TextToTapestry - Oriol Colomer Delgado, 2025
//
//arxiu | Treball Final de Postgrau. Postgrau en Escena i Tecnologia Digital, Institut del Teatre (2024-2025)

String dictionary = "abcdefghijklmnopqrstuvwxyz1234567890.,'- ";


//Parameters------------
String fileName = "text.txt";
int tileSize = 6;
boolean drawText = true;
boolean sortText = false;

//----------------------

String[] file;
String text = "";

void setup() {
  size(1000, 1000);
  colorMode(HSB, 100.0, 100.0, 100.0);
  background(0);
  println("dictionary length: " + dictionary.length());

  file = loadStrings(fileName);
  text = join(file, "");
  
  if(sortText){
  SortText();
  }
  
  
  calcTileSize();
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
        char c = text.charAt(index);
        noStroke();
        fill(getColorAtValue(c));
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

void SortText(){
  String newText = "";
  char[] charList = text.toCharArray();
  newText = new String(sort(charList));
  
  text = newText;
}

void calcTileSize(){
  //tileSize = int(width*height/text.length() * 0.1f);
}
