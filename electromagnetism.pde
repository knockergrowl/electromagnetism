// Pressing Control-R will render this sketch.

final static float M2NM = 0.000000001;

float nm_exp = 0; 
float nm = 0;

void setup() {
    background(0);
    size(900, 450);
    smooth();
    frameRate(30);
} 

void draw() { 
    background(0);
    nm_exp = map(mouseX, 0, width-1, -12, 3);
    nm = pow(10.0, nm_exp);
    
    
    colorMode(HSB);
    if(nm < 430 * M2NM) {
      background(220, map(nm_exp, log10(430 * M2NM), -12.0, 64.0, 0.0), map(nm_exp, log10(430 * M2NM), -12.0, 64.0, 192.0));
    }
    else if(nm < 572 * M2NM) {
      
      background(map(nm, 430 * M2NM, 572 * M2NM, 220.0, 0.0), 255, 255);
      
    } else {
      background(0, 255, map(nm_exp, log10(572 * M2NM), 0.0, 64.0, 0.0));
    }
    colorMode(RGB);
    
    stroke(255);
    strokeWeight(1);
    line(mouseX, 0, mouseX, height-1);
    
    fill(255);
    String t = "10^" + nfs(nm_exp, 2, 2);
    t += " = " + nfs(nm, 4, 12) + " m";
    text(t, 5, height-5);
    

}

float log10(float x) {
  return (log(x)/log(10));
}


