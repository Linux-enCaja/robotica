/*
 * neighbours.c
 *
 * This file has just one function which sends the YOUARE messages
 * in order to identify blocks' positions and directions.
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

// FreeRTOS features
#include <FreeRTOS.h>
#include <task.h>

// GLiP features
#include "neighbours.h"
#include "envoi.h"
#include "constant.h"


void neighbours () {
    static uint8_t YouAreID = 1;
    for(;;) {
        send_neighbours(YouAreID);
        YouAreID = (YouAreID%255)+1;
        vTaskDelay(DELAY_SEND_MESSAGES/portTICK_RATE_MS);
    }
}
