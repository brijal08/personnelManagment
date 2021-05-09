#ifndef EMPLOYEEDETAILS_H
#define EMPLOYEEDETAILS_H

#include <QAbstractListModel>
#include <QDate>

class EmployeeDetails : public QAbstractListModel
{
    Q_OBJECT

    Q_PROPERTY(int employeeType READ getEmployeeType WRITE setEmployeeType NOTIFY employeeTypeChanged);
    Q_PROPERTY(QString employeeName READ getEmployeeName WRITE setEmployeeName NOTIFY employeeNameChanged);
    Q_PROPERTY(QString securityNumber READ getSecurityNumber NOTIFY securityNumberChanged);

public:
    explicit EmployeeDetails(QObject *parent = nullptr) : QAbstractListModel(parent){}
    virtual ~EmployeeDetails() {};

    virtual int getEmployeeType() = 0;
    virtual void setEmployeeType(int pEmployeeType) = 0;
    virtual float getCompansastion(QDate pDate) = 0;
    virtual QString getEmployeeName() = 0;
    virtual void setEmployeeName(QString pEmployeeName) = 0;
    virtual QString getSecurityNumber() = 0;
    virtual void setSecurityNumber(QString pSecurityNumber) = 0;

signals:
    void employeeTypeChanged();
    void employeeNameChanged();
    void securityNumberChanged();

protected:
    int enEmployeType = -1;
    QString qstrEmloyeeName;
    QString qstrSecurityNumber;
};

#endif // EMPLOYEEDETAILS_H
