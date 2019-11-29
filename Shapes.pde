void groundAndWall()
{
  beginShape(QUADS);
  noStroke();
  texture(floor);
  vertex(-8.5,-1,8.5,0,0);
  vertex(8.5,-1,8.5,5,0);
  vertex(8.5,-1,-8.5,5,5);
  vertex(-8.5,-1,-8.5,0,5);
  endShape();
 
  beginShape(QUAD);
  texture(wall);
  tint(159,111,89);
  vertex(-8.5,-1,-8.5,0,1);
  vertex(-8.5,1,-8.5,1,1);
  vertex(8.5,1,-8.5,1,0);
  vertex(8.5,-1,-8.5,0,0);
  
  vertex(8.5,-1,-8.5,0,1);
  vertex(8.5,1,-8.5,1,1);
  vertex(8.5,1,8.5,1,0);
  vertex(8.5,-1,8.5,0,0);
  
  vertex(8.5,-1,8.5,0,1);
  vertex(8.5,1,8.5,1,1);
  vertex(-8.5,1,8.5,1,0);
  vertex(-8.5,-1,8.5,0,0);
  
  vertex(-8.5,-1,8.5,0,1);
  vertex(-8.5,1,8.5,1,1);
  vertex(-8.5,1,-8.5,1,0);
  vertex(-8.5,-1,-8.5,0,0);
  tint(255,255,255);
  endShape();
}

void snowman()
{  
  pushMatrix();
  translate(0,-0.4,-2);
  rotateY(snowmanAngle);
  shape(sphere1);
  
  pushMatrix();
  translate(0,0.8,0);
  shape(sphere2);
  popMatrix();
  
  pushMatrix();
  translate(0,0.3,0.55);
  sphere(0.03);
  popMatrix();
  
  pushMatrix();
  translate(0,0.1,0.6);
  sphere(0.03);
  popMatrix();
  
  pushMatrix();
  translate(0,-0.1,0.6);
  sphere(0.03);
  popMatrix();
  
  pushMatrix();
  translate(-0.1,0.85,0.3);
  sphere(0.03);
  popMatrix();
  
  pushMatrix();
  translate(0.1,0.85,0.3);
  sphere(0.03);
  popMatrix();
  
  pushMatrix();
  fill(255,170,0);
  translate(0,0.75,0.35);
  rotateX(radians(90));
  scale(0.08);
  tri3d(nose);
  fill(0,0,0);
  popMatrix();
  
  popMatrix();
  snowmanAngle += 0.03;
}

float giftAngle = 0;
void gifts()
{
  pushMatrix();
  translate(-7.5,-0.5,7.1);
  rotateY(giftAngle);
  scale(-0.3,-0.2);
  cube(side1);
  popMatrix();
  
  pushMatrix();
  translate(-4.5,-0.5,7.3);
  rotateX(-0.3);
  rotateY(-giftAngle);
  scale(-0.1,-0.3, 0.1);
  cube(side2);
  popMatrix();
    
  pushMatrix();
  translate(-1.5, -0.3, 7.3);
  rotateX(-0.5);
  rotateY(giftAngle * 0.5);
  scale(-0.4);
  cube(side3);
  popMatrix();
  
  pushMatrix();
  translate(1.5, -0.5, 7.3);
  rotateY(giftAngle * 1.2);
  scale(-0.4,-0.1,-0.4);
  cube(side4);
  popMatrix();
  
  pushMatrix();
  translate(4.5, -0.5, 7.3);
  rotateY(giftAngle * -0.8);
  scale(-0.2);
  cube(side5);
  popMatrix();
  giftAngle += 0.03;
}

void chimney()
{
  pushMatrix();
  translate(3,-0.5,-4);
  scale(0.5,0.5,0.3);
  cube(chimney);
  
  pushMatrix();
  translate(0,-0.5,1);
  scale(0.7,0.7);
  fire();
  popMatrix();
  
  translate(0,2.5,0);
  scale(0.8,1.7,0.8);
  cube(chimney);
  popMatrix();
}

float[] f = {1,0.9,0.8,0.7,0.6};
float fc = f[(int)(random(f.length))];
void fire()
{
  beginShape(QUAD);
  texture(fire);
  vertex(fc,fc,0,1,0);
  vertex(1,-1,0,1,1);
  vertex(-1,-1,0,0,1);
  vertex(-fc,fc,0,0,0);
  endShape();
  
  if(millis() % 20 == 0)
    fc = f[(int)(random(f.length))];
}

