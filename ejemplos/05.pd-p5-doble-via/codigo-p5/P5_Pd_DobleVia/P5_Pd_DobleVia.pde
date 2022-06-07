/**
 * Envio y recepción de mensajes OSC
 * Raúl Lacabanne - 2009
 * oscP5 website at http://www.sojamo.de/oscP5
 */

import oscP5.*;
import netP5.*;

OscP5 oscP5;
NetAddress myRemoteLocation;

void setup() {
  size(100,100);
  frameRate(25);
  /* receptor */
  /* start oscP5, listening for incoming messages at port 12000 */
  oscP5 = new OscP5(this,7700);

  /* myRemoteLocation is a NetAddress. a NetAddress takes 2 parameters,
   * an ip address and a port number. myRemoteLocation is used as parameter in
   * oscP5.send() when sending osc packets to another computer, device, 
   * application. usage see below. for testing purposes the listening port
   * and the port of the remote location address are the same, hence you will
   * send messages back to this sketch.
   */
  myRemoteLocation = new NetAddress("localhost",12000);
}


void draw() {
  background(0); 
  OscMessage posx = new OscMessage("/posx");
  posx.add(mouseX); /* add an int to the osc message */
  oscP5.send(posx, myRemoteLocation); 

  OscMessage posy = new OscMessage("/posy");
  posy.add(mouseY); /* add an int to the osc message */
  oscP5.send(posy, myRemoteLocation); 

}

void mousePressed() {
  /* in the following different ways of creating osc messages are shown by example */
  OscMessage myMessage = new OscMessage("/clic");

  myMessage.add(1); /* add an int to the osc message */

  /* send the message */
  oscP5.send(myMessage, myRemoteLocation); 
}

void mouseReleased() {
    OscMessage myMessage = new OscMessage("/clic");

  myMessage.add(0); /* add an int to the osc message */

  /* send the message */
  oscP5.send(myMessage, myRemoteLocation);
}


/* incoming osc message are forwarded to the oscEvent method. */
void oscEvent(OscMessage theOscMessage) {
  if(theOscMessage.checkAddrPattern("/test")==true) {
    /* check if the typetag is the right one. */
    if(theOscMessage.checkTypetag("i")) {
      /* parse theOscMessage and extract the values from the osc message arguments. */
      int firstValue = theOscMessage.get(0).intValue();  // get the first osc argument
      println(firstValue);
    } 
    else if (theOscMessage.checkTypetag("f")) {
      float secondValue = theOscMessage.get(0).floatValue(); // get the second osc argument
      println(secondValue);
    } 
    else if (theOscMessage.checkTypetag("s")) {
      String thirdValue = theOscMessage.get(0).stringValue(); // get the third osc argument
      println(thirdValue);
    }
  }
  /* print the address pattern and the typetag of the received OscMessage */
  print("### received an osc message.");
  print(" addrpattern: "+theOscMessage.addrPattern());
  println(" typetag: "+theOscMessage.typetag());
}





