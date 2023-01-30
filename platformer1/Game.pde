void game() {
  background(0);
  drawWorld();

  //live refinment
  fill(red);
  textSize(20);
  heart.resize(32, 32);
  text("lives:", 50, 50);

  int n = 70;
  int i = 0;
  
//draw life loop
  while (life > i) {
    image(heart, n, 40);
    n = n + 30;
    i++;
  }
  
//die
  if (life <= 0) {
    mode = GAMEOVER;
    life = 6;
    gameover.rewind();
  }

  if (lives <= 0) {
    player.setPosition(500, 400);
    lives = 3;
    life= life -1;
    dead.rewind();
    dead.play();
    reset();
  }
}

void reset() {

  world.remove(player);
  enemies = new ArrayList<FGameObject>();
  
//map select
  if (level == 1) {
    loadWorld(map1);
  } else if (level == 2) {
    loadWorld(map2);
  }
  
  drawWorld();
  loadPlayer();
}
