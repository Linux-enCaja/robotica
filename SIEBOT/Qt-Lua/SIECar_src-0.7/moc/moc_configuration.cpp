/****************************************************************************
** Meta object code from reading C++ file 'configuration.h'
**
** Created: Thu Feb 10 17:37:57 2011
**      by: The Qt Meta Object Compiler version 62 (Qt 4.7.1)
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#include "../globals/configuration.h"
#if !defined(Q_MOC_OUTPUT_REVISION)
#error "The header file 'configuration.h' doesn't include <QObject>."
#elif Q_MOC_OUTPUT_REVISION != 62
#error "This file was generated using the moc from 4.7.1. It"
#error "cannot be used with the include files from this version of Qt."
#error "(The moc has changed too much.)"
#endif

QT_BEGIN_MOC_NAMESPACE
static const uint qt_meta_data_Configuration[] = {

 // content:
       5,       // revision
       0,       // classname
       0,    0, // classinfo
       5,   14, // methods
       0,    0, // properties
       0,    0, // enums/sets
       0,    0, // constructors
       0,       // flags
       3,       // signalCount

 // signals: signature, parameters, type, tag, flags
      15,   14,   14,   14, 0x05,
      25,   14,   14,   14, 0x05,
      35,   14,   14,   14, 0x05,

 // slots: signature, parameters, type, tag, flags
      42,   14,   14,   14, 0x08,
      56,   14,   14,   14, 0x08,

       0        // eod
};

static const char qt_meta_stringdata_Configuration[] = {
    "Configuration\0\0showBar()\0hideBar()\0"
    "test()\0systemEvent()\0disconnected()\0"
};

const QMetaObject Configuration::staticMetaObject = {
    { &QObject::staticMetaObject, qt_meta_stringdata_Configuration,
      qt_meta_data_Configuration, 0 }
};

#ifdef Q_NO_DATA_RELOCATION
const QMetaObject &Configuration::getStaticMetaObject() { return staticMetaObject; }
#endif //Q_NO_DATA_RELOCATION

const QMetaObject *Configuration::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->metaObject : &staticMetaObject;
}

void *Configuration::qt_metacast(const char *_clname)
{
    if (!_clname) return 0;
    if (!strcmp(_clname, qt_meta_stringdata_Configuration))
        return static_cast<void*>(const_cast< Configuration*>(this));
    return QObject::qt_metacast(_clname);
}

int Configuration::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
{
    _id = QObject::qt_metacall(_c, _id, _a);
    if (_id < 0)
        return _id;
    if (_c == QMetaObject::InvokeMetaMethod) {
        switch (_id) {
        case 0: showBar(); break;
        case 1: hideBar(); break;
        case 2: test(); break;
        case 3: systemEvent(); break;
        case 4: disconnected(); break;
        default: ;
        }
        _id -= 5;
    }
    return _id;
}

// SIGNAL 0
void Configuration::showBar()
{
    QMetaObject::activate(this, &staticMetaObject, 0, 0);
}

// SIGNAL 1
void Configuration::hideBar()
{
    QMetaObject::activate(this, &staticMetaObject, 1, 0);
}

// SIGNAL 2
void Configuration::test()
{
    QMetaObject::activate(this, &staticMetaObject, 2, 0);
}
QT_END_MOC_NAMESPACE
