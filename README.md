# EspressoShotTimer
Tuning your espresso machine so that it provides the best espresso possible is as much an art as it can be science and engineering. 
Apart from many other parameters (pressure, temperature), the time for the pulling the shot is crucial. Too short and you underextract, to long and the shot may become bitter or diluted. Many coffee wikis and forums homed in on 30 seconds as a good time for a pulling a good shot. I personally also found this to be a good guideline. I use 7 to 8 grams of freshly ground espresso, and tune the degree of grinding as well as the pressure to provide 30 seconds of shot time. Of course I want regular control that my shot time is indeed in this range, so an espress shot timer is needed. 

So, this project is about building an Espresso Shot Timer for the Gaggia Classic and it covers electronics, software and a 3D printed enclosure for the timer. 

## Boundary conditions

The timer, counting seconds, should start when you push the button engaging the pressure pump and obviously stop when you switch the pump off again. It would be ideal if the final value could be displayed for some more seconds after the pump is switched off, but this is not part of my design for reasons that will become obvious (mostly because if would have been complicated). 

## Electronics
The electronics should provide a timer counting seconds and a display to display the current value. The switch that switches the pump of the Gaggia on and off is switching 230V, so one needs a power supply to convert the 230V down to the 3.3V needed by the electronics of this project. 

SAFETY WARNING: If you work on project like this that deal with mains voltage of 110V or higher, you need to know what you are doing. Otherwise you may shock or kill yourself and even others trying to help you. If you unsure, ask someone who knows! 

Since I was doing microcontroller programming with the Arduino framework a lot recently, I decided to go for something that was simple for me, rather than the cheapest and overall simplest solution. So I based the design on an ESP8266 and OLED display. The ESP8266 is mostly wasted here, because it provides Wifi which is not needed here, but I like the modular design of the WEMOS D1 componentent with ESP8266 and went to those. You can quite likely find something even cheaper. 
So, the main component of this build were

* Wemos D1 compatible ESP8266 board for 6.30 Euro (bought from AZ-Delivery via Amazon.de)
* D1 compatible OLED shield for 4.50 Euro from HomeEngineer (bought via Amazon.de)
* Power supply 230V to 3.3.V from TenStar (bought from AZ-Delivery via Amazon.de)
* A circuit board with some wire, capacitors and fuses

The board design was inspired by [this RandomeNerd tutorial](https://randomnerdtutorials.com/esp8266-hi-link-hlk-pm03/), which convinced me to add fuses to protect the components and some capacitory to stablize the current to the microcontroller. You can probably do without those and safe some space. As you will see, these additional component made the whole timer quite bulky :).


## Software
Arduino-language-based timer software

## Enclosure
Designed in OpenSCAD to be 3D printed
