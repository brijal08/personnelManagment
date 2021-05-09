#ifndef EMPLOYEELISTMODEL_H
#define EMPLOYEELISTMODEL_H

#include <QAbstractListModel>
#include <QVector>
#include <QDate>
#include <QSharedDataPointer>
#include "employeedetails.h"

class EmployeeListModel : public QAbstractListModel
{
    Q_OBJECT
    Q_ENUMS(EmployeeType)

    enum EmployeeListModelRoles {
        EmployeeName = Qt::UserRole + 1,
        SocialSecurityNumber,
        EmployeeType,
        Compensastion,
        EmployeeObject
    };

public:
    enum EmployeeType {
        EN_NotSelected = -1,
        EN_MonthlyPaid = 0,
        EN_HourlyPaid,
        EN_SalesMan
    };

public:
    explicit EmployeeListModel(QObject *parent = nullptr);
    ~EmployeeListModel() override;

    bool addItem(QSharedPointer<EmployeeDetails> pModelData);

    bool deleteAllItem();

    QVector<QSharedPointer<EmployeeDetails> > &getAllEmployeeList();

    Q_INVOKABLE QString getEmployeeType(int pTypeId) const;

    Q_INVOKABLE void setDate(QDate pDate);

protected:

    virtual int rowCount(const QModelIndex& pParent = QModelIndex()) const override;

    QVariant data(const QModelIndex & pIndex, int pDisplayRole = Qt::DisplayRole) const override;

    QHash<int, QByteArray> roleNames() const override;

private:

    QDate mDate;

    QVector<QSharedPointer<EmployeeDetails>> m_EmployeeList;

    bool validateIndex(const int& pIndex) const;
};

#endif // EMPLOYEELISTMODEL_H
