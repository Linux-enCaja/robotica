#ifndef OUTPUT_H
#define OUTPUT_H

#include <QtGui/QWidget>
#include "globals/configuration.h"
#include <QMovie>
#include <QLabel>
#include <QGraphicsScene>
#include <QGraphicsView>
#include <QMouseEvent>
#include <QTimerEvent>
#include <QPaintEvent>
#include <QPainter>
#include <QPixmapCache>
#include <QKeyEvent>
#include "infobar.h"
class Output : public QWidget
{
    Q_OBJECT
private:
    enum BACK{
        MOVE,TURN,GPS
            };enum MOVIE{
        FORWARD,BACKWARD,LEFT,RIGHT,GPSM
    };

public:
    Output(int fps=0,QWidget *parent = 0);
    ~Output();
    virtual bool event(QEvent *event);

    QSize sizeHint();
    public slots:
    void start();
    void showbar(){bar->show();}
    void hidebar(){bar->hide();}
    void startTestLoop(){startTimer(100);}
#if !SIE_CAR
    virtual void timerEvent(QTimerEvent *);
#endif
    virtual void paintEvent(QPaintEvent *);

private slots:
    void hideMessage();
private:
    void titleFromEvent(QEvent *event);
    void adjustBack(BACK back);
    void adjustMovie(MOVIE movie);
protected:
    Configuration *conf;
    QPixmap *backPix;
    QMovie *fdmv,*bcmv,*lfmv,*rtmv,*gpsM;
    QLabel *animlabel,*movieContainer;
    QString title,mR,mL,message,message2;
    QTime fpsControl;
    InfoBar *bar;
private:
    bool delayed,showMessage;
    int freq;
};

#endif // OUTPUT_H
