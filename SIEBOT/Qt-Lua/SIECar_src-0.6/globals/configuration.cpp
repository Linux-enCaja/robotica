/* ---- DOMOTI S.A.S. ----
 * Originaly made by Domoti S.A.S.
 * Calle 98 No 8 28 Of 501 Bogot� Col
 * info@domoti-sas.com
 */

#include "configuration.h"

Configuration* Configuration::instance = 0;

Configuration::Configuration()
{
}
Configuration::~Configuration()
{
#if defined(unix)
    lua_close(L);
    delete pio;
#endif
}

Configuration* Configuration::getInstance()
{
    if(instance ==0)
        instance = new Configuration();
    return instance;
}

bool Configuration::execute()
{
    // call the lua script
#if defined (unix)
    if (luaL_loadfile(L, "sie_program") || lua_pcall(L, 0, 0, 0))
    {
        qDebug()<< "Error leyendo lua";
//        printf("error: %s", lua_tostring(L, -1));
        return false;
    }
#endif
    return true;
}

void Configuration::start()//(luaL_Reg sie_Llib[])
{
#if defined(unix)
qDebug()<< "start";
    pio = jz_gpio_map(CS2_PORT);
    jz_gpio_as_func(pio,CS2_PIN,0);
    SIEmethods::virt_addr = (int *) jz_mmap (0x13010000) + 0x18;

    if (*SIEmethods::virt_addr != 0xFFF7700){
        *SIEmethods::virt_addr = 0xFFF7700;                 // 0 WS, 8 bits
        printf ("Configuring CS2 8 bits \n");
    }
    else
    printf ("CS2, already configured\n");

    SIEmethods::virt_addr = (int *) jz_fpga_map (0x14000000);

    // Build lib struct for Lua
    const static struct luaL_reg sie_Llib [] = {
        {"delayMs", &SIEmethods::delayMs},
        {"pwm", &SIEmethods::pwm},
        {"move", &SIEmethods::move},
        {"encoder", &SIEmethods::encoder},
        {"message", &SIEmethods::print_qt},
        /*{"gps", &SIEmethods::gps},*/
        {"terminate", &SIEmethods::terminate},
        {"restart_enc", &SIEmethods::restart_enc},
        {NULL,NULL} //must be here!
    };


    // open lua state
    L = lua_open();
    luaL_openlibs(L);

    // open the libs
    luaL_openlib(L, "sie_Llib", sie_Llib, 0);
#endif
    /**/
}

int *Configuration::getVirtualAddress()
{
#if defined(unix)
    return SIEmethods::virt_addr;
#else
    return 0;
#endif


}
