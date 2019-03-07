PImage oImage;
PImage nImage;

//names of the die images
String[] imageNames = { "1.png", "2.png", "3.png", "4.png","5.png","6.png","7.png","8.png","9.png","10.png","11.png","12.png" };
PImage[] die = new PImage[imageNames.length];

//Used to add a bit of randomness (so that pure white is not just a white 1 dice) 
int[] chanceToChange= { 80,30,20,10,10,5,5,10,10,20,30,80 };

//scale. The lower, the higher detail/more die
int scl = 8;

int columns, rows, w_die, h_die, w_OImage, h_OImage, w_FImage, h_FImage;

void setup(){
  size(3508  , 4960);

  oImage = loadImage("Kristian.jpg");
  oImage.loadPixels();
  
  // Final image size
  w_FImage = 3508;
  h_FImage = 4960;
  
  //original image size
  w_OImage = oImage.width;
  h_OImage = oImage.height;
  
  //how many rows and columns
  columns = w_OImage/scl;
  rows = h_OImage/scl;
  
  die = new PImage[12];

  //load die array
  for (int i = 0; i < die.length; i++) {
    // Load the image
    PImage img = loadImage(sketchPath("data/die/")+imageNames[i]);
    
    // create and scale to match final image size
    // e.g. w_original image 708, scale is 10, number of die is 70.8. 
    // final image w is 3508 hence each die is 3508/70.8 = 49
    die[i] = createImage(w_FImage/columns, h_FImage/rows, RGB);
    die[i].copy(img, 0, 0, img.width, img.height, 0, 0, w_FImage/columns, h_FImage/rows);
    die[i].loadPixels();
  }  

  nImage = createImage(columns, rows, RGB);
  nImage.copy(oImage, 0, 0, oImage.width, oImage.height, 0, 0, columns, rows);
}
 
void draw() {
  background(255);
  nImage.loadPixels();
 
  // Columns and rows
  for (int x =0; x < columns; x++) {
    for (int y = 0; y < rows; y++) {
      // Draw an image with equivalent brightness to source pixel
      int index = x + y * columns;
      color c = nImage.pixels[index];
      float dieNumber = (brightness(c) / (255/12))-1;

      if (dieNumber < 0)
      dieNumber = 0;
      
      //mix it up a bit
      if (random(99) <= chanceToChange[(int)dieNumber]) 
      {
        if (random(2) < 1){
          dieNumber++;
          }
          else
          dieNumber--;
      }
       if (dieNumber < 0)
      dieNumber = 0;
      else if (dieNumber > 11)
      dieNumber = 11;
      
      image(die[(int)dieNumber], x*w_FImage/columns, y*h_FImage/rows, w_FImage/columns, h_FImage/rows);
    }
  }
  save("new_image");
  noLoop();
}
