import processing.opengl.*;

float PHI = 0.618033989;

PFont filmName;
PFont yearLabel;

String[] data;
void setup() {
  background(255);
  size(1300, 758);
  smooth();

  String fileName = "afiFilmList.txt";
  data = loadStrings(fileName);
  println("number of lines of data : " + (data.length - 1));
  for (int i = 0; i < data.length - 1; i++) {
    String[] pieces = split(data[i], TAB);
    println("yesyew" + pieces[0]);
  }


  filmName = createFont("Helvetica", 48);
  yearLabel = createFont("Helvetica", 144);

  randomSeed(47);
}

void draw() {
  background(255);
  
 drawByRow();
}


 void drawByRow(){
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

