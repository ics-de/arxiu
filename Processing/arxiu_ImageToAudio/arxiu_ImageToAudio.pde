import processing.sound.*;

PImage img;

SinOsc sine;
Waveform waveform;

// Define how many samples of the Waveform you want to be able to read at once
int samples = 100;

int analysisHeight = 250;

void setup(){
  
  size(1920,1080);
  
 img = loadImage("data/img.png"); 
 background(0);
 analysisHeight = int(random(0, height));
 // create and start the sine oscillator.
  sine = new SinOsc(this);
  sine.play();
  
  // Create the Waveform analyzer and connect the playing soundfile to it.
  waveform = new Waveform(this, samples);
  waveform.input(sine);
}

void draw(){
  //background(0);
  image(img, 0, 0, width, height);
  analyze(frameCount % width);
  //analysisHeight += random(-4, 2);
  delay(1);
}

void analyze(int column){
  fill(255,125);
  noStroke();
  rect(column, 0, 2, height);
  rect(0,analysisHeight,width,2);
  int value = img.get(column, analysisHeight);
  println("value = " + value);
  updateSine(0.3f, map(value, -14447224, 0, 400, 800), map(column,0,width,-1,1));
}

void updateSine(float amplitude, float frequency, float panning){
 // Map mouseY from 0.0 to 1.0 for amplitude
  sine.amp(amplitude);

  // Map mouseX from 20Hz to 1000Hz for frequency  
  sine.freq(frequency);

  // Map mouseX from -1.0 to 1.0 for panning the audio to the left or right
  sine.pan(panning); 
  
  stroke(255);
  strokeWeight(2);
  noFill();
  
  // Perform the analysis
  waveform.analyze();
  
  beginShape();
  for(int i = 0; i < samples; i++){
    // Draw current data of the waveform
    // Each sample in the data array is between -1 and +1 
    vertex(
      map(i, 0, samples, 0, width),
      map(waveform.data[i], -1, 1, 0, height)
    );
  }
  endShape();
}
