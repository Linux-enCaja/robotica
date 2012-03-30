/*
 * main.c
 *
 * This is the main file for the children blocks. It creates and starts 
 * tasks and declares block's parameters like the block ID.
 *
 *
 * Copyright 2010 - Mickaël Camus <mickaelcamus.mc@gmail.com>,
 *                  Enzo Casasola <enzocasasola@gmail.com>,
 *                  Julie Estivie <juliestivie@gmail.com>,
 *                  Florent Matignon <florent.matignon@gmail.com>
 *
 * All rights reserved.
 * GLiP (Great LEDs interactive Puzzle)
 * Telecom ParisTech - ELECINF344/ELECINF381
 *
 * This file is part of GLiP Project.
 *
 * GLiP Project is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * GLiP Project is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with GLiP Project.  If not, see <http://www.gnu.org/licenses/>.
 *
 *
 */

// FreeRTOS and STM32 features
#include <stm32f10x.h>
#include <FreeRTOS.h>
#include <task.h>

// GLiP features
#include "hardware_init.h"
#include "irda.h"
#include "glip-animation.h"
#include "glip-image.h"
#include "recevoir.h"
#include "envoi.h"
#include "synchro.h"

#include "fatal.h"

uint8_t myID, myMID, rotation, numAnim;

int main () {

    int i;

    // STM32 initialization
    hardware_init();

    // Constants
    myID = which_is_myID();
    myMID = 2;
    rotation = 0;
    numAnim = 0;

     // IrDAs initialization
    initIRDA (IRDA_MIN);

    // LEDs initialization
    image_init();
    anim_init();

    // Local clock initialization
    time_init();

    // Create tasks
    for(i=IRDA_MIN;i<=4;i++) {
        ENSURE(xTaskCreate(writeReadDataIrda,(signed portCHAR *)"irda",
                    configMINIMAL_STACK_SIZE, (void*)i,
                    tskIDLE_PRIORITY+1, NULL)
           == pdPASS);
    }

    ENSURE(xTaskCreate(receive, (signed portCHAR *)"receive", configMINIMAL_STACK_SIZE, NULL, tskIDLE_PRIORITY + 1, NULL)
       == pdPASS);

    // Start scheduler and tasks
    vTaskStartScheduler();

    //Should not get there!
    for(;;);
}
