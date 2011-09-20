#include "output.h"

Output::Output(QWidget *parent)
    : QWidget(parent)
{
    background = new QLabel();
    //anim = new QLabel(background);
    //title = new QLabel(background);
    conf = Configuration::getInstance();
    // Build lib struct for Lua

    conf->start();
    

}

void Output::start()
{
conf->execute();
    
}
Output::~Output()
{

}

bool Output::event(QEvent *event)
{
qDebug()<<"evento "<< event->type();

    if(event->type() == QSieEvent::MoveEvent)
    {
    qDebug() << "moving event";
        QSieMoveEvent *e = static_cast<QSieMoveEvent*>(event);
        QMovie *movie;
        switch(e->direction())
        {
        case QSieMoveEvent::Forward:
            background->setPixmap(QPixmap(":/backgrounds/images/move.png"));
            movie = new QMovie(":backgrounds/images/movefor.gif");
            anim->setMovie(movie);
            movie->start();

        break;

        case QSieMoveEvent::Backward:
            background->setPixmap(QPixmap(":/backgrounds/images/move.png"));
            movie = new QMovie(":backgrounds/images/moveback.gif");
            anim->setMovie(movie);
            movie->start();
        break;

        case QSieMoveEvent::TurnLeft:
            background->setPixmap(QPixmap(":/backgrounds/images/turn.png"));
            movie = new QMovie(":backgrounds/images/turnleft.gif");
            anim->setMovie(movie);
            movie->start();
        break;

        case QSieMoveEvent::TurnRight:
            background->setPixmap(QPixmap(":/backgrounds/images/turn.png"));
            movie = new QMovie(":backgrounds/images/turnright.gif");
            anim->setMovie(movie);
            movie->start();
        break;
        }
            background->showFullScreen();
            anim->show();
    }
    if(event->type() == QSieEvent::EncoderEvent)
    {
qDebug() << "encoder event";
    }
    if(event->type() == QSieEvent::GPSEvent)
    {
qDebug() << "gps event";
        background->setMovie(new QMovie(":backgrounds/images/gps.gif"));
    }
    return false;
}

QSize Output::sizeHint()
{
    return QSize(320,240);
}