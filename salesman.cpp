#include "salesman.h"
#include <QDebug>

SalesMan::SalesMan(QObject *parent) : EmployeeDetails(parent)
{

}

SalesMan::~SalesMan()
{
    this->clearSalaryList();
}

int SalesMan::getEmployeeType()
{
    return this->enEmployeType;
}

void SalesMan::setEmployeeType(int pEmployeeType)
{
    this->enEmployeType = pEmployeeType;
}

float SalesMan::getCompansastion(QDate pDate)
{
    float lCompansastion = 0;
    if(!qvecSalaryList.isEmpty()) {
        foreach (QSharedPointer<SalesManSalaryData> ldata, qvecSalaryList) {
            if((ldata->mDate.month() == pDate.month())
                    && (ldata->mDate.year() == pDate.year())) {
                lCompansastion = ldata->fCompensastion;
                float lTotalOutcome = this->calculateTotalRealisedOutcome(ldata->mRealisedOutComeList);
                lCompansastion += (lTotalOutcome * this->calculateBonous(ldata->fClaimedOutcome,lTotalOutcome));
                break;
            }
        }
    }
    return lCompansastion;
}

QString SalesMan::getEmployeeName()
{
    return this->qstrEmloyeeName;
}

void SalesMan::setEmployeeName(QString pEmployeeName)
{
    this->qstrEmloyeeName = pEmployeeName;
}

QString SalesMan::getSecurityNumber()
{
    return this->qstrSecurityNumber;
}

void SalesMan::setSecurityNumber(QString pSecurityNumber)
{
    this->qstrSecurityNumber = pSecurityNumber;
}

QString SalesMan::getCompensastion(QDate pDate)
{
    QString lClaimedOutcome;
    foreach (QSharedPointer<SalesManSalaryData> ldata, qvecSalaryList) {
        if((ldata->mDate.month() == pDate.month())
                && (ldata->mDate.year() == pDate.year())) {
            lClaimedOutcome = QString::number(ldata->fCompensastion,'f',2);
            break;
        }
    }
    return lClaimedOutcome;
}

QString SalesMan::getClaimedOutcome(QDate pDate)
{
    QString lClaimedOutcome;
    foreach (QSharedPointer<SalesManSalaryData> ldata, qvecSalaryList) {
        if((ldata->mDate.month() == pDate.month())
                && (ldata->mDate.year() == pDate.year())) {
            lClaimedOutcome = QString::number(ldata->fClaimedOutcome,'f',2);
            break;
        }
    }
    return lClaimedOutcome;
}

bool SalesMan::addSalary(QDate pDate, QString pCompansastion, QString pClaimedOutcome, QString pRealisedOutcome)
{
    bool lRet = false;
    int laddIndex = 0;
    bool elementFound = false;
    if(!pDate.isValid() || (pCompansastion.toFloat() <= 0) || (pClaimedOutcome.toFloat() <= 0)) {
        return lRet;
    }
    if(!qvecSalaryList.isEmpty()) {
        foreach (QSharedPointer<SalesManSalaryData> ldata, qvecSalaryList) {
            if((ldata->mDate.month() == pDate.month())
                    && (ldata->mDate.year() == pDate.year())) {
                laddIndex = qvecSalaryList.indexOf(ldata);
                elementFound = true;
                break;
            }
            if(ldata->mDate < pDate) {
                laddIndex = qvecSalaryList.indexOf(ldata);
            }
        }
    }
    if(laddIndex != -1) {
        if(elementFound) {
            if(pRealisedOutcome.toFloat() > 0) {
                qvecSalaryList.at(laddIndex)->mRealisedOutComeList.append(pRealisedOutcome);
                QModelIndex lModelIndex = this->index(laddIndex);
                emit dataChanged(lModelIndex,lModelIndex,{RealisedOutcome});
                emit dataChanged(lModelIndex,lModelIndex,{TotalRealisedOutcome});
                emit dataChanged(lModelIndex,lModelIndex,{Bonous});
            }
        } else {
            beginInsertRows(QModelIndex(), laddIndex, laddIndex);
            SalesManSalaryData lSalaryData;
            lSalaryData.mDate = pDate;
            lSalaryData.fCompensastion = pCompansastion.toFloat();
            lSalaryData.fClaimedOutcome = pClaimedOutcome.toFloat();
            if(pRealisedOutcome.toFloat() > 0) {
                lSalaryData.mRealisedOutComeList.append(pRealisedOutcome);
            }
            qvecSalaryList.insert(laddIndex,QSharedPointer<SalesManSalaryData>(new SalesManSalaryData(lSalaryData)));
            endInsertRows();
            lRet = true;
        }
        lRet = true;
    }
    return lRet;
}

bool SalesMan::removeSalary(int pIndex)
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

int SalesMan::rowCount(const QModelIndex &pParent) const
{
    Q_UNUSED(pParent);
    return qvecSalaryList.count();
}

QVariant SalesMan::data(const QModelIndex &pIndex, int pDisplayRole) const
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
        case ClaimedOutcome:
            lValue = QString::number(qvecSalaryList.at(pIndex.row())->fClaimedOutcome,'f',2);
            break;
        case RealisedOutcome:
            lValue = qvecSalaryList.at(pIndex.row())->mRealisedOutComeList;
            break;
        case TotalRealisedOutcome:
            lValue = QString::number(this->calculateTotalRealisedOutcome(qvecSalaryList.at(pIndex.row())->mRealisedOutComeList),'f',2);
            break;

        case Bonous:
            lValue = QString::number(this->calculateBonous(qvecSalaryList.at(pIndex.row())->fClaimedOutcome,
                                                           this->calculateTotalRealisedOutcome(qvecSalaryList.at(pIndex.row())->mRealisedOutComeList)),'f',2);
            break;
        default:
            qInfo() << "Inavlalid roleId" << pDisplayRole;
            break;
        }
    }
    return lValue;
}

QHash<int, QByteArray> SalesMan::roleNames() const
{
    QHash<int, QByteArray> lSalaryRoles;
    lSalaryRoles[Date] = "Date";
    lSalaryRoles[Compansastion] = "Compansastion";
    lSalaryRoles[ClaimedOutcome] = "ClaimedOutcome";
    lSalaryRoles[RealisedOutcome] = "RealisedOutcome";
    lSalaryRoles[TotalRealisedOutcome] = "TotalRealisedOutcome";
    lSalaryRoles[Bonous] = "Bonous";
    return lSalaryRoles;
}

bool SalesMan::validateIndex(const int &pIndex) const
{
    if ((pIndex >= 0) && (pIndex < qvecSalaryList.size())) {
        return true;
    } else {
        qWarning() << "invalid Row no" << "[idx]" << pIndex << "[listsize]" << qvecSalaryList.size();
    }
    return false;
}

bool SalesMan::clearSalaryList()
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

float SalesMan::calculateTotalRealisedOutcome(QStringList &pOutcome) const
{
    float lTotalOutcome = 0;
    if(!pOutcome.isEmpty()) {
        foreach (QString lOutcome, pOutcome) {
            lTotalOutcome += lOutcome.toFloat();
        }
    }
    return lTotalOutcome;
}

float SalesMan::calculateBonous(float pClaimedOutcome, float pRealisedOutcome) const
{
    float lBonous = ((pRealisedOutcome - pClaimedOutcome) * 100) / pRealisedOutcome;
    if(lBonous < 0) {
        lBonous = 0;
    }
    return lBonous;
}
