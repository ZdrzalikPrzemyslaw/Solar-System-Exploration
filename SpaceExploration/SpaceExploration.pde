PShape s;
PShape t;
PShape o;
PShape statek;
PShape maszt;

void setup() {
  size(1280, 720, P3D);
  noStroke();
  s = loadShape("capsule.obj");
  t = loadShape("teapot.obj");
  o = loadShape("orbitagruba.obj");
  // Statek morski tez może być statkiem kosmicznym ._.
  statek = loadShape("Lodka.obj");
  maszt = loadShape("Maszt.obj");
}

boolean czy_czajnik = false;


// pozycja kamery
float camX = 0;
float camY = 0;
float camZ = 0;
float camDirXVal = 0;
float camDirYVal = 0;
float camDirZVal = 0;
float camDirX = 0;
float camDirY = 0;
float camDirZ = cos(camDirZVal);
float obrotMasztu = 0;

boolean moveForward = false;
boolean moveLeft = false;
boolean moveRight = false;
boolean moveBackwards = false;
boolean moveUp = false;
boolean moveDown = false;
boolean moveCamDirLeft = false;
boolean moveCamDirRight = false;
boolean moveCamDirUp = false;
boolean moveCamDirDown = false;
boolean pause = false;
boolean direction = false;
boolean czyMysz = false;


/**
Ruch statkiem w górę i w dół nie jest zależny od kierunku w który skierowana jest kamera
W - ruch statkiem do przodu
S - ruch statkiem do tyłu 
A - ruch statkiem w lewo
D - ruch statkiem w prawo
Spacja - ruch statkiem do góry
Z - ruch statkiem w dół

Q / ruch myszą w lewo - obrót kamery w lewo
E / ruch myszą w prawo - obrót kamery w prawo
X / mWheelUp - obrót kamery w górę 
C / mWheelDown - obrót kamery w dół

M - uruchomienie kontroli kamery myszą (kontroli klawiaturą nie można wyłączyć)

P - pauza ruchu planet i księżycy
H - zmiana planet w czajniki
I - zmiana kierunku ruchu planet i księżycy

R - reset pozycji kamery i statku
*/

void mouseMoved(){
  if (czyMysz) { 
    float dx = mouseX - pmouseX;
    camDirXVal -= 0.001 * dx;
    camDirZVal -= 0.001 * dx;
    camDirX = sin(camDirXVal);
    camDirZ = cos(camDirZVal);
  }
}

void mouseWheel(MouseEvent event) {
  if (czyMysz) {
    float e = event.getAmount();
    camDirYVal += e * 0.01;
    if (camDirYVal > PI / 2) {
      camDirYVal = PI / 2;
    }
    else if (camDirYVal < -PI / 2) {
      camDirYVal = - PI / 2;
    }
    camDirY = sin(camDirYVal);
  }
}

void keyPressed() {
  if (key == 'H' || key == 'h') {
      czy_czajnik = !czy_czajnik;
  }
  if (key == 'W' || key == 'w') {
    moveForward = true;
  }
  if (key == 'A' || key == 'a') {
    moveLeft = true;
  }
  if (key == 'D' || key == 'd') {
    moveRight = true;
  }
  if (key == 'S' || key == 's') {
    moveBackwards = true;
  }
  if (key == 'R' || key == 'r') {
    camX = 0;
    camY = 0;
    camZ = 0;
    camDirXVal = 0;
    camDirYVal = 0;
    camDirZVal = 0;
    camDirX = 0;
    camDirY = 0;
    camDirZ = cos(camDirZVal);
  }
  if (key == ' ') {
    moveUp = true;
  }
  if (key == 'Z' || key == 'z') {
    moveDown = true;
  }
  if (key == 'Q' || key == 'q') {
    moveCamDirLeft = true;
  }
  if (key == 'E' || key == 'e') {
    moveCamDirRight = true;
  }
  if (key == 'X' || key == 'x') {
    moveCamDirUp = true;
  }
  if (key == 'C' || key == 'c') {
    moveCamDirDown = true;
  }
  if (key == 'P' || key == 'p') {
    pause =! pause;
  }
  if (key == 'I' || key == 'i') {
    direction =! direction;
  }
  if (key == 'M' || key == 'm') {
    czyMysz =! czyMysz;
  }
}

void keyReleased() {
  if (key == 'W' || key == 'w') {
    moveForward = false;
  }
  if (key == 'A' || key == 'a') {
    moveLeft = false;
  }
  if (key == 'D' || key == 'd') {
    moveRight = false;
  }
  if (key == 'S' || key == 's') {
    moveBackwards = false;
  }
  if (key == ' ') {
    moveUp = false;
  }
  if (key == 'Z' || key == 'z') {
    moveDown = false;
  }
  if (key == 'Q' || key == 'q') {
    moveCamDirLeft = false;
  }
  if (key == 'E' || key == 'e') {
    moveCamDirRight = false;
  }
  if (key == 'X' || key == 'x') {
    moveCamDirUp = false;
  }
  if (key == 'C' || key == 'c') {
    moveCamDirDown = false;
  }
}

