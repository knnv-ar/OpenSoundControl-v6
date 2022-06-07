/**
 * Lienzo de dibujo compartido (servidor) 
 * por Alexander R. Galloway // traducido por: Raúl Lacabanne
 * 
 * Este ejemplo presenta un lienzo de dibujo compartido entre dos ordenadores.
 * Para que un servidor abra una conexión, primero debe seleccionar un puerto
 * para poder escuchar a los clientes y con los cuales poder comunicarse.
 * Una vez que dicha conexión se haya establecido, un cliente puede conectarse al
 * servidor y puede enviar o recibir comandos y datos.
 * Primero ejecute este boceto y luego el boceto correspondiente al Cliente
 * para ver cómo interactúan entre ellos.
 */

import processing.net.*;

Server s;
Client c;
String input;
int data[];

void setup() {
  size(450, 255);
  background(204);
  stroke(0);
  // baja la velocidad de fotogramas:
  frameRate(5);
  //inicia un servidor en el puerto 12345:
  s = new Server(this, 12345);
}

void draw() {
  if (mousePressed == true) {
    // dibuja la línea:
    stroke(255);
    line(pmouseX, pmouseY, mouseX, mouseY);
    // envía las coordenadas de mouse:
    s.write(pmouseX + " " + pmouseY + " " + mouseX + " " + mouseY + "\n");
  }
  // recive los datos del cliente:
  c = s.available();
  if (c != null) {
    input = c.readString();
    // Sólo hasta el caracter ASCII "newline":
    input = input.substring(0, input.indexOf("\n"));
    // separa los valores dentro de un array:
    data = int(split(input, ' '));
    // dibuja la línea usando las coordenadas recibidas:
    stroke(0);
    line(data[0], data[1], data[2], data[3]);
  }
}
