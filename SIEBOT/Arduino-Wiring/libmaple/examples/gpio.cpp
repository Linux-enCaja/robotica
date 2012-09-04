/* Wiring/Arduino example for stm32f4 Discovery Boards
 * Prints GPIO input value*/

#include "wirish.h"

#define INPUT_SIGNAL  D16

int oldval, newval = 0;

/* Function to clear serial terminal*/
void clearScreen() {

    Serial1.write(27);
	Serial1.print("[2J"); // clear screen
	Serial1.write(27); // ESC
	Serial1.print("[H"); // cursor to home

}

void setup() {
    /* Set up the LED to blink  */
    pinMode(INPUT_SIGNAL, INPUT);
    newval = digitalRead(INPUT_SIGNAL);
    oldval = newval;

    /* Send a message out USART2  */
    Serial1.begin(115200);

    /* Greeting Message :) */
    clearScreen();
    Serial1.println("Hello from M4 with Wiring/Arduino language :P");
	Serial1.print(newval);
	Serial1.println(" Logic Level!.");
}

void loop() {

	newval = digitalRead(INPUT_SIGNAL);

	if (oldval != newval) {

		clearScreen();
	    Serial1.print(newval);
	    Serial1.println(" Logic Level!.");
		oldval = newval;

	}

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
