/* Form and Code: Repeated Boba Drink Pattern
 *
 * Emily Chung
 */

/* Importing controlp5 to add sliders that will change the cup colors
 + adding the variables for them
 */
import controlP5.* ;
ControlP5 cp5 ;

int Cup1Red = 222 ;
int Cup1Green = 207 ;
int Cup1Blue = 245 ;

int Cup2Red = 255 ;
int Cup2Green = 203 ;
int Cup2Blue = 220 ;

/* Declaring variables and assigning them a value to draw the boba cup */

/* Straw Variables */
int sw = 10 ;                   //straw width
int sh = 50 ;                   //straw height
int csh = 3 ;                   //bottom straw height
float str = random (240) ;      //straw r value
float stg = random (240) ;      //straw g value
float stb = random (240) ;      //straw b value
float str1 = random (240) ;     //straw1 r value
float stg1 = random (240) ;     //straw1 g value
float stb1 = random (240) ;     //straw1 b value

/* Cup Variables */
int tcw = 100 ;                //top cup width
int ch = 100 ;                 //cup height
int bcw = tcw/2 ;              //bottom cup width
int tlcx ;                     //top left cup x coordinate
int tcy ;                      //top cup y coordinate
int brcx ;                     //bottom right cup coordinate
int bcy ;                      //bottom cup y coordinate

int ccirh = 20 ;                //cup circle height

/* Boba Variables */
float bsize = tcw*0.07 ;        //boba diameter
float bdis = (2*bsize)-2 ;      //boba distance

int bspeed = 1 ;                //boba speed for movement

float bypos  ;                   //top left boba y coordinate
float bxpos  ;                   //top left boba x coordinate


/* Setting a variable that will determine the offset of the boba,
 * so it can move back and forth
 */
int offset = 0 ;

