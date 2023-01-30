import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;

import fisica.*;

final int INTRO= 1;
final int GAME = 2;
final int GAME1 = 3;

final int WIN = 4;
final int GAMEOVER = 5;

//sound variables
Minim minim;
AudioPlayer  killGoomba, killHammerBro, gameover, jumping, win, levelChange, dead, bounce;

int mode;
int level = 1;

FWorld world;

//texture colors
color white = #FFFFFF;
//stone
color black = #000000;
//spike
color grey = #7E8383;
//ice
color cyan = #00FFFF;
//tree
color middleGreen = #00FF00;
color leftGreen = #009F00;
color rightGreen = #006F00;
color intersectGreen = #004F00;
color treeTrunkBrown = #FF9500;
//lava
color orange = #F0A000;
//bridge
color brown = #996633;
//trampoline
color yellow = #fce808;
//Gooomba
color purple = #e30ce3;
//wall
color dblue = #0922de;
//thwomp
color  pink = #f523f5;
//hammerbro
color red = #FF0000;
//level change
color blue = #00aaff;
//win
color sand = #f2c268;

//textures
PImage map1, map2, ice, stone, spike, treeTrunk, intersectTree, middleTree, leftTree, rightTree, trampoline, bridge, hammer, heart;

//animated textures
PImage [] idle;
PImage [] jump;
PImage [] run;
PImage [] action;
PImage [] goomba;
PImage [] thwomp;
PImage [] hammerbro;
PImage [] lava;

//arrays
ArrayList <FGameObject> terrain;
ArrayList <FGameObject> enemies;

//variables
int gridSize = 32;
float zoom = 1;
boolean wkey, skey, akey, dkey, upkey, downkey, rightkey, leftkey;
int lives = 3;
int life = 6;
boolean spacekey;

Button start;
Button retry;
Button restart;

//clicks
boolean mouseReleased;
boolean wasPressed;

//player initiation
FPlayer player;



void setup() {
  size(600, 600);
  Fisica.init(this);
  rectMode(CENTER);
  
  
  terrain = new ArrayList<FGameObject>();
  enemies = new ArrayList<FGameObject>();
  loadImages();
  //loadWorld(map1);
  if (level == 1) {
    loadWorld(map1);
  } else if (level == 2) {
    loadWorld(map2);
  }
  loadPlayer();
  mode = INTRO;
  
  //buttons
  start = new Button("START", 300, 400, 200,100,black,white);
  retry = new Button("RETRY", 300, 450,200,100, purple, cyan);
  restart = new Button("RESTART", 300, 400, 200,100, black,white);
  
  //minim 
  minim = new Minim(this);
  killGoomba = minim.loadFile("killGoomba.wav");
  killHammerBro = minim.loadFile("killHammerBro.wav");
  gameover = minim.loadFile("gameover.wav");
  jumping = minim.loadFile("jumping.wav");
  win = minim.loadFile("win.wav");
  levelChange = minim.loadFile("levelChange.wav");
  dead = minim.loadFile("dead.wav");
  bounce = minim.loadFile("bounce.wav");
  
}

void loadImages() {
  map1 = loadImage("map1.png");
  map2 = loadImage("map2.png");
  //basic terrain
  stone = loadImage("stone.png");
  ice = loadImage("ice.png");
  spike = loadImage("spike.png");
  treeTrunk = loadImage("treeTrunk.png");
  middleTree = loadImage("middleTree.png");
  leftTree = loadImage("leftTree.png");
  rightTree = loadImage("rightTree.png");
  intersectTree = loadImage("intersectTree.png");
  trampoline = loadImage("trampoline.png");
  bridge = loadImage("bridge.png");
  hammer = loadImage("hammer.png");
  heart = loadImage("heart.png");
  //load action
  idle = new PImage[2];
  idle[0] = loadImage("idle0.png");
  idle[1] = loadImage("idle1.png");
  //jump
  jump = new PImage[1];
  jump[0] = loadImage("jump0.png");
  //run
  run = new PImage[3];
  run[0] = loadImage("runright0.png");
  run[1] = loadImage("runright1.png");
  run[2] = loadImage("runright2.png");
  //stand still
  action = idle;
  //lava
  lava = new PImage[6];
  lava[0] = loadImage("lava0.png");
  lava[1] = loadImage("lava1.png");
  lava[2] = loadImage("lava2.png");
  lava[3] = loadImage("lava3.png");
  lava[4] = loadImage("lava4.png");
  lava[5] = loadImage("lava5.png");
  //goomba
  goomba = new PImage[2];
  goomba[0] = loadImage("goomba0.png");
  goomba[0].resize(gridSize, gridSize);
  goomba[1] = loadImage("goomba1.png");
  goomba[1].resize(gridSize, gridSize);
  //thwomp
  thwomp = new PImage[2];
  thwomp[0] = loadImage("thwomp0.png");
  thwomp[1] = loadImage("thwomp1.png");
  //hammerbro
  hammerbro = new PImage[2];
  hammerbro[0] = loadImage("hammerbro0.png");
  hammerbro[1] = loadImage("hammerbro1.png");
}


