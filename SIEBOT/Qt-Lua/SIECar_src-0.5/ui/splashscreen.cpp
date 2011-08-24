#include "splashscreen.h"
#include <QResizeEvent>
#include <QTimer>
SplashScreen::SplashScreen(int timeout,QWidget *parent) :
    QSplashScreen(parent)
{
    horizontal = new QPixmap(":/corporative/images/splash.png");
    if(timeout)
        QTimer::singleShot(timeout,this,SLOT(closeAndDelete()));
    this->setPixmap(*horizontal);
}


void SplashScreen::closeAndDelete()
{
    delete horizontal;
    close();
    emit startApp();
    delete this;
}
