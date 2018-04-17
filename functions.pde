void drawIntro() {
  //reset
  score1 = 0;
  score2 = 0;
  myball.setPosition(287.5, 287.5);
  myball.setVelocity(0, 0);
  p1.setPosition(100, height/2);
  p2.setPosition(width - 100, height/2);

  background(darkblue);
  textSize(50);
  fill(white);
  text("Pong Game", 180, 130);
  fill(white);
  stroke(darkblue);
  ellipse(width/2, height/2, 100, 100);
  fill(black);
  textSize(30);
  text("Play", 275, 310);
}

void drawPlaying() {
  
  //setting ball and paddles back once scored
  if (myball.getX() > width + 25) {
    myball.setPosition(200, 287.5); //287.5, 287.5
    myball.setVelocity(0, 0);
    p1.setPosition(100, height/2);
    p2.setPosition(width - 100, height/2);
    score1 += 1;
  }
  if (myball.getX() < -25) {
    myball.setPosition(400, 287.5);
    myball.setVelocity(0, 0);
    p1.setPosition(100, height/2);
    p2.setPosition(width - 100, height/2);
    score2 += 1;
  }
  if (p1.getX() >= 290) p1.setPosition(290, p1.getY());
  if (p2.getX() <= 310) p2.setPosition(310, p2.getY());
  
  //score
  fill(white);
  textSize(30);
  text(score1, 200, 100);
  text("|", 300, 100);
  text(score2, 380, 100);

  if (score1 == 5) {
    mode = GAMEOVER;
  } else if (score2 == 5) {
    mode = GAMEOVER;
  }

  fill(white);
  textSize(20);
  text("| |", width - 20, 20);
}

void drawPause() {
  fill(black, 100);
  rect(-1, -1, width + 5, height + 5);

  fill(white);
  textSize(50);
  text("Paused", 220, 310);
  textSize(30);
  text("PLAY", 260, 350);
  text("HOME", 250, 390);
}

void drawGameover() {

  if (score1 == 5) {
    fill(white);
    textSize(50);
    text("Winner", 100, 310);
    text("Loser", 350, 310);
  } else if (score2 == 5) {
    fill(white);
    textSize(50);
    text("Winner", 350, 310);
    text("Loser", 100, 310);
  }

  fill(white);
  stroke(white);
  rect(240, 365, 109, 50);
  fill(black);
  textSize(30);
  text("Replay", 250, 400);
}