void loadWorld(PImage img) {
  world = new FWorld(-2000, -2000, 6000, 6000);
  world.setGravity(0, 900);

  for (int y = 0; y < img.height; y++) {
    for (int x = 0; x < img.width; x++) {
      color c = img.get(x, y); // color of current pixel

      FBox b = new FBox(gridSize, gridSize);
      b.setPosition(x*gridSize, y*gridSize);
      b.setStatic(true);

      //texture assignment
      if (c == black) {
        b.attachImage(stone);
        b.setFriction(10);
        b.setName("stone");
        world.add(b);
      } else if (c == dblue) {
        b.attachImage(stone);
        b.setFriction(0);
        b.setName("wall");
        world.add(b);
      } else if (c == sand) {
        b.attachImage(stone);
        b.setFriction(0);
        b.setName("win");
        world.add(b);
      } else if (c == blue) {
        b.attachImage(ice);
        b.setName("level");
        b.setFriction(10);
        world.add(b);
      } else if (c == cyan) {
        b.attachImage(ice);
        b.setFriction(0);
        b.setName("ice");
        world.add(b);
      } else if (c == treeTrunkBrown) {
        b.attachImage(treeTrunk);
        b.setSensor(true);
        b.setName("tree trunk");
        world.add(b);
      } else if (c == intersectGreen) {
        b.attachImage(intersectTree);
        b.setFriction(10);
        b.setName("treetop");
        world.add(b);
      } else if (c == middleGreen) {
        b.attachImage(middleTree);
        b.setFriction(10);
        b.setName("treetop");
        world.add(b);
      } else if (c == leftGreen) {
        b.attachImage(leftTree);
        b.setFriction(10);
        b.setName("treetop");
        world.add(b);
      } else if (c == rightGreen) {
        b.attachImage(rightTree);
        b.setFriction(10);
        b.setName("treetop");
        world.add(b);
      } else if (c==orange) {
        FLava lav = new FLava(x*gridSize, y*gridSize);
        terrain.add(lav);
        world.add(lav);
      } else if (c== yellow) {
        b.attachImage(trampoline);
        b.setName("trampoline");
        b.setFriction(4);
        b.setRestitution(1.235);
        //bounce.rewind();
        //bounce.play();
        world.add(b);
      } else if (c== grey) {
        b.attachImage(spike);
        b.setRestitution(0.5);
        b.setName("spike");
        world.add(b);
      } else if (c == brown) {
        FBridge br = new FBridge(x* gridSize, y*gridSize);
        terrain.add(br);
        world.add(br);
      } else if (c == purple) {
        FGoomba gmb = new FGoomba (x*gridSize, y*gridSize);
        enemies.add(gmb);
        world.add(gmb);
      } else if (c == pink) {
        FThwomp thw = new FThwomp (x*gridSize, y*gridSize);
        enemies.add(thw);
        world.add(thw);
      } else if (c== red) {
        FHammerBro ham = new FHammerBro (x*gridSize, y*gridSize);
        enemies.add(ham);
        world.add(ham);
      }
    }
  }
}

//player add
void loadPlayer() {
  player = new FPlayer();
  world.add(player);
}

void draw() {
  click();

  if (mode == INTRO) {
    intro();
  } else if (mode == GAME) {
    game();
  } else if ( mode == GAME1) {
    game1();
  } else if (mode ==WIN) {
    win();
  } else if (mode ==GAMEOVER) {
    gameover();
  }
  actWorld();
}

void actWorld() {
  player.act();
  for (int i = 0; i < terrain.size(); i++) {
    FGameObject t = terrain.get(i);
    t.act();
  }
  for (int i = 0; i < enemies.size(); i++) {
    FGameObject e = enemies.get(i);
    e.act();
  }
}

void drawWorld() {
  pushMatrix();
  translate(-player.getX() * zoom + width/2, -player.getY() * zoom + height/2);
  scale(zoom);
  world.step();
  world.draw();
  popMatrix();
}
