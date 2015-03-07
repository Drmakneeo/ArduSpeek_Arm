// Includes
#include <Servo.h>

// Servo definitions
Servo waist;
Servo shoulder;
Servo elbow;
Servo wrist;
Servo hand;

// Servo values
int valWaist = 90;
int valShoulder = 90;
int valElbow = 90;
int valWrist = 0;
int valHand = 0;

// Other variables
String s;
String in;
int n;

void setup(){
  // Init serial
  Serial.begin(9600);
  
  // Attach servos
  waist.attach(11);
  shoulder.attach(10);
  elbow.attach(9);
  wrist.attach(6);
  hand.attach(5);
}

void loop(){
  // Read serial data
  if (Serial.available() > 0) {
    in = (String)Serial.read();
  }
  
  // Write initial servo values
  waist.write(valWaist);
  shoulder.write(valShoulder);
  elbow.write(valElbow);
  wrist.write(valWrist);
  hand.write(valHand);
  
  // Grab module
  if (in.equals("h:g")) {
    wrist.write(90);
  }
  // Grab module
  else if (in.equals("h:r")) {
    wrist.write(0);
  }
}
