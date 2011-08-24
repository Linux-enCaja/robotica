#ifndef OUTPUT_H
#define OUTPUT_H

#include <QtGui/QMainWindow>
#include "globals/configuration.h"
#include <QMovie>
#include <QLabel>
#include <QGraphicsScene>
#include <QGraphicsView>
#include <QMouseEvent>
#include <QTimerEvent>
#include <QPaintEvent>
class Output : public QMainWindow
{
    Q_OBJECT
private:
    enum BACK{
        MOVE,TURN
            };enum MOVIE{
        FORWARD,BACKWARD,LEFT,RIGHT,GPS
    };

public:
    Output(QWidget *parent = 0);
    ~Output();
    virtual bool event(QEvent *event);

    QSize sizeHint();
    public slots:
    void start();

    virtual void timerEvent(QTimerEvent *);
private:
    void adjustMovie(MOVIE movie);
    void adjustBack(BACK back);
protected:
    Configuration *conf;
    QGraphicsScene *scene;
    QGraphicsView *view;
    QBrush *movebck,*turnbck;
    QMovie *fdmv,*bcmv,*lfmv,*rtmv,*gpsmv;
    QLabel *animlabel,*backlabel;
};

#endif // OUTPUT_H
