class FGoomba extends FGameObject {
  
  int frame = 0 ;
  int direction = L;
  int speed = 50;

  FGoomba(float x, float y) {
    super();
    setPosition(x, y);
    setName("goomba");
    setRotatable(false);
  }

  void act() {
    move();
    collision();
    animate();
  }

  void animate() {
    if (frame >=goomba.length)frame = 0;
    if (frameCount % 5 == 0) {
      if (direction == R) attachImage(goomba[frame]);
      if (direction ==L)  attachImage(reverseImage(goomba[frame]));
      frame++;
    }
  }

  void collision() {
    if (isTouching("wall")) {
      direction *= -1;
      setPosition(getX() + direction* 3, getY());
    }

    if (isTouching("player")) {
      if (player.getY() < getY() - gridSize) {
        world.remove(this);
        enemies.remove(this);
        player.setVelocity(player.getVelocityX(), 300);
        killGoomba.rewind();
        killGoomba.play();
      } else {
        //die.rewind();
        //die.play();
        lives= lives -1;
        
      }
    }
  }
  
  void move() {
    float vy = getVelocityY();
    //float vx = getVelocityX();
    if (direction == L) {
      setVelocity(-200, vy);
    } else if (direction == R) {
      setVelocity(200, vy);
    }
  }
}
