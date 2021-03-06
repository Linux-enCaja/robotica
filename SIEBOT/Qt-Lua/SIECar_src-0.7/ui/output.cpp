#include "output.h"
#include <QFile>
int counter;
Output::Output(int fps,QWidget *parent)
    : QWidget(parent)
{
    if(fps)
    {
        freq = 1000/fps;
        fpsControl.start();
    }else
        freq=0;
    conf = Configuration::getInstance();
    conf->start();
    connect(conf,SIGNAL(hideBar()),this,SLOT(hidebar()));
    connect(conf,SIGNAL(showBar()),this,SLOT(showbar()));
    connect(conf,SIGNAL(test()),this,SLOT(startTestLoop()));
    MW::getInstance()->mainWindow = this;
    backPix = new QPixmap();
    animlabel=0;
    fdmv=bcmv=0;
    lfmv=rtmv=0;
    gpsM = 0;
    movieContainer = new QLabel();
    delayed=false;
    showMessage =false;
    counter=0; // for test purpouses only
    bar = new InfoBar(this);
}

void Output::start()
{
    this->show();
    bar->hide();
    this->setGeometry(0,0,320,240);

    bar->show();

//    this->startTimer(50);

}
Output::~Output()
{
    backPix->detach();
    Configuration::getInstance()->deleteLater();
    delete backPix;
    delete conf;
    delete animlabel;
    delete movieContainer;
    delete fdmv;
    delete bcmv;
    delete lfmv;
    delete rtmv;
}

bool Output::event(QEvent *event)
{
    titleFromEvent(event);
    if(event->type() == QSieEvent::MoveEvent)
    {
        if(freq)
        {
            if(fpsControl.elapsed()<freq)
            {
                return false; //FPS CONTROL
            }
            fpsControl.restart();
        }
        QSieMoveEvent *e = static_cast<QSieMoveEvent*>(event);
        
        switch(e->direction())
        {
        case QSieMoveEvent::Forward:
            adjustBack(MOVE);
            adjustMovie(FORWARD);
//            repaint();
            break;
        case QSieMoveEvent::Backward:
            adjustBack(MOVE);
            adjustMovie(BACKWARD);
//            repaint();
            break;

        case QSieMoveEvent::TurnLeft:
            adjustBack(TURN);
            adjustMovie(LEFT);
//            repaint();
            break;

        case QSieMoveEvent::TurnRight:
            adjustBack(TURN);
            adjustMovie(RIGHT);
//            repaint();
            break;
        case QSieMoveEvent::Stop:
//            repaint();
            break;
        }
        update();
        e->accept();
        return true;

    }else
    if(event->type() == QSieEvent::MessageEvent)
    {
        message2 = static_cast<QSIEMessageEvent*>(event)->message();
        showMessage = true;
        bar->hide();
        QTimer::singleShot(static_cast<QSIEMessageEvent*>(event)->time(),this,SLOT(hideMessage()));
        event->accept();
        return true;
    }else
    if(event->type() == QSieEvent::EncoderEvent)
    {
        QSIEEncoderEvent *e = static_cast<QSIEEncoderEvent*>(event);
        if(e->side() == QSIEEncoderEvent::Left)
            bar->setmL(QString::number(e->steps()));
        if(e->side() == QSIEEncoderEvent::Right)
            bar->setmR(QString::number(e->steps()));
        event->accept();
        return true;
    }else
    if(event->type() == QSieEvent::GPSEvent)
    {
        QSieGPSEvent *e = static_cast<QSieGPSEvent*>(event);
        if(e->show()){
        adjustBack(GPS);
        repaint();
        }
        bar->setLon(e->longitude());
        bar->setLat(e->latitude());
        event->accept();
        return true;
    }else
    if(event->type() == QSieEvent::DelayEvent)
    {
        if(static_cast<QSIEDelayEvent*>(event)->time()>0){
            delayed=true;
            bar->hide();
        }
        else{
            bar->show();
            delayed=false;
        }
        repaint();
        event->accept();
        return true;
    }else
    if(event->type() == QSieEvent::ConnectionEvent)
    {
        QSIEConnectionEvent *e = static_cast<QSIEConnectionEvent*>(event);
        if(e->action() == QSIEConnectionEvent::Add)
        {
            bar->connected();
            bar->repaint();
        }else
        {
            bar->disconnected();
            bar->repaint();
        }
        event->accept();
        return true;
    }
    return QWidget::event(event);
}


