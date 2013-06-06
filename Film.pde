class Film {

  String name;
  int yr;
  int ranking;
  float targX, x, targY, y;

  void update() {
    x += (targX - x) * .1;
    y += (targY - y) * .1;
  }

  void render() {

      pushMatrix();
      translate(x, y);

      rotate(-PI/2);
      fill(0);
      noStroke();
      rect(0, 0, 100, 2);
    if ( abs(mouseX - x) < 5 ) {

      fill(170);
      textFont(yearLabel);
      text(yr, 90, 105);
      fill(0);
      textFont(filmName);
      text(name, 90, 0 );
    }
      popMatrix();
    
  }
}


