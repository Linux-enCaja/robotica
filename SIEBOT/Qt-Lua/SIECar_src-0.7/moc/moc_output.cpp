/****************************************************************************
** Meta object code from reading C++ file 'output.h'
**
** Created: Thu Feb 10 17:37:54 2011
**      by: The Qt Meta Object Compiler version 62 (Qt 4.7.1)
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#include "../ui/output.h"
#if !defined(Q_MOC_OUTPUT_REVISION)
#error "The header file 'output.h' doesn't include <QObject>."
#elif Q_MOC_OUTPUT_REVISION != 62
#error "This file was generated using the moc from 4.7.1. It"
#error "cannot be used with the include files from this version of Qt."
#error "(The moc has changed too much.)"
#endif

QT_BEGIN_MOC_NAMESPACE
static const uint qt_meta_data_Output[] = {

 // content:
       5,       // revision
       0,       // classname
       0,    0, // classinfo
       6,   14, // methods
       0,    0, // properties
       0,    0, // enums/sets
       0,    0, // constructors
       0,       // flags
       0,       // signalCount

 // slots: signature, parameters, type, tag, flags
       8,    7,    7,    7, 0x0a,
      16,    7,    7,    7, 0x0a,
      26,    7,    7,    7, 0x0a,
      36,    7,    7,    7, 0x0a,
      52,    7,    7,    7, 0x0a,
      77,    7,    7,    7, 0x08,

       0        // eod
};

static const char qt_meta_stringdata_Output[] = {
    "Output\0\0start()\0showbar()\0hidebar()\0"
    "startTestLoop()\0paintEvent(QPaintEvent*)\0"
    "hideMessage()\0"
};

const QMetaObject Output::staticMetaObject = {
    { &QWidget::staticMetaObject, qt_meta_stringdata_Output,
      qt_meta_data_Output, 0 }
};

#ifdef Q_NO_DATA_RELOCATION
const QMetaObject &Output::getStaticMetaObject() { return staticMetaObject; }
#endif //Q_NO_DATA_RELOCATION

const QMetaObject *Output::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->metaObject : &staticMetaObject;
}

void *Output::qt_metacast(const char *_clname)
{
    if (!_clname) return 0;
    if (!strcmp(_clname, qt_meta_stringdata_Output))
        return static_cast<void*>(const_cast< Output*>(this));
    return QWidget::qt_metacast(_clname);
}

int Output::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
{
    _id = QWidget::qt_metacall(_c, _id, _a);
    if (_id < 0)
        return _id;
    if (_c == QMetaObject::InvokeMetaMethod) {
        switch (_id) {
        case 0: start(); break;
        case 1: showbar(); break;
        case 2: hidebar(); break;
        case 3: startTestLoop(); break;
        case 4: paintEvent((*reinterpret_cast< QPaintEvent*(*)>(_a[1]))); break;
        case 5: hideMessage(); break;
        default: ;
        }
        _id -= 6;
    }
    return _id;
}
QT_END_MOC_NAMESPACE