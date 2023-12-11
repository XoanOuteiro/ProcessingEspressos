System sys = new System();

void setup() {

  size(1000, 1000);
  background(50);
  noFill();
  stroke(255);
  strokeWeight(20);
  smooth(4);
}

void draw() {

  background(50);
  sys.callMovements();
  sys.drawDots();
  sys.drawLines();
}

void mouseClicked() {

  sys.addOrigin(mouseX, mouseY);
}

class System {

  ArrayList<Origin> array = new ArrayList();

  /**
   *  Draws dots at origins positions
   */
  void drawDots() {

    stroke(241, 152, 147);  //Light pink

    for (int i = 0; i < array.size(); ++i) {

      Origin ref = this.array.get(i);

      strokeWeight(ref.weight);

      point(ref.position.x, ref.position.y);
    }
  }

  void addOrigin(float x, float y) {

    array.add(new Origin((int)x, (int)y));
  }

  void callMovements() {

    for (Origin org : array) {

      org.move();
    }
  }


  void drawLines() {
    
    stroke(175);
    strokeWeight(2);

    float minLineDistance = 105;
    
    for (Origin g : array) {

      PVector selfClone = new PVector(g.position.x, g.position.y);

      for (Origin gg : array) {

        if (!g.equals(gg)) {

          PVector otherClone = new PVector(gg.position.x, gg.position.y);

          PVector temp = otherClone.sub(selfClone);
          float distance = sqrt(pow(temp.x, 2) + pow(temp.y, 2));

          if (distance <= minLineDistance) {

            float[] iP1 = {g.position.x, g.position.y};
            float[] iP2 = {gg.position.x, gg.position.y};
            
            throwRandomSpline(iP1,iP2);
          }
        }
      }
    }
  }
  
  void throwRandomSpline(float[] iP1, float[] iP2){
   
    // The first control point is made via generating a new random unit vector from
    // the iP1and getting the objects position after a given step
    //PVector unitTransform = PVector.random2D();
    //PVector pos1 = new PVector(iP1[0],iP1[1]);
    //pos1.add(unitTransform);
    //pos1.mult(random(-.2,2));
    float[] cP1 = generateRandomControlPoint(iP1);
    
    //The second control point is made alike, but with the ending point
    //unitTransform = PVector.random2D();
    //PVector pos2 = new PVector(iP2[0],iP2[1]);
    //pos2.add(unitTransform);
    //pos2.mult(random(-.2,2));
    float[] cP2 = generateRandomControlPoint(iP2);
    
    /*
    strokeWeight(5);
    stroke(20,200,240);
    point(cP1[0],cP1[1]);
    point(cP2[0],cP2[1]);
    */
    strokeWeight(2);
    stroke(100,100,240,60);
    curve(cP1[0],cP1[1],iP1[0],iP1[1],iP2[0],iP2[1],cP2[0],cP2[1]);
  }
  
  float[] generateRandomControlPoint(float[] iP) {
    float range = 150; // Adjust the range as needed
  
    float randomX = random(iP[0] - range, iP[0] + range);
    float randomY = random(iP[1] - range, iP[1] + range);
  
    // Alternatively, you can use iP2 instead of iP1 for the other end of the range
  
    float[] controlPoint = {randomX, randomY};
    return controlPoint;
  }
}



class Origin {

  final int BOUND_MAX_X = 1000;
  final int BOUND_MAX_Y = 1000;
  final int BOUND_MIN_X = 0;
  final int BOUND_MIN_Y = 0;

  PVector direction;
  PVector position;
  float weight;

  Origin(int posX, int posY) {
    this.position = new PVector(posX, posY);
    this.newTransform();  //First set
    this.weight = random(4, 10);
  }

  /**
   *  Sets a new direction random unit vector
   */
  void newTransform() {

    //Generate a new transform random n2 normal vector
    this.direction = PVector.random2D();
  }

  /**
   *
   *  Executes a theoretical movement, returns true if its contained in bounds.
   *
   */
  boolean checkNextMovement() {

    PVector tempPos = new PVector(position.x, position.y);

    tempPos.add(direction);

    if (tempPos.x < BOUND_MAX_X && tempPos.y < BOUND_MAX_Y &&
      tempPos.x > BOUND_MIN_X && tempPos.y > BOUND_MIN_Y) {

      return true;
    } else {

      return false;
    }
  }

  void move() {

    if (checkNextMovement()) {

      this.position.add(direction);
    } else {

      this.newTransform();
    }
  }
}
