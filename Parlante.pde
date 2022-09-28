class Parlante {
 FCircle notas;
  float x, y;
  float ancho = 70;
  float alto =70;
  float velocidad = 500;
  float anguloVel = 2;
  float angulo;


  PImage nota1, nota2, nota3;

  Parlante( float x_, float y_ ) {
    x=x_;
    y= y_;
    angulo = radians (40);
    

   


  }

  void dibujar () {
    pushMatrix();
    nota1 = loadImage("imagenes/notas.png");
    nota2 = loadImage("imagenes/notas.png");
    nota3 = loadImage("imagenes/notas.png");

    rect(x, y, ancho, alto);
    popMatrix();
  }

  void dibujarNotas( FWorld mundo) {
    notas = new FCircle(90);
       float vx = velocidad * cos (angulo);
    float vy = velocidad * sin (angulo);
    
    notas.setPosition( x+50, y+10 );
    notas.setGrabbable(true);
    notas.setVelocity (vx, vy);
    
      //para despues detectar las coliciones
    notas.setName("notas");

    if (random(2)<1) {
      notas.attachImage(nota1);
    } else if (random(2)>1) {
      notas.attachImage(nota2);
    } else {
      notas.attachImage(nota3);
    }
    mundo.add(notas);
    
   
  }
void eliminarNotas(FWorld mundo){

mundo.remove(notas);
}

  void oportunidades(SoundFile audio) {
    ArrayList <FBody> cuerpos = mundo.getBodies();

    for (FBody este : cuerpos) {
      String nombre = este.getName();
      if (nombre != null) {
        if ( nombre.equals("notas")) {
          if (este.getY() > height) {
            opo--;
            mundo.remove(este);
            audio.play();
          }
        }
      }
    }
  }

}
