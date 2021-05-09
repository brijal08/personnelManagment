#ifndef MONTHLYPAID_H
#define MONTHLYPAID_H

#include <QObject>
#include <QDate>
#include <QSharedPointer>
#include "employeedetails.h"

class MonthlyPaidSalaryData;

class MonthlyPaid : public EmployeeDetails
{
    Q_OBJECT

public:
    enum SalaryRoles {
        Date = Qt::UserRole + 1,
        Compansastion
    };

public:
    explicit MonthlyPaid(QObject *parent = nullptr);
    virtual ~MonthlyPaid() override;

    virtual int getEmployeeType() override;
    virtual void setEmployeeType(int pEmployeeType) override;
    virtual float getCompansastion(QDate pDate) override;
    virtual QString getEmployeeName() override;
    virtual void setEmployeeName(QString pEmployeeName) override;
    virtual QString getSecurityNumber() override;
    virtual void setSecurityNumber(QString pSecurityNumber) override;

    Q_INVOKABLE bool addSalary(QDate pDate, QString pCompansastion);
    Q_INVOKABLE bool removeSalary(int pIndex);

    virtual int rowCount(const QModelIndex& pParent = QModelIndex()) const override;
    QVariant data(const QModelIndex & pIndex, int pDisplayRole = Qt::DisplayRole) const override;

protected:
    QHash<int, QByteArray> roleNames() const override;

private:
    QVector<QSharedPointer<MonthlyPaidSalaryData>> qvecSalaryList;

    bool validateIndex(const int& pIndex) const;
    bool clearSalaryList();
};

class MonthlyPaidSalaryData
{
public:
    QDate mDate;
    float fCompensastion;
};

#endif // MONTHLYPAID_H
