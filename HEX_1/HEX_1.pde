Ball[] balls;

PImage img;
int[][] history;
int frames = 0;

void setup() {
  size(600, 1000, P2D);
  
  //img = loadImage("data/mainlogo2.png");
  
  balls = new Ball[80];
  
  int count = 0;
  while (count < balls.length) {
    Ball b = new Ball(random(2, width-2), random(2, height-2), 6);
    
    boolean ok = true;
    for (int i = 0; i < count; i++) {
      Ball c = balls[i];
      float d = PVector.dist(b.position, c.position);
      if (d <= b.radius + c.radius) {
        ok = false;
        break;
      }
    }
    
    if (ok) {
      balls[count] = b;
      count++;
    }
  }
  
  int idx = floor(random(balls.length));
  Ball b = balls[idx];
  b.state = 1;
  
  history = new int[3600][2];
  
}

 void mouseClicked() {
  setup();
   }

void draw() {
  
  
  
  background(0);
  
  noStroke();
  fill(0);
  
  //rect(0, 0, width, 60);
 
  int susceptible = 0;
  int infected = 0;
  int recovered = 0;
  
  for (Ball b : balls) {
    if (b.state == 0) {
      susceptible++;
    } else if (b.state == 1) {
      infected++;
    } else {
      recovered++;
    }

  }
  

  
 /**
 
  history[frames][0] = susceptible;
  history[frames][1] = infected;
  history[frames][2] = recovered;
  
  for (int j = 0; j <= frames; j++) {
    int s = int(history[j][0] / 200.0 * 60);
    int i = int(history[j][1] / 200.0 * 60);
    int r = int(history[j][2] / 200.0 * 60);
    stroke(0, 0, 255);
    line(j/10+120, 0, j/10+120, r);
    stroke(0, 255, 0);
    line(j/10+120, r, j/10+120, r+s);
    stroke(255, 0, 0);
    line(j/10+120, r+s, j/10+120, r+s+i);
  }
  
  textAlign(LEFT, CENTER);
  fill(0, 255, 0);
  text("Susceptible: " + susceptible, 10, 15);
  fill(255, 0, 0);
  text("Infected: " + infected, 10, 30);
  fill(0, 0, 255);
  text("Recovered: " + recovered, 10, 45);
  
 **/ 

  for (Ball b : balls) {
    b.display();
  }

  for (int n = 0; n < 50; n++) {
    for (Ball b : balls) {
      b.update();
      b.checkBoundaryCollision();
    }
    
    for (int i = 0; i < balls.length; i++) {
      for (int j = i+1; j < balls.length; j++) {
        balls[i].checkCollision(balls[j]);
      }
    }
  }
  
  //image(img, 50, 50, width/6, height/6);
  
  frames++;
  rec();
}
