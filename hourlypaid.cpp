#include "hourlypaid.h"
#include <QDebug>

HourlyPaid::HourlyPaid(QObject *parent) : EmployeeDetails(parent)
{

}

HourlyPaid::~HourlyPaid()
{
    this->clearSalaryList();
}

int HourlyPaid::getEmployeeType()
{
    return this->enEmployeType;
}

void HourlyPaid::setEmployeeType(int pEmployeeType)
{
    this->enEmployeType = pEmployeeType;
}

float HourlyPaid::getCompansastion(QDate pDate)
{
    float lCompansastion = 0;
    if(!qvecSalaryList.isEmpty()) {
        foreach (QSharedPointer<HourlyPaidSalaryData> ldata, qvecSalaryList) {
            if((ldata->mDate.month() == pDate.month())
                    && (ldata->mDate.year() == pDate.year())) {
                lCompansastion = lCompansastion + (ldata->fCompensastion * ldata->fSpentHour);
            }
        }
    }
    return lCompansastion;
}

QString HourlyPaid::getEmployeeName()
{
    return this->qstrEmloyeeName;
}

void HourlyPaid::setEmployeeName(QString pEmployeeName)
{
    this->qstrEmloyeeName = pEmployeeName;
}

QString HourlyPaid::getSecurityNumber()
{
    return this->qstrSecurityNumber;
}

void HourlyPaid::setSecurityNumber(QString pSecurityNumber)
{
    this->qstrSecurityNumber = pSecurityNumber;
}

bool HourlyPaid::addSalary(QDate pDate, QString pCompansastion, QString pSpentHour)
{
    bool lRet = false;
    int laddIndex = 0;
    if(!pDate.isValid() || (pCompansastion.toFloat() <= 0) || (pSpentHour.toFloat() <= 0) || ((pSpentHour.toFloat() > 24))) {
        return lRet;
    }
    if(!qvecSalaryList.isEmpty()) {
        foreach (QSharedPointer<HourlyPaidSalaryData> ldata, qvecSalaryList) {
            if(ldata->mDate == pDate) {
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
        HourlyPaidSalaryData lSalaryData;
        lSalaryData.mDate = pDate;
        lSalaryData.fCompensastion = pCompansastion.toFloat();
        lSalaryData.fSpentHour = pSpentHour.toFloat();
        qvecSalaryList.insert(laddIndex,QSharedPointer<HourlyPaidSalaryData>(new HourlyPaidSalaryData(lSalaryData)));
        endInsertRows();
        lRet = true;
    }
    return lRet;
}

bool HourlyPaid::removeSalary(int pIndex)
{
    bool lRet = false;
    if(validateIndex(pIndex)) {
        beginRemoveRows(QModelIndex(),pIndex,pIndex);
        qvecSalaryList.removeAt(pIndex);
        endRemoveRows();
        lRet = true;
    }
    return lRet;
}

int HourlyPaid::rowCount(const QModelIndex &pParent) const
{
    Q_UNUSED(pParent);
    return qvecSalaryList.count();
}

QVariant HourlyPaid::data(const QModelIndex &pIndex, int pDisplayRole) const
{
    QVariant lValue;
    if(validateIndex(pIndex.row())) {
        switch (pDisplayRole) {
        case Date:
            lValue = qvecSalaryList.at(pIndex.row())->mDate.toString("dd-MMM-yyyy");
            break;
        case Compansastion:
            lValue = QString::number(qvecSalaryList.at(pIndex.row())->fCompensastion,'f',2);
            break;
        case SpentHour:
            lValue = QString::number(qvecSalaryList.at(pIndex.row())->fSpentHour,'f',2);
            break;
        default:
            qInfo() << "Inavlalid roleId" << pDisplayRole;
            break;
        }
    }
    return lValue;
}

QHash<int, QByteArray> HourlyPaid::roleNames() const
{
    QHash<int, QByteArray> lSalaryRoles;
    lSalaryRoles[Date] = "Date";
    lSalaryRoles[Compansastion] = "Compansastion";
    lSalaryRoles[SpentHour] = "SpentHour";
    return lSalaryRoles;
}

bool HourlyPaid::validateIndex(const int &pIndex) const
{
    if ((pIndex >= 0) && (pIndex < qvecSalaryList.size())) {
        return true;
    } else {
        qWarning() << "invalid Row no" << "[idx]" << pIndex << "[listsize]" << qvecSalaryList.size();
    }
    return false;
}

bool HourlyPaid::clearSalaryList()
{
    bool lRet = false;
    if(!qvecSalaryList.isEmpty()) {
        beginRemoveRows(QModelIndex(),0,qvecSalaryList.count() - 1);
        qvecSalaryList.clear();
        endRemoveRows();
        lRet = true;
    }
    return lRet;
}
