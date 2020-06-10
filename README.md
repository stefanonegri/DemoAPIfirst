# Demo API first integration
## Intro
The demo aims to cover the 2 possible approaches for API first integration: 1) bottom up and 2) top down
### Bottom up
This case is suitable when a company has a set of digital assets that he wants to make available as managed APIs; it includes 2 steps:
1. The first step transforms the asset (a database table in this sample) in an REST API
2. The second step makes the REST API available to internal and external users as managed API

![bottom up](bottom-up.png)

## Pre requisites
1. Database MySql
2. Salesforce account

## Set up of the env.
### Database
1. Create schema Employees
2. Create a table Employees (using the following script: [(createEmployeesTable.sql)](createEmployeesTable.sql)
3. Add records to the table (for example using: [(insertEmployee.sql)](insertEmployee.sql))
### WSO2 Enterprise Integrator
- start WSO2 EI with port offset 10
```
./integrator.sh -DportOffset=10
```
- start WSO2 API Manager



## Description of the demo
### Bottom up
#### Create a new datasource
- Datasource name: *EmployeeDS*, Datasource Type: *Database*, Database Engine: *MySQL*, Driver class: *com.mysql.jdbc.Driver*, URL: *jdbc:mysql://localhost:3306/Employees* (replace hostname and port accordingly)
- Add 2 queries:
 1. employees
```
select EmployeeNumber, FirstName, LastName, Email, Salary from Employees
```
 2. employeeById
```
select EmployeeNumber, FirstName, LastName, Email, Salary from Employees where EmployeeNumber=:EmployeeNumber
```
- Add 2 resources:
1. resource path: *employee*, resource method: *GET*, query ID: *employees*
2. resource path: *employee/{EmployeeNumber}*, resource method: *GET*, query ID: *employeeById*
- Save the DS; show it in the Deployed Services and show the swagger generated url: 
```
http://localhost:8290/services/EmployeeDS?swagger.json
```
- Test the services (they are accessible as REST but without restrictions/security):
```
curl --request GET 'http://localhost:8290/services/EmployeeDS/employee'
curl --request GET 'http://localhost:8290/services/EmployeeDS/employee/1
```
#### Create the corresponding API in the API Manager and apply policies
- Open the publisher and create a new API using as source the swagger endpoint of the Datasource (see above)
- as endpoint use: EP: http://localhost:8290/services/EmployeeDS
- define security and throttling policy
- publish the API
- Open the Dev Portal, show the API just created, subscribe with any application
- run the API using a token; show the xml to json transformation
```
curl -X GET "http://localhost:8280/Employees/1.0/Employee/3" -H "accept: application/json" -H "Authorization: Bearer *token*"
```
