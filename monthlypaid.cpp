#include "monthlypaid.h"
#include <QDebug>

MonthlyPaid::MonthlyPaid(QObject *parent) : EmployeeDetails(parent)
{

}

MonthlyPaid::~MonthlyPaid()
{
    this->clearSalaryList();
}

int MonthlyPaid::getEmployeeType()
{
    return this->enEmployeType;
}

void MonthlyPaid::setEmployeeType(int pEmployeeType)
{
    this->enEmployeType = pEmployeeType;
}

float MonthlyPaid::getCompansastion(QDate pDate)
{
    float lCompansastion = 0;
    if(!qvecSalaryList.isEmpty()) {
        foreach (QSharedPointer<MonthlyPaidSalaryData> ldata, qvecSalaryList) {
            if((ldata->mDate.month() == pDate.month())
                    && (ldata->mDate.year() == pDate.year())) {
                lCompansastion = ldata->fCompensastion;
                break;
            }
        }
    }
    return lCompansastion;
}

QString MonthlyPaid::getEmployeeName()
{
    return this->qstrEmloyeeName;
}

void MonthlyPaid::setEmployeeName(QString pEmployeeName)
{
    this->qstrEmloyeeName = pEmployeeName;
}

QString MonthlyPaid::getSecurityNumber()
{
    return this->qstrSecurityNumber;
}

void MonthlyPaid::setSecurityNumber(QString pSecurityNumber)
{
    this->qstrSecurityNumber = pSecurityNumber;
}

bool MonthlyPaid::addSalary(QDate pDate, QString pCompansastion)
{
    bool lRet = false;
    int laddIndex = 0;
    if(!pDate.isValid() || (pCompansastion.toFloat() <= 0)) {
        return lRet;
    }
    if(!qvecSalaryList.isEmpty()) {
        foreach (QSharedPointer<MonthlyPaidSalaryData> ldata, qvecSalaryList) {
            if((ldata->mDate.month() == pDate.month())
                    && (ldata->mDate.year() == pDate.year())) {
                laddIndex = -1;
                break;
            }
            if(ldata->mDate < pDate) {
                laddIndex = qvecSalaryList.indexOf(ldata);
            }
        }
    }
    if(laddIndex != -1) {
        beginInsertRows(QModelIndex(), laddIndex, laddIndex);
        MonthlyPaidSalaryData lSalaryData = {pDate,pCompansastion.toFloat()};
        qvecSalaryList.insert(laddIndex,QSharedPointer<MonthlyPaidSalaryData>(new MonthlyPaidSalaryData(lSalaryData)));
        endInsertRows();
        lRet = true;
    }
    return lRet;
}

bool MonthlyPaid::removeSalary(int pIndex)
{
    bool lRet = false;
    if(validateIndex(pIndex))
    {
        beginRemoveRows(QModelIndex(),pIndex,pIndex);
        qvecSalaryList.removeAt(pIndex);
        endRemoveRows();
        lRet = true;
    }
    return lRet;
}

bool MonthlyPaid::clearSalaryList()
{
    bool lRet = false;
    if(!qvecSalaryList.isEmpty())
    {
        beginRemoveRows(QModelIndex(),0,qvecSalaryList.count() - 1);
        qvecSalaryList.clear();
        endRemoveRows();
        lRet = true;
    }
    return lRet;
}

int MonthlyPaid::rowCount(const QModelIndex &pParent) const
{
    Q_UNUSED(pParent);
    return qvecSalaryList.count();
}

QVariant MonthlyPaid::data(const QModelIndex &pIndex, int pDisplayRole) const
{
    QVariant lValue;
    if(validateIndex(pIndex.row())) {
        switch (pDisplayRole) {
        case Date:
            lValue = qvecSalaryList.at(pIndex.row())->mDate.toString("MMM-yyyy");
            break;
        case Compansastion:
            lValue = QString::number(qvecSalaryList.at(pIndex.row())->fCompensastion,'f',2);
            break;
        default:
            qInfo() << "Inavlalid roleId" << pDisplayRole;
            break;
        }
    }
    return lValue;
}

QHash<int, QByteArray> MonthlyPaid::roleNames() const
{
    QHash<int, QByteArray> lSalaryRoles;
    lSalaryRoles[Date] = "Date";
    lSalaryRoles[Compansastion] = "Compansastion";
    return lSalaryRoles;
}

bool MonthlyPaid::validateIndex(const int &pIndex) const
{
    if ((pIndex >= 0) && (pIndex < qvecSalaryList.size())) {
        return true;
    } else {
        qWarning() << "invalid Row no" << "[idx]" << pIndex << "[listsize]" << qvecSalaryList.size();
    }
    return false;
}
