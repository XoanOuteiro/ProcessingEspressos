System sys = new System();

void setup() {

  size(1000, 1000);
  background(50);
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

    float minLineDistance = 75;
    
    for (Origin g : array) {

      PVector selfClone = new PVector(g.position.x, g.position.y);

      for (Origin gg : array) {

        if (!g.equals(gg)) {

          PVector otherClone = new PVector(gg.position.x, gg.position.y);

          PVector temp = otherClone.sub(selfClone);
          float distance = sqrt(pow(temp.x, 2) + pow(temp.y, 2));

          if (distance <= minLineDistance) {

            line(g.position.x,g.position.y,gg.position.x,gg.position.y);
          }
        }
      }
    }
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
