/**
 * Envio y recepción de mensajes OSC
 * Ejemplo de envío y recepción en un mismo sketch de Processing
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
// Declaramos la variable de objeto miDireccionRemota de tipo de clase NetAddress el cual administra la dirección IP y el número de puerto de una locación remota en la red.
NetAddress miDireccionRemota;

void setup() {
  size(100,100);

  /* Recepción
   * Inicializamos oscP5: una nueva instancia de objeto.
   12000 corresponde al número de puerto al cual escucharemos los mensajes OSC entrantes.
   */
  oscP5 = new OscP5(this, 12000);

  /* Difusión
   * Inicializamos miDireccionRemota: una nueva instancia de objeto.
   * La clase NetAddress es usada cuando enviamos mensajes OSC con el método ".send".
   * Incluye la dirección IP y el puerto de envío.
   */
  miDireccionRemota = new NetAddress("localhost",12000);
}


void draw() {

  background(0); 

  /*
  * Inicializamos posx: una nueva instancia de objeto.
  */
  // Especificamos un "patrón de dirección" llamado "/posx".
  OscMessage posx = new OscMessage("/posx");
  // Agregamos un valor (un entero) a posx.
  posx.add(mouseX);
  // Enviamos el mensaje de posx a la locación remota especificada en miDireccionRemota.
  OscP5.flush(posx, miDireccionRemota); 

  /*
  * Inicializamos posy: una nueva instancia de objeto.
  */
  // Especificamos un "patrón de dirección" llamado "/posy".
  OscMessage posy = new OscMessage("/posy");
  // Agregamos un valor (un entero) a posy.
  posy.add(mouseY);
  // Enviamos el mensaje de posy a la locación remota especificada en miDireccionRemota.
  OscP5.flush(posy, miDireccionRemota); 
}

void mousePressed() {
  /*
  * Inicializamos clic: una nueva instancia de objeto.
  */
  // Especificamos un "patrón de dirección" llamado "/posx".
  OscMessage clic = new OscMessage("/clic");
  // Agregamos un valor (un entero) a clic.
  clic.add(1);
  // Enviamos el mensaje de clic a la locación remota especificada en miDireccionRemota.
  OscP5.flush(clic, miDireccionRemota); 
}

void mouseReleased() {
  /*
  * Inicializamos clic: una nueva instancia de objeto.
  */
  // Especificamos un "patrón de dirección" llamado "/posx".
  OscMessage clic = new OscMessage("/clic");
  // Agregamos un valor (un entero) a clic.
  clic.add(0);
  // Enviamos el mensaje de clic a la locación remota especificada en miDireccionRemota.
  OscP5.flush(clic, miDireccionRemota);
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
}
