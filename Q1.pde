PImage floor, wall, giftTop, tree, treeBark, nose, chimney, fire, snowman, treeTex;
PImage side1, side2, side3, side4, side5;
PShape sphere1, sphere2;
PShape[] fireworks = new PShape[3];
void setup()
{
  size(640,640,P3D);
  background(0,0,0);  
  hint(DISABLE_OPTIMIZED_STROKE);
  resetMatrix();
  noStroke();
  sphere1 = createShape(SPHERE, 0.6);
  sphere2 = createShape(SPHERE, 0.3);
  textureMode(NORMAL);
  floor = loadImage("assets/floor.jpg");
  wall = loadImage("assets/wall.jpg");
  giftTop = loadImage("assets/giftTop.png");
  side1 = loadImage("assets/side1.jpg");
  side2 = loadImage("assets/side2.jpg");
  side3 = loadImage("assets/side3.jpg");
  side4 = loadImage("assets/side4.jpg");
  side5 = loadImage("assets/side5.jpg");
  tree = loadImage("assets/tree.jpg");
  treeBark = loadImage("assets/treeBark.jpg");
  treeTex = loadImage("assets/treeTex.png");
  nose = loadImage("assets/nose.jpg");
  chimney = loadImage("assets/chimney.jpg");
  fire = loadImage("assets/fire.png");
  snowman = loadImage("assets/snowman.jpg");
  sphere1.setTexture(snowman);
  sphere2.setTexture(snowman);
  textureWrap(REPEAT);
}
final float SPEED = 0.1;
float eyeX = 0, eyeY = 0, eyeZ = 0, centerX = 0, centerY = 0, centerZ = -5;
PVector position = new PVector(0,0,-5);
boolean back, forward, turnR, turnL;
boolean fireWorks = false;
boolean treeMove = false;
boolean thirdPerson = false;

PVector face = new PVector(0,0,-5);
PVector front = new PVector(0,0,-5);
PVector right = new PVector(5,0,0);
PVector backward = new PVector(0,0,5);
PVector left = new PVector(-5,0,0);

String parsing; //using nf in methods to keep it to one decimal place

float snowmanAngle = 0;
float moveGifts = -12;

float fireY = 2;
void draw()
{
  clear();
  frustum(-1,1,1,-1,1,20);
  translate(0,-0.3,-1);
  
  if(thirdPerson && eyeY <= 1)
    eyeY += 0.1;
  else if(!thirdPerson && eyeY >= 0)
    eyeY -= 0.1;
  
  groundAndWall();
  pushMatrix();
  translate(5,0,4);
  snowman();
  popMatrix();
  
  
  pushMatrix();
  translate(moveGifts += 0.01, 0, 0);
  gifts();
  popMatrix();
  if(moveGifts > 15) moveGifts = -12;
  
  tree();
  if(moveTree < -6.5)
    treeTex();
  chimney();
  
  if(fireWorks && !treeMove)
  {
    fireworks();
    for(int i = 0; i < fireworks.length; i++)
    {
      pushMatrix();
      translate(random(-3.7,-2.5),random(0,1) * fireY,random(-3,-2)); 
      rotate(random(-2,2));
      scale(random(0.05,0.15));
      shape(fireworks[i]);
      popMatrix();
    }
    fireY += 0.03;
    if(fireY > 7) fireY = 2;
  }
  
  forward();
  back();
  turnR();
  turnL();
  avatar(); //<>//
  camera(eyeX, eyeY, eyeZ, centerX, 0, centerZ, 0, 1, 0);  
}

