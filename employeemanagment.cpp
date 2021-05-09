#include <QDebug>
#include <QQmlContext>
#include <QString>
#include <QFile>
#include <QTextStream>
#include "employeemanagment.h"
#include "monthlypaid.h"
#include "hourlypaid.h"
#include "salesman.h"

#define CSV_FILE_NAME "employeeDetail.csv"

EmployeeManagment::EmployeeManagment(QObject *parent) :
    QObject(parent)
  ,m_QmlAppEnginePtr(nullptr)
{

}

EmployeeManagment::~EmployeeManagment()
{

}

bool EmployeeManagment::setQmlEngine(QQmlApplicationEngine *pQQmlApplicationEngine)
{
    bool lRet = false;
    if(pQQmlApplicationEngine) {
        m_QmlAppEnginePtr = pQQmlApplicationEngine;
        lRet = true;
    } else {
        qWarning() <<" Null Pointer Assignment is not Possible";
    }

    return lRet;
}

bool EmployeeManagment::init()
{
    bool lRet = false;

    if(m_QmlAppEnginePtr) {
        m_QmlAppEnginePtr->rootContext()->setContextProperty("EmployeeModel",&m_EmployeeModel);
        m_QmlAppEnginePtr->rootContext()->setContextProperty("EmployeeManagment",this);
        qmlRegisterSingletonType(QUrl("qrc:/UiSchemes.qml"), "UiSchemes", 1, 0, "UiSchemes");
    } else {
        qWarning() << "QmlAppEngine Not Set, Failed to set Context Property";
    }
    return lRet;
}

void EmployeeManagment::initPage()
{
//    QSharedPointer<EmployeeDetails> lModelData = QSharedPointer<EmployeeDetails>(new SalesMan(this));
//    lModelData->setEmployeeName("Brijal Panchal");
//    lModelData->setSecurityNumber("ABC12345");
//    lModelData->setEmployeeType(EmployeeListModel::EN_SalesMan);
//    if(m_EmployeeModel.addItem(lModelData)) {
//        if(m_QmlAppEnginePtr) {
//            m_QmlAppEnginePtr->rootContext()->setContextProperty("MonthlyModel"+lModelData->getSecurityNumber(),lModelData.data());
//        }
//    }
}

bool EmployeeManagment::addEmployee(QString pName, QString pSecurityNumber, int pEmployeeType)
{
    bool lRet = true;
    QString lErrorMessage;
    if(pName.isEmpty()) {
        lRet = false;
        lErrorMessage.append("Employee name is empty");
    }
    if(pSecurityNumber.isEmpty()) {
        lRet = false;
        if(lErrorMessage.isEmpty() == false)
            lErrorMessage.append(", ");
        lErrorMessage.append("Security number is empty");
    }

    if(pEmployeeType == EmployeeListModel::EN_NotSelected) {
        lRet = false;
        if(lErrorMessage.isEmpty() == false)
            lErrorMessage.append(", ");
        lErrorMessage.append("Select employee type");
    }

    if(lRet) {
        QSharedPointer<EmployeeDetails> lEmployeeDetail = nullptr;
        if(pEmployeeType == EmployeeListModel::EN_MonthlyPaid) {
            lEmployeeDetail = QSharedPointer<EmployeeDetails>(new MonthlyPaid(this));
        } else if(pEmployeeType == EmployeeListModel::EN_HourlyPaid) {
            lEmployeeDetail = QSharedPointer<EmployeeDetails>(new HourlyPaid(this));
        } else if(pEmployeeType == EmployeeListModel::EN_SalesMan) {
            lEmployeeDetail = QSharedPointer<EmployeeDetails>(new SalesMan(this));
        }

        if(lEmployeeDetail) {
            lEmployeeDetail->setEmployeeName(pName);
            lEmployeeDetail->setSecurityNumber(pSecurityNumber);
            lEmployeeDetail->setEmployeeType(pEmployeeType);
            lRet = m_EmployeeModel.addItem(lEmployeeDetail);
            if(lRet) {
                if(m_QmlAppEnginePtr) {
                    m_QmlAppEnginePtr->rootContext()->setContextProperty("MonthlyModel"+pSecurityNumber,lEmployeeDetail.data());
                }
            }
        }

        if(lRet == false) {
            lErrorMessage.append("Employee already exist");
            emit errorAddingEmployee(lErrorMessage);
        } else {
            emit addEmployeeSuccessFull();
        }
    } else {
        emit errorAddingEmployee(lErrorMessage);
    }

    return lRet;
}

QString EmployeeManagment::getBounousPercentage(float pClaimedOutPut, float pRealizedOutput)
{
    QString lReturn;
    float lBonouse = pRealizedOutput - pClaimedOutPut;
    if(lBonouse > 0) {
        lReturn = QString::number((lBonouse/pClaimedOutPut) * 100,'f',2);
    } else {
        lReturn = "0";
    }
    return lReturn;
}

