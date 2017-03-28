/*
*CELL/GRID CLASS FOR THE MIDTERM PROJECT
 * AUTHOR: ANDREW HUANG
 * DATE: MAR 24 2017
 *
 */
class Cell {
  int speed, rad, posx, posy;

  Cell(int rad, int posx, int posy, int speed) {
    this.rad = rad;
    this.posx = posx;
    this.posy = posy;
    this.speed = speed;
  }
  void draw() {
    ellipse(posx, posy, rad, rad);
  }
  void animate(int r, int g, int b){
    for (int i = rad; i < rad +30; i++){
      fill(r,g,b);
      ellipse(posx, posy, i, i);
    }
    for (int i = rad+30; i < rad; i--){
      ellipse(posx, posy, i, i);
    }  
  }
  void move(){
    posy += speed;
  }
  int getposx(){
    return posx;
  }
  int getposy(){
    return posy;
  }
  int getspeed(){
    return speed;
  }
  void setspeed(int spd){
    speed = spd;
  }
  void setpos(int x, int y){
    posx = x;
    posy = y;
  }
}

class Grid{
  // both the pieces api and the hitzone api will be coded from this class
  
  Cell[] cells;
  int cols;
  int permute = -1;
  int fillc=0;
  int alph=-1;
  
  Grid(int fillc, int alph, int cols, int w, int h, int AR){
    this.alph = alph;
    this.cols = cols;
    this.fillc = fillc;
    cells = new Cell[cols];
    for (int i =0; i < cols; i++){
      cells[i] = new Cell(50, (int )map(i, 0, cols, 0 , w) + w/cols/2, h, AR);
    }
  }
  void drawGrid(){
    for (int i=0; i < cols; i++){
      if (alph >= 0){
         fill(fillc, alph);
      } else {
        fill(fillc, cells[i].getposy()-20);
      }
      cells[i].draw();
    }
  }
  void moveGrid(){
    for (int i=0; i < cols; i++){
      cells[i].move();
    }
  }
  void moverandom(){
    //moves one at a time.
    if (permute == -1){
      permute = (int) random(0, cols);
    }
    if (cells[permute].getposy() >= 0 && cells[permute].getposy() < height){
      cells[permute].move();
    } else {
      //cells[permute].setspeed(-cells[permute].getspeed());
      cells[permute].setpos(cells[permute].getposx(), 0);
      permute = (int) random(0, cols);
    }
  }
  void bounce(){
    for (int i=0; i < cols; i++){
      if (cells[i].getposx() < 0 || cells[i].getposy()< 0 || cells[i].getposy()> height){
        cells[i].setspeed(-cells[i].getspeed());
      }
    }
  }
  int scoring(int ht, int tolerance){
    // scoring for the balls position, relative to the screen.
    Cell ball = cells[permute];
    if (ball.getposy() <= ht + tolerance && ball.getposy() >=  ht - tolerance){
      ball.animate(51, 252, 255);
      return 300;
    }
    else if (ball.getposy() <= ht + tolerance*2 && ball.getposy() >= ht - tolerance*2){
      ball.animate(51, 255, 60);
      return 200;
    }
    else if (ball.getposy() <= ht + tolerance*3 && ball.getposy() >= ht - tolerance*5){
      ball.animate(255, 94, 51);
      return 100;
    }
    return 0;
  }
}