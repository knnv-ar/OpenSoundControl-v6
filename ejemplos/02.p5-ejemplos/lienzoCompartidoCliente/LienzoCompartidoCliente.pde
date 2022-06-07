/**
 * Lienzo de dibujo compartido (cliente) 
 * por Alexander R. Galloway // traducido por: Raúl Lacabanne
 * 
 * Se crea una instancia de la clase "Client" de Processing al especificar
 * una dirección IP remota y un número de puerto a la cual se debe establecer
 * la conexión.
 * Una vez establecida dicha conexión, el cliente puede leer datos del servidor,
 * o bien escribir datos al servidor.
 * Antes de ejecutar este boceto, ejecute el correspodiente al Servidor.
 */

import processing.net.*;

Client c;
String input;
int data[];

void setup() {
  size(450, 255);
  background(204);
  stroke(0);
  // baja la velocidad de fotogramas:
  frameRate(5);
  // conecta a la dirección IP y puerto del servidor:
  // (en caso que corresponda, reemplacelos por los
  // valores de su servidor)
  c = new Client(this, "127.0.0.1", 12345);
}

void draw() {
  if (mousePressed == true) {
    // dibuja la línea
    stroke(255);
    line(pmouseX, pmouseY, mouseX, mouseY);
    // envía las coordenadas de mouse:
    c.write(pmouseX + " " + pmouseY + " " + mouseX + " " + mouseY + "\n");
  }
  // recive datos del servidor
  if (c.available() > 0) {
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