void forward()
{
  if(forward)
  {
    if(face.equals(front))
    {
      eyeZ -= SPEED;
      parsing = nf(eyeZ, 1,1);
      eyeZ = Float.parseFloat(parsing);
      if(eyeZ <= position.z + 4)
      {
        forward = false;
        position.z -= 1;
        centerZ -= 1; 
      }      
    }
    else if(face.equals(right))
    {
      eyeX += SPEED;
      parsing = nf(eyeX, 1,1);
      eyeX = Float.parseFloat(parsing);
      if(eyeX >= position.x - 4)
      {
        forward = false;
        position.x += 1;
        centerX += 1;
      }
    }
    else if(face.equals(backward))
    {
      eyeZ += SPEED;
      parsing = nf(eyeZ, 1,1);
      eyeZ = Float.parseFloat(parsing);
      if(eyeZ >= position.z - 4)
      {
        forward = false;
        position.z += 1;
        centerZ += 1; 
      }      
    }
    else if(face.equals(left))
    {
      eyeX -= SPEED;
      parsing = nf(eyeX, 1,1);
      eyeX = Float.parseFloat(parsing);
      if(eyeX <= position.x + 4)
      {
        forward = false;
        position.x -= 1;
        centerX -= 1;
      }
    }
  }
}

void back()
{
  if(back)
  {
    if(face.equals(front))
    {
      eyeZ += SPEED;
      parsing = nf(eyeZ, 1,1);
      eyeZ = Float.parseFloat(parsing);
      if(eyeZ >= position.z + 6)
      {
        back = false;
        position.z += 1;
        centerZ += 1;
      }
    }
    else if(face.equals(right))
    {
      eyeX -= SPEED;
      parsing = nf(eyeX, 1,1);
      eyeX = Float.parseFloat(parsing);
      if(eyeX <= position.x - 6)
      {
        back = false;
        position.x -= 1;
        centerX -= 1;
      }
    }
    else if(face.equals(backward))
    {
      eyeZ -= SPEED;
      parsing = nf(eyeZ, 1,1); //<>//
      eyeZ = Float.parseFloat(parsing);
      if(eyeZ <= position.z - 6)
      {
        back = false;
        position.z -= 1;
        centerZ -= 1;
      }      
    }
    else if(face.equals(left))
    {
      eyeX += SPEED;
      parsing = nf(eyeX, 1,1);
      eyeX = Float.parseFloat(parsing);
      if(eyeX >= position.x + 6)
      {
        back = false;
        position.x += 1;
        centerX += 1;
      }      
    }
  }
}

void turnR()
{
  if(turnR)
  {
    if(face.equals(front))
    {
      centerX += SPEED;
      parsing = nf(centerX,1,1);
      centerX = Float.parseFloat(parsing);
      centerZ += SPEED;
      parsing = nf(centerZ,1,1);
      centerZ = Float.parseFloat(parsing);
      if(centerX >= position.x + 5 || centerZ >= position.z + 5)
      {
        face.set(5,0,0);
        position.set(eyeX + 5, 0, eyeZ);
        turnR = false;
      }
    }
    else if(face.equals(right))
    {
      centerX -= SPEED;
      parsing = nf(centerX,1,1);
      centerX = Float.parseFloat(parsing);
      centerZ += SPEED;
      parsing = nf(centerZ,1,1);
      centerZ = Float.parseFloat(parsing);
      if(centerX <= position.x - 5 || centerZ >= position.z + 5)
      {
        face.set(0,0,5);
        position.set(eyeX, 0, eyeZ + 5);
        turnR = false;
      }
    }
    else if(face.equals(backward))
    {
      centerX -= SPEED;
      parsing = nf(centerX,1,1);
      centerX = Float.parseFloat(parsing);
      centerZ -= SPEED;
      parsing = nf(centerZ,1,1);
      centerZ = Float.parseFloat(parsing);
      if(centerX <= position.x - 5 || centerZ <= position.z - 5)
      {
        face.set(-5,0,0);
        position.set(eyeX - 5, 0, eyeZ);
        turnR = false;
      } 
    }
    else if(face.equals(left))
    {
      centerX += SPEED;
      parsing = nf(centerX,1,1);
      centerX = Float.parseFloat(parsing);
      centerZ -= SPEED;
      parsing = nf(centerZ,1,1);
      centerZ = Float.parseFloat(parsing);
      if(centerX >= position.x + 5 || centerZ <= position.z - 5)
      {
        face.set(0,0,-5);
        position.set(eyeX, 0, eyeZ - 5);
        turnR = false;
      }
    }
  }
}