void move() {
  if (moveForward == true) {
    camZ -= 1 * cos(camDirXVal);
    camX -= 1 * sin(camDirZVal);
  }
  if (moveLeft == true) {
    camX -= 1 * cos(camDirZVal);
    camZ += 1 * sin(camDirXVal);
  }
  if (moveRight == true) {
    camX += 1 * cos(camDirZVal);
    camZ -= 1 * sin(camDirXVal);
  }
  if (moveBackwards == true) {
    camZ += 1 * cos(camDirXVal);
    camX += 1 * sin(camDirZVal);
  }
  if (moveUp == true) {
    camY -= 1;
  }
  if (moveDown == true) {
    camY += 1;
  }
  if (moveCamDirLeft == true) {
    if (obrotMasztu > -1.2) {
      obrotMasztu -=0.01;
    }
    camDirXVal += 0.01;
    camDirZVal += 0.01;
    camDirX = sin(camDirXVal);
    camDirZ = cos(camDirZVal);
  }
  if (moveCamDirRight == true) {
    if (obrotMasztu < 1.2) {
      obrotMasztu +=0.01;
    }
    camDirXVal -= 0.01;
    camDirZVal -= 0.01;
    camDirX = sin(camDirXVal);
    camDirZ = cos(camDirZVal);
  }
  if (moveCamDirUp == true) {
   if (camDirYVal < PI/2) {
     camDirYVal += 0.01;
   }
   else if (camDirYVal > PI/2) {
     camDirYVal = PI/2;
   }
   camDirY = sin(camDirYVal);
  }
  if (moveCamDirDown == true) {
   if (camDirYVal > -PI/2) {
     camDirYVal -= 0.01;
   }
   else if (camDirYVal < -PI/2) {
     camDirYVal = -PI/2;
   }
   camDirY = sin(camDirYVal);
  }
  if (!moveCamDirRight && !moveCamDirLeft) {
    if (obrotMasztu > 0) {
      obrotMasztu -= 0.01;
  }
  else {
    obrotMasztu += 0.01;
    }
  }
}

float time = 0.01;
final int sizeOfSun = 100;

