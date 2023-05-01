ArrayList<Float> mainHolder = new ArrayList();
int iterate = 0;
int nextPos = iterate+1;

void setup(){
  background(0);
  stroke(255);
  strokeWeight(1);
  size(900,300);
  spawnAutoLine();
}

void draw(){
  background(0);
  if(iterate<900){
    sort(iterate);
  }
  iterate++;
  
  //DrawArray
  for(int i = 0; i<900;i++){
   line(i,300,i,mainHolder.get(i)); 
  }

  if(iterate>900){
    restart();
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

void sort(int curPos){
  int curSmallest = curPos; //Start asuming smallest float is at pos Iterate
  for(int i = curPos; i<mainHolder.size(); i++){
    if(mainHolder.get(i)<mainHolder.get(curSmallest)){
      curSmallest = i;
    }
  }  //By now we should know the smallest value ahead of curPos
    float swapmem = mainHolder.get(curPos);
    mainHolder.set(curPos, mainHolder.get(curSmallest));
    mainHolder.set(curSmallest,swapmem);
  
}

void restart(){
  iterate = 0;
  mainHolder.clear();
  spawnAutoLine();
}
