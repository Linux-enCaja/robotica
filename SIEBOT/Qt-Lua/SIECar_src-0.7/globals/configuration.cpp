/* ---- DOMOTI S.A.S. ----
 * Originaly made by Domoti S.A.S.
 * Calle 98 No 8 28 Of 501 Bogot� Col
 * info@domoti-sas.com
 */

#include "configuration.h"

Configuration* Configuration::instance = 0;

Configuration::Configuration()
{

    server = new QLocalServer(this);
    if(server->listen("x-Sie-Car-Server-0.001")){
        qDebug()<<"server running";
    this->connect(server,SIGNAL(newConnection()),this,SLOT(systemEvent()));
    }else
    {
        qDebug()<<"server falied to start";
    }
    connect(&watchdog,SIGNAL(timeout()),this,SLOT(disconnected()));

}


Configuration::~Configuration()
{
#if SIE_CAR
    lua_close(L);
    delete pio;
#endif
    server->close();
    server->deleteLater();
}

void Configuration::systemEvent()
{
    QLocalSocket *clientConnection = server->nextPendingConnection();
         connect(clientConnection, SIGNAL(disconnected()),
                 clientConnection, SLOT(deleteLater()));

    clientConnection->waitForReadyRead();
    QByteArray bytes = clientConnection->readAll();
    clientConnection->flush();
    clientConnection->disconnectFromServer();
    QString mess(bytes);
    if(mess == "exit" || mess == "shutdown")
    {
        Configuration::getInstance()->deleteLater();
        qApp->exit(0);
    }else
    if(mess == "ping")
    {
        watchdog.stop();
        watchdog.start(2000);
        QSIEConnectionEvent *event = new QSIEConnectionEvent(QSIEConnectionEvent::Add);
        SIEmethods::testEvents(event);
    }else
    if(mess.indexOf("play ")!= -1)
    {
        QString filename;
        QStringList parts = mess.split(" ");
        for(int i=0 ; i< parts.length() ; i++)
        {
            if(parts.at(i)=="play")
                filename = parts.at(i+1);
        }
        execute(filename.toAscii().data());
    }else
    if(mess == "pause" || mess == "cancel")
    {
        cancel();
    }else
    if(mess == "showbar")
    {
        emit showBar();
    }else
    if(mess == "hidebar")
    {
        emit hideBar();
    }else
    if(mess == "testloop")
    {
        emit test();
    }
}

void Configuration::disconnected()
{
    QSIEConnectionEvent *event = new QSIEConnectionEvent(QSIEConnectionEvent::Remove);
    SIEmethods::testEvents(event);
    watchdog.stop();
}

Configuration* Configuration::getInstance()
{
    if(instance ==0)
        instance = new Configuration();
    return instance;
}

bool Configuration::execute(char *filename)
{
    // call the lua script
    SIEmethods::openSerial();
    t_id = startTimer(100);
    if (luaL_dofile(L,filename))
    {
        qDebug()<< "Stop";
//        printf("error: %s", lua_tostring(L, -1));
        killTimer(t_id);
        SIEmethods::closeSerial();
        return false;
    }
    killTimer(t_id);
    SIEmethods::closeSerial();
    return true;
}

void Configuration::timerEvent(QTimerEvent *)
{
    SIEmethods::gps();
}
void Configuration::cancel()
{
    lua_yield(L,0);
}

void Configuration::start()//(luaL_Reg sie_Llib[])
{
#if SIE_CAR
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

    // open lua state
    L = lua_open();
    luaL_openlibs(L);

    // open the libs
    luaL_openlib(L, "sie_Llib", sie_Llib, 0);
    
#endif
    
}

int *Configuration::getVirtualAddress()
{
#if SIE_CAR
    return SIEmethods::virt_addr;
#else
    return 0;
#endif


}
