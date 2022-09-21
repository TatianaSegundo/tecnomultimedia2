

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
boolean empezarTiempo;
int cambia=0;
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
String [] textosPerder, textosGanar; //estado perder-ganar
boolean botonPresionado;
PImage fondoInicio, tituloInicio, tituloPerder, tituloGanar, instrucciones, botonInicio, botonJugar, botonReintentar, bailarines, radio, fondoEstado2;
/*String [] nombre={"fragmento02", "fragmento03", "fragmento04", "fragmento05", "fragmento06", 
  "fragmento07", "fragmento08", "fragmento09", "fragmento010", "fragmento011", "fragmento012", "fragmento013", 
  "fragmento014", "fragmento015", "fragmento016", "fragmento017", "fragmento018", 
  "fragmento019", "fragmento020", "fragmento021", "fragmento022", "fragmento023", "fragmento024", 
  "fragmento025", "fragmento026", "fragmento027", "fragmento028", "fragmento029", "fragmento030", "fragmento031"};*/
  String [] nombre={"frag00","frag01", "frag02", "frag03", "frag04", "frag05","fragmento06"};
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
  gauchos=new PImage[3];
  empanadas = new PImage[4];
  fuenteTexto = createFont("PatrickHand-Regular.ttf", 50);
  textFont(fuenteTexto);
  //for(int i=0; i<5; i++){
  //    text(textosGanar[frase], width/2, height/2);
  //}
  for (int i=0; i<6; i++) {
    fragmento [i]= new SoundFile(this, nombre[i]+".wav");
    barraProgreso[i]= loadImage("imagenes/progreso"+ i +".png");
  }
  for (int i=0; i<2; i++) {

    gauchos[i]= loadImage("imagenes/bailarines"+ i +".png");
    gauchos[i].resize(400, 400);
  }
  for (int i=0; i<4; i++) {

    empanadas[i]= loadImage("imagenes/empanada"+ i +".png");
  }
  
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
  fondoEstado2 = loadImage("imagenes/fondoEstado4.jpg");
  //resize bailarines
  //bailarines.resize(400, 450);


  //textos
  textosPerder = loadStrings("imagenes/perder.txt"); 
  textosGanar = loadStrings("imagenes/ganar.txt"); 
  // circulo=new FCircle(10);
  Fisica.init(this);
  mundo = new FWorld();
  caja=new FBox(40, 10);
  meta=new FBox(400, 380);
  borde=new FBox(20, height+1000);
  bordeA= new FBox(10000, 10);
  meta.setStatic(true);
  meta.setName("meta");
  caja.setPosition(width/2, height/2);
  caja.setNoStroke();
  borde.setStatic(true);
  bordeA.setStatic(true);
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
boolean eliminarNota=false;

  if (estado==1) {
    eliminarNota=true;
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
  
    if(eliminarNota==true){
    p.eliminarNotas(mundo);
  eliminarNota=false;}
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
    if(entroFragmento[0]==true){
    marcaDeTiempo3=millis()-marcaDeTiempo4;}
        
        if (entroFragmento[0]==true && marcaDeTiempo3>tiempo2) {

      
      marcaDeTiempo4=millis();

    }
    
    println(entroFragmento[0], entroFragmento[1], entroFragmento[2], entroFragmento[3], entroFragmento[4], entroFragmento[5], entroFragmento[7], entroFragmento[8], numeroDeFragmento);












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
    image(fondoEstado2, 0, 0);
    golpea.setTarget(mouseX, mouseY); //Con esto el rectangulo sigue al mouse
    //para que hagan todos los calculos matematicos entre los cuerpos que interactuan ¿¿
    mundo.step();
    //dibuja el mundo de fisica
    mundo.draw();

    image(gauchos[cambia], 1300, 160);

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
    image(radio, 30, 10);
    //  rect(500, 10, progreso*10, 10);
   // image(barraProgreso[progreso], 680, 10);
   
   //Barra sin pintar
    if(entroFragmento[0]==false){image(barra[0],400,10);}
    if(entroFragmento[0]==false){image(barra[1],460,10);}
    if(entroFragmento[1]==false){image(barra[2],495,10);}
    if(entroFragmento[1]==false){image(barra[3],610,10);}
    if(entroFragmento[2]==false){image(barra[4],660,10);}
    if(entroFragmento[2]==false){image(barra[5],715,10);}
    if(entroFragmento[3]==false){image(barra[6],770,10);}
    if(entroFragmento[3]==false){image(barra[7],820,10);}
    if(entroFragmento[4]==false){image(barra[8],880,10);}
    if(entroFragmento[5]==false){image(barra[9],900,10);}
   
//Barra pintada, cambia segun el fragmento que entre
    if(entroFragmento[0]==true){image(barraColor[0],400,10);}
    if(entroFragmento[0]==true){image(barraColor[1],460,10);}
    if(entroFragmento[1]==true){image(barraColor[2],495,10);}
    if(entroFragmento[1]==true){image(barraColor[3],610,10);}
    if(entroFragmento[2]==true){image(barraColor[4],660,10);}
    if(entroFragmento[2]==true){image(barraColor[5],715,10);}
    if(entroFragmento[3]==true){image(barraColor[6],770,10);}
    if(entroFragmento[3]==true){image(barraColor[7],820,10);}
    if(entroFragmento[4]==true){image(barraColor[8],880,10);}
    if(entroFragmento[5]==true){image(barraColor[9],900,10);}
    //mapeo la marca de tiempo 
float mover= map(marcaDeTiempo3,0,tiempo2,400,900);
//barrita que se mueve
   rect(mover,10,2,60);
   
    image(empanadas[opo], 50, 450);
    
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

  }


  println(estado, cambiarEstado);
}
void contactStarted(FContact contacto) {
  FBody body1=contacto.getBody1();
  FBody body2=contacto.getBody2();
  tiempo++;

  if ( body1.getName() != null && body2.getName() !=null && body1.getName() != body2.getName()) {entroFragmento[numeroDeFragmento]=true;
    //numeroDeFragmento++;

    
    mundo.remove(body2);
    // println(body1.getName(), "colisiono");
    progreso++;
    empezarTiempo=true;
    cambia++;
    if (cambia>=2) {
      cambia=0;
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