void Output::adjustBack(BACK back)
{
    if(!backPix)
        backPix = new QPixmap();
    if(!backPix->isNull())
    {
        backPix->detach();
    }
        
    switch(back)
    {
    case MOVE:
        if(gpsM)
        {
            delete gpsM;
            gpsM=0;
        }
        if(!QPixmapCache::find(QString("move"),backPix))
        {
            QPixmap pm(":/backgrounds/images/move.png");
            QPixmapCache::insert(QString("move"),pm);
            QPixmapCache::find(QString("move"),backPix);
        }
        break;
    case TURN:
        if(gpsM)
        {
            delete gpsM;
            gpsM=0;
        }
        if(!QPixmapCache::find(QString("turn"),backPix))
        {
            QPixmap pm(":/backgrounds/images/turn.png");
            QPixmapCache::insert(QString("turn"),pm);
            QPixmapCache::find(QString("turn"),backPix);
        }
        break;
    case GPS:
        delete backPix;
        backPix=0;
        if(gpsM==0){
            gpsM = new QMovie(":/backgrounds/images/gps.gif");
            movieContainer->setMovie(gpsM);
            gpsM->start();
        }
        break;
    }
}

void Output::titleFromEvent(QEvent *event)
{
    if(event->type()== QSieEvent::MoveEvent)
    {
        QSieMoveEvent *e = static_cast<QSieMoveEvent*>(event);
        switch(e->direction())
        {
        case QSieMoveEvent::Stop:
            title = tr("Detenido");
            break;
        case QSieMoveEvent::Forward:
            title = tr("Adelante");
            break;
        case QSieMoveEvent::Backward:
            title = tr("Atras");
            break;
        case QSieMoveEvent::TurnRight:
            title = tr("Girando Derecha");
            break;
        case QSieMoveEvent::TurnLeft:
            title = tr("Girando Izquierda");
        break;
        }
    }

    if(event->type()== QSieEvent::PWMEvent)
    {
        title = tr("Se�al PWM");
    }
    if(event->type()== QSieEvent::GPSEvent)
    {
        QSieGPSEvent *e = static_cast<QSieGPSEvent*>(event);
        if(e->show())
        title = tr("GPS");
    }
    if(event->type()== QSieEvent::DelayEvent)
    {
        message = tr("Esperando ") + QString::number(static_cast<QSIEDelayEvent*>(event)->time());
    }
}

void Output::paintEvent(QPaintEvent *event)
{
    QPainter painter(this);

    painter.setTransform(Configuration::getInstance()->transform);
    if(backPix)
        painter.drawPixmap(backPix->rect(),*backPix);
    if(gpsM)
    {
        movieContainer->render(&painter);
    }
    painter.drawText(QRect(0,20,260,40),Qt::AlignHCenter,title.toUpper());


    if(delayed){
        painter.fillRect(QRect(0,0,320,240),QBrush(QColor(0,0,0,150)));
        painter.fillRect(15,107,290,25,QBrush(QColor(255,255,255,200)));
        painter.drawText(QRect(20,112,280,40),Qt::AlignHCenter,message);
    }if(showMessage)
    {
        painter.fillRect(QRect(0,0,320,240),QBrush(QColor(0,0,0,150)));
        painter.fillRect(15,107,290,25,QBrush(QColor(255,255,255,200)));
        painter.drawText(QRect(20,112,280,40),Qt::AlignHCenter,message2);
    }
    painter.end();
    QWidget::paintEvent(event);
}

