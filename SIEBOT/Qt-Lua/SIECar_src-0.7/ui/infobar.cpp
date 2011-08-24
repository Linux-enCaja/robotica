/* ---- DOMOTI S.A.S. ----
 * Originaly made by Domoti S.A.S.
 * Calle 98 No 8 28 Of 501 Bogot� Col
 * info@domoti-sas.com
 */

#include "infobar.h"
InfoBar::InfoBar(QWidget *parent) :
    QWidget(parent)
{
    showAnim = new QPropertyAnimation(this,"geometry",this);
    showAnim->setStartValue(QRect(320,0,80,240));
    showAnim->setEndValue(QRect(240,0,80,240));
    showAnim->setDuration(1000);

    hideAnim = new QPropertyAnimation(this,"geometry",this);
    hideAnim->setStartValue(QRect(240,0,80,240));
    hideAnim->setEndValue(QRect(320,0,80,240));
    hideAnim->setDuration(1000);
    connect(hideAnim,SIGNAL(finished()),this,SLOT(privateHide()));

    status =0;
    statusPix = new QPixmap();
    if(!QPixmapCache::find(QString("red"),statusPix))
    {
        QPixmap pm(":/icons/red");
        QPixmapCache::insert(QString("red"),pm);
        QPixmapCache::find(QString("red"),statusPix);
    }
}


void InfoBar::paintEvent(QPaintEvent *event)
{
    QPainter painter(this);
    painter.setTransform(Configuration::getInstance()->transform);
    QLinearGradient gradient(0, 0, 100, 0);
    gradient.setColorAt(0.0, Qt::transparent);
    gradient.setColorAt(0.1, Qt::black);
    gradient.setColorAt(1.0, Qt::black);
    painter.fillRect(0,0,this->width(),this->height(),gradient);

    painter.drawPixmap(10,5,16,16,*statusPix);

    painter.setPen(QPen(QColor(Qt::white)));
    painter.drawText(0,0,this->width(),20,Qt::AlignCenter,Title);

    painter.drawText(10,100,this->width(),20,Qt::AlignLeft,"Posicion:");
    QString LonStatus = tr("Lon: ") + Lon;
    QString LatStatus = tr("Lat: ") + Lat;
    painter.drawText(10,120,this->width(),20,Qt::AlignLeft,LonStatus);
    painter.drawText(10,140,this->width(),20,Qt::AlignLeft,LatStatus);
    
    painter.drawText(10,180,this->width(),20,Qt::AlignLeft,"Motores:");
    QString motorRStatus = tr("Dcho: ") + mR;
    QString motorLStatus = tr("Izdo: ") + mL;
    painter.drawText(10,200,this->width(),20,Qt::AlignLeft,motorRStatus);
    painter.drawText(10,220,this->width(),20,Qt::AlignLeft,motorLStatus);

    painter.end();
    QWidget::paintEvent(event);
}

void InfoBar::connected()
{
    if(status){
        if(!QPixmapCache::find(QString("green1"),statusPix))
        {
            QPixmap pm(":/icons/green1");
            QPixmapCache::insert(QString("green1"),pm);
            QPixmapCache::find(QString("green1"),statusPix);

        }
        status=0;
    }else{
         if(!QPixmapCache::find(QString("green2"),statusPix))
        {
            QPixmap pm(":/icons/green2");
            QPixmapCache::insert(QString("green2"),pm);
            QPixmapCache::find(QString("green2"),statusPix);

        }
         status=1;
    }
}

void InfoBar::setLon(float longitude)
{
    Lon = QString::number(longitude);
}

void InfoBar::setLat(float latitude)
{
    Lat = QString::number(latitude);
}

void InfoBar::disconnected()
{
    if(!QPixmapCache::find(QString("red"),statusPix))
    {
        QPixmap pm(":/icons/red");
        QPixmapCache::insert(QString("red"),pm);
        QPixmapCache::find(QString("red"),statusPix);
        status =0;
    }
}

void InfoBar::show()
{
    if(this->isHidden()){
    QWidget::show();
    //showAnim->start();
    this->setGeometry(QRect(240,0,80,240));
    }
}

void InfoBar::hide()
{
//    if(hideAnim->state() != QAbstractAnimation::Running)
//    {
//        qDebug() << "hideAnim";
//        hideAnim->start();
        this->setGeometry(QRect(320,0,80,240));
      QWidget::hide();
//    }
}

void InfoBar::privateHide()
{
    QWidget::hide();
}

void InfoBar::setmL(QString steps)
{
    mL = steps;
}

void InfoBar::setmR(QString steps)
{
    mR = steps;
}
