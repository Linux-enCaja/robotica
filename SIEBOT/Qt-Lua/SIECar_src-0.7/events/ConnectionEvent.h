#ifndef CONNECTIONEVENT_H
#define CONNECTIONEVENT_H

#include "SIEEvent.h"
class QSIEConnectionEvent : public QSieEvent
{
public:
    enum Action{
        Add=0,Remove=1
    };

    QSIEConnectionEvent(Action action):QSieEvent(QSieEvent::ConnectionEvent)
    {
        _action = action;
    }
    Action action()
    {
        return _action;
    }

protected:
    Action _action;
};

#endif // CONNECTIONEVENT_H
