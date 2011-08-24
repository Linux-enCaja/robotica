#include "output.h"
#include <QFile>
int counter;
Output::Output(QWidget *parent)
    : QMainWindow(parent)
{
	conf = Configuration::getInstance();
    conf->start();
    movebck =0;
    turnbck=0;
    animlabel=0;
    fdmv=bcmv=0;
    lfmv=rtmv=0;
    gpsmv=0;
    scene = new QGraphicsScene();
    view = new QGraphicsView(scene);
    backlabel = new QLabel(this);
    this->setCentralWidget(backlabel);
    //SIEmethods::mW = this;
    MW::getInstance()->mainWindow = this; 
    counter=0;
}

void Output::start()
{

this->showFullScreen();
//conf->execute();
	startTimer(3000);
}
Output::~Output()
{
    delete movebck;
    delete turnbck;
    delete fdmv;
    delete bcmv;
    delete lfmv;
    delete rtmv;
}

bool Output::event(QEvent *event)
{
    if(event->type() == QEvent::MouseButtonPress)
    {
        QMouseEvent *e = new QMouseEvent(QEvent::MouseButtonRelease,QPoint(0,0),Qt::LeftButton
                                         ,Qt::NoButton,Qt::NoModifier);
        this->mouseReleaseEvent(e);
        return false;
    }
    if(event->type() == QSieEvent::MoveEvent)
    {
    	qDebug()<<"llego evento de move";
        QSieMoveEvent *e = static_cast<QSieMoveEvent*>(event);
        switch(e->direction())
        {
        case QSieMoveEvent::Forward:
            adjustBack(MOVE);
            adjustMovie(FORWARD);

        break;
        case QSieMoveEvent::Backward:
            adjustBack(MOVE);
            adjustMovie(BACKWARD);
        break;

        case QSieMoveEvent::TurnLeft:
            adjustBack(TURN);
            adjustMovie(LEFT);
        break;

        case QSieMoveEvent::TurnRight:
            adjustBack(TURN);
            adjustMovie(RIGHT);
        break;
        case QSieMoveEvent::Stop:
            scene->setBackgroundBrush(Qt::NoBrush);
            if(animlabel){
                animlabel->hide();
                animlabel->deleteLater();
                animlabel=0;
            }
        break;
        }
        e->accept();

    }
    if(event->type() == QSieEvent::EncoderEvent)
    {
        qDebug() << "encoder event";
    }
    if(event->type() == QSieEvent::GPSEvent)
    {
        QSieGPSEvent *e = static_cast<QSieGPSEvent*>(event);
        adjustMovie(GPS);
    }
    return QWidget::event(event);
}

