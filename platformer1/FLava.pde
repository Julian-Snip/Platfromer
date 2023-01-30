class FLava extends FGameObject {
  int f = 0;
  int randomLava;

  FLava(float x, float y ) {
    super();
    setPosition(x, y);
    setName("lava");
    setStatic(true);
  }

  void act() {
    if (frameCount % 12 == 0) {
      randomLava = (int) random (0, 5);
      attachImage(lava[randomLava]);
    }
  }
}