void setup() {
  size(850, 750) ;
  smooth() ;
  frameRate(35) ;
  cp5 = new ControlP5(this) ;

  /* Creating horizontals sliders that corresponds to the rbg of the cups
   */

  cp5.addSlider("Cup1Red")
    .setPosition((tcw/4), (height - ((3*ch)/4)))
    .setRange(0, 255)
    .setSize(((3*width)/16), 12)
    .setColorLabel(0)
    .setColorForeground(#C60F0F)
    .setColorBackground(#470000)
    .setColorActive(#F69292)
    ;

  cp5.addSlider("Cup1Green")
    .setPosition((tcw/4), (height - ((3*ch)/4))+18)
    .setRange(0, 255)
    .setSize(((3*width)/16), 12)
    .setColorLabel(0)
    .setColorForeground(#28B61F)
    .setColorBackground(#0D3C0A)
    .setColorActive(#9FED9A)
    ;

  cp5.addSlider("Cup1Blue")
    .setPosition((tcw/4), (height - ((3*ch)/4))+36)
    .setRange(0, 255)
    .setSize(((3*width)/16), 12)
    .setColorLabel(0)
    .setColorForeground(#0029D6)
    .setColorBackground(#000347)
    .setColorActive(#89BEFF)
    ;

  cp5.addSlider("Cup2Red")
    .setPosition((width/2), (height - ((3*ch)/4)))
    .setRange(0, 255)
    .setSize(((3*width)/16), 12)
    .setColorLabel(0)
    .setColorForeground(#C60F0F)
    .setColorBackground(#470000)
    .setColorActive(#F69292)
    ;

  cp5.addSlider("Cup2Green")
    .setPosition(width/2, (height - ((3*ch)/4))+18)
    .setRange(0, 255)
    .setSize(((3*width)/16), 12)
    .setColorLabel(0)
    .setColorForeground(#28B61F)
    .setColorBackground(#0D3C0A)
    .setColorActive(#9FED9A)
    ;

  cp5.addSlider("Cup2Blue")
    .setPosition((width/2), (height - ((3*ch)/4))+36)
    .setRange(0, 255)
    .setSize(((3*width)/16), 12)
    .setColorLabel(0)
    .setColorForeground(#0029D6)
    .setColorBackground(#000347)
    .setColorActive(#89BEFF)
    ;
}

void draw() {
  background(#F5F5DC) ;

  // Creating an area so that when pressed, takes a screenshot
  fill(150);
  square ((width - (bcw/2)), (height - (bcw/2)), (bcw/3)) ;

  /* Assigning top left cup x coordinate to 0, so the drawing
   can begin at the left side
   */

  tlcx = 0 ;


  /* Creating the conditionals so that the boba can move back and forth
   in a certain range within each boba cup
   */

  offset += bspeed ;
  if (offset>5) {
    bspeed*=-1 ;
  }
  if (offset<-5) {
    bspeed*=-1 ;
  }

  /* Creating a loop so that the pattern can keep repeating across the size of the canvas
   starts from the top left and goes up along the y coordinate - then restarts at the 0 ycoordinate to go up
   */

  while (tlcx < width) {
    //making the y coordinate of the cup equal to the straw height
    tcy = sh;
    while (tcy < (height-(ch+sh))) {
      /* establishing the bottom right x coordinate and bottom y coordinate of the cup
       to create our cup shape */

      brcx = tlcx + (3*(tcw/4)) ;
      bcy = tcy+ch ;

      //boba cup construction
      fill(Cup1Red, Cup1Green, Cup1Blue) ;
      ellipseMode(CENTER) ;

      stroke(0) ;
      ellipse((brcx-(bcw/2)), bcy, bcw, ccirh) ;                   //bottom circle of the cup

      noStroke();
      quad(tlcx, tcy, tlcx +tcw, tcy, brcx, bcy, brcx-bcw, bcy) ;  //cup shape
      stroke(0) ;
      line(tlcx, tcy, brcx-bcw, bcy) ;                             //cup leftside outline
      line(tlcx+tcw, tcy, brcx, bcy) ;                             //cup rightside outline

      stroke(0) ;
      fill(Cup1Red - 80, Cup1Green - 80, Cup1Blue - 80) ;         //changing fill so it can be darker at the top cup
      ellipse((tlcx+((tcw)/2)), tcy, tcw, ccirh) ;                 //top cup circle

      //straw construction
      fill(str1, stg1, stb1) ;
      rectMode(CORNER);

      ellipse((tlcx+((tcw)/2)), tcy, sw, csh);                            //bottom straw circle

      noStroke();
      rect(tlcx+((tcw/2)-(sw/2)), tcy-sh, sw, sh);                        //straw rect length
      stroke(0);
      line(tlcx+((tcw/2)-(sw/2)), tcy-sh, tlcx+((tcw/2)-(sw/2)), tcy);    //straw leftside outline
      line(tlcx+((tcw/2)+(sw/2)), tcy-sh, tlcx+((tcw/2)+(sw/2)), tcy);    //straw rightside outline

      fill(str1 - 100, stg1 - 100, stb1 - 100) ;                          //changing fill to be darker at straw hole
      ellipse((tlcx+((tcw)/2)), tcy-sh, sw, csh);                         // top straw circle

      //boba construction
      bypos = offset+tcy+(2*ch/3);                         //top left boba y coordinate
      bxpos = offset+tlcx+(tcw/3.5);                       //top left boba x coordinate


      fill(0);
      // position of the bobas
      circle(bxpos, bypos, bsize);
      circle(bxpos + (bsize*2), bypos, bsize);
      circle(bxpos + (bsize*4), bypos, bsize);
      circle(bxpos + (bsize*6), bypos, bsize);
      circle(bxpos + bsize, bypos + bdis, bsize);
      circle(bxpos + (bsize*3), bypos + bdis, bsize);
      circle(bxpos + (bsize*5), bypos + bdis, bsize);
      circle(bxpos + (bsize*2), bypos + (bdis*2), bsize);
      circle(bxpos + (bsize*4), bypos + (bdis*2), bsize);

      //changing the top cup y coordinate to create the repeated pattern vertically
      tcy += ch+sh+(ccirh/2)+(csh/2);
    }

    //changing the top cup x coordinate to create the repeated pattern horizontally or next column
    tlcx+=tcw+bcw;
  }

  //changing the top left corner so that the cup can be upside down between the downside up cups
  tlcx = 0 - (tcw+bcw)/2 ;

  /* between the gaps of the above loop
   Creating a loop so that the pattern can keep repeating across the size of the canvas
   the cup will be upside down - the following code is the same as one above but some construction has different
   arguments so the cup can be drawn upside down
   */

  while (tlcx < width) {
    tcy = sh;
    while (tcy < (height-(ch+sh))) {
      brcx = tlcx + (3*(tcw/4)) ;
      bcy = tcy+ch ;

      //boba cup construction
      fill(Cup2Red, Cup2Green, Cup2Blue);
      ellipseMode(CENTER);
      rectMode(CORNER);

      stroke(0);
      ellipse((tlcx+((tcw)/2)), tcy, bcw, ccirh);

      noStroke();
      quad(tlcx, bcy, tlcx+tcw, bcy, brcx, tcy, brcx-bcw, tcy);
      stroke(0);
      line(tlcx, bcy, brcx-bcw, tcy);
      line(tlcx+tcw, bcy, brcx, tcy);

      stroke(0);
      fill(Cup2Red - 100, Cup2Green - 100, Cup2Blue - 100) ;
      ellipse((brcx-(bcw/2)), bcy, tcw, ccirh);

      //straw construction
      fill(str, stg, stb) ;

      ellipse((tlcx+((tcw)/2)), tcy-(sh+ccirh/2), sw, csh);

      noStroke();
      rect(tlcx+((tcw/2)-(sw/2)), tcy-(sh+ccirh/2), sw, sh);
      stroke(0);
      line(tlcx+((tcw/2)-(sw/2)), tcy-(sh+ccirh/2), tlcx+((tcw/2)-(sw/2)), tcy-(ccirh/2));
      line(tlcx+((tcw/2)+(sw/2)), tcy-(sh+ccirh/2), tlcx+((tcw/2)+(sw/2)), tcy-(ccirh/2));

      fill(str - 100, stg - 100, stb - 100) ;
      ellipse((tlcx+((tcw)/2)), tcy-(ccirh/2), sw, csh);

      //boba contructions
      bypos = tcy+(ch/8)-offset;
      bxpos = offset+tlcx+(tcw/2.25);

      fill(0);
      circle(bxpos, bypos, bsize);
      circle(bxpos + (bsize*2), bypos, bsize);
      circle(bxpos - bsize, bypos + bdis, bsize);
      circle(bxpos + (bsize), bypos + bdis, bsize);
      circle(bxpos + (bsize*3), bypos + bdis, bsize);
      circle(bxpos - (bsize*2), bypos + (bdis*2), bsize);
      circle(bxpos - (bsize/6), bypos + (bdis*2), bsize);
      circle(bxpos + (bsize*2), bypos + (bdis*2), bsize);
      circle(bxpos + (bsize*4), bypos + (bdis*2), bsize);

      //changing the top cup y coordinate to create the repeated pattern vertically
      tcy += ch+sh+(ccirh/2)+(csh/2);
    }

    //changing the top cup y coordinate to create the repeated pattern horizontally
    tlcx+=tcw+bcw;
  }
}

/* When mouse is pressed, a screenshot of the frame will be saved
 */

void mousePressed() {
  if (mouseX > (width - (bcw/2)) && mouseY > (height - (bcw/2))) {
    saveFrame() ;
  }
}
