/* ---- DOMOTI S.A.S. ----
 * Originaly made by Domoti S.A.S.
 * Calle 98 No 8 28 Of 501 Bogot� Col
 * info@domoti-sas.com
 */

#ifndef SIEMOVEEVENT_H
#define SIEMOVEEVENT_H

#include "SIEEvent.h"
class QSieMoveEvent : public QSieEvent
{
public:
    enum Direction{
        Stop =0,
        Forward =1,
        Backward =2,
        TurnRight=3,
        TurnLeft=4
    };

    QSieMoveEvent(Direction dir,int speed):QSieEvent(QSieEvent::MoveEvent)
    {
        _direction =dir;
        _speed = speed;
    }

    Direction direction()
    {
        return _direction;
    }
    int speed()
    {
        return _speed;
    }

protected:
    Direction _direction;
    int _speed;
};

#endif // SIEMOVEEVENT_H
