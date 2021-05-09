#ifndef EMPLOYEEMANAGMENT_H
#define EMPLOYEEMANAGMENT_H

#include <QObject>
#include <QQmlApplicationEngine>
#include "employeelistmodel.h"

class EmployeeManagment : public QObject
{
    Q_OBJECT

public:
    explicit EmployeeManagment(QObject *parent = nullptr);
    ~EmployeeManagment() override;
    bool setQmlEngine(QQmlApplicationEngine *pQQmlApplicationEngine);
    bool init();

    Q_INVOKABLE void initPage();
    Q_INVOKABLE bool addEmployee(QString pName, QString pSecurityNumber, int pEmployeeType);
    Q_INVOKABLE QString getBounousPercentage(float pClaimedOutPut, float pRealizedOutput);
    Q_INVOKABLE bool printIntoCSVFormate();

signals:
    Q_SIGNAL void errorAddingEmployee(QString pMessage);
    Q_SIGNAL void addEmployeeSuccessFull();
    Q_SIGNAL void printCSVMessage(QString pMessage);

private:
    QQmlApplicationEngine *m_QmlAppEnginePtr;
    EmployeeListModel m_EmployeeModel;
};

#endif // EMPLOYEEMANAGMENT_H
