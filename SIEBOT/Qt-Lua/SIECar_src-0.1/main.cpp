#include <QtGui/QApplication>
#include "ui/output.h"

int main(int argc, char *argv[])
{
    QApplication a(argc, argv);
    Output w;
    w.show();
    return a.exec();
}
