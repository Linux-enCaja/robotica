#include <QtGui/QApplication>
#include "ui/output.h"
#include "ui/splashscreen.h"
#include "qfontdatabase.h"
int main(int argc, char *argv[])
{
    QApplication a(argc, argv);
    for(int i =0 ; i< argc ; i++)
    {
        QString arg(argv[i]);
        if(arg == "rotate" || arg == "-rotate" || arg == "-r")
        {
            //CHECK Value
            if(i < argc-1)
            {
                QString value(argv[i+1]);
                bool success;
                int v = value.toInt(&success);
                if(success){
                    QTransform trans;
                    trans.translate(180,120);
                    trans.rotate(v);
                    trans.translate(-180,-120);
                    Configuration::getInstance()->transform = trans;
                }else
                {
                    qDebug() <<"WARNING: Invalid value for rotate";
                }
            }else
            {
                qDebug()<<"WARNING: You must provide an angle (degrees) after rotate";
            }
        }
    }
    QApplication::setOverrideCursor(Qt::BlankCursor);

    Output *w = new Output(24);
    qDebug()<<w->cursor().pos();
    w->cursor().setPos(320,240);
    SplashScreen *splash = new SplashScreen(3000);

    QFile bold(":fonts/Bold");
    bold.open(QIODevice::ReadOnly);
    int id = QFontDatabase::addApplicationFontFromData(bold.readAll());
    QFont f(QFontDatabase::applicationFontFamilies(id).first());
    QApplication::setFont(f);
    splash->showFullScreen();
    splash->connect(splash,SIGNAL(startApp()),w,SLOT(start()));

  return a.exec();
}
