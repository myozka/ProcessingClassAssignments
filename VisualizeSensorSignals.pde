//variables
String[] val;
int cur = 0;
int[] xvals,yvals,zvals;
int[] x,y,z;
int flag=0;
//end_variables


void setup() {
  //background
  size(600, 360);
  noSmooth();
  stroke(255);
  frameRate(60);
  //end_background
  
  //load data
  val = loadStrings("Accelerometer.txt");
  
  //create arrays for screen data
  xvals = new int[width];
  yvals = new int[width];
  zvals = new int[width];
  //create arrays for accelerometer data
  x = new int[val.length];
  y = new int[val.length];
  z = new int[val.length];
  
  //populate the data arrays (x,y,z)
  crawlValues();
  
}
void crawlValues(){
  int cur=0;
  while (cur < val.length) {
    
    String[] pieces = split(val[cur], ' ');
    if (pieces.length == 3) {
      x[cur] = int(pieces[0]) * 5;
      y[cur] = int(pieces[1]) * 5;
      z[cur] = int(pieces[2]) * 5;
    }
    // Go to the next line for the next run through draw()
    cur = cur + 1;
  }
}
//extra part
void keyPressed() {
  // check if key 'p' is pressed
  if (key == 'p' || key == 'P') {
    // if it is, we should tell draw function to stop drawing
    flag=1;
  }
  if (key == 'r' || key == 'R') {
    // if r is pressed, continue drawing
    flag=0;
  }
  
}


void draw() {
  //chech if it is paused
  if(flag == 0){
    //draw background
    background(102);
    //shift previous screen values
    for(int i = 1; i < width; i++) { 
      xvals[i-1] = xvals[i]; 
      yvals[i-1] = yvals[i];
      zvals[i-1] = zvals[i];
    } 
    // Add the new values to the end of the array 
    xvals[width-1] = x[cur]; 
    yvals[width-1] = y[cur]; 
    zvals[width-1] = z[cur];
    //divide the screen to 3 segments for x, y, and z
    //white background for the second, others are gray
    fill(255);
    noStroke();
    rect(0, height/3, width, height/3+1);
    //print letters 'x','y', and 'z' to the almost middle of the segments
    textSize(32);
    fill(255);
    text("X", 10, height/6);
    fill(0);
    text("Y", 10, height/2);
    fill(255);
    text("Z", 10, 5*height/6);
    //loop to visualize the data 
    for(int i=1; i<width; i++) {
      stroke(255);
      line(i-1,xvals[i-1]/3, i, xvals[i]/3);
      stroke(0);
      line(i-1, height/3+yvals[i-1]/3,i, height/3+yvals[i]/3);
      stroke(255);
      line(i-1, 2*height/3+zvals[i-1]/3,i, 2*height/3+zvals[i]/3);
    }
    //continue to the next data
    cur = cur + 1;
    //if reached to the end, then stop at the last value
    if (cur == val.length)
      cur = cur - 1;
      textSize(16);
      text("Press P to pause, R to continue", 20, height - 20);
  }
}