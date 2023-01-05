//Universal constants
final float Cf = 0.5;      //Cohesion force
final float Rf = 0.5;      //Repulsion force
final float SOI = 200;     //Sphere of influence (forces are all the same across the SOI)

USystem usystem;

void setup() {
  size(1000, 1000);
  smooth(4);
  stroke(255);
  strokeWeight(10);
  background(0, 0, 0);

  usystem = new USystem();
}

void mouseClicked() {
  usystem.addObj(new Object(mouseX, mouseY));
}

void refresh() {
  background(0, 0, 0);
}

void draw() {
  refresh();
  usystem.display();
  delay(10);
  usystem.run();
}

/*
  CLASS OBJECT
 */
class Object {
  //Atributes
  PVector pos;

  //Construction methods
  public Object(float x, float y) {
    this.pos = new PVector(x, y);
  }

  public void applyForces(Object obj , float distance) {
  //Repulsion
  this.pos.add(this.pos.sub(obj.pos));
  
  //Cohesion
  this.pos.add(obj.pos.sub(this.pos));
  }
}


/*
  CLASS COLONY
 */
class USystem {
  //Atributes
  ArrayList <Object> universe;

  //Construction methods
  public USystem() {
    this.universe = new ArrayList();
  }

  //Display methods
  public void display() {
    for (int i = 0; i < universe.size(); i++) {
      point(universe.get(i).pos.x, universe.get(i).pos.y);
    }
  }

  //USystem methods
  public void run() {
    for (int i = 0; i < universe.size(); i++) {
      for (int j = 0; j < universe.size(); j++) {
        if(universe.get(i) != universe.get(j)){
          if (universe.get(i).pos.dist(universe.get(j).pos) < SOI) {
            universe.get(i).applyForces(universe.get(j) , universe.get(i).pos.dist(universe.get(j).pos));
          }
        }
      }
    }
  }

  public void addObj(Object obj) {
    universe.add(obj);
  }
}
