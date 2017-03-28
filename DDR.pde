/*
*DDR MAIN CLASS FOR THE MIDTERM PROJECT
* AUTHOR: ANDREW HUANG
* DATE: MAR 24 2017
*
*/ 
final int COLS = 3;
final int wid = 1000;
final int ht = 500;
final int tolerance = 10; // no one is perfect
final int AR = 5; //ms of approach rate

import processing.serial.*;
Serial myPort;
int val, value;

void setup(){
   size(1000,500, P2D); // manually set COLS and wid,  weird bug
   printArray(Serial.list());
   myPort = new Serial(this, Serial.list()[2], 9600);
}

// GRID( color, alpha=-1, columns, width, height, approach rate);

Grid g = new Grid(100, -1, COLS, wid, 0, AR); // starts at top.

Grid hz = new Grid(255, 0, COLS, wid, ht-35, 0); // hitzone on bottom.

int score = 0;

void draw(){
  //background(0);
  noStroke();
  gradientRect(0, 0, wid, ht, #AEC6CF, #B39EB5);
  //fill(100);
  g.drawGrid();
  g.moverandom();
  stroke(255);
  strokeWeight(5);
  hz.drawGrid();
}
void keyPressed(){
   score += g.scoring(ht - 35, tolerance);
   println(score);
}

void gradientRect(int x, int y, int w, int h, color c1, color c2) {
  beginShape();
  fill(c1);
  vertex(x,y);
  vertex(x+w,y);
 
  fill(c2);
  vertex(x+w,y+h);
  vertex(x,y+h);
  endShape();
}