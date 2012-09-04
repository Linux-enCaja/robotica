/* Wiring/Arduino example for stm32f4 Discovery Boards
 * LEDS to GPIO output pin and turn them ON*/

#include "wirish.h"

#define GREEN_LED  D60
#define ORANGE_LED  D61
#define YELLOW_LED  D62
#define BLUE_LED  D63

/* Function to clear serial terminal*/
void clearScreen() {

    Serial1.write(27);
	Serial1.print("[2J"); // clear screen
	Serial1.write(27); // ESC
	Serial1.print("[H"); // cursor to home

}

/* Setup functions*/
void setup() {

    /* Set up the LED pint for output */
    pinMode(GREEN_LED, OUTPUT);
    pinMode(ORANGE_LED, OUTPUT);
    pinMode(YELLOW_LED, OUTPUT);
    pinMode(BLUE_LED, OUTPUT);

    /* Configure UART1 peripheral*/
    Serial1.begin(115200);

}

void loop() {

	/* Toggle all LEDS ON*/
	digitalWrite(GREEN_LED, HIGH);
	digitalWrite(ORANGE_LED, HIGH);
	digitalWrite(YELLOW_LED, HIGH);
	digitalWrite(BLUE_LED, HIGH);
	clearScreen();
    Serial1.println("Hello from M4 with Wiring/Arduino language :P");

}

// Force init to be called *first*, i.e. before static object allocation.
// Otherwise, statically allocated objects that need libmaple may fail.
__attribute__((constructor)) void premain() {
    init();
}

int main(void) {
    setup();
    loop();

    return 0;
}
