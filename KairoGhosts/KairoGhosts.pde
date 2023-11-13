

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

  setup(); //reload screen

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
   strokeWeight(DEFAULTWEIGHT);
   point(position.x,position.y);
 }
}

/**
*  Simulates the program of Kairo 2001 horror movie computer program 
*  in which a series of spheres spawned, moved and died based on proximity 
*  to other ghosts
*
*/
public class Life{
  
 int spawnTimer = 0;  // Defines the ammount of seconds that have passed without a ghost spawn
 final int spawnCooldown = 400; // Defines the ammount of time to wait to spawn a new ghost
  
 ArrayList<Ghost> ghosts;
 
 public Life(){
 
     this.ghosts = new ArrayList();
   
 }
}
