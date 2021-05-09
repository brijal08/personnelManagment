Added following functionality
1. Display employee details
2. Add emplyee
3. Save employee details into .csv formate stored into binary folder

Here is class detail of personal managment application

1. EmployeeManagment class inherited by QObject class has functionality of updating employee details into  EmployeeListModel class to show list of employee into UI. It adds employee data requested by user from qml to model class after verifying the data is it valid or not, if data is not valid it emits error message to qml. It shows employee details for selected month.user can switch between months to see result for diffrent months. It save employee details into .csv formate at the execution directory while clicking on save button on the UI. On successfull save the list into file it emits sucess message and on failer it emits failer message

2. EmployeeListModel is model class inherited by QAbstractListModel class containing list of employee having data (i.e. employee name, sequrity number, compansation etc.) for the listview in qml. Qml listview get or set employee data through  EmployeeListModel class object registered by context property. The list of employee is updated by EmployeeManagment class

3. EmployeeDetails  is abstact model class inharited  by QAbstractListModel class for monthly paid, hourly paid and salesman objects

4. HourlyPaid is derived model class inherited by  EmployeeDetails containing employee detailes and salary structure list. It has functionality of adding or removing salary data for given day for spent hours. In this used has to click on add button it will show add salary menu. User has to select date, enter compensastion(/hour) and spent hour. And click on adding salary button. If user has already added the salary detail for given date it will not allow you to add the salary into database. On successfull add the salary it will bring back employee detail screen and you can see the added salary data. User can remove the salary data by clicking “-” button

5. MonthlyPaid is derived model class inherited by  EmployeeDetails containing employee detailes and salary structure list. It has functionality of adding or removing salary data for given month.In this used has to click on add button it will show add salary menu. User has to select date, enter compensastion And click on add salary button. If user has already added the salary detail for given month it will not allow you to add the salary into database. On successfull adding the salary it will bring back employee detail screen and you can see the added salary data. User can remove the salary data by clicking “-” button

6. SalesMan is derived model class inherited by  EmployeeDetails containing employee detailes and salary structure list. It has functionality of adding or removing salary data for given day for claimed outcome and revised outcome.In this used has to click on add button it will show add salary menu. User has to select date, enter compensastion, enter claimed outcome and realised outcome(opetional for first time). click on add salary button. If user has already added the compensation and claimed outcome detail for given month it will not allow you to update that feild. On successfull adding the salary it will bring back employee detail screen and you can see the added salary data. User can remove the salary data by clicking “-” button