void Output::adjustMovie(MOVIE movie)
{
    int labelx,labely,width,height;
    if(animlabel){
        animlabel->hide();
        animlabel->deleteLater();
        animlabel=0;
    }
    QFile file;
    switch(movie)
    {
    case FORWARD:
    	
    	qDebug() << "existe animacion "<<file.exists(":/animations/images/movefor.gif");
        if(fdmv ==0)
            fdmv = new QMovie(":/animations/images/movefor.gif");
            
        qDebug()<<"gif animado "<<fdmv->isValid();
        animlabel = new QLabel(this);
        animlabel->setMovie(fdmv);
        animlabel->show();
        fdmv->start();
        labelx = (this->rect().width() - fdmv->frameRect().width())/2;
        labely = (int)(0.7*(float)this->rect().height());
        width = fdmv->frameRect().width();
        height = fdmv->frameRect().height();
        break;
    case BACKWARD:
        if(bcmv ==0)
            bcmv = new QMovie(":/animations/images/moveback.gif");
        animlabel = new QLabel(this);
        animlabel->setMovie(bcmv);
        animlabel->show();
        bcmv->start();
        labelx = (this->rect().width() - bcmv->frameRect().width())/2;
        labely = (int)(0.7*(float)this->rect().height());
        width = bcmv->frameRect().width();
        height = bcmv->frameRect().height();
        break;
    case LEFT:
        if(lfmv ==0)
            lfmv = new QMovie(":/animations/images/turnleft.gif");
        animlabel = new QLabel(this);
        animlabel->setMovie(lfmv);
        animlabel->show();
        lfmv->start();
        labely = (this->rect().height() - lfmv->frameRect().height())/2;
        labelx = (int)(0.0*(float)this->rect().width());
        width = lfmv->frameRect().width();
        height = lfmv->frameRect().height();

        break;
    case RIGHT:
        if(rtmv ==0)
            rtmv = new QMovie(":/animations/images/turnright.gif");
        animlabel = new QLabel(this);
        animlabel->setMovie(rtmv);
        animlabel->show();
        rtmv->start();
        labely = (this->rect().height() - rtmv->frameRect().height())/2;
        labelx = (int)(0.0*(float)this->rect().width());
        width = rtmv->frameRect().width();
        height = rtmv->frameRect().height();
        break;
      case GPS:
        //scene->setBackgroundBrush(Qt::NoBrush);
        if(gpsmv ==0)
            gpsmv = new QMovie(":/animations/images/gps.gif");
        qDebug()<<QMovie::supportedFormats ();
        animlabel = new QLabel(this);
        animlabel->setMovie(gpsmv);
        animlabel->show();
        gpsmv->start();
        labely = (this->rect().height() - gpsmv->frameRect().height())/2;
        labelx = (int)(0.0*(float)this->rect().width());
        width = gpsmv->frameRect().width();
        height = gpsmv->frameRect().height();
        //QPixmap pix(":/animations/images/gps.gif");
        //backlabel->setPixmap(pix);
        break;
    }


    animlabel->setGeometry(labelx,labely,width,height);
}

void Output::adjustBack(BACK back)
{
    switch(back)
    {
    case MOVE:
        if(!movebck){
            //QTransform transform;
            //transform.translate(160,120);
            QPixmap pix(":/backgrounds/images/move.png");
            movebck = new QBrush(pix);
            //movebck->setTransform(transform);
            backlabel->setPixmap(pix);
            //view->centerOn(160,120);
        }
        scene->setBackgroundBrush(QBrush(*movebck));
        break;
    case TURN:
        if(!turnbck){
            //QTransform transform;
            //transform.translate(160,120);
            QPixmap pix(":/backgrounds/images/turn.png");
            turnbck = new QBrush(pix);
            //turnbck->setTransform(transform);
            backlabel->setPixmap(pix);
        }
        //scene->setBackgroundBrush(QBrush(*turnbck));
        break;
    }
    repaint();
}

void Output::timerEvent(QTimerEvent *)
{
    Q_ASSERT_X(SIEmethods::mW,"mouseRelease Event","W is null");
    if(counter == 0){
        QSieMoveEvent *e = new QSieMoveEvent(QSieMoveEvent::Forward,10);
        SIEmethods::testEvents(e);
    }
    if(counter == 1){
        QSieMoveEvent *e = new QSieMoveEvent(QSieMoveEvent::Backward,10);
        SIEmethods::testEvents(e);
    }
    if(counter == 2){
        QSieMoveEvent *e = new QSieMoveEvent(QSieMoveEvent::TurnLeft,10);
        SIEmethods::testEvents(e);
    }
    if(counter == 3){
        QSieMoveEvent *e = new QSieMoveEvent(QSieMoveEvent::TurnRight,10);
        SIEmethods::testEvents(e);
    }
    if(counter == 4){
        QSieMoveEvent *e = new QSieMoveEvent(QSieMoveEvent::Stop,0);
        SIEmethods::testEvents(e);
    }
    if(counter == 5){
        QSieGPSEvent *e = new QSieGPSEvent(1534,-252);
        SIEmethods::testEvents(e);
    }
    if(counter == 6)
        counter =0;
    counter++;
}

QSize Output::sizeHint()
{
    return QSize(320,240);
}
