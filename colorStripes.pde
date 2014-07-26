//licenced under GPLv3. read: http://www.gnu.org/licenses/gpl.txt
//by Tom Brewe 2013
float time;
int colorBlocks;
float transparency;
boolean grey;

void setup(){
  size(displayWidth, displayHeight, P2D);
  colorMode(HSB, width);
  noStroke();
  time = 0.0;
  colorBlocks = 59;
  transparency = 50;
  grey = false;
}

//toggle transparency with 't'
//take a snapshot as .tif with 'r'
//change amount of similiar colored blocks by press 1-9
//toggle first and last block to be desaturated (grey) by pressing 'g'


void draw(){
  time = time + 0.02;
  float stripeCount = map(mouseX, 0, width, 1,100);
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
     float s = b = map(noise((i+j)),0,1, 200, width-500);
     if(grey && (i == 0 || i >= (colorBlocks*sameColorStripeCount) - sameColorStripeCount)) s = borderBlockSaturation;
     fill(color(startHue + hueNoise, s + saturationNoise, b + brightnessNoise),transparency);
     rect((i+j)*stripeWidth,0, stripeWidth, height);
   }
  }
}



void keyPressed(){
  if(key == 'r'){
    saveFrame("screencaps/scrstripes###.jpg");
  }
  else if (key == 't'){
    transparency = (transparency == height) ? 50 : height;
  }
  else if(key == 'g'){
    grey = !grey;
  }
  else if (key >= '0' && key <= '9'){ //in ascii values
   colorBlocks = Integer.parseInt("" + key);
   if(colorBlocks == 0) colorBlocks = 10;
 }
}