float treeAngle = 0;
float moveTree = 0;
void tree()
{
  pushMatrix();
  if(treeMove)
  {
    if(moveTree > -10)
      moveTree -= 0.05;
  }
  else
  {
    if(moveTree < 0)
      moveTree += 0.05;
  }
  translate(0,0,moveTree);
  pushMatrix();
  light();
  translate(-3,0.7,-3);
  scale(1.3,0.8,1.3);
  tri3d(tree);
  
  translate(0,0.4,0);
  tri3d(tree);
  
  translate(0,0.4,0);
  tri3d(tree);
  
  translate(0,-2,0.5);
  scale(0.3,0.8,0.3);
  cube(treeBark);
  
  stroke(0,255,0);
  strokeWeight(10);
  translate(0,-1,1);
  line(-1,0,1,0);
  noStroke();
  popMatrix();
  popMatrix();
}

color[] colour = {color(255,0,0), color(0,255,0),color(0,0,255), color(252,142,3)};
color clr = colour[0];
color clr2 = colour[1];
color clr3 = colour[2];
float change = 0;
void light()
{
  pushMatrix();
  translate(-3,1.7,-2.55);
  light1();
  light2();
  light3();
  
  pushMatrix();
  translate(-0.2,0,0.2);
  rotateY(radians(90));
  light1();
  light2();
  light3();
  popMatrix();
  
  pushMatrix();
  translate(0.2,0,0.2);
  rotateY(-radians(90));
  light1();
  light2();
  light3();
  popMatrix();
  
  pushMatrix();
  translate(0,0,0.4);
  rotateY(radians(180));
  light1();
  light2();
  light3();
  popMatrix();
  popMatrix();

}
void light1()
{
  pushMatrix();
  strokeWeight(7);
  stroke(clr);
  point(0,0);
  
  pushMatrix();
  translate(0.2,-0.5,-0.25);
  point(0,0);
  popMatrix();
  popMatrix();
  
  if((change == 0 && millis() % 30 == 0) || 
     (change == 1 && millis() % 15 == 0) ||
     (change == 2 && millis() % 2 == 0))
      clr = colour[(int)(random(colour.length))];
}
void light2()
{
  pushMatrix();
  stroke(clr2);
  translate(-0.2,-0.5,-0.25);
  point(0,0);
  
  pushMatrix();
  translate(-0.2,-0.5,-0.2);
  point(0,0);
  noStroke();
  popMatrix();
  popMatrix();
  
  if((change == 0 && millis() % 30 == 0) || 
     (change == 1 && millis() % 15 == 0) ||
     (change == 2 && millis() % 2 == 0))
      clr2 = colour[(int)(random(colour.length))];
}
void light3()
{
  pushMatrix();
  stroke(clr3);
  translate(0.35,-1,-0.4);
  point(0,0);
  
  pushMatrix();
  translate(-0.4,0,0);
  point(0,0);
  noStroke();
  popMatrix(); 
  popMatrix();
  
  if((change == 0 && millis() % 30 == 0) || 
   (change == 1 && millis() % 15 == 0) ||
   (change == 2 && millis() % 2 == 0))
    clr3 = colour[(int)(random(colour.length))];
}

void treeTex()
{
  pushMatrix();
  translate(-3,0,-8.2);
  scale(0.8);
  beginShape(QUAD);
  texture(treeTex);
  vertex(1,1,0,1,0);
  vertex(1,-1,0,1,1);
  vertex(-1,-1,0,0,1);
  vertex(-1,1,0,0,0);
  endShape();
  popMatrix();
}

