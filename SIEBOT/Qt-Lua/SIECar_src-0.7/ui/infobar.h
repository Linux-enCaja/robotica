/* ---- DOMOTI S.A.S. ----
 * Originaly made by Domoti S.A.S.
 * Calle 98 No 8 28 Of 501 Bogot� Col
 * info@domoti-sas.com
 */

#ifndef INFOBAR_H
#define INFOBAR_H

#include <QWidget>
#include <QPainter>
#include <QPaintEvent>
#include <QPropertyAnimation>
#include <QDebug>
#include <QPixmapCache>
#include "../globals/configuration.h"
class InfoBar : public QWidget
{
    Q_OBJECT
public:
    explicit InfoBar(QWidget *parent = 0);

    virtual void paintEvent(QPaintEvent *);

    virtual void show();
    virtual void hide();

    void setTitle(QString title);

    void setmL(QString steps);
    void setmR(QString steps);
    
    void setLon(float longitude);
    void setLat(float latitude);
    
    void connected();
    void disconnected();
signals:

private slots:
    void privateHide();
protected:
    QPropertyAnimation *showAnim,*hideAnim;
    QString Title,mR,mL,Lon,Lat;
    QPixmap *statusPix;
    int status;
};

#endif // INFOBAR_H
