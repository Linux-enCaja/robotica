/* ---- DOMOTI S.A.S. ----
 * Originaly made by Domoti S.A.S.
 * Calle 98 No 8 28 Of 501 Bogot� Col
 * info@domoti-sas.com
 */

#ifndef DELAYEVENT_H
#define DELAYEVENT_H
#include "SIEEvent.h"

class QSIEDelayEvent : public QSieEvent
{
public:

    QSIEDelayEvent(int secs):QSieEvent(QSieEvent::DelayEvent)
    {
        _secs = secs;
    }

    int time()
    {
        return _secs;
    }

protected:
    int _secs;
};
#endif // DELAYEVENT_H
