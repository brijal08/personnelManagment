#include <QDebug>
#include "employeelistmodel.h"

EmployeeListModel::EmployeeListModel(QObject *parent) : QAbstractListModel(parent)
{

}

EmployeeListModel::~EmployeeListModel()
{
    deleteAllItem();
}

bool EmployeeListModel::addItem(QSharedPointer<EmployeeDetails> pModelData)
{
    bool lRet = false;
    if(pModelData->getEmployeeName().isEmpty()
            || pModelData->getSecurityNumber().isEmpty())
    {
        qWarning() << "invalid data!!"
                   << "[Name]" << pModelData->getEmployeeName()
                   << "[SecurityNumber]" << pModelData->getSecurityNumber();
    }
    else
    {
        lRet = true;
        foreach (QSharedPointer<EmployeeDetails> ldata, m_EmployeeList) {
            if(ldata->getSecurityNumber() == pModelData->getSecurityNumber())
            {
                qWarning() << "Employee Already Exist!!"
                           << "[Name]" << pModelData->getEmployeeName()
                           << "[SecurityNumber]" << pModelData->getSecurityNumber();
                lRet = false;
                break;
            }
        }
        if(lRet)
        {
            beginInsertRows(QModelIndex(), rowCount() , rowCount());
            m_EmployeeList.append(pModelData);
            endInsertRows();
        }
    }
    return lRet;
}

bool EmployeeListModel::deleteAllItem()
{
    bool lRet = false;
    if(!m_EmployeeList.isEmpty())
    {
        beginRemoveRows(QModelIndex(),0,m_EmployeeList.count() - 1);
        m_EmployeeList.clear();
        endRemoveRows();
        lRet = true;
    }
    return lRet;
}

QVector<QSharedPointer<EmployeeDetails>>& EmployeeListModel::getAllEmployeeList()
{
    return m_EmployeeList;
}

QString EmployeeListModel::getEmployeeType(int pTypeId) const
{
    QString lRetunType;

    switch (pTypeId) {
    case EN_MonthlyPaid:
        lRetunType = "Monthly Paid";
        break;
    case EN_HourlyPaid:
        lRetunType = "Hourly Paid";
        break;
    case EN_SalesMan:
        lRetunType = "SalesMan";
        break;
    default:
        lRetunType = "Select Type";
    }
    return lRetunType;
}

void EmployeeListModel::setDate(QDate pDate)
{
    mDate = pDate;
    if(!m_EmployeeList.isEmpty()) {
        for(int i = 0 ; i < m_EmployeeList.count() ; i++) {
            QModelIndex lModelIndex = this->index(i);
            emit dataChanged(lModelIndex,lModelIndex,{Compensastion});
        }
    }
}

int EmployeeListModel::rowCount(const QModelIndex &pParent) const
{
    Q_UNUSED(pParent);
    return m_EmployeeList.count();
}

QVariant EmployeeListModel::data(const QModelIndex &pIndex, int pDisplayRole) const
{
    QVariant lValue;
    if(validateIndex(pIndex.row()))
    {
        switch (pDisplayRole) {
        case EmployeeName:
            lValue = m_EmployeeList.at(pIndex.row())->getEmployeeName();
            break;
        case SocialSecurityNumber:
            lValue = m_EmployeeList.at(pIndex.row())->getSecurityNumber();
            break;
        case EmployeeType:
            lValue = m_EmployeeList.at(pIndex.row())->getEmployeeType();
            break;
        case Compensastion:
            lValue = QString::number(m_EmployeeList.at(pIndex.row())->getCompansastion(mDate),'f',2);
            break;
        case EmployeeObject:
            lValue = QVariant::fromValue<QObject *>(m_EmployeeList.at(pIndex.row()).data());
            break;
        default:
            qInfo() << "Inavlalid roleId" << pDisplayRole;
            break;
        }
    }
    return lValue;
}


QHash<int, QByteArray> EmployeeListModel::roleNames() const
{
    QHash<int, QByteArray> lEmployeeListModelRoles;
    lEmployeeListModelRoles[EmployeeName] = "EmployeeName";
    lEmployeeListModelRoles[SocialSecurityNumber] = "SocialSecurityNumber";
    lEmployeeListModelRoles[EmployeeType] = "EmployeeType";
    lEmployeeListModelRoles[Compensastion] = "Compensastion";
    lEmployeeListModelRoles[EmployeeObject] = "EmployeeObject";
    return lEmployeeListModelRoles;
}

bool EmployeeListModel::validateIndex(const int &pIndex) const
{
    if ((pIndex >= 0) && (pIndex < m_EmployeeList.size())) {
        return true;
    } else {
        qWarning() << "invalid Row no" << "[idx]" << pIndex << "[listsize]" << m_EmployeeList.size();
    }
    return false;
}
