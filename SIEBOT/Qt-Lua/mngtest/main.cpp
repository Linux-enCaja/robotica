#include <QtGui/QApplication>
#include <QMovie>
#include <QDebug>
#include <QLabel>
#include <QFile>

int main(int argc, char *argv[])
{
    QApplication a(argc, argv);
    if(argc != 2)
    {
        qDebug()<<"Error! usage Mngtest [filename]";
        a.exit(0);
        exit(0);
    }
    QLabel *label = new QLabel();
    QMovie *movie = new QMovie(argv[1]);
    qDebug()<< QMovie::supportedFormats() <<     movie->isValid();
    label->setMovie(movie);
    label->show();
    label->setGeometry(0,0,320,240);
    movie->start();

    return a.exec();
}
