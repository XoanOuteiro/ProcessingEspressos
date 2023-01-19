ArrayList<Float> mainHolder = new ArrayList();
int iterate = 1;
float currentGreatest;

void setup(){
  background(0);
  stroke(255);
  strokeWeight(1);
  size(900,300);
  spawnAutoLine();
  currentGreatest = mainHolder.get(1);
}

void draw(){
  background(0);
  if(iterate>=899){
    iterate = 899;
  } 
  iterate++;
  //DrawArray
  for(int i = 1; i<900;i++){
   line(i,300,i,mainHolder.get(i)); 
  }

  
}

void spawnAutoLine(){
  for( int i = 0; i < 900; i++){
    boolean correct = false;
    while(!correct){
      float thisInt = random(1,300);
      if(!(mainHolder.contains(thisInt))){
        mainHolder.add(thisInt);
        correct = true;
      }
    }
  }
    
}
