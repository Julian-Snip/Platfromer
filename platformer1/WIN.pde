void win(){
  background(#FE00FF);
  fill(#14F5EF);
  textSize(70);
 text("CONGRATULATIONS",300,200);
  text("YOU WIN",300,300);
  restart.show();
  win.rewind();
  win.play();
  
  
  if(restart.clicked){
    mode = INTRO;
    level = 1;
  }  
}
