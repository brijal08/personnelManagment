#ifndef SALESMAN_H
#define SALESMAN_H

#include <QObject>
#include <QDate>
#include <QSharedPointer>
#include "employeedetails.h"

class SalesManSalaryData;

class SalesMan : public EmployeeDetails
{
    Q_OBJECT

public:
    enum SalaryRoles {
        Date = Qt::UserRole + 1,
        Compansastion,
        ClaimedOutcome,
        RealisedOutcome,
        TotalRealisedOutcome,
        Bonous
    };
public:
    explicit SalesMan(QObject *parent = nullptr);
    virtual ~SalesMan() override;

    virtual int getEmployeeType() override;
    virtual void setEmployeeType(int pEmployeeType) override;
    virtual float getCompansastion(QDate pDate) override;
    virtual QString getEmployeeName() override;
    virtual void setEmployeeName(QString pEmployeeName) override;
    virtual QString getSecurityNumber() override;
    virtual void setSecurityNumber(QString pSecurityNumber) override;

    Q_INVOKABLE QString getCompensastion(QDate pDate);
    Q_INVOKABLE QString getClaimedOutcome(QDate pDate);
    Q_INVOKABLE bool addSalary(QDate pDate, QString pCompansastion, QString pClaimedOutcome, QString pRealisedOutcome);
    Q_INVOKABLE bool removeSalary(int pIndex);

    virtual int rowCount(const QModelIndex& pParent = QModelIndex()) const override;

    QVariant data(const QModelIndex & pIndex, int pDisplayRole = Qt::DisplayRole) const override;
protected:
    QHash<int, QByteArray> roleNames() const override;

private:
    QVector<QSharedPointer<SalesManSalaryData>> qvecSalaryList;

    bool validateIndex(const int& pIndex) const;
    bool clearSalaryList();
    float calculateTotalRealisedOutcome(QStringList& pOutcome) const;
    float calculateBonous(float pClaimedOutcome, float pRealisedOutcome) const;
};

class SalesManSalaryData
{
public:
    QDate mDate;
    float fCompensastion;
    float fClaimedOutcome;
    QStringList mRealisedOutComeList;
};

#endif // SALESMAN_H
