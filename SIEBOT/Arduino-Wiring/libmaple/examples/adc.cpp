/* Wiring/Arduino example for stm32f4 Discovery Boards
 * Controls LED intensity changing PWM duty cycle */

#include "wirish.h"

#define ANALOGUE_PIN  D01
#define DELAY_INTERVAL 50

HardwareTimer timer(4);

int newval = 0;
int normduty = 0;
int incr = 5;
int normfact = 655;

/* Function to clear serial terminal*/
void clearScreen() {

    Serial1.write(27);
	Serial1.print("[2J"); // clear screen
	Serial1.write(27); // ESC
	Serial1.print("[H"); // cursor to home

}

void setup() {
    /* Set up the LED with PWM*/
    pinMode(ANALOGUE_PIN, INPUT_ANALOG);

    /* Send a message out USART2  */
    Serial1.begin(115200);

    /* Greeting Message :) */
    Serial1.println("Hello from M4 with Wiring/Arduino language :P");

}

void loop() {
	/* Increase or decrease duty cycle*/
	newval = analogRead(ANALOGUE_PIN);
	if ((crtduty == 95) | (crtduty == 5)) {
		incr = -incr;
	}

    delay(DELAY_INTERVAL);
//    clearScreen();
    Serial1.print(newval);
    Serial1.println(" ADC Reading!!");
}

// Force init to be called *first*, i.e. before static object allocation.
// Otherwise, statically allocated objects that need libmaple may fail.
__attribute__((constructor)) void premain() {
    init();
}

int main(void) {
    setup();

    while (true) {
        loop();
    }

    return 0;
}
