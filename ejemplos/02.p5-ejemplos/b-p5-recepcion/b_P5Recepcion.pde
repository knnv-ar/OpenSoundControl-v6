/**
 * Recepción de mensajes OSC
 * Ejemplo de recepción en un sketch de Processing
 * Raúl Lacabanne - 2009
 */

// Importamos las librerías OSC
import oscP5.*;
import netP5.*;

//Declaramos e inicializamos las tres variables que usaremos
int posX = 0;
int posY = 0;
int clic = 0;

//Declaramos la variable de objeto oscP5 de tipo de clase OscP5
OscP5 oscP5;

void setup() {
  size(100,100);
  background(0); 
  /* Recepción
   * Inicializamos oscP5: una nueva instancia de objeto.
   12000 corresponde al número de puerto al cual escucharemos los mensajes OSC entrantes.
   */
  oscP5 = new OscP5(this, 12001);
}


void draw() {
}

  /*
  * Los mensajes recibidos son dirigidos al método oscEvent.
  */
void oscEvent(OscMessage elMensajeOsc) {
  if(elMensajeOsc.checkAddrPattern("/posx")==true) {
    posX = elMensajeOsc.get(0).intValue();  // toma el argumento.
  }
  if(elMensajeOsc.checkAddrPattern("/posy")==true) {
    posY = elMensajeOsc.get(0).intValue();  // toma el argumento.
  }
  if(elMensajeOsc.checkAddrPattern("/clic")==true) {
    clic = elMensajeOsc.get(0).intValue();  // toma el argumento.
  }
  println("x: " + posX + ", y: " + posY + " clic: " + clic);
  stroke(clic);
  line(posX, posY, posX, posY);
}
