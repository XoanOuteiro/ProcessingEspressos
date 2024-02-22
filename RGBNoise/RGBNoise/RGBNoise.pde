final int WHITE = 255;
final int DARK = 0 ;
final int LIGHTNESS = 0;
final int DARKNESS = 0;
final float step = 2;
Dot[][] array = new Dot[100][100];


void setup(){
 fillArray();
 size(200,200);
 background(0);
 stroke(0);
 smooth(4);
 strokeWeight(2);
}

void draw(){
  
  colorArray();
  drawArray();
  
}

void fillArray(){
  
  int x = 0;
  int y = 0;
  
  for(int i = 0; i < array.length; i++){
   for(int j = 0; j < array[i].length; j++){
    
     array[i][j] = new Dot(x,y);
     
     x+= step;
     
   }
   
   x = 0;
   y += step;
   
  }
  
}

void colorArray(){
  
  for(int i = 0; i < array.length; i++){
   for(int j = 0; j < array[i].length; j++){
     array[i][j].getRandomValue();
     
   }
  }
  
}

void drawArray(){
  
  for(int i = 0; i < array.length; i++){
   for(int j = 0; j < array[i].length; j++){
     Dot dot = array[i][j];
     stroke(dot.red,dot.green,dot.blue);
     point(dot.x,dot.y);
     
   }
  }
  
}

class Dot{
 
  float x;
  float y;
  float red;
  float green;
  float blue;
  
  void getRandomValue(){
   
    this.red = random(DARK + LIGHTNESS, WHITE - DARKNESS);
    this.green = random(DARK + LIGHTNESS, WHITE - DARKNESS);
    this.blue = random(DARK + LIGHTNESS, WHITE - DARKNESS);
    
  }
  
  Dot(float x, float y){
   
    this.x = x;
    this.y = y;
    
  }
  
}
