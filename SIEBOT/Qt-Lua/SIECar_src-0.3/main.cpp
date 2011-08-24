#include <QtGui/QApplication>
#include "ui/output.h"
#include "ui/splashscreen.h"
int main(int argc, char *argv[])
{
    QApplication a(argc, argv);
    Output *w = new Output();
    SplashScreen *splash = new SplashScreen(4000);
    splash->showFullScreen();
    splash->connect(splash,SIGNAL(startApp()),w,SLOT(start()));

  return a.exec();
}
