import processing.sound.*;

PImage img;

SinOsc[] sine;
Waveform[] waveform;

int waves = 1;

// Define how many samples of the Waveform you want to be able to read at once
int samples = 100;

int[] analysisHeights;

void setup() {

  size(1920, 1080);
  //size(1080,1068);
  
  img = loadImage("data/img3.png");
  //img = loadImage("data/img2.jpg");
  background(0);

  analysisHeights = new int[waves];

  // create and start the sine oscillator.
  sine = new SinOsc[waves];
  for (int w = 0; w < waves; w++) {
    sine[w] = new SinOsc(this);
    sine[w].play();
  }
  // Create the Waveform analyzer and connect the playing soundfile to it.
  waveform = new Waveform[waves];
  for (int w = 0; w < waves; w++) {
    waveform[w] = new Waveform(this, samples);
    waveform[w].input(sine[w]);

    analysisHeights[w] = int(random(0, height));
  }
}

void draw() {
  //background(0);
  image(img, 0, 0, width, height);
  loadPixels();
  analyze(frameCount % width);
  delay(1);
}

void analyze(int column) {
  fill(255, 125);
  noStroke();
  rect(column, 0, 2, height);
  
  for (int w = 0; w < waves; w++) {
    
  rect(0, analysisHeights[w], width, 2);
  int value = img.get(column, analysisHeights[w]);
  //int value = pixels[column*width+analysisHeights[w]];
  println("value = " + value);
  updateSine(w, 0.3f, map(value, -14447224, 0, 400, 800), map(column, 0, width, -1, 1));
  //updateSine(w, map(value, -14447224, 0, 400, 800)*0.01f, analysisHeights[w], map(column, 0, width, -1, 1));
  }
}

void updateSine(int w, float amplitude, float frequency, float panning) {
  // Map mouseY from 0.0 to 1.0 for amplitude
  sine[w].amp(amplitude);

  // Map mouseX from 20Hz to 1000Hz for frequency
  sine[w].freq(frequency);

  // Map mouseX from -1.0 to 1.0 for panning the audio to the left or right
  sine[w].pan(panning);

  stroke(255);
  strokeWeight(1);
  noFill();

  // Perform the analysis
  waveform[w].analyze();

  beginShape();
  for (int i = 0; i < samples; i++) {
    // Draw current data of the waveform
    // Each sample in the data array is between -1 and +1
    vertex(
      map(i, 0, samples, 0, width),
      map(waveform[w].data[i], -1, 1, 0, height)
      );
  }
  endShape();
}
