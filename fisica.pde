

/*import ddf.minim.*;
 import ddf.minim.analysis.*;
 import ddf.minim.effects.*;
 import ddf.minim.signals.*;
 import ddf.minim.spi.*;
 import ddf.minim.ugens.*;
 */
import processing.sound.*;
SoundFile file;

import fisica.*;
float mover=0;
boolean empezarTiempo;
int cambia=0;
int etapaUno=0;
int etapaDos=2;
int etapaTres=4;
int estado=1;
int contador=0;
int c= 0; //contador 1
int salen=150; //tiempo que tardan en salir las notas
int c2= 0; //contador 2
int c3=0;//contador 3
int a=150;
int opo=3; //oportunidades
int progreso;
int frase, fraseGanar; //estado perder-ganar
////////Efecto radio
int cantImg= 3;
int cantImgA= 6;
int cantImgR= 9;
int indexImg= 0;
////////
PImage [] efectoRadioVerde = new PImage [cantImgR];
PImage [] efectoRadioAmarillo = new PImage [cantImgR];
PImage [] efectoRadioRojo = new PImage [cantImgR];
//PImage[] rojo, verde, amarillo;
String [] textosPerder, textosGanar; //estado perder-ganar
boolean botonPresionado;
PImage fondoInicio, tituloInicio, tituloPerder, tituloGanar, instrucciones, botonInicio, botonJugar, botonReintentar, bailarines, radio, fondoJugando;

