void setup(){
  size(displayWidth, displayHeight, P2D);
  colorMode(HSB, width);
  noStroke();  
}

//toggle transparency with 't'
//take a snapshot as .tif with 'r'

float time = 0.0;
int colorBlocks = 5;
float transparency = 35;

void draw(){
  time = time + 0.04;
  float stripeCount = map(mouseX, 0, width, 1,300);
  int sameColorStripeCount = ceil(stripeCount/colorBlocks);
  float stripeWidth = (width/stripeCount);//  * map(noise(time+6000),0,1, 0.5, 1.5); 
  float startHue = map(mouseY,0,height, 5, width);
  float hueNoise = map(noise(time), 0,1, -120,120);
  float brightnessNoise = map(noise((time+5000) / 1.5), 0,1, -60,60);
  float saturationNoise = map(noise((time-500) / 1.5), 0,1, 60,60);
  
  
  for(int i=0; i<stripeCount; i=i+sameColorStripeCount){
    startHue = (startHue + (i*(stripeWidth))) % width;
    
   for(int j=0; j<=sameColorStripeCount; j++){
     float n = map(noise((i+j)),0,1, 200, width-100);     
     fill(color(startHue + hueNoise, n + saturationNoise, n + brightnessNoise),transparency);
     rect((i+j)*stripeWidth,0, stripeWidth, height);
   } 
  }
}



void keyPressed(){
  if(key == 'r'){
    saveFrame("stripes###.tif");
  }
  else if (key == 't'){
    transparency = (transparency == height) ? 50 : height;
  } 
  else if (key >= '0' && key < '9'){ //in ascii values
   colorBlocks = Integer.parseInt("" + key);
   if(colorBlocks == 0) colorBlocks = 10;
 }
}
  