void turnL()
{
  if(turnL)
  {
    if(face.equals(front))
    {
      centerX -= SPEED;
      parsing = nf(centerX,1,1);
      centerX = Float.parseFloat(parsing);
      centerZ += SPEED;
      parsing = nf(centerZ,1,1);
      centerZ = Float.parseFloat(parsing);
      if(centerX <= position.x - 5 || centerZ >= position.z + 5)
      {
        face.set(-5,0,0);
        position.set(eyeX - 5, 0, eyeZ);
        turnL = false;
      }
    }
    else if(face.equals(right))
    {
      centerX -= SPEED;
      parsing = nf(centerX,1,1);
      centerX = Float.parseFloat(parsing);
      centerZ -= SPEED;
      parsing = nf(centerZ,1,1);
      centerZ = Float.parseFloat(parsing);
      if(centerX <= position.x - 5 || centerZ <= position.z - 5)
      {
        face.set(0,0,-5);
        position.set(eyeX, 0, eyeZ - 5);
        turnL = false;
      }
    } 
    else if(face.equals(backward))
    {
      centerX += SPEED;
      parsing = nf(centerX,1,1);
      centerX = Float.parseFloat(parsing);
      centerZ -= SPEED;
      parsing = nf(centerZ,1,1);
      centerZ = Float.parseFloat(parsing);
      if(centerX >= position.x + 5 || centerZ <= position.z - 5)
      {
        face.set(5,0,0);
        position.set(eyeX + 5, 0, eyeZ);
        turnL = false;
      }
    }
    else if(face.equals(left))
    {
      centerX += SPEED;
      parsing = nf(centerX,1,1);
      centerX = Float.parseFloat(parsing);
      centerZ += SPEED;
      parsing = nf(centerZ,1,1);
      centerZ = Float.parseFloat(parsing);
      if(centerX >= position.x + 5 || centerZ >= position.z + 5)
      {
        face.set(0,0,5);
        position.set(eyeX, 0, eyeZ + 5);
        turnL = false;
      }
    }
  }
}

void keyPressed() {
  switch (key) {
  case 'w':
    if(validFor() && ((face.equals(front) && eyeZ > -8) || (face.equals(right) && eyeX < 7) 
        || (face.equals(backward) && eyeZ < 4) || (face.equals(left) && eyeX > -7)))
        if(!back && !turnR && !turnL)
         forward = true;
         break;
  case 's':
    if(validBack() && ((face.equals(front) && eyeZ < 4) || (face.equals(right) && eyeX > -7) 
        || (face.equals(backward) && eyeZ > -8) || (face.equals(left) && eyeX < 7)))
        if(!forward && !turnR && !turnL)
          back = true;
          break;
  case 'd':
    if(!forward && !back && !turnL)
      turnR = true;
      break;
  case 'a':
    if(!forward && !back && !turnR)
      turnL = true;
      break;
  case ' ':
    thirdPerson = !thirdPerson;    
  }
  if(face.equals(front)){ tpX = eyeX; tpZ = eyeZ - 1; }
  else if(face.equals(right)){ tpX = eyeX + 2; tpZ = eyeZ + 1; }
  else if(face.equals(backward)){ tpX = eyeX; tpZ = eyeZ + 3; }
  else if(face.equals(left)){ tpX = eyeX - 2; tpZ = eyeZ + 1; }
}

void mouseClicked()
{
  float x = 2 * mouseX;
  x /=  width - 1;
  float y = 2 * (height-mouseY+1);
  y /= height - 1;  
  if(eyeX == -3 && eyeZ == -1 && position.x == -3 && position.z == -6)
  {
    if(x >= 0.8 && x <= 1.19 && y <= 0.76 && y >= 0.39) //<>//
    {
      change++;
      if(change >= 4)
        change = 0; 
    }
    else if(x >= 0.72 && x <= 1.28 && y <= 0.96 && y >= 0.77)
    {
      fireWorks = !fireWorks;
    }
    else if(x >= 0.73 && x <= 1.27 && y <= 1.15 && y >= 0.96)
    {
        treeMove = true;
        fireWorks = false;
    }
  }
  else if(eyeX == -3 && eyeZ == -8 && position.x == -3 && position.z == -13)
  {
    if(x >= 0.38 && x <= 1.58 && y <= 1.34 && y >= 0.16)
      treeMove = false;
  }
}