String [] nombre={"frag00", "frag01", "frag02", "frag03", "frag04", "frag05", "fragmento06"};
PImage[] barra;
PImage[] barraColor;
FWorld mundo;
Parlante p;
//Minim minim;
SoundFile error;
SoundFile perdiste;
SoundFile bien;
SoundFile chifle;
SoundFile cancion;
SoundFile amorSalvaje;
SoundFile ganar;
SoundFile[] fragmento;
int numeroDeFragmento=0;
boolean cambiarEstado=false;
//----sonido----
int tiempo= 2900;
int tiempo2= 18000;
int marcaDeTiempo=0;
int marcaDeTiempo2=0;
int marcaDeTiempo4=0;// marca para reiniciar la que mueve
int marcaDeTiempo3=0;//marca que mueve
boolean [] entroFragmento;
boolean salenNotas=false;
PImage [] barraProgreso;
PImage [] gauchos;
PImage [] empanadas;
PFont fuenteTexto;
//----sonido----
//creamos una caja
//FBox caja;
FMouseJoint golpea;
FCircle circulo;
FBox caja; //este es el parlante
FBox meta; //este es la pareja
//PImage nota1, nota2, nota3;
FBox borde;
FBox bordeA;
void setup() { 
  //minim=new Minim(this);
  size(1800, 600);
  barra= new PImage[10];
  barraColor= new PImage[10];
  entroFragmento= new boolean[30];
  amorSalvaje= new SoundFile(this, "amorSalvajeInstrumental.wav");
  ganar= new SoundFile(this, "ganar.wav");
  error= new SoundFile (this, "error.mp3");
  bien= new SoundFile (this, "bien.wav");
  //cancion= new SoundFile (this, "chaqueño.mp3");
  fragmento=new SoundFile[7];
  chifle= new SoundFile(this, "chifle.mp3");
  perdiste= new SoundFile(this, "chaqueño_editado.mp3");
  barraProgreso= new PImage[30] ;
  gauchos=new PImage[6];
  empanadas = new PImage[4];
  //////Efecto radio
  for (int i = 0; i <efectoRadioVerde.length; i++) {
    efectoRadioVerde[i] = loadImage("sonidoVerde0" + i + ".png" );
  }
  for (int i = 0; i <efectoRadioAmarillo.length; i++) {
    efectoRadioAmarillo[i] = loadImage("sonidoAmarillo0" + i + ".png" );
  }
  for (int i = 0; i <efectoRadioRojo.length; i++) {
    efectoRadioRojo[i] = loadImage("sonidoRojo0" + i + ".png" );
  }

  //verde=new PImage[3];
  //amarillo=new PImage[3];
  //rojo=new PImage[3];
  fuenteTexto = createFont("PatrickHand-Regular.ttf", 50);
  textFont(fuenteTexto);
  //for(int i=0; i<5; i++){
  //    text(textosGanar[frase], width/2, height/2);
  //}
  for (int i=0; i<6; i++) {
    fragmento [i]= new SoundFile(this, nombre[i]+".wav");
    barraProgreso[i]= loadImage("imagenes/progreso"+ i +".png");
  }
  for (int i=0; i<6; i++) {

    gauchos[i]= loadImage("imagenes/bailarines"+ i +".png");
    gauchos[i].resize(400, 400);
  }
  for (int i=0; i<4; i++) {

    empanadas[i]= loadImage("imagenes/empanada"+ i +".png");
  }
  //for (int i=0; i<3; i++) {

  //  verde[i]= loadImage("sonidoVerde0"+ i +".png");
  //}

  //for (int i=0; i<3; i++) {

  //  amarillo[i]= loadImage("sonidoAmarillo0"+ i +".png");
  //}

  //for (int i=0; i<3; i++) {

  //  rojo[i]= loadImage("sonidoRojo0"+ i +".png");
  //}



  for (int i=0; i<10; i++) {

    barra[i]= loadImage("barra0"+ i +".png");
  }
  for (int i=0; i<10; i++) {

    barraColor[i]= loadImage("barracolor0"+ i +".png");
  }
  empanadas[3].resize(200, 100);
  empanadas[2].resize(145, 100);
  empanadas[1].resize(92, 100);
  amorSalvaje.loop();
  //amorSalvaje.amp(0.1);
  ganar.amp(0.2);
  //imagenes
  fondoInicio = loadImage("imagenes/fondoInicio.png");
  tituloInicio = loadImage("imagenes/tituloAentro.png");
  tituloPerder = loadImage("imagenes/tituloPerdiste.png");
  tituloGanar = loadImage("imagenes/tituloGanaste.png");
  instrucciones = loadImage("imagenes/instrucciones.png");
  botonInicio = loadImage("imagenes/botonInicio.png");
  botonJugar = loadImage("imagenes/botonJugar.png");
  botonReintentar = loadImage("imagenes/botonReintentar.png");
  //bailarines = loadImage("imagenes/bailarines.png");
  radio = loadImage("imagenes/radio.png");
  fondoJugando = loadImage("imagenes/fondo-jugando.png");
  //resize bailarines
  //bailarines.resize(400, 450);




  //textos
  textosPerder = loadStrings("imagenes/perder.txt"); 
  textosGanar = loadStrings("imagenes/ganar.txt"); 
  // circulo=new FCircle(10);
  Fisica.init(this);
  mundo = new FWorld();
  caja=new FBox(10, 10);
  meta=new FBox(400, 380);
  borde=new FBox(20, height+1000);
  bordeA= new FBox(10000, 10);
  meta.setStatic(true);
  meta.setName("meta");
  caja.setPosition(width/2, height/2);
  caja.setNoStroke();
  borde.setStatic(true);
  bordeA.setStatic(true);
    borde.setNoFill();
  bordeA.setNoFill();
  golpea= new FMouseJoint(caja, width/2, height/2); //Le hago un joint al rectangulo para conectarlo al mouse
  p = new Parlante (70, 70);
  //circulo.setName("nota");
  //para agregarle bordes al mundo y los elementos no se escapen
  // mundo.setEdges();

  caja.setRotatable(false); //para que no se gire el rectangulo cuando golpea las notas
  borde.setNoStroke();
  bordeA.setNoStroke();
  meta.setNoFill();
  caja.setNoFill();
  //cancion.play();
}

