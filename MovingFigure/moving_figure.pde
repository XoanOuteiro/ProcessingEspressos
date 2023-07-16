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
  
  sys.newTransform();

}

class System{
    
    Origin[] array = new Origin[4];

    System(){

        this.array[0] = new Origin(200,200);
        this.array[1] = new Origin(300,200);
        this.array[2] = new Origin(200,300);
        this.array[3] = new Origin(300,300);

    }
    
    /**
    *  Draws dots at origins positions
    */
    void drawDots(){

      strokeWeight(10);

      for (int i = 0; i < 4; ++i) {

        point(sys.array[i].position.x,sys.array[i].position.y);
        
      }
    }

    /**
    *  Draws lines between origins.
    */
    void drawLines(){

      strokeWeight(3);

      //Lines from 0 to 1 and 2
      line(sys.array[0].position.x,sys.array[0].position.y,
           sys.array[1].position.x,sys.array[1].position.y);
      
      line(sys.array[0].position.x,sys.array[0].position.y,
           sys.array[2].position.x,sys.array[2].position.y);

      //Lines from 3 to 1 and 2
      line(sys.array[3].position.x,sys.array[3].position.y,
           sys.array[1].position.x,sys.array[1].position.y);

      line(sys.array[3].position.x,sys.array[3].position.y,
           sys.array[2].position.x,sys.array[2].position.y);

    }
    
    /**
    *  Iterates through Origins changing their position
    */
    void newTransform(){
      
      for(Origin fPoint : array){
        
        //Generate a new transform random n2 normal vector
        PVector r = PVector.random2D().mult(1.5);
        //Apply transform
        fPoint.position = fPoint.position.add(r);
        
      }
      
    }

}

/**
 * Represents a floating point in 2D space
 */
class Origin{
  
    PVector position;

    Origin(int posX, int posY){
        this.position = new PVector(posX,posY);
    }

}
