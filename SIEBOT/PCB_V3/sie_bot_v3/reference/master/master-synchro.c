/*
 * master-synchro.c
 *
 * This file has just one function which sends the PING messages
 * in order to synchronize all the blocks.
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
#include "constant.h"
#include "envoi.h"
#include "paquet.h"
#include "synchro.h"
#include "master-synchro.h"
#include "glip-animation.h"

void master_synchro()
{
  static Paquet paquet;
  static uint8_t data[MAX_COMMAND_SIZE];
  int msgId = 0;

  initPaquet(&paquet);

  for (;;) {
    for (unsigned int target = 2; target <= (currentAnimation->nb_colonnes)*(currentAnimation->nb_lignes); target++) {
      vTaskDelay(200 / portTICK_RATE_MS);

      // Send nothing if we want to desynchronize the blocks
      if (currentAnimation->desynchronize)
        continue;

      msgId++;
      if (!msgId)
	        msgId = 1;
      data[0] = msgId;
      data[1] = target;

      *(uint32_t *)&data[2] = current_time();
      makePaquet(&paquet, 0, myID, 20, PING, data);
      send_to_destination(&paquet);
    }
  }
}
