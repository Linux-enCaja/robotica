/* ---- DOMOTI S.A.S. ----
 * Originaly made by Domoti S.A.S.
 * Calle 98 No 8 28 Of 501 Bogot� Col
 * info@domoti-sas.com
 */

#ifndef DEFINITIONS_H
#define DEFINITIONS_H
extern "C" {
#include "include/lua.h"
#include "include/lualib.h"
#include "include/lauxlib.h"
}

#include <QTime>
#include <QApplication>
#include "../events/SIEMoveEvent.h"
#include "../events/GPSEvent.h"
#include "../events/PWMEvent.h"
#include "../events/EncoderEvent.h"
#include "../events/DelayEvent.h"
#include "../events/MessageEvent.h"
#include "../events/ConnectionEvent.h"
#include "../globals/MW.h"
#include "../include/serial.h"

#define TIMEOUT 1000000

#define SIE_CAR 1

namespace SIEmethods{
    //public:
    static int dummies;
    static int *virt_addr;
    static QObject *mW;
    
    static int serial_fd;
    static char data[100]; 
        
    static float lat=1;
    static float lon=1;
      	
    static int n = 0;
    //    void setMW(QObject *obj){mainWindow = obj;}
    static int delayMs(lua_State* l){
        
        int milisec=0;
        bool display = false;
        milisec=luaL_optint(l,1,0); // obtain time parameter
		display = (bool)luaL_optint(l,2,0); // should i display the countdown?

        if (milisec==0)
            return 0;
        //ESTE DELAY ES VALIDO PERO BLOQUEA TODOS LOS PROCESOS INCLUYASE INTERFAZ DE USUARIO
        //EN ESTE CASO NO SE LE PUEDE NOTIFICAR AL USUARIO QUE NO SE HA TRABADO LA APLICACION
        //EN CASO DE SER UN DELAY PROLONGADO PUEDE SER MOLESTO
        /*struct timespec req={0};
        time_t sec;

        sec=(int)(milisec/1000);

        milisec = milisec - (sec*1000);

        req.tv_sec=sec;
        req.tv_nsec=milisec*1000000L;

        while(nanosleep(&req,&req)==-1)
            continue;*/
       
       
       QTime t;
       t.start();
       
       while(t.elapsed()<milisec)
       {
            if(display){
               	QSIEDelayEvent *event = new QSIEDelayEvent(milisec-t.elapsed());
               	QApplication::sendEvent(MW::getInstance()->mainWindow,event);
            }
       }
       QSIEDelayEvent *event = new QSIEDelayEvent(-1);
       QApplication::sendEvent(MW::getInstance()->mainWindow,event);
       QApplication::processEvents();
       
       return 0;
    }

    static void testEvents(QSieEvent *event)
    {
        QApplication::postEvent(MW::getInstance()->mainWindow,event);
    }

    // Move function
    static int move(lua_State* l){
    	
        dummies=0;
        //  This function sets the hbridge input signals to move the motors in some simple ways
        /*  We will receive an action code:             0-stop
                                                    1-move forward
                                                    2-move backward
                                                    3-turn right
                                                    4-turn left
                then we receive a value to set the speed (pwm) to execute the action.
            */

        int action,speed;

                    action = luaL_optint(l,1,0);    // obtain the action code
                    speed = luaL_optint(l,2,0);     // obtain the speed value

        QSieMoveEvent *event;
        switch(action){
        case 0:                     //stop
            virt_addr[1024] = 0;
            event = new QSieMoveEvent(QSieMoveEvent::Stop,0);
            break;
        case 1:                     //move forward
            speed &= 0xFF;
            virt_addr[1024] = speed | (speed << 24);
            event = new QSieMoveEvent(QSieMoveEvent::Forward,speed);
            break;
        case 2:                     //move backward
            speed &= 0xFF;
            virt_addr[1024] = (speed << 8) | (speed << 16);
            event = new QSieMoveEvent(QSieMoveEvent::Backward,speed);
            break;
        case 3:                     //turn right
            speed &= 0xFF;
            virt_addr[1024] = (speed << 16) | (speed << 24);
            event = new QSieMoveEvent(QSieMoveEvent::TurnRight,speed);
            break;
        case 4:                     //turn left
            speed &= 0xFF;
            virt_addr[1024] = speed | (speed << 8);
            event = new QSieMoveEvent(QSieMoveEvent::TurnLeft,speed);
            break;
        }
        
        QApplication::sendEvent(MW::getInstance()->mainWindow,event);
        QApplication::processEvents();
        
        return 0;
    }

    static int pwm(lua_State* l){
        // This function sets a pwm dutycycle independently on free digital pins:
        // 6,7,8,9,16,17,18,19,20,21,22,23

		int gpio,dutyCycle;
                    gpio=luaL_optint(l,1,6); // obtain gpio-pin parameter
                    dutyCycle=luaL_optint(l,2,255); // obtain duty cycle parameter

        switch(gpio){
        case 6:
            virt_addr[1536] = dutyCycle;
            break;
        case 7:
            virt_addr[1536] = dutyCycle;
            break;
        case 8:
            virt_addr[1536] = dutyCycle;
            break;
        case 9:
            virt_addr[1536] = dutyCycle;
            break;
        case 16:
            virt_addr[1536] = dutyCycle;
            break;
        case 17:
            virt_addr[1536] = dutyCycle;
            break;
        case 18:
            virt_addr[1536] = dutyCycle;
            break;
        case 19:
            virt_addr[1536] = dutyCycle;
            break;
        case 20:
            virt_addr[1536] = dutyCycle;
            break;
        case 21:
            virt_addr[1536] = dutyCycle;
            break;
        case 22:
            virt_addr[1536] = dutyCycle;
            break;
        case 23:
            virt_addr[1536] = dutyCycle;
            break;
        }
        QSiePWMEvent *event = new QSiePWMEvent(gpio,dutyCycle);
        QApplication::sendEvent(MW::getInstance()->mainWindow,event);
        QApplication::processEvents();
        
        return 0;
    }

