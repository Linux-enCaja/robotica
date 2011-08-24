/* ---- DOMOTI S.A.S. ----
 * Originaly made by Domoti S.A.S.
 * Calle 98 No 8 28 Of 501 Bogot� Col
 * info@domoti-sas.com
 */

#ifndef CONFIGURATION_H
#define CONFIGURATION_H

/* ---------------------------
 * |    SINGLETON CLASS      |
 * ---------------------------
 */

extern "C" {
#include "include/lua.h"
#include "include/lualib.h"
#include "include/lauxlib.h"
#if defined (unix)
#include "include/jz47xx_gpio.h"
#include "include/jz47xx_mmap.h"
#endif
}

#define CS2_PORT JZ_GPIO_PORT_B
#define CS2_PIN  26

#include "../functions/definitions.h"
#include <QtCore>
#include <QTransform>
#include <QLocalServer>
#include <QLocalSocket>
#include <QTimerEvent>
const static struct luaL_reg sie_Llib [] = {
    {"delayMs", &SIEmethods::delayMs},
    {"pwm", &SIEmethods::pwm},
    {"move", &SIEmethods::move},
    {"encoder", &SIEmethods::encoder},
    {"message", &SIEmethods::print_qt},
    {"gps", &SIEmethods::gps},
    /*{"terminate", &SIEmethods::terminate},*/
    {"restart_enc", &SIEmethods::restart_enc},
    {NULL,NULL} //must be here!
};
class Configuration :public QObject
{
    Q_OBJECT
private:
    static Configuration *instance;

public:
   //static int *virt_addr;
    static Configuration *getInstance();
    void start();//(luaL_Reg sie_Llib[]=0);
    bool execute(char *filename);
    void cancel();
    ~Configuration();
    int *getVirtualAddress();
    virtual void timerEvent(QTimerEvent *);
private slots:
    void systemEvent();
    void disconnected();
signals:
    void showBar();
    void hideBar();
    void test();
private:
    Configuration();
    Configuration(const Configuration &copy){}
    Configuration &operator =(const Configuration &copy){}
#if SIE_CAR
    JZ_PIO *pio;
    int rencoder,lencoder;
#endif
    lua_State *L;
    int t_id;
public:
QWidget *mainWindow;
QTransform transform;
//SieGraphServer *server;
QLocalServer *server;
QTimer watchdog;
};

#endif // CONFIGURATION_H
