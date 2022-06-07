/**
 * Envio de mensajes OSC
 * Ejemplo de envío desde un sketch de Processing
 * Raúl Lacabanne - 2009
 */

// Importamos las librerías OSC
import oscP5.*;
import netP5.*;

// Declaramos la variable de objeto miDireccionRemota
// de tipo de clase NetAddress el cual administra
// la dirección IP y el número de puerto de
//una locación remota en la red.
NetAddress miDireccionRemota;

void setup() {
  size(100,100);
  background(0); 
  /* Difusión
   * Inicializamos miDireccionRemota: una nueva instancia de objeto.
   * La clase NetAddress es usada cuando enviamos mensajes OSC con el método ".flush".
   * Incluye la dirección IP y el puerto de envío.
   */
  miDireccionRemota = new NetAddress("localhost", 12001);
}


void draw() {
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

  if (mousePressed) {
    stroke(255);
    line(mouseX, mouseY, mouseX, mouseY);
  }

}

void mousePressed() {
  /*
  * Inicializamos clic: una nueva instancia de objeto.
   */
  // Especificamos un "patrón de dirección" llamado "/posx".
  OscMessage clic = new OscMessage("/clic");
  // Agregamos un valor (un entero) a clic.
  clic.add(255);
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



