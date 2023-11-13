Life life = new Life();

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
  
  life.tickTimers();

}


public class Ghost{
  
    final int BOUND_MAX_X = 850;
    final int BOUND_MAX_Y = 850;
    final int BOUND_MIN_X = 50;
    final int BOUND_MIN_Y = 50;
  
   PVector position;
   PVector direction;
   float speed;
   
   int size;
   int weight;
   final int DEFAULTWEIGHT = 5; 
   
   int health = 10;  //Changes from black to white making the illusion that the ghost is appearing, it also represents the hp of a ghost
   final int MAXHEALTH = 255;
  
 public Ghost(float x,float y, int weight){
   
   this.position = new PVector(x,y);
   this.weight = weight;
   this.speed = 1;
   this.newTransform();
   
 }
 
 void drawThisGhost(){
   strokeWeight(this.weight);
   point(position.x,position.y);
 }
 
 /**
 *  Sets a new direction random unit vector  
 */
 void newTransform(){

   //Generate a new transform random n2 normal vector
   this.direction = PVector.random2D();
        
 }
 
 void move(){
      
  if(checkNextMovement()){
        
    this.position.add(direction.mult(speed));
        
  }else{
        
    this.newTransform();       
 }     
}

  /**
  *
  *  Executes a theoretical movement, returns true if its contained in bounds.
  *
  */
  boolean checkNextMovement(){
     
    PVector tempPos = new PVector(position.x, position.y);
      
    tempPos.add(direction.mult(speed));
      
    if (tempPos.x < BOUND_MAX_X && tempPos.y < BOUND_MAX_Y && 
        tempPos.x > BOUND_MIN_X && tempPos.y > BOUND_MIN_Y){
           
        return true;
            
    } else {
       
        return false;
        
    }

  }
  
  void tickColor(){
   
    if(this.health < MAXHEALTH){
     
      this.health += 1; //To be used as stroke, a ghost recovers 1 health per tick but loses it when too close to another ghost
      
    }
    
  }
 
}

/**
*  Simulates the program from the Kairo 2001 horror movie
*  in which a series of spheres(ghosts) spawned, moved and died based on proximity 
*  to other ghosts(spheres)
*
*/
public class Life{
  
 final float SAFE = 75; //The ammount of space with no neighbors a ghost needs to not take damage
  
 int spawnTimer = 0;  // Defines the ammount of seconds that have passed without a ghost spawn
 final int SPAWNCOOLDOWN = 200; // Defines the ammount of time to wait to spawn a new ghost
  
 ArrayList<Ghost> ghosts;
 
 public Life(){
 
     this.ghosts = new ArrayList();
   
 }
 
 void simpleGhostsRoutines(){
   
    drawGhosts();
    damageGhosts();
    checkToKillGhosts();
    moveGhosts();
   
 }
 
 void drawGhosts(){
   
   for(Ghost g : ghosts){
    
     //Draw
     stroke(g.health);
     g.drawThisGhost();
          
   }
   
 }
 
 void checkToKillGhosts(){
   
   ArrayList<Ghost> tbr = new ArrayList();
   
   for(Ghost g : ghosts){
     
     if(g.health <= 0){ 
      tbr.add(g);
     } 
     
   }// Now we have collected all dead ghosts
   
   for(Ghost g : tbr){
     
     this.ghosts.remove(g);
     
   }
   
 }
 
 void moveGhosts(){
  
   for(Ghost g : ghosts){
    
     g.move();
     
   }
   
 }

 
 void tickTimers(){

   simpleGhostsRoutines();
   
   //Tickers
   this.spawnTimer += 1;
   
   for (Ghost g : ghosts){
    
     g.tickColor();
     
   }
   
   //Events
   //println(spawnTimer + " || " + this.ghosts.size());
   if(this.spawnTimer >= SPAWNCOOLDOWN){
     
     //println("Spawned");
     
     this.ghosts.add(new Ghost(random(200,600),random(200,600),(int)random(10,80)));
     
     spawnTimer = 0;
     
   }
 }
 
 
 void damageGhosts(){
   
   for(Ghost g : ghosts){
     
     float closest = 900;
     PVector selfClone = new PVector(g.position.x , g.position.y);
   
     for(Ghost gg : ghosts){
   
       if(!g.equals(gg)){
       
         PVector otherClone = new PVector(gg.position.x, gg.position.y);
     
         PVector temp = otherClone.sub(selfClone);
         float distance = sqrt(pow(temp.x,2) + pow(temp.y,2));
       
         if(distance <= closest){
        
           closest = distance;
         
         }
       }
   
     } // We have the closest distance
     
     if(closest <= SAFE){
    
       g.health -= 10;
       
     }
     
   }
 
 }
 
 
}
