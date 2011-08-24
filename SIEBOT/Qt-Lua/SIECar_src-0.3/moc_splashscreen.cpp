/****************************************************************************
** Meta object code from reading C++ file 'splashscreen.h'
**
** Created: Fri Jan 28 14:16:35 2011
**      by: The Qt Meta Object Compiler version 62 (Qt 4.7.0)
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#include "ui/splashscreen.h"
#if !defined(Q_MOC_OUTPUT_REVISION)
#error "The header file 'splashscreen.h' doesn't include <QObject>."
#elif Q_MOC_OUTPUT_REVISION != 62
#error "This file was generated using the moc from 4.7.0. It"
#error "cannot be used with the include files from this version of Qt."
#error "(The moc has changed too much.)"
#endif

QT_BEGIN_MOC_NAMESPACE
static const uint qt_meta_data_SplashScreen[] = {

 // content:
       5,       // revision
       0,       // classname
       0,    0, // classinfo
       2,   14, // methods
       0,    0, // properties
       0,    0, // enums/sets
       0,    0, // constructors
       0,       // flags
       1,       // signalCount

 // signals: signature, parameters, type, tag, flags
      14,   13,   13,   13, 0x05,

 // slots: signature, parameters, type, tag, flags
      25,   13,   13,   13, 0x08,

       0        // eod
};

static const char qt_meta_stringdata_SplashScreen[] = {
    "SplashScreen\0\0startApp()\0closeAndDelete()\0"
};

const QMetaObject SplashScreen::staticMetaObject = {
    { &QSplashScreen::staticMetaObject, qt_meta_stringdata_SplashScreen,
      qt_meta_data_SplashScreen, 0 }
};

#ifdef Q_NO_DATA_RELOCATION
const QMetaObject &SplashScreen::getStaticMetaObject() { return staticMetaObject; }
#endif //Q_NO_DATA_RELOCATION

const QMetaObject *SplashScreen::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->metaObject : &staticMetaObject;
}

void *SplashScreen::qt_metacast(const char *_clname)
{
    if (!_clname) return 0;
    if (!strcmp(_clname, qt_meta_stringdata_SplashScreen))
        return static_cast<void*>(const_cast< SplashScreen*>(this));
    return QSplashScreen::qt_metacast(_clname);
}

int SplashScreen::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
{
    _id = QSplashScreen::qt_metacall(_c, _id, _a);
    if (_id < 0)
        return _id;
    if (_c == QMetaObject::InvokeMetaMethod) {
        switch (_id) {
        case 0: startApp(); break;
        case 1: closeAndDelete(); break;
        default: ;
        }
        _id -= 2;
    }
    return _id;
}

// SIGNAL 0
void SplashScreen::startApp()
{
    QMetaObject::activate(this, &staticMetaObject, 0, 0);
}
QT_END_MOC_NAMESPACE
