void intro(){
  
  background(#7524BC);
  start.show();
  textAlign(CENTER,CENTER);
  textSize(70);
  fill(0);
  text("CAVE EXPLORATION",300,200);
  
  
  
  if(start.clicked){
    mode = GAME;
    level = 1;
  }
}
