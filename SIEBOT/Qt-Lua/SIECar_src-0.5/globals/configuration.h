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
class Configuration
{
private:
    static Configuration *instance;

public:
   //static int *virt_addr;
    static Configuration *getInstance();
    void start();//(luaL_Reg sie_Llib[]=0);
    bool execute();
    ~Configuration();
    int *getVirtualAddress();

private:
    Configuration();
    Configuration(const Configuration &copy){}
    Configuration &operator =(const Configuration &copy){}
#if defined(unix)
    JZ_PIO *pio;
    int rencoder,lencoder;
#endif
    lua_State *L;
public:
QWidget *mainWindow;

};

#endif // CONFIGURATION_H