bool EmployeeManagment::printIntoCSVFormate()
{
    bool lRet = false;
    QVector<QSharedPointer<EmployeeDetails>>& lModelDataList = m_EmployeeModel.getAllEmployeeList();
    if(lModelDataList.isEmpty() == false)
    {
        QString lCSVData;
        QStringList lCsvDataList;
        lCsvDataList << "\"SrNo\"" << "\"Employee Name\"" << "\"Social security number\"" << "\"Employee Type\""
                     << "\"Date\"" << "\"Compensation(US$)\"" << "\"Hours\"" << "\"Claimed Outcome(US$)\""
                     << "\"Realised Outcome(US$)\"" << "\"Bonous(%)\"";
        lCSVData.append(lCsvDataList.join(","));
        lCsvDataList.clear();
        int lIndex = 0;
        foreach (QSharedPointer<EmployeeDetails> lEmployeeData, lModelDataList) {
            if(lEmployeeData) {
                lCSVData.append("\n");
                lCsvDataList.append(QString::number(lIndex));
                lCsvDataList.append(lEmployeeData->getEmployeeName());
                lCsvDataList.append(lEmployeeData->getSecurityNumber());
                lCsvDataList.append(m_EmployeeModel.getEmployeeType(lEmployeeData->getEmployeeType()));
                if(lEmployeeData->getEmployeeType() == EmployeeListModel::EN_MonthlyPaid) {
                    for(int i = 0 ; i < lEmployeeData->rowCount(); i++) {
                        QModelIndex lModelIndex = lEmployeeData->index(i);
                        lCsvDataList.append(lEmployeeData->data(lModelIndex,MonthlyPaid::Date).toString());
                        lCsvDataList.append(lEmployeeData->data(lModelIndex,MonthlyPaid::Compansastion).toString());
                        lCsvDataList.append("NA");
                        lCsvDataList.append("NA");
                        lCsvDataList.append("NA");
                        lCsvDataList.append("NA");
                        lCSVData.append(lCsvDataList.join(","));
                        lCsvDataList.clear();
                        if(i < (lEmployeeData->rowCount() - 1)) {
                            lCSVData.append("\n");
                            lCsvDataList.append("");
                            lCsvDataList.append("");
                            lCsvDataList.append("");
                            lCsvDataList.append("");
                        }
                    }
                } else if(lEmployeeData->getEmployeeType() == EmployeeListModel::EN_HourlyPaid) {
                    for(int i = 0 ; i < lEmployeeData->rowCount(); i++) {
                        QModelIndex lModelIndex = lEmployeeData->index(i);
                        lCsvDataList.append(lEmployeeData->data(lModelIndex,HourlyPaid::Date).toString());
                        lCsvDataList.append(QString::number(lEmployeeData->getCompansastion(lEmployeeData->data(lModelIndex,SalesMan::Date).toDate()),'f',2));
                        lCsvDataList.append(lEmployeeData->data(lModelIndex,HourlyPaid::SpentHour).toString());
                        lCsvDataList.append("NA");
                        lCsvDataList.append("NA");
                        lCsvDataList.append("NA");
                        lCSVData.append(lCsvDataList.join(","));
                        lCsvDataList.clear();
                        if(i < (lEmployeeData->rowCount() - 1)) {
                            lCSVData.append("\n");
                            lCsvDataList.append("");
                            lCsvDataList.append("");
                            lCsvDataList.append("");
                            lCsvDataList.append("");
                        }
                    }
                } else if(lEmployeeData->getEmployeeType() == EmployeeListModel::EN_SalesMan) {
                    for(int i = 0 ; i < lEmployeeData->rowCount(); i++) {
                        QModelIndex lModelIndex = lEmployeeData->index(i);
                        lCsvDataList.append(lEmployeeData->data(lModelIndex,SalesMan::Date).toString());
                        lCsvDataList.append(QString::number(lEmployeeData->getCompansastion(lEmployeeData->data(lModelIndex,SalesMan::Date).toDate()),'f',2));
                        lCsvDataList.append("NA");
                        lCsvDataList.append(lEmployeeData->data(lModelIndex,SalesMan::ClaimedOutcome).toString());
                        lCsvDataList.append(lEmployeeData->data(lModelIndex,SalesMan::TotalRealisedOutcome).toString());
                        lCsvDataList.append(lEmployeeData->data(lModelIndex,SalesMan::Bonous).toString());
                        lCSVData.append(lCsvDataList.join(","));
                        lCsvDataList.clear();
                        if(i < (lEmployeeData->rowCount() - 1)) {
                            lCSVData.append("\n");
                            lCsvDataList.append("");
                            lCsvDataList.append("");
                            lCsvDataList.append("");
                            lCsvDataList.append("");
                        }
                    }
                }
                lCSVData.append(lCsvDataList.join(","));
                lCsvDataList.clear();
            }
            lIndex++;
        }

        QFile file(CSV_FILE_NAME);
        if (file.open(QIODevice::WriteOnly)) {
            QTextStream stream(&file);
            stream << lCSVData << endl;
            file.close();
            lRet = true;
        } else {
            qInfo() << "unable to open file";
        }
    }
    else
    {
        qInfo() << "List is empty!!";
    }
    if(lRet) {
        emit printCSVMessage("File saved successfully.");
    } else {
        emit printCSVMessage("Unable to save file, please try again.");
    }
    return lRet;
}
