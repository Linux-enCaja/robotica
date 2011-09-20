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
#if defined (unix)
//#include "include/jz47xx_gpio.c"
//#include "include/jz47xx_mmap.c"
#define CS2_PORT JZ_GPIO_PORT_B
#define CS2_PIN  26
#endif
#include <QTime>
#include <QApplication>
#include <QMouseEvent>
#include <QDebug>
namespace SIEmethods{
//public:
    static int *virt_addr;
//    QObject *mW;
//    void setMW(QObject *obj){mainWindow = obj;}
    static int delayMs(lua_State* l){
    qDebug()<< "delay";
        int milisec=0;


        milisec=luaL_optint(l,1,0); // obtain parameter

        if (milisec==0)
            return 0;
#if defined (unix)
        struct timespec req={0};
        time_t sec;

        sec=(int)(milisec/1000);

        milisec = milisec - (sec*1000);

        req.tv_sec=sec;
        req.tv_nsec=milisec*1000000L;

        while(nanosleep(&req,&req)==-1)
            continue;
#elif defined (__WIN32__)
        QTime t;
        t.start();
        while(t.elapsed()<milisec){}
#endif

        return 0;
    }

    static void testEvents()
    {
        QMouseEvent *event = new QMouseEvent(QEvent::MouseButtonPress,QPoint(100,100)
                                             ,Qt::LeftButton,Qt::NoButton,Qt::NoModifier);
//        QApplication::sendEvent(mW,event);
    }

    // Move function
    static int move(lua_State* l){
    qDebug()<< "move";
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

        switch(action){
        case 0:                     //stop
            virt_addr[1024] = 0;
            break;
        case 1:                     //move forward
            speed &= 0xFF;
            virt_addr[1024] = speed | (speed << 24);
            break;
        case 2:                     //move backward
            speed &= 0xFF;
            virt_addr[1024] = (speed << 8) | (speed << 16);
            break;
        case 3:                     //turn right
            speed &= 0xFF;
            virt_addr[1024] = (speed << 16) | (speed << 24);
            break;
        case 4:                     //turn left
            speed &= 0xFF;
            virt_addr[1024] = speed | (speed << 8);
            break;
        }

        return 0;
    }

    static int pwm(lua_State* l){
qDebug()<< "pwm";
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

        return 0;
    }

    static int encoder(lua_State* l){
qDebug()<< "encoder";
        // This function just reads a FPGA 32bits register to count each wheel steps
        //(steps per revolution depends on the robot, current is 24)
        // initial value on the FPGA is 0, the number increases/deacreases with forward/backward
        // negative values are also possible

        int side = luaL_optint(l,1,0); // obtain encoder side parameter (0->right, 1->left)
        int steps;

        if(side == 0)steps = virt_addr[0];
        else steps = virt_addr[512];

        lua_pushinteger(l,steps);   // push steps count

        return 1;
    }
    
    //restart encoder function
static int restart_enc(lua_State* l){

    virt_addr[0] = 0;
    virt_addr[512] = 0;
    
    return 0;
}

//Terminate lua state and then this program
static int terminate(lua_State* l){

    // This function will destroy all objects on the lua state, and then exit
    
    lua_close(l);
    printf ("Program end!\n");
    exit(0);
    
    return 0;
}
};
#endif // DEFINITIONS_H