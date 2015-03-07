// Import
import processing.serial.*;
import voce.*;

// Serial Variables
Serial ardu;
String port = "COM3";
int baudrate = 9600;

// Voce init
String initStr = "C:/Users/Admin/Desktop/speechArm/processing/lib";
String initGram = "file:/C:/Users/Admin/Desktop/speechArm/processing/lib/gram";

// Voce variables
String s;
String d;
String q;
String out;
String k;
String str;
boolean n = true;

// Font
PFont font = createFont("Lato",30,true);


void setup() {
  // Default window elements
  size(500, 500);
  background(000);
  fill(255);
  textAlign(CENTER, TOP);
  textFont(font, 30);
  text("speechArm", 250, 0);
 
  // Init serial
  ardu = new Serial(this, port, baudrate);
 
  // Init STT
  voce.SpeechInterface.init(initStr, true, true, initGram, "commands");
}

void draw(){
  // Begin listening
  while (voce.SpeechInterface.getRecognizerQueueSize() > 0) {
    // Generate string for request
    s = voce.SpeechInterface.popRecognizedString();
   
    // Keyboard module
    if (s.equals("arm keyboard")) {
      Say("keyboard input enabled");
      while (voce.SpeechInterface.getRecognizerQueueSize() > 0) {
        if (keyPressed) {
          if (key == 'w' || key == 'W') {
            Output("[k:w]");
            Say("Moving north");
          }
          if (key == 'a' || key == 'A') {
            Output("[k:a]");
            Say("Moving left");
          }
          if (key == 's' || key == 'S') {
            Output("[k:s]");
            Say("Moving south");
          }
          if (key == 'd' || key == 'D') {
            Output("[k:d]");
            Say("Moving right");
          }
          if (key == 'q' || key == 'Q') {
            Output("[k:q]");
            Say("Moving up");
          }
          if (key == 'e' || key == 'E') {
            Output("[k:e]");
            Say("Moving down");
          }
          k = voce.SpeechInterface.popRecognizedString();
          if (k.equals("arm quit") || k.equals("arm keyboard")) {
            break;
          }
        }
      }
      Say("keyboard input disabled");
      n = true;
    }
    // Grab module
    if (s.equals("arm grab")) {
      Output("[h:g]");
      Say("Grabbing object");
    }
    // Release module
    if (s.equals("arm release")) {
      Output("[h:r]");
      Say("Releasing object");
    }
    // Rotate waist module
    if (s.equals("arm rotate") || s.equals("arm rotate waist")) {
      Say("How many degrees?");
      while (voce.SpeechInterface.getRecognizerQueueSize() > 0) {
        d = voce.SpeechInterface.popRecognizedString();
        if (!(d.equals(""))) {
          Say("Rotating " + d + "degrees");
          Output("[r:0:" + d + "]");
          break;
        }
      }
    }
    // Rotate shoulder module
    if (s.equals("arm rotate shoulder")) {
      Say("How many degrees?");
      d = voce.SpeechInterface.popRecognizedString();
      Say("Rotating shoulder " + d + "degrees");
      Output("[r:1:" + d + "]");
    }
    // Rotate shoulder module
    if (s.equals("arm rotate elbow")) {
      Say("How many degrees?");
      d = voce.SpeechInterface.popRecognizedString();
      Say("Rotating elbow " + d + "degrees");
      Output("[r:2:" + d + "]");
    }
    // Rotate wrist module
    if (s.equals("arm rotate wrist")) {
      Say("How many degrees?");
      d = voce.SpeechInterface.popRecognizedString();
      
      Say("Rotating wrist " + d + "degrees");
      Output("[r:3:" + d + "]");
    }
  }
}

void Output(String a) {
  ardu.write(a);
}

void Say(String a) {  
  System.out.println(a);
  voce.SpeechInterface.synthesize(a);
  text(a, 250, 250);
}