float tpX = eyeX, tpZ = eyeZ - 1;
void avatar()
{
  pushMatrix();
  fill(236,211,169);
  if(turnR)
  {
    if(face.equals(front))
    {
      translate(tpX += 0.05, eyeY - 1.5, tpZ += 0.05);
      if(tpX >= eyeX + 2) tpX = eyeX;
      if(tpZ >= eyeZ + 2) tpZ = eyeZ - 1;      
    }
    else if(face.equals(right))
    {
      translate(tpX -= 0.05, eyeY - 1.5, tpZ += 0.05);
      if(tpX <= eyeX) tpX = eyeX + 2;
      if(tpZ >= eyeZ + 3) tpZ = eyeZ + 1;
    }
    else if(face.equals(backward))
    {
      translate(tpX -= 0.05, eyeY - 1.5, tpZ -= 0.05);
      if(tpX <= eyeX - 2) tpX = eyeX;
      if(tpZ <= eyeZ + 1) tpZ = eyeZ + 3;      
    }    
    else if(face.equals(left))
    {
      translate(tpX += 0.05, eyeY - 1.5, tpZ -= 0.05);
      if(tpX >= eyeX) tpX = eyeX - 2;
      if(tpZ <= eyeZ - 1) tpZ = eyeZ + 1;      
    }
  }
  else if(turnL)
  {
    if(face.equals(front))
    {
      translate(tpX -= 0.05, eyeY - 1.5, tpZ += 0.05);
      if(tpX <= eyeX - 2) tpX = eyeX;
      if(tpZ >= eyeZ + 2) tpZ = eyeZ - 1;
    }
    if(face.equals(left))
    {
      translate(tpX += 0.05, eyeY - 1.5, tpZ += 0.05);
      if(tpX >= eyeX) tpX = eyeX - 2;
      if(tpZ >= eyeZ + 3) tpZ = eyeZ + 1;
    }
    if(face.equals(backward))
    {
      translate(tpX += 0.05, eyeY - 1.5, tpZ -= 0.05);
      if(tpX >= eyeX + 2) tpX = eyeX;
      if(tpZ <= eyeZ + 1) tpZ = eyeZ + 3;
    }
    if(face.equals(right))
    {
      translate(tpX -= 0.05, eyeY - 1.5, tpZ -= 0.05);
      if(tpX <= eyeX) tpX = eyeX + 2;
      if(tpZ <= eyeZ - 1) tpZ = eyeZ + 1;
    }
  }
  else
  {
    if(face.equals(front))
      translate(eyeX, eyeY - 1.5, eyeZ - 1);
    else if(face.equals(right))
      translate(eyeX + 2, eyeY - 1.5, eyeZ + 1);
    else if(face.equals(backward))
      translate(eyeX, eyeY - 1.5, eyeZ + 3);
    else if(face.equals(left))
      translate(eyeX - 2, eyeY - 1.5, eyeZ + 1);
  }
  sphere(0.2);
  fill(212,145,150);
  translate(0,-0.25,0);
  box(0.4);
  
  fill(66,35,27);
  pushMatrix();
  translate(-0.1,-0.2,0.1);
  box(0.17);
  popMatrix();
  
  pushMatrix();
  translate(0.1,-0.2,0.1);
  box(0.17);
  popMatrix();  
  
  pushMatrix();
  translate(0.1,-0.2,-0.1);
  box(0.17);
  popMatrix();
  
  pushMatrix();
  translate(-0.1,-0.2,-0.1);
  box(0.17);
  popMatrix();
  
  fill(0,0,0);
  popMatrix();
}
void cube(PImage sides)
{
  beginShape(QUADS);
  texture(giftTop);
  vertex(-1, -1, -1, 0,0);
  vertex( 1, -1, -1, 1,0);
  vertex( 1, -1,  1, 1,1);
  vertex(-1, -1,  1, 0,1);
  endShape();
  
  beginShape(QUADS);
  texture(sides);
  vertex(-1, -1,  1, 1,0);
  vertex( 1, -1,  1, 1,1);
  vertex( 1,  1,  1, 0,1);
  vertex(-1,  1,  1, 0,0);
  
  vertex( 1, -1, -1, 1,0);
  vertex(-1, -1, -1, 1,1);
  vertex(-1,  1, -1, 0,1);
  vertex( 1,  1, -1, 0,0);

  vertex( 1, -1,  1, 1,0);
  vertex( 1, -1, -1, 1,1);
  vertex( 1,  1, -1, 0,1);
  vertex( 1,  1,  1, 0,0);
  
  vertex(-1, -1, -1, 1,0);
  vertex(-1, -1,  1, 1,1);
  vertex(-1,  1,  1, 0,1);
  vertex(-1,  1, -1, 0,0);
  endShape();
}

void tri3d(PImage tex)
{
  beginShape(TRIANGLES);
  texture(tex);
  vertex(-0.5,-1, 0,0);
  vertex(0,1,0.5, 1,0);
  vertex(0.5,-1,0, 1,1);
  
  vertex(0.5,-1,0, 0,0);
  vertex(0,1,0.5, 1,0);
  vertex(0.5,-1,1, 1,1);
  
  vertex(-0.5,-1,1, 0,0);
  vertex(0,1,0.5, 1,0);
  vertex(0.5,-1,1, 1,1);
  
  vertex(-0.5,-1,0, 0,0);
  vertex(0,1,0.5, 1,0);
  vertex(-0.5,-1,1, 1,1);  
  endShape();
}