void Output::hideMessage()
{
    showMessage=false;
    bar->show();
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
    	
    	//qDebug() << "existe animacion "<<file.exists(":/animations/images/movefor.mng");
        if(fdmv ==0)
            fdmv = new QMovie(":/animations/images/movefor.gif");
            
        //qDebug()<<"mng animado "<<fdmv->isValid();
        animlabel = new QLabel(this);
        animlabel->setMovie(fdmv);
        animlabel->show();
        fdmv->start();
        labelx = (this->rect().width() - fdmv->frameRect().width())/5;
        labely = (int)(0.35*(float)this->rect().height());
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
        labelx = (this->rect().width() - bcmv->frameRect().width())/5;
        labely = (int)(0.35*(float)this->rect().height());
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
        labely = (this->rect().height() - lfmv->frameRect().height())*2/3;
        labelx = (int)(0.25*(float)this->rect().width());
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
        labely = (this->rect().height() - rtmv->frameRect().height())*2/3;
        labelx = (int)(0.25*(float)this->rect().width());
        width = rtmv->frameRect().width();
        height = rtmv->frameRect().height();
        break;
      case GPSM:
        //scene->setBackgroundBrush(Qt::NoBrush);
        if(gpsM ==0)
            gpsM = new QMovie(":/animations/images/gps.gif");
        qDebug()<<QMovie::supportedFormats ();
        animlabel = new QLabel(this);
        animlabel->setMovie(gpsM);
        animlabel->show();
        gpsM->start();
        labely = (this->rect().height() - gpsM->frameRect().height())/2;
        labelx = (int)(0.0*(float)this->rect().width());
        width = gpsM->frameRect().width();
        height = gpsM->frameRect().height();
        //QPixmap pix(":/animations/images/gps.mng");
        //backlabel->setPixmap(pix);
        break;
    }


    animlabel->setGeometry(labelx,labely,width,height);
}

QSize Output::sizeHint()
{
    return QSize(320,240);
}
#if !SIE_CAR
void Output::timerEvent(QTimerEvent *event)
{
    if(counter <100){
        QSieMoveEvent *e = new QSieMoveEvent(QSieMoveEvent::Forward,10);
        SIEmethods::testEvents(e);
        QSIEEncoderEvent *event = new QSIEEncoderEvent(QSIEEncoderEvent::Left,counter);
        SIEmethods::testEvents(event);
        event = new QSIEEncoderEvent(QSIEEncoderEvent::Right,counter);
        SIEmethods::testEvents(event);
        QApplication::processEvents();
    }else
    if(counter < 200){
        QSieMoveEvent *e = new QSieMoveEvent(QSieMoveEvent::Backward,10);
        SIEmethods::testEvents(e);
        QApplication::processEvents();
        QSIEEncoderEvent *event = new QSIEEncoderEvent(QSIEEncoderEvent::Left,counter);
        SIEmethods::testEvents(event);
        QApplication::processEvents();
        event = new QSIEEncoderEvent(QSIEEncoderEvent::Right,counter);
        SIEmethods::testEvents(event);
        QApplication::processEvents();
    }else
    if(counter < 300){
        QSieMoveEvent *e = new QSieMoveEvent(QSieMoveEvent::TurnLeft,10);
        SIEmethods::testEvents(e);
        QSIEEncoderEvent *event = new QSIEEncoderEvent(QSIEEncoderEvent::Left,counter);
        SIEmethods::testEvents(event);
        event = new QSIEEncoderEvent(QSIEEncoderEvent::Right,counter);
        SIEmethods::testEvents(event);
    }else
    if(counter < 400){
        QSieMoveEvent *e = new QSieMoveEvent(QSieMoveEvent::TurnRight,10);
        SIEmethods::testEvents(e);
        QSIEEncoderEvent *event = new QSIEEncoderEvent(QSIEEncoderEvent::Left,counter);
        SIEmethods::testEvents(event);
        event = new QSIEEncoderEvent(QSIEEncoderEvent::Right,counter);
        SIEmethods::testEvents(event);
    }else
    if(counter < 401){
        QSieMoveEvent *e = new QSieMoveEvent(QSieMoveEvent::Stop,0);
        SIEmethods::testEvents(e);
        QApplication::processEvents();
        int milisec = 3000;
        QTime t;
        t.start();
        while(t.elapsed()<milisec)
        {
            QSIEDelayEvent *event = new QSIEDelayEvent(milisec-t.elapsed());
            QApplication::sendEvent(MW::getInstance()->mainWindow,event);
        }
        QSIEDelayEvent *event = new QSIEDelayEvent(-1); //INDICA QUE SE ACABO EL DELAY
        QApplication::sendEvent(MW::getInstance()->mainWindow,event);
    }else
    if(counter < 501){
        QSieGPSEvent *e = new QSieGPSEvent(1534,-252);
        SIEmethods::testEvents(e);
        QSIEEncoderEvent *event = new QSIEEncoderEvent(QSIEEncoderEvent::Left,counter);
        SIEmethods::testEvents(event);
        event = new QSIEEncoderEvent(QSIEEncoderEvent::Right,counter);
        SIEmethods::testEvents(event);
    }else
    {

        counter =0;
    }

    counter++;
}
#endif
