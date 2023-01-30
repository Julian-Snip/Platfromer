void gameover() {
  background(0);
  fill(#0FE4FA);
  textSize(50);
  text("BETTER LUCK NEXT TIME", 300, 200);
  text("YOU SUCK", 300, 300);
  retry.show();
  gameover.play();

  if (retry.clicked) {
    mode = GAME;
    level = 1;
  }
}
