/* ---- DOMOTI S.A.S. ----
 * Originaly made by Domoti S.A.S.
 * Calle 98 No 8 28 Of 501 Bogot� Col
 * info@domoti-sas.com
 */

#ifndef PWMEVENT_H
#define PWMEVENT_H
#include "SIEEvent.h"

class QSiePWMEvent :public QSieEvent
{
public:
    QSiePWMEvent(int port,int duty):QSieEvent(QSieEvent::PWMEvent)
    {
        _port = port;
        _duty=duty;
    }
    int port(){return _port;}
    int duty(){return _duty;}
protected:
    int _port,_duty;
};

#endif // PWMEVENT_H
