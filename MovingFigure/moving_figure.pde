System sys;

void setup(){
 size(600,600);
 background(20);
 strokeWeight(3);
 stroke(255);
 smooth(2);

 sys = new System();
}

//Main
void draw(){
  
  background(20);
  
  sys.drawDots();
  sys.drawLines(); 
  
  //Movements
  sys.callMovements();

}

void mouseClicked(){
  
  float closest = 900; //Max is 600 so they will alway be less
  int indexofclosest = 0; 
  PVector closestVector = null;
 
  Origin dot = new Origin(mouseX,mouseY);
  
  for(Origin org : sys.array){
    
    //Avoid reference contamination by instancing clones
    PVector currentOrg = new PVector(org.position.x, org.position.y);
    PVector currentDot = new PVector(dot.position.x, dot.position.y);
    
    PVector temp = currentOrg.sub(currentDot);
    
    float distance = sqrt(pow(temp.x,2) + pow(temp.y,2));
    
    if(distance <= closest){
     
      closest = distance;
      indexofclosest = sys.array.indexOf(org);
      closestVector = org.position;
      
    }
    
  } //Assume by now we have closest index
  
  sys.array.add(indexofclosest,dot);
  
  
}

class System{
    
    ArrayList<Origin> array = new ArrayList();

    System(){

        this.array.add(new Origin(200,200));
        this.array.add(new Origin(300,200));
        this.array.add(new Origin(300,300));
        this.array.add(new Origin(200,300));
        
    }
    
    /**
    *  Draws dots at origins positions
    */
    void drawDots(){

      strokeWeight(10);

      for (int i = 0; i < array.size(); ++i) {

        point(this.array.get(i).position.x, this.array.get(i).position.y);
        
      }
    }

    /**
    *  Draws lines between origins.
    */
    void drawLines(){

      strokeWeight(3);
           
      int maxval = array.size() -1;
           
      for (int i = 0; i < array.size(); ++i){
       
        if(i < array.size()-1){
          
          line(this.array.get(i).position.x, this.array.get(i).position.y,
                this.array.get(i+1).position.x, this.array.get(i+1).position.y);
        
        }else{
         
          line(this.array.get(maxval).position.x, this.array.get(maxval).position.y,
               this.array.get(0).position.x, this.array.get(0).position.y);
          
        }
      }

    }
    
    
    void callMovements(){
     
      for(Origin org : array){
       
        org.move();
        
      }
      
    }
    
}

/**
 * Represents a floating point in 2D space
 */
class Origin{
  
    final int BOUND_MAX_X = 600;
    final int BOUND_MAX_Y = 600;
    final int BOUND_MIN_X = 0;
    final int BOUND_MIN_Y = 0;
  
    PVector position;
    PVector direction;
    float speed;

    Origin(int posX, int posY){
        this.position = new PVector(posX,posY);
        this.speed = 1;
        this.newTransform();  //First set
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
    
    /**
    *  Sets a new direction random unit vector  
    */
    void newTransform(){

        //Generate a new transform random n2 normal vector
        this.direction = PVector.random2D();
        
    }

}
