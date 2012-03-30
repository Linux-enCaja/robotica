
/*
 * main.c
 *
 * This file is the main file for the master. It creates and starts
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
#include "envoi.h"
#include "irda.h"
#include "glip-animation.h"
#include "glip-image.h"
#include "neighbours.h"
#include "synchro.h"
#include "master-synchro.h"
#include "recevoir.h"

#include "debug.h"
#include "fatal.h"

uint8_t myID,myMID,rotation,numAnim;

int main () {
    int i;

    // STM32 initialization
    hardware_init();

    // Constants
    myID = which_is_myID();
    myMID = 1;
    rotation = 0;
    numAnim = 0;

    // Debug initialization
    if (IRDA_MIN == 2)
    {
        initDebug ();
        writeDebug ("GLiP Commander!\r\n");
        writeDebug ("What do you want to do ?\r\n");
        writeDebug ("'C'+number -> Play the selected animation\r\n");
        writeDebug ("'L' -> List the available animations\r\n");
        writeDebug ("'N' -> Play the next animation\r\n");
        writeDebug ("'P' -> Play the previous animation\r\n");
        writeDebug ("'R' -> Reset the master\r\n");
    }

    // IrDAs initialization
    initIRDA (IRDA_MIN);

    // Local clock initialization
    time_init();

    // LEDs initialization
    image_init();
    anim_init();

    // Create tasks
    for(i=IRDA_MIN;i<=4;i++)
        ENSURE(xTaskCreate(writeReadDataIrda,(signed portCHAR *)"irda",
                    configMINIMAL_STACK_SIZE, (void*)i,
                    tskIDLE_PRIORITY+1, NULL) == pdPASS);

    ENSURE(xTaskCreate(receiveDebug,(signed portCHAR *)"debug",
                       configMINIMAL_STACK_SIZE, NULL,
                       tskIDLE_PRIORITY+1,NULL) == pdPASS);

    ENSURE(xTaskCreate(neighbours,(signed portCHAR *)"neighbours",
                   configMINIMAL_STACK_SIZE, NULL,
                   tskIDLE_PRIORITY+1,NULL) == pdPASS);

    ENSURE(xTaskCreate(master_synchro, (signed portCHAR *)"master_synchro",
		       configMINIMAL_STACK_SIZE, NULL,
		       tskIDLE_PRIORITY+1,NULL) == pdPASS);

    ENSURE(xTaskCreate(receive, (signed portCHAR *)"reception",
		       configMINIMAL_STACK_SIZE, NULL,
		       tskIDLE_PRIORITY+1,NULL) == pdPASS);

    // Start scheduler and tasks
    vTaskStartScheduler();

    //Should not get there !
    for(;;);
}