float x,z;
boolean validFor()
{
  ArrayList<PVector> coords = new ArrayList<PVector>();
  if(face.equals(front))
  {
    for(int i = 0; i < 9; i++)
    {
      if(i == 0 && !treeMove) { x = -2;  z = -6;}
      else if(i == 3) { x = 4; z = -8; }
      else if(i == 6) { x = 6; z = -2; }
        coords.add(new PVector(x--,0,z));
    }
  }
  else if(face.equals(right))
  {
    for(int i = 0; i < 9; i++)
    {
      if(i == 0 && !treeMove) { x = 0;  z = -2;}
      else if(i == 3) { x = 6; z = -4; }
      else if(i == 6) { x = 8; z = 2; }
        coords.add(new PVector(x,0,z--));
    }
  }
  else if(face.equals(backward))
  {
    for(int i = 0; i < 9; i++)
    {
      if(i == 0 && !treeMove) { x = -2;  z = 0;}
      else if(i == 3) { x = 4; z = -2; }
      else if(i == 6) { x = 6; z = 4; }
        coords.add(new PVector(x--,0,z));
    }
  }
  else if(face.equals(left))
  {
    for(int i = 0; i < 9; i++)
    {
      if(i == 0 && !treeMove) { x = -6;  z = -2;}
      else if(i == 3) { x = 0; z = -4; }
      else if(i == 6) { x = 2; z = 2; }
        coords.add(new PVector(x,0,z--));
    }
  }
  PVector center = new PVector(centerX, centerY, centerZ);
  if(coords.contains(center))  
    return false;
  return true;
}

boolean validBack()
{
  ArrayList<PVector> coords = new ArrayList<PVector>();
  if(face.equals(front))
  {
    for(int i = 0; i < 9; i++)
    {
      if(i == 0 && !treeMove) { x = -2;  z = -10;}
      else if(i == 3) { x = 4; z = -12; }
      else if(i == 6) { x = 6; z = -6; }
        coords.add(new PVector(x--,0,z));
    }
  }
  else if(face.equals(right))
  {
    for(int i = 0; i < 9; i++)
    {
      if(i == 0 && !treeMove) { x = 4;  z = -2;}
      else if(i == 3) { x = 10; z = -4; }
      else if(i == 6) { x = 12; z = 2; }
        coords.add(new PVector(x,0,z--));
    }
  }
  else if(face.equals(backward))
  {
    for(int i = 0; i < 9; i++)
    {
      if(i == 0 && !treeMove) { x = -2;  z = 4;}
      else if(i == 3) { x = 4; z = 2; }
      else if(i == 6) { x = 6; z = 8; }
        coords.add(new PVector(x--,0,z));
    }
  }
  else if(face.equals(left))
  {
    for(int i = 0; i < 9; i++)
    {
      if(i == 0 && !treeMove) { x = -10;  z = -2;}
      else if(i == 3) { x = -4; z = -4; }
      else if(i == 6) { x = -2; z = 2; }
        coords.add(new PVector(x,0,z--));
    }
  }
  PVector center = new PVector(centerX, centerY, centerZ);
  if(coords.contains(center))  
    return false;
  return true;
}

void fireworks()
{
  PShape rect = createShape(RECT, 0,0,1,1);
  PShape circle = createShape(ELLIPSE, 0,0,1,1);
  PShape tri = createShape(TRIANGLE, -1,-1,0,1,1,-1);
  
  rect.setFill(color(random(255),random(255),random(255)));
  circle.setFill(color(random(255),random(255),random(255)));
  tri.setFill(color(random(255),random(255),random(255)));
  
  fireworks[0] = rect;
  fireworks[1] = circle;
  fireworks[2] = tri;
}
