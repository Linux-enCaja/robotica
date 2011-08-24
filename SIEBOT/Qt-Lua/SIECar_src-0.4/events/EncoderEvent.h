/* ---- DOMOTI S.A.S. ----
 * Originaly made by Domoti S.A.S.
 * Calle 98 No 8 28 Of 501 Bogot� Col
 * info@domoti-sas.com
 */

#ifndef ENCODEREVENT_H
#define ENCODEREVENT_H
#include "SIEEvent.h"

class QSIEEncoderEvent : public QSieEvent
{
public:
    enum Side{
        Right=0,Left =1
    };

    QSIEEncoderEvent(Side side,int steps):QSieEvent(QSieEvent::EncoderEvent)
    {
        _side = side;
        _steps = steps;
    }
    Side side()
    {
        return _side;
    }
    int steps()
    {
        return _steps;
    }

protected:
    Side _side;
    int _steps;
};

#endif // ENCODEREVENT_H
