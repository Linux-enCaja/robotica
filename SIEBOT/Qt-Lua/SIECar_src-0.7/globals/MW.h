
#ifndef MW_H
#define MW_H


class MW
{
private:
///    static MW *instance;

public:
    static MW *getInstance()
    {
    /*if(instance ==0)
        instance = new MW();*/
        static MW* instance = new MW();
    return instance;
    }
    
private:
    MW(){}
    MW(const MW &copy){}
    MW &operator =(const MW &copy){}
public:
QObject *mainWindow;

};

#endif

