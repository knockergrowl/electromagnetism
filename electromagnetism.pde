//Conversion from meters to nanometers
final static float M2NM = 0.000000001;

//Wavelenght of blue, green and red. According to average peak of detection in human eyes.
final static int RED_CONE = 650;   //Nanometers
final static int GREEN_CONE = 530;
final static int BLUE_CONE = 430;


final static int BLUE_PEAK = 380;  //Nanometers
final static int RED_PEAK = 780;

final static float MIN_EXP = -15.0;
final static float MAX_EXP = 3.0;


float nm, nm_exp;
int[] spectrumColors;
int spRed = 0, spGreen = 0, spBlue = 0;

void setup() {
    size(1200, 450);
    
    //Calculates color for every pixel (horizontal)
    spectrumColors = new int[width];
    colorMode(HSB);
    for(int i = 0; i < width; i++) {
      int c;
      float nm, nm_exp;
      nm_exp = map(i, 0, width-1, MIN_EXP, MAX_EXP);
      nm = pow(10, nm_exp);
      
      //Ultraviolets
      if(nm < BLUE_PEAK * M2NM) {
        c = color(180, map(nm_exp, log10(BLUE_PEAK * M2NM), MIN_EXP, 100.0, 0.0), map(nm_exp, log10(BLUE_PEAK * M2NM), MIN_EXP, 64.0, 235.0));
      }
      //Visitble spectrum
      else if(nm < RED_PEAK * M2NM) {
        c = color(map(nm, BLUE_PEAK * M2NM, RED_PEAK * M2NM, 220.0, 0.0), 255, 255);
      
      }
      //Infrared
      else {
        c = color(0, 255, map(nm_exp, log10(RED_PEAK * M2NM), 0.0, 64.0, 0.0));
      }
      
      spectrumColors[i] = c;
      
      // Calculates average human eye color detection
      if(nm < BLUE_CONE * M2NM) {
        spBlue = i;
      }
      if(nm < GREEN_CONE * M2NM) {
        spGreen = i;
      }
      if(nm < RED_CONE * M2NM) {
        spRed = i;
      }
      
      
      
    }
    colorMode(RGB);
    smooth();
    frameRate(30);
} 

void draw() { 
    background(0);
    background(spectrumColors[mouseX]);
    nm_exp = map(mouseX, 0, width-1, MIN_EXP, MAX_EXP);
    nm = pow(10, nm_exp);
    
    paintPrimary(height-60, height-50);
    
    stroke(255, 220);
    strokeWeight(1);
    line(mouseX, 0, mouseX, height-1);
    

    
    for(int i = 0; i < width; i++) {
      stroke(spectrumColors[i]);
      strokeWeight(1);
      line(i, height-50, i, height);
    }
    

    
    stroke(255, 127);
    line(mouseX, 0, mouseX, height-1);
    
    fill(255);
    textAlign(RIGHT);
    String t = "10^" + nfs(nm_exp, 2, 2);
    if(nm > M2NM * 1000.0) {
      t += " = " + nfs(nm, 4, 12) + " m";
    }
    else {
      t += " = " + nfs(nm / M2NM, 4, 12) + " nm";
    }
    text(t, width, height-10);

}

void paintPrimary(int minH, int maxH) {
  colorMode(RGB);
  strokeWeight(3);
  
  stroke(255, 0, 0);
  line(spRed, minH, spRed, maxH);
  
  stroke(0, 255, 0);
  line(spGreen, minH, spGreen, maxH);
  
  stroke(0, 0, 255);
  line(spBlue, minH, spBlue, maxH);
}

float log10(float x) {
  return (log(x)/log(10));
}


