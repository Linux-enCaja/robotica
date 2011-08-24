/* ---- DOMOTI S.A.S. ----
 * Originaly made by Domoti S.A.S.
 * Calle 98 No 8 28 Of 501 Bogot� Col
 * info@domoti-sas.com
 */

#ifndef GPSEVENT_H
#define GPSEVENT_H
#include "SIEEvent.h"
#include <QPoint>
class QSieGPSEvent :public QSieEvent
{
public:
    QSieGPSEvent(float longitude,float latitude, bool show):QSieEvent(QSieEvent::GPSEvent)
    {
        lon = longitude;
        lat = latitude;
        _show = show;
    }
   
    float longitude(){return lon;}
    float latitude(){return lat;}
    bool show(){return _show;}
    
protected:
    float lon,lat;
    bool _show;
};

#endif // GPSEVENT_H