void draw() {
  //lights();
  background(0);
  translate(width/2, height/2, -100);
  
  
  pushMatrix();
    pointLight(255, 255, 255, camX, camY + 20, (height/2.0 + camZ) / tan(PI*30.0 / 180.0));
    pointLight(255, 255, 255, 0, 0, 0);
    //pointLight(255, 255, 255, sizeOfSun, 0, 0);
    //pointLight(255, 255, 255, -sizeOfSun, 0, 0);
    //pointLight(255, 255, 255, 0, sizeOfSun, 0);
    //pointLight(255, 255, 255, 0, -sizeOfSun, 0);
    //pointLight(255, 255, 255, 0, 0, sizeOfSun);
    //pointLight(255, 255, 255, 0, 0, -sizeOfSun);
    
  popMatrix();
  
  
  pushMatrix();
    scale(370, 10 , 370);
    shape(o, 0, 0);
  popMatrix();
  pushMatrix();
    rotateZ(PI/2);
    scale(270, 10, 270);
    shape(o, 0, 0);
  popMatrix();
  pushMatrix();
    rotateZ(PI/4);
    rotateX(0.1);
    scale(282, 6, 282);
    shape(o, 0, 0);
  popMatrix();
   pushMatrix();
    rotateZ(-PI/4);
    rotateX(0.3);
    scale(200, 6, 200);
    shape(o, 0, 0);
  popMatrix();
  
  pushMatrix();
  
    fill(255, 255, 0);
    emissive(255, 255, 0);
    rotate(time);
    if (czy_czajnik) {
      pushMatrix();
        rotate(-PI/8);
        translate(100, 0, 0);
        scale(25);
        rotate(PI);
        rotateX(PI);
            //rotate(time);
        shape(t, 0, 0);
      popMatrix();
      
      
      pushMatrix();
        translate(-50, 110, 0);
        scale(25);
        //rotate(time + PI/2);
        rotateX(PI);
        shape(t, 0, 0);
      popMatrix();
      
    }
    else {
      sphere(sizeOfSun);
    }
    
  popMatrix();
    
  pushMatrix();
  
    emissive(0, 0, 0);
    fill(255, 0, 0);
    lightSpecular(255, 100, 255);
    specular(255, 255, 255);
    shininess(0.9);
    rotateZ(- PI / 4 );
    rotateX(0.3);
    rotateY(2 * time);
    translate(-200, 0, 0);
    spotLight(255, 255, 255, 0, 0, 0, 0, -1, 0, PI/2, 2);
    if (czy_czajnik) {
      scale(23);
      shape(t, 0, 0);
      scale(0.043476261f);
    }
    else {
      sphere(19);
    }
    pushMatrix();
    
      rotateY(time * 4);
      translate(45, 0, 0);
      fill(0, 0, 255);
      lightSpecular(100, 100, 255);
      specular(255, 55, 155);
      shininess(0.5);
      sphere(10);
      
    popMatrix();
    
    pushMatrix();
    
      rotateX(-time * 3);
      translate(0, -30, 0);
      fill(0, 100, 255);
      lightSpecular(100, 20, 255);
      specular(255, 55, 12);
      shininess(0.43);
      sphere(12);
      
    popMatrix();
    
    pushMatrix();
   
      rotateX(time * 1.5);
      rotateY(time * 1.5);
      translate(13, 55, 0);
      fill(255, 128, 255);
      lightSpecular(100, 233, 255);
      specular(255, 55, 123);
      shininess(0.41);
      sphere(13);
      
    popMatrix();
    
    pushMatrix();
    
      rotateX(time * 1.5);
      rotateY(time * 1.5);
      translate(77, 102, 0);
      fill(127, 222, 129);
      lightSpecular(100, 156, 255);
      specular(255, 57, 123);
      shininess(0.69);
      sphere(15);
      
    popMatrix();
    
    pushMatrix();
    
      rotate(time * 2.1);
      translate(123, 21, 0);
      fill(99, 188, 213);
      lightSpecular(123, 156, 255);
      specular(212, 57, 123);
      shininess(0.66);
      sphere(17);
      
    popMatrix();
      
  popMatrix();
  
  pushMatrix();
    rotateX(time * 1.3);
    //rotateZ(time * 1.3);
    rotateY(time * 1.3);
    translate(0, 300);
    pushMatrix();
      fill(123, 233, 101);
      lightSpecular(200, 22, 24);
      specular(100, 255, 200);
      shininess(1.1);
      rotateX(time * 1.4);
      //rotateZ(time * 1.4);
      rotateY(time * 1.4);
      translate(89, 89);
      box(19, 20, 20);
    popMatrix();
    fill(0, 255, 0);
    lightSpecular(255, 255, 255);
    specular(100, 255, 255);
    shininess(0.97);
    if (czy_czajnik) {
      translate(0, -25, 0);
      scale(23);
      shape(t, 0, 0);
      scale(0.043476261f);
    }
    else {
      box(100, 35, 100);
    }
  popMatrix();
  
  pushMatrix();
    //rotateX(time * 1.3);
    //rotateZ(time * 1.3);
    rotateY(time * 1.2);
    translate(400, 0, 0);
    pushMatrix();
      fill(123, 233, 101);
      lightSpecular(200, 178, 224);
      specular(222, 255, 200);
      shininess(0.3);
      rotateX(time * 1.4);
      //rotateZ(time * 1.4);
      rotateY(time * 1.4);
      translate(89, 89);
      box(19, 20, 20);
    popMatrix();
    if (czy_czajnik) {
      translate(0, -25, 0);
      scale(23);
      shape(t, 0, 0);
      scale(0.043476261f);
    }
    else {
    scale(40);
    shape(s, 0, 0);
    scale(1f/40f);
    }
  popMatrix();
  
  pushMatrix();
    translate(0,-25,0);
    rotateZ(PI/4);
    rotateX(0.1);
    rotateY(time * 2);
    translate(282, 0);
    fill(0, 255, 0);
    lightSpecular(255, 255, 255);
    specular(100, 255, 255);
    shininess(1.0);
    scale(23);
    shape(t, 0, 0);
  popMatrix();
  
 
  
  move();
  pushMatrix();
    translate(camX, camY, (height/2.0 + camZ) / tan(PI*30.0 / 180.0) + 100);
    //rotateY(camDirX);
    //rotateX(-camDirY);
    translate(-200 * sin(camDirXVal), 20, -200 * cos(camDirZVal));
    rotateY(camDirXVal);
    rotateX(-camDirYVal);
    rotateX(PI);
    rotateY(-PI/2);
    scale(0.7);
    shape(statek);
  popMatrix();
  
  pushMatrix();
    translate(camX, camY, (height/2.0 + camZ) / tan(PI*30.0 / 180.0) + 100);
    //rotateY(camDirX);
    //rotateX(-camDirY);
    translate(-200 * sin(camDirXVal), 20, -200 * cos(camDirZVal));
    rotateY(camDirXVal);
    rotateX(-camDirYVal);
    rotateX(PI);
    rotateY(-PI/2);
    rotateY(obrotMasztu);
    scale(0.7);
    shape(maszt);
  popMatrix();
  
  camera(width/2.0 + camX, height/2.0 + camY, (height/2.0 + camZ) / tan(PI*30.0 / 180.0), width/2.0 + camX - camDirX, height/2.0 + camY - camDirY, (height/2.0 + camZ) / tan(PI*30.0 / 180.0) - camDirZ, 0, 1, 0);
  // saveFrame("output/frame_####.png");
  if (!pause) {
    if (direction) {
      time += 0.01;
    }
    else {
      time -= 0.01;
    }
  }
}
