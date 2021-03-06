#ifndef SPLASHSCREEN_H
#define SPLASHSCREEN_H

#include <QSplashScreen>

class SplashScreen : public QSplashScreen
{
    Q_OBJECT
public:
    explicit SplashScreen(int timeout=0,QWidget *parent = 0);

private slots:
    void closeAndDelete();
    signals:
    void startApp();
protected:
    QPixmap *horizontal;
//    QPixmap *vertical;
};

#endif // SPLASHSCREEN_H
