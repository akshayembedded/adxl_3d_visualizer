/*
    Arduino and ADXL345 Accelerometer - 3D Visualization Example 
    by Akshay, https://embeddedmachan.in
*/

import processing.serial.*;
import java.awt.event.KeyEvent;
import java.io.IOException;

Serial myPort;

String data="";
float roll, pitch;
PImage logo;  // Declare a PImage variable for the logo

void setup() {
  size (960, 640, P3D);
  myPort = new Serial(this, "COM4", 9600); // Start serial communication
  myPort.bufferUntil('\n');
  
  logo = loadImage("logo.jpg"); // Load the logo image
}

void draw() {
  background(33);
  translate(width / 2, height / 2, 0);  // Move the origin to the center of the screen
  
  // Display the roll and pitch values
  textSize(22);
  fill(255);
  text("Roll: " + int(roll) + "     Pitch: " + int(pitch), -100, 265);

  // Rotate the logo image based on the roll and pitch values
  rotateX(radians(roll));
  rotateZ(radians(-pitch));
  
  // Display the rotating logo image
  imageMode(CENTER);  // Center the image
  image(logo, 0, 0, logo.width / 2, logo.height / 2);  // Adjust size and position
  
  //delay(10);
  //println("ypr:\t" + angleX + "\t" + angleY); // Print the values to check whether we are getting proper values
}

// Read data from the Serial Port
void serialEvent (Serial myPort) { 
  // Read the data from the Serial Port
  data = myPort.readStringUntil('\n');

  // If data is received
  if (data != null) {
    data = trim(data);
    // Split the string at "/"
    String items[] = split(data, '/');
    if (items.length > 1) {
      // Parse the roll and pitch values from the serial data
      roll = float(items[0]);
      pitch = float(items[1]);
    }
  }
}
