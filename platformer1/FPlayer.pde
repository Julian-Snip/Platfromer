class FPlayer extends FGameObject {
  int frame;
  int direction;
  final int L = -1;
  final int R = 1;

  boolean alive = true;

  FPlayer() {
    super();
    frame = 0;
    direction = R;
    setPosition(500, 200);
    setName("player");
    setRotatable(false);
    setFillColor(red);
  }

  void act() {
    handelInput();
    collision();
    animate();
  }

  void animate() {
    if (frame >=action.length)frame = 0;
    if (frameCount % 5 == 0) {
      if (direction == R) attachImage(action[frame]);
      if (direction ==L)  attachImage(reverseImage(action[frame]));
      frame++;
    }
  }

  void collision() {

    if (isTouching("spike")) {
      lives= lives-3;
    }
    if (isTouching("lava")) {
      lives= lives-3;
    }
    if (isTouching("trampoline")) {
      bounce.rewind();
      bounce.play();
    }
    if (isTouching("hammer")) {
      lives= lives-3;
    }
    if (isTouching("level")) {
      mode = GAME1;
      levelChange.rewind();
      levelChange.play();
    }
    if (isTouching("win")) {
      mode = WIN;
      win.rewind();
      win.play();
    }
  }

  void handelInput() {
    float vy = getVelocityY();
    //float vx = getVelocityX();
    if (vy == 0) {
      action = idle;
    }
    if (akey ) {
      setVelocity(-200, vy);
      action = run;
      direction = L;
    }
    if (dkey) {
      setVelocity(200, vy);
      action = run;
      direction = R;
    }
    if (leftkey) {
      setVelocity(-200, vy);
      action = run;
      direction = L;
    }
    if (rightkey) {
      setVelocity(200, vy);
      action = run;
      direction = R;
    }
    if (abs(vy)> 0.1) {
      action = jump;
    }
    jumping();
  }

  void jumping() {
    float vx = getVelocityX();
    ArrayList<FContact> jump = getContacts();

    for (int i = 0; i < jump.size(); i++) {
      FContact j = jump.get(i) ;
      if (j.contains ("stone")) {
        if (upkey||wkey) {
          jumping.rewind();
          jumping.play();
          setVelocity (vx, -400) ;
        }
      } else if (j.contains ("ice")) {
        if (upkey|| wkey) {
          jumping.rewind();
          jumping.play();
          setVelocity (vx, -400) ;
        }
      } else if (j.contains ("spike")) {
        if (upkey|| wkey) {
          jumping.rewind();
          jumping.play();
          setVelocity (vx, -400) ;
        }
      } else if (j.contains ("bridge")) {
        if (upkey|| wkey) {
          jumping.rewind();
          jumping.play();
          setVelocity (vx, -400) ;
        }
      } else if (j.contains ("treetop")) {
        if (upkey || wkey) {
          jumping.rewind();
          jumping.play();
          setVelocity (vx, -400) ;
        }
      }
    }
  }
}
