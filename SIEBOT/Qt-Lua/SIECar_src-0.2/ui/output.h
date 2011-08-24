#ifndef OUTPUT_H
#define OUTPUT_H

#include <QtGui/QWidget>
#include "globals/configuration.h"
#include <QMovie>
#include <QLabel>
class Output : public QWidget
{
    Q_OBJECT

public:
    Output(QWidget *parent = 0);
    ~Output();
    virtual bool event(QEvent *event);
    QSize sizeHint();
    public slots:
    void start();
protected:
    Configuration *conf;
    QLabel *background;
    QLabel *anim;
    QLabel *title;
};

#endif // OUTPUT_H
