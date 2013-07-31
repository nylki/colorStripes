//licenced under GPLv3. read: http://www.gnu.org/licenses/gpl.txt

void setup(){
  size(displayWidth, displayHeight);
  colorMode(HSB, width);
  noStroke();
}

//toggle transparency with 't'
//take a snapshot as .tif with 'r'
//change amount of similiar colored blocks by press 1-9
//toggle first and last block to be desaturated (grey) by pressing 'g'

float time = 0.0;
int colorBlocks = 5;
float transparency = 50;
boolean grey = false;

void draw(){
  time = time + 0.01;
  float stripeCount = map(mouseX, 0, width, 1,300);
  int sameColorStripeCount = ceil(stripeCount/colorBlocks);
  float stripeWidth = (width/stripeCount);//  * map(noise(time+6000),0,1, 0.5, 1.5); 
  float startHue = map(mouseY,0,height, 5, width);
  float hueNoise = map(noise(time), 0,1, -120,120);
  float brightnessNoise = map(noise((time+5000) / 1.5), 0,1, -40,80);
  float saturationNoise = map(noise((time-500) / 1.5), 0,1, 60,60);
  // grauwert
  
  float borderBlockSaturation = width*0;
  
  
  for(int i=0; i<stripeCount; i=i+sameColorStripeCount){
    startHue = (startHue + (i*(stripeWidth))) % width;
    
   for(int j=0; j<=sameColorStripeCount; j++){
     float b;
     float s = b = map(noise((i+j)),0,1, 200, width-100);     
     if(grey && (i == 0 || i >= (colorBlocks*sameColorStripeCount) - sameColorStripeCount)) s = borderBlockSaturation;
     fill(color(startHue + hueNoise, s + saturationNoise, b + brightnessNoise),transparency);
     rect((i+j)*stripeWidth,0, stripeWidth, height);
   } 
  }
}



void keyPressed(){
  if(key == 'r'){
    saveFrame("stripes###.png");
  }
  else if (key == 't'){
    transparency = (transparency == height) ? 50 : height;
  } 
  else if(key == 'g'){
    grey = grey ? false : true;
  }
  else if (key >= '0' && key <= '9'){ //in ascii values
   colorBlocks = Integer.parseInt("" + key);
   if(colorBlocks == 0) colorBlocks = 10;
 }
}
  