    static int encoder(lua_State* l){
        // This function just reads a FPGA 32bits register to count each wheel steps
        //(steps per revolution depends on the robot, current is 24)
        // initial value on the FPGA is 0, the number increases/deacreases with forward/backward
        // negative values are also possible
//int side,steps;

		int side = luaL_optint(l,1,0); // obtain encoder side parameter (0->right, 1->left)
        int steps;

        if(side == 0)steps = virt_addr[0];
        else steps = virt_addr[512];

//        lua_pushinteger(l,steps);   // push steps count

        lua_pushinteger(l,steps);
        //dummies++;
        
        QSIEEncoderEvent *event = new QSIEEncoderEvent((QSIEEncoderEvent::Side)side,steps);
        QApplication::sendEvent(MW::getInstance()->mainWindow,event);
        QApplication::processEvents();
        
        return 1;
    }
    
    //restart encoder function
    static int restart_enc(lua_State* l){
        virt_addr[0] = 0;
        virt_addr[512] = 0;

        return 0;
    }

    static int print_qt(lua_State* l){
        const char *message = luaL_optstring(l,1,0); // obtain text parameter
        int time = luaL_optint(l,2,1000); // obtain message time parameter
        QSIEMessageEvent *event = new QSIEMessageEvent(message,time);
        QApplication::sendEvent(MW::getInstance()->mainWindow,event);
        QApplication::processEvents();
        return 0;
    }
    //Terminate lua state and then this program
   /* static int terminate(lua_State* l){
        // This function will destroy all objects on the lua state, and then exit

            lua_close(l);
            printf ("Program end!\n");
            //exit(0);

        return 0;
    }*/
    
    static void openSerial()
    {
        char *file = "/dev/ttyS0";
        serial_fd=serial_open(file,B57600);
    }
    static void closeSerial()
    {
        //-- Close the serial port
        serial_close(serial_fd);
    }
    static void gps(){
               
        //-- Open the serial port
        //-- The speed is configure at 57600 baud
                
        if (serial_fd==-1) {
           qDebug()<<"Error opening the serial device: /dev/ttyS0";
           perror("OPEN");
        }
        
        //-- Wait for the received data
        
        n = serial_read(serial_fd,data,50,TIMEOUT);
        char* temp;
        if (n>0) {
            
            //the GLL sentence: $GPGLL,0444.0313,N,07401.8391,W,043449.400,A,D*40
            // needed data:            xxxx xxxx   xxxxx xxxx   xxxxxx xxx
            //printf("data: %s",data);
            if (strncmp (data,"$GPGLL,",7) == 0){
                
                // Latitude parsing in degrees
                //printf("flush with for 1\n");
                //memset(temp,0,sizeof(temp));
                temp=new char[12];
                strncpy(temp, data+7,2);
			    lat = atof(temp);
			    delete temp;
			    temp=new char[12];
			    strncpy(temp, data+9,7);
			    lat += atof(temp)/60;
			    delete temp;
			    temp=new char[12];
			    if(memcmp(data+17,"S",1) == 0)lat *= -1;
			    delete temp;
                //Longitud parsing in degrees
                temp=new char[12];
                strncpy(temp, data+19,3);
			    lon = atof(temp);
			    delete temp;
			    temp=new char[12];
			    strncpy(temp, data+22,7);
			    lon += atof(temp)/60;
			    delete temp;
			    temp=new char[12];
			    if(memcmp(data+30,"W",1) == 0)lon *= -1;
			    delete temp;
		    }
		}/*else {
            printf ("Timeout!\n");
            lua_pushnumber(l,-1);   // push -1 due to the timeout
        }*/
        QSieGPSEvent *event = new QSieGPSEvent(lon,lat,false);
        QApplication::sendEvent(MW::getInstance()->mainWindow,event);
        QApplication::processEvents();
    }
    //GPS data function
    static int gps(lua_State* l){
        
        int req = luaL_optint(l,1,0);      // obtain requested info value
                                            // 0 latitude (will be returned in degrees)
                                            // 1 longitude ('')
                                            // 2 time (UTC hhmmss.sss) (not used yet)
        if(n==0)
        {
                printf ("Bad GPS config!\n");
                lua_pushnumber(l,-1);   // push -1 due to the bad string gathered
                return 1;
        }                    
        switch (req){
                case 0:
                    lua_pushinteger(l,lat*1000000);   // push latitude
                break;
                case 1:
                    lua_pushinteger(l,lon*1000000);   // push longitud
                break;
                default:
                    printf("switch case default :P");
                break;
            }
        QSieGPSEvent *event = new QSieGPSEvent(lon,lat,true);
        QApplication::sendEvent(MW::getInstance()->mainWindow,event);
        QApplication::processEvents();
        return 1;
    }
    
    
};
#endif // DEFINITIONS_H
