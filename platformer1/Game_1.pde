void game1() {
  background(255);
  //level select
  level = 2;
 
  //reset
  world.remove(player);
  terrain = new ArrayList<FGameObject>();
  enemies = new ArrayList<FGameObject>();
  loadWorld(map2);
  loadPlayer();
 
  mode = GAME;
  
}
