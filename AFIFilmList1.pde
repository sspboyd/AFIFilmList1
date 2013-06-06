import processing.opengl.*;

float PHI = 0.618033989;

Film[] films;

PFont filmName;
PFont yearLabel;

String[] data;

void setup() {
  background(255);
  size(1000, 618);
  smooth();


  String fileName = "afiFilmList.txt";
  films=getFilms(fileName);
  for (Film f : films) {
    f.targX = map(f.yr, 1910, 2017, 0, width);
    f.targY = height;
  }

  filmName = createFont("Helvetica", 48);
  yearLabel = createFont("Helvetica", 144);

  randomSeed(47);
}

void draw() {
  background(255);
  pushMatrix();
  translate(0,height);
  rotate(-PI/2);
  fill(200);
  text("1910", 0, 34);
  popMatrix();
  pushMatrix();
  translate(width, height);
  rotate(-PI/2);
    text("2025", 0, 0);
    popMatrix();

  for (Film f : films) {
    f.update();
    f.render();
  }

  //drawByRow();
}


Film[] getFilms(String fn) {
  Film[] films;
  int rowCount = 0;
  String[] data = loadStrings(fn);
  films = new Film[data.length-1];

  println("number of lines of data : " + (data.length - 1));
  for (int i = 0; i < data.length - 1; i++) {
    Film f = new Film();
    String[] pieces = split(data[i], TAB);
    f.x = 0;
    f.y = 0;
    f.name = pieces[0];
    f.yr = int(pieces[1]);
    f.ranking = int(pieces[2]);
    films[rowCount++] = f;
  }
  return films;
}







void drawByRow() {
  for (int i = 0; i < data.length - 1; i++) {
    String[] pieces = split(data[i], TAB);
    int yr = int(pieces[1]);
    // println(yr);
    float rx = map(yr, 1910, 2012, 0, width);
    fill(0);
    noStroke();
    rect(rx, height-100, 2, 100);

    // if mouse is close by then show film name
    if ( abs(mouseX - rx) < 5 ) {
      pushMatrix();
      translate(rx, height);
      rotate(-PI/2);

      fill(170);
      textFont(yearLabel);
      text(pieces[1], 90, 105);
      fill(0);
      textFont(filmName);
      text(pieces[0], 90, 0 );

      popMatrix();
    }
  }
}















// UI and Save Functions___________________________________________

void keyPressed() {
  if (key == 'S') screenCap(".tif");
}

void screenCap(String type) {
  // save functionality in here
  String outputDir = "out/";
  String sketchName = "template-";
  String dateStamp = year() + nf(month(), 2) + nf(day(), 2) + "-" + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  String fileType = type;
  String fileName = outputDir + sketchName + fileType;
  save(fileName);
  println("Screenshot saved to " + fileName);
}

