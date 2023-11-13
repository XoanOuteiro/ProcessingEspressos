void setup(){
  //Processing things
   background(0);
   strokeWeight(2);
   stroke(255);
   size(900,900);
   smooth(10);
   
  //Program things
}

void draw(){

  setup() //reload screen

}


public class Ghost{
  
   PVector position;
   int size;
   int weight;
   final int DEFAULTWEIGHT = 5; 
  
 public Ghost(float x,float y, int weight){
   
   this.position = new PVector(x,y);
   this.weight = weight;
   
 }
 
 void drawThisGhost(){
   strokeWeight(this.weight);
   point(position.x,position.y);
   strokeWeight(DEFAULTWEIGHT);
   
 }
}

public class Life{
  
 ArrayList<Ghost> ghosts;
 
 public Life(){
 
     this.ghosts = new ArrayList();
   
 }
}
