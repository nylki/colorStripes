//licenced under GPLv3. read: http://www.gnu.org/licenses/gpl.txt
//by Tom Brewe 2013
var time;
var colorBlocks;
var transparency;
var grey;

function setup() {
  createCanvas(displayWidth, displayHeight);
  colorMode(HSB, width);
  noStroke();
  time = 0.0;
  colorBlocks = 59;
  transparency = 50;
  grey = false;
  document.querySelector("body").addEventListener("onkeydown",keyPressed);
}

function draw() {
  time = time + 0.02;
  var stripeCount = map(mouseX, 0, width, 1,100);
  var sameColorStripeCount = ceil(stripeCount/colorBlocks);
  var stripeWidth = (width/stripeCount);//  * map(noise(time+6000),0,1, 0.5, 1.5);
  var startHue = map(mouseY,0,height, 5, width);
  var hueNoise = map(noise(time), 0,1, -120,120);
  var brightnessNoise = map(noise((time+5000) / 1.5), 0,1, -40,80);
  var saturationNoise = map(noise((time-500) / 1.5), 0,1, 60,60);
  // grauwert

  var borderBlockSaturation = width*0;


  for(var i=0; i<stripeCount; i=i+sameColorStripeCount){
    startHue = (startHue + (i*(stripeWidth))) % width;

   for(var j=0; j<=sameColorStripeCount; j++){
     var b;
     var s = map(noise((i+j)),0,1, 200, width-500);
     var b = map(noise((i+j)),0,1, 200, width-500);
     if(grey && (i === 0 || i >= (colorBlocks*sameColorStripeCount) - sameColorStripeCount)) s = borderBlockSaturation;
     fill(startHue + hueNoise, s + saturationNoise, b + brightnessNoise, transparency);
     rect((i+j)*stripeWidth,0, stripeWidth, height);
   }
  }
}

function keyPressed(event) {
  if(event.key == 'r') {
    save("screencaps/colorStripes_" + Date.now() + ".jpg");
  }
  else if (event.key == 't') {
    transparency = (transparency == height) ? 50 : height;
    console.log(transparency);
  }
  else if(event.key == 'g') {
    grey = !grey;
  }
  else if (event.key >= '0' && event.key <= '9') { //in ascii values
   colorBlocks = int("" + key);
   if(colorBlocks == 0) colorBlocks = 10;
 }
}