void draw() {

  if (estado==1) {

    salenNotas=false;
    //------------------------------prueba---------------------------
    for (int b=0; b<6; b++) {
      entroFragmento[b]=false;
    }
    contador++;
    c=0;
    //------------------------------prueba---------------------------
    numeroDeFragmento=0;


    perdiste.stop();
    //background(255);
    background(fondoInicio);
    image(botonJugar, width*0.43, height*0.71);
    image(tituloInicio, width/2-265, 70);
    image(instrucciones, width*0.39, height*0.4);
    ganar.stop();
    botonCustom("play", 2, round(width*0.43), round(height*0.71), 235, 83);
    opo=3;
    progreso=0;
  }
  if (estado==2) {


    //------------------------------------------------prueba de sonido------------------------------------------------
    salenNotas =true;
    amorSalvaje.amp(0.03);

    marcaDeTiempo=millis()-marcaDeTiempo2;
    for (int z=0; z<6; z++) {
      if (entroFragmento[z]==true) {
        fragmento[z].amp(0.2);
      }
    }
    for (int z=0; z<6; z++) {
      if (entroFragmento[z]==true) {
        amorSalvaje.amp(0.03);
      }
    }

    if (entroFragmento[0]==true && marcaDeTiempo>tiempo) {

      //fragmento[numeroDeFragmento].play();
      marcaDeTiempo2=millis();
      fragmento[numeroDeFragmento].play();
      fragmento[numeroDeFragmento].amp(0.0);
      numeroDeFragmento++;
    }
    if (numeroDeFragmento>5) {
      numeroDeFragmento=0;
    }
    if (entroFragmento[0]==true) {
      marcaDeTiempo3=millis()-marcaDeTiempo4;
    }

    if (entroFragmento[0]==true && marcaDeTiempo3>tiempo2) {


      marcaDeTiempo4=millis();
    }

    println(cambia);












    //------------------------------------------------prueba de sonido------------------------------------------------

    perdiste.stop();
    fragmento[numeroDeFragmento].amp(0.4);
    meta.setNoStroke();
    meta.setPosition(1500, 370); //rectangulo bailarines
    p.oportunidades(error);
    c++;
    c2++;
    background(255);
    textSize(15);
    text("contador:"+ c, 60, 30);
    text("progreso:"+ progreso, 1000, 30);
    textSize(20);
    fill(#000000);
    text("oportunidades:"+ opo, 60, 490);
    image(fondoJugando, 0, 0);
    golpea.setTarget(mouseX, mouseY); //Con esto el rectangulo sigue al mouse
    //para que hagan todos los calculos matematicos entre los cuerpos que interactuan ¿¿
    mundo.step();
    //dibuja el mundo de fisica
    mundo.draw();
    if (opo==3) {  
      image(efectoRadioVerde[indexImg], 100, 110);
      indexImg = (indexImg+1) % efectoRadioVerde.length;
      //for (int i=0; i<3; i++) {

      //  image(verde[i], 150, 150);
      //}
    }

    if (opo==2) {    
      //for (int i=0; i<3; i++) {

      //  image(amarillo[i], 150, 150);
      //}
      image(efectoRadioAmarillo[indexImg], 100, 110);
      indexImg = (indexImg+1) % efectoRadioAmarillo.length;
    }

    if (opo==1) {    
      //for (int i=0; i<3; i++) {

      //  image(rojo[i], 150, 150);
      //}
      image(efectoRadioRojo[indexImg], 110, 120);
      indexImg = (indexImg+1) % efectoRadioRojo.length;
    }



    image(gauchos[cambia], 1400, 160);

    if (opo==3) {
      cambia=etapaUno;
    }
    if (opo==2) {
      cambia=etapaDos;
    }
    if (opo==1) {
      cambia=etapaTres;
    }

    if (c>=salen && salenNotas==true) {
      p.dibujarNotas(mundo);
      c=0;
    }
    //Si c2 es mayor a 600 las notas van a salir mas rapido, empieza a contar c3
    if (c2>600) {
      c3++;
      mundo.setGravity(-2000, 0);
    }
    if (c2==600) {
      chifle.play();
    }
    // cuando c3 llega a 800 vuelven a salir con normalidad
    if (c3>=100) {
      c2=0;
      c3=0;
      mundo.setGravity(100, 100);
    }

    p.dibujar();
    image(radio, 10, 10);
    //  rect(500, 10, progreso*10, 10);
    // image(barraProgreso[progreso], 680, 10);

    //Barra sin pintar
    if (entroFragmento[0]==false) {
      image(barra[0], 600, 20);
    }
    if (entroFragmento[0]==false) {
      image(barra[1], 660, 20);
    }
    if (entroFragmento[1]==false) {
      image(barra[2], 695, 20);
    }
    if (entroFragmento[1]==false) {
      image(barra[3], 710, 20);
    }
    if (entroFragmento[2]==false) {
      image(barra[4], 760, 20);
    }
    if (entroFragmento[2]==false) {
      image(barra[5], 815, 20);
    }
    if (entroFragmento[3]==false) {
      image(barra[6], 870, 20);
    }
    if (entroFragmento[3]==false) {
      image(barra[7], 920, 20);
    }
    if (entroFragmento[4]==false) {
      image(barra[8], 980, 20);
    }
    if (entroFragmento[5]==false) {
      image(barra[9], 1000, 20);
    }

    //Barra pintada, cambia segun el fragmento que entre
    if (entroFragmento[0]==true) {
      image(barraColor[0], 600, 20);
    }
    if (entroFragmento[0]==true) {
      image(barraColor[1], 660, 20);
    }
    if (entroFragmento[1]==true) {
      image(barraColor[2], 695, 20);
    }
    if (entroFragmento[1]==true) {
      image(barraColor[3], 710, 20);
    }
    if (entroFragmento[2]==true) {
      image(barraColor[4], 760, 20);
    }
    if (entroFragmento[2]==true) {
      image(barraColor[5], 815, 20);
    }
    if (entroFragmento[3]==true) {
      image(barraColor[6], 870, 20);
    }
    if (entroFragmento[3]==true) {
      image(barraColor[7], 920, 20);
    }
    if (entroFragmento[4]==true) {
      image(barraColor[8], 980, 20);
    }
    if (entroFragmento[5]==true) {
      image(barraColor[9], 1000, 20);
    }
    //mapeo la marca de tiempo 

    if (numeroDeFragmento==0) {
      barra[0].resize(68, 65);
      barra[1].resize(42, 65);
    } else {  
      barra[0].resize(62, 59);
      barra[1].resize(38, 59);
    }
    if (numeroDeFragmento==1) {
      barra[2].resize(130, 65);
      barra[3].resize(57, 65);
    } else { 
      barra[2].resize(118, 59);
      barra[3].resize(52, 59);
    }
    if (numeroDeFragmento==2) {
      barra[4].resize(63, 65);
      barra[5].resize(69, 65);
    } else { 
      barra[4].resize(58, 59);
      barra[5].resize(63, 59);
    }

    if (numeroDeFragmento==3) {
      barra[6].resize(62, 65);
      barra[7].resize(68, 65);
    } else { 
      barra[6].resize(57, 59);
      barra[7].resize(62, 59);
    }
    if (numeroDeFragmento==4) {
      barra[8].resize(32, 65);
    } else { 
      barra[8].resize(30, 59);
    }
    if (numeroDeFragmento==5) {
      barra[9].resize(42, 65);
    } else { 
      barra[9].resize(38, 59);
    }
    //barrita que se mueve
    rect(mover, 50, 2, 60);

    image(empanadas[opo], 1580, 20);

    if (opo<=0) {
      estado=3;
      fragmento[numeroDeFragmento].stop();
      perdiste.play();
      frase = round(random(0, 4));
    }
    if (progreso>=15 || entroFragmento[0] && entroFragmento[1] && entroFragmento[2] && entroFragmento[3] && entroFragmento[4] && entroFragmento[5]) {
      estado=4;
      //fragmento[numeroDeFragmento].stop();
      ganar.play();
      fraseGanar = round(random(0, 2));
      amorSalvaje.stop();
    }
  }
  if (estado==3) {
    salenNotas=false;
    push();
    textAlign(CENTER);
    textSize(50);
    //text("perdiste", width/2, height/2);
    image(fondoInicio, 0, 0);
    text(textosPerder[frase], width/2, height/2);

    image(tituloPerder, width/2-245.5, 70);
    image(botonReintentar, width/2-150.5, height/4*3-20);
    botonGanar("Menu", 1, round(width/2-150.5), round(height/4*3-20), 301, 85);
    contador++;
    c=0;
    pop();
    mundo.clear();
  }

  if (estado==4) {
    salenNotas=false;
    background(255);
    image(fondoInicio, 0, 0);
    push();
    textAlign(CENTER);
    textSize(50);
    text(textosGanar[fraseGanar], width/2, height/2);
    image(tituloGanar, width/2-245, 70);
    image(botonInicio, width/2-117.5, height/4*3-20);
    botonGanar("Menu", 1, round(width/2-117.5), round(height/4*3-20), 213, 83);
    amorSalvaje.stop();
    error.stop();
    bien.stop();
    chifle.stop();
    pop();
    contador++;
    c=0;
    mundo.clear();
  }


  println(estado, cambiarEstado);
}
void contactStarted(FContact contacto) {
  FBody body1=contacto.getBody1();
  FBody body2=contacto.getBody2();
  tiempo++;

  if ( body1.getName() != null && body2.getName() !=null && body1.getName() != body2.getName()) {
    entroFragmento[numeroDeFragmento]=true;
    //numeroDeFragmento++;


    mundo.remove(body2);
    // println(body1.getName(), "colisiono");
    progreso++;
    empezarTiempo=true;
    //cambia++;
    if (opo==3) {
      etapaUno++;
    }
    if (opo==2) {
      etapaDos++;
    }
    if (opo==1) {
      etapaTres++;
    }

    if (etapaUno>1 && opo==3) {
      etapaUno=0;
    }
    if (etapaDos>3 && opo==2) {
      etapaDos=2;
    }

    if (etapaTres>5 && opo==1) {
      etapaTres=4;
    }
  }
}



void botonCustom(String textoB, int queEstado, int x, int y, int posx, int posy) {
  pushStyle();
  if (mouseX > x && mouseX < posx +x && mouseY > y && mouseY < posy + y ) {
    //fill(245, 190, 247);
    if (mousePressed==true && contador>=50) {
      botonPresionado=true;
      estado=queEstado;
      //fill(230, 133, 232);
      contador=0;
      mundo.add(meta);
      mundo.add(caja);
      mundo.add(golpea);
      mundo.add(borde);
      mundo.add(bordeA);
    }
  } else {
    //fill(100, 200, 200);
    //botonPresionado=false;
  }
  //rect(x, y, posx, posy, 45);
  fill(255, 0, 0);

  //textSize(15);
  //text(textoB, x+posx/2, y+posy/2);
  popStyle();
}
void botonGanar(String textoB, int queEstado, int x, int y, int posx, int posy) {
  pushStyle();

  if (mouseX > x && mouseX < posx +x && mouseY > y && mouseY < posy + y ) {
    //fill(245, 190, 247);
    if (mousePressed==true&& contador>=50) {
      //amorSalvaje.loop();
      contador=0;
      estado=queEstado;
      //fill(230, 133, 232);
      mundo.add(meta);
      mundo.add(caja);
      mundo.add(golpea);
      mundo.add(borde);
      mundo.add(bordeA);
    }
  } else {
    fill(100, 200, 200);
    //botonPresionado=false;
  }

  popStyle();
}
