/*********************************************************************
This code is for a 64x48 size  
Monochrome OLEDs based on SSD1306 drivers
using I2C to communicate
3 pins are required to interface (2 I2C and one reset)

Written by Christoph Steinbeck, 
MIT License
*********************************************************************/

#include <SPI.h>
#include <Wire.h>
#include <Ticker.h>
#include <time.h>
#include <Adafruit_GFX.h>
#include <Adafruit_SSD1306.h>

// SCL GPIO5
// SDA GPIO4
#define OLED_RESET 0  // GPIO0
Adafruit_SSD1306 display(OLED_RESET);

Ticker ticker1;
int seconds = 0;

void setup()   {
  Serial.begin(9600);


  display.begin(SSD1306_SWITCHCAPVCC, 0x3C);  // initialize with the I2C addr 0x3C (for the 64x48)
 
 /* Start a 1 second ticker which calls the routine displayNumber() below, which again increments the 
 *  seconds counter and updates the OLED display
 */ 
 ticker1.attach(1, displayNumber);

}

void loop() {
  delay(100);
}

void displayNumber()
{
  char secondsChar[3];
  seconds = seconds + 1;
  if (seconds > 99) seconds = 0; 
  // Clear the buffer.
  display.clearDisplay();
  display.setTextSize(5);
  display.setTextColor(WHITE);
  
  String secondsString = String(seconds);
  if (seconds < 10) secondsString = "0" + secondsString;
  secondsString.toCharArray(secondsChar, 3);
  int16_t tbx, tby; uint16_t tbw, tbh;
  display.getTextBounds(secondsChar, 0, 0, &tbx, &tby, &tbw, &tbh);
  uint16_t x = (display.width() - tbw) / 2 + 2;
  uint16_t y = (display.height() - tbh) / 2;
  display.setCursor(x,y);
  display.println(secondsChar);
  display.display();
  
}
