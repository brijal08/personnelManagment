#ifndef HOURLYPAID_H
#define HOURLYPAID_H

#include <QObject>
#include <QSharedPointer>
#include "employeedetails.h"

class HourlyPaidSalaryData;

class HourlyPaid : public EmployeeDetails
{
    Q_OBJECT

public:
    enum SalaryRoles {
        Date = Qt::UserRole + 1,
        Compansastion,
        SpentHour
    };

public:
    explicit HourlyPaid(QObject *parent = nullptr);
    virtual ~HourlyPaid() override;

    virtual int getEmployeeType() override;
    virtual void setEmployeeType(int pEmployeeType) override;
    virtual float getCompansastion(QDate pDate) override;
    virtual QString getEmployeeName() override;
    virtual void setEmployeeName(QString pEmployeeName) override;
    virtual QString getSecurityNumber() override;
    virtual void setSecurityNumber(QString pSecurityNumber) override;

    Q_INVOKABLE bool addSalary(QDate pDate, QString pCompansastion, QString pSpentHour);
    Q_INVOKABLE bool removeSalary(int pIndex);

    virtual int rowCount(const QModelIndex& pParent = QModelIndex()) const override;

    QVariant data(const QModelIndex & pIndex, int pDisplayRole = Qt::DisplayRole) const override;

protected:
    QHash<int, QByteArray> roleNames() const override;

private:
    QVector<QSharedPointer<HourlyPaidSalaryData>> qvecSalaryList;

    bool validateIndex(const int& pIndex) const;
    bool clearSalaryList();
};

class HourlyPaidSalaryData
{
public:
    QDate mDate;
    float fCompensastion;
    float fSpentHour;
};

#endif // HOURLYPAID_H
