/**
 * Envío y recepción de mensajes OSC vía TCP
 * Ejemplo de creación y envío de mensajes OSC mediante el protocolo TCP
 * Raúl Lacabanne - 2009
 */

// Importamos las librerías OSC
import oscP5.*;
import netP5.*;

//Declaramos los objetos oscP5tcpServer, oscP5tcpClient
OscP5 oscP5tcpServer;
OscP5 oscP5tcpClient;

void setup() {
  /* Creamos un objeto servidor TCP (recepción) que escucha al puerto 11000 */
  oscP5tcpServer = new OscP5(this, 11000, OscP5.TCP);
  
  /* Creamos un objeto cliente TCP (envío) con IP localhost y puerto 11000 */
  oscP5tcpClient = new OscP5(this, "127.0.0.1", 11000, OscP5.TCP);

  background(0);  
}

void draw() {
}

void mousePressed() {
  /* El cliente TCP envía un mensaje OSC al servidor que se encuentra en conexión */
  oscP5tcpClient.send("/cliente", new Object[] {new Integer(1)});
}

void keyPressed() {
  /* Verifica la cantidad de clientes que se encuentran conectados al servidor */
  println(oscP5tcpServer.tcpServer().getClients().length);
}

void oscEvent(OscMessage elMensajeOSC) {
  /* En este ejemplo, el servidor y el cliente comparten el método oscEvent */
  System.out.println("Obtuvo un mensaje!!! " + elMensajeOSC);
  if(elMensajeOSC.checkAddrPattern("/cliente")) {
    /* Creamos un nuevo mensaje para responderle al cliente*/
    OscMessage mensajeDelServidor = new OscMessage("/servidor");
    mensajeDelServidor.add("El servidor responde: lo tengo!");
    /* el servidor responde al mensaje del cliente */
    oscP5tcpServer.send(mensajeDelServidor, elMensajeOSC.tcpConnection());
  }
}
