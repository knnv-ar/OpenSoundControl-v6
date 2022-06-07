/**
 * Envío y recepción de Envoltorios OSC
 * Ejemplo de creación y envío de Envoltorios OSC
 * Raúl Lacabanne - 2009
 */

// Importamos las librerías OSC
import oscP5.*;
import netP5.*;

//Declaramos los objetos oscP5 y miDireccionRemota
OscP5 oscP5;
NetAddress miDireccionRemota;

void setup() {
  /* Inicializamos oscP5 (servidor), el cual escucha los mensajes entrantes del puerto 12000 */
  oscP5 = new OscP5(this,12000);
  
  /* Inicializamos miDireccionRemota (cliente) */
  miDireccionRemota = new NetAddress("127.0.0.1",12000);
}

void draw() {
  background(0);  
}

void mousePressed() {
  /* Creación de un objeto Envoltorio OSC */
  OscBundle miEnvoltorioOSC = new OscBundle();
  
  /* Creación de un objeto Mensaje OSC */
  OscMessage miMensajeOSC = new OscMessage("/test");
  miMensajeOSC.add("abc");
  
  /* Agregamos un mensaje OSC al envoltorio OSC */
  miEnvoltorioOSC.add(miMensajeOSC);
  
  /* Limpiamos el objeto miMensajeOSC object para reusarlo */
  miMensajeOSC.clear();
  
  /* Volvemos a llenar el objeto miMensajeOSC y lo agregamos a miEnvoltorioOSC */
  miMensajeOSC.setAddrPattern("/test2");
  miMensajeOSC.add("defg");
  miEnvoltorioOSC.add(miMensajeOSC);
  
  /* Configuramos la etiqueta de tiempo OSC de miEnvoltorioOSC */
  miEnvoltorioOSC.setTimetag(miEnvoltorioOSC.now() + 10000);
  
  /* Enviamos el envoltorio OSC (conteniendo dos mensajes) a miDireccionRemota */
  oscP5.send(miEnvoltorioOSC, miDireccionRemota);
}

/* Los paquetes entrantes se direccionan al método oscEvent */
void oscEvent(OscMessage elMensajeOSC) {
  /* Imprimimos el patrón de dirección, el typetag, el argumento y la timetag */
  println("Hemos recibo un paquete OSC!!!");
  println(" Patrón de direción: " + elMensajeOSC.addrPattern());
  println(" Etiqueta de tipo OSC: " + elMensajeOSC.typetag());
  println(" Argumento: " + elMensajeOSC.get(0).stringValue());
  println(" Etiqueta de tiempo: " + elMensajeOSC.timetag());
}
