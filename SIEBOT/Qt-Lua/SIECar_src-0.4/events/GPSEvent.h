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
    QSieGPSEvent(int longitude,int latitude):QSieEvent(QSieEvent::GPSEvent)
    {
        lon = longitude;
        lat = latitude;
    }
    QSieGPSEvent(QPoint point):QSieEvent(QSieEvent::GPSEvent)
    {
        lon = point.x();
        lat = point.y();
    }
    int longitude(){return lon;}
    int latitude(){return lat;}
    QPoint pos(){return QPoint(lon,lat);}
protected:
    int lon,lat;
};

#endif // GPSEVENT_H
