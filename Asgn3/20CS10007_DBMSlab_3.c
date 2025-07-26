// Anand Manojkumar Parikh
// Roll : 20CS10007
// Database Management Systems Assignment 3
// Spring 2023
// Database Connectivity in C

/*
  Compile as :
      gcc main.c -lodbc32
    to link with this external dynamic library
*/

#include <stdio.h>
#include <string.h>
#include <windows.h>
#include <sql.h>
#include <sqlext.h>

SQLHENV  henv=NULL;
SQLHDBC  hdbc=NULL;

// function to connect to database
int Connect_to_database(SQLCHAR* ds, SQLCHAR* user, SQLCHAR* pw)
{
  SQLRETURN  rc;

  hdbc=NULL;
  henv=NULL;

  // Allocate environment handle
  rc=SQLAllocHandle(SQL_HANDLE_ENV, SQL_NULL_HANDLE, &henv);  
  if (rc==SQL_SUCCESS || rc==SQL_SUCCESS_WITH_INFO) 
  {
    //  Set the ODBC version environment attribute
    rc=SQLSetEnvAttr(henv, SQL_ATTR_ODBC_VERSION, (void*)SQL_OV_ODBC3, 0); 

    if (rc==SQL_SUCCESS || rc==SQL_SUCCESS_WITH_INFO) 
    {
      // Allocate connection handle 
      rc=SQLAllocHandle(SQL_HANDLE_DBC, henv, &hdbc); 

      if (rc==SQL_SUCCESS || rc==SQL_SUCCESS_WITH_INFO) 
      {
        // Set login timeout to 5 seconds. 
        SQLSetConnectAttr(hdbc, SQL_LOGIN_TIMEOUT, (SQLPOINTER)5, 0);

        // Connect to data source
        rc=SQLConnect(hdbc, ds, SQL_NTS, user, SQL_NTS, pw, SQL_NTS);
	
        if (rc==SQL_SUCCESS || rc==SQL_SUCCESS_WITH_INFO)
        {
          return 1;
        }
        SQLDisconnect(hdbc);
      }
      SQLFreeHandle(SQL_HANDLE_DBC, hdbc);
    }
  }
  SQLFreeHandle(SQL_HANDLE_ENV, henv);

  hdbc=NULL;
  henv=NULL;

  return 0;
}

// function to disconnect from database
int Disconnect_from_database()
{
  if(hdbc) 
  {
    SQLDisconnect(hdbc);	
    SQLFreeHandle(SQL_HANDLE_DBC, hdbc);
  }
  if(henv) SQLFreeHandle(SQL_HANDLE_ENV, henv);
  hdbc=NULL;
  henv=NULL;
  return 1;
}

int db_exec_stmt(char* stmt_str)
{
  SQLHSTMT hstmt;
  SQLRETURN  rc;

  if(henv==NULL || hdbc==NULL) return 0;

  /* Allocate statement handle */
  rc = SQLAllocHandle(SQL_HANDLE_STMT, hdbc, &hstmt); 
  if(!(rc==SQL_SUCCESS || rc==SQL_SUCCESS_WITH_INFO) ) return 0;
	
  rc = SQLExecDirect(hstmt, stmt_str, SQL_NTS);
  SQLFreeHandle(SQL_HANDLE_STMT, hstmt);
  if(rc==SQL_SUCCESS || rc==SQL_SUCCESS_WITH_INFO) return 1;
  if(rc==SQL_NO_DATA) return 1;

  printf("sqlerr: %d\n", rc);
  return 0;
}

int db_fetch(int query)
{ // sql specific data types
  SQLRETURN r;
  SQLHSTMT hstmt;
  SQLCHAR sql[4096];
  SQLLEN n;
  SQLINTEGER id;
  SQLCHAR str[200];
  SQLREAL age;
  SQL_TIMESTAMP_STRUCT create_timestamp;

  if(hdbc==NULL || henv==NULL) return 0;

  r=SQLAllocHandle(SQL_HANDLE_STMT, hdbc, &hstmt);
  if(!(r==SQL_SUCCESS||r==SQL_SUCCESS_WITH_INFO)) return 0;

  // Q_1
  if(query == 1){
    // copy the string format of sql query in a character array
    strcpy(sql,"SELECT _physician._name as _name FROM _physician INNER JOIN _trained_in ON _physician._employee_id = _trained_in._physician INNER JOIN _procedure ON _trained_in._treatment = _procedure._code WHERE _procedure._name = \"bypass surgery\";");
    r=SQLExecDirect(hstmt, sql, SQL_NTS);   // execute sql statement
    if(r!=SQL_SUCCESS){   // handle errors
      printf("cannot access [%s]\n", sql);
      SQLFreeHandle(SQL_HANDLE_STMT, hstmt);
      return 0;
    }
    printf("%30s\n", "Physician Name");   // column(s) name
    while(1){
      r=SQLFetch(hstmt);
      if(r==SQL_SUCCESS||r==SQL_SUCCESS_WITH_INFO){
        r=SQLGetData(hstmt, 1, SQL_C_CHAR, str, 200, &n);   // get the 1st column, which is Physician name of type SQL_C_CHAR
        printf("%30s\n", str);
      }
      else if(SQL_NO_DATA==r) break;
      else{
        printf("%s\n", "fail to fetch data");   // handle errors in case data could not be fetched
        break;
      }
    }
  }

  // Q_2
  if(query == 2){
    strcpy(sql,"SELECT _physician._name as _name FROM _physician INNER JOIN _affiliated_with ON _physician._employee_id = _affiliated_with._physician INNER JOIN _department ON _department._department_id = _affiliated_with._department INNER JOIN _trained_in ON _trained_in._physician = _physician._employee_id INNER JOIN _procedure ON _procedure._code = _trained_in._treatment WHERE _procedure._name = \"bypass surgery\" AND _department._name = \"cardiology\";");
    r=SQLExecDirect(hstmt, sql, SQL_NTS);
    if(r!=SQL_SUCCESS){
      printf("cannot access [%s]\n", sql);
      SQLFreeHandle(SQL_HANDLE_STMT, hstmt);
      return 0;
    }
    printf("%30s\n", "Physician Name");
    while(1){
      r=SQLFetch(hstmt);
      if(r==SQL_SUCCESS||r==SQL_SUCCESS_WITH_INFO){
        r=SQLGetData(hstmt, 1, SQL_C_CHAR, str, 200, &n);
        printf("%30s\n", str);
      }
      else if(SQL_NO_DATA==r) break;
      else{
        printf("%s\n", "fail to fetch data");
        break;
      }
    }
  }

  // Q_3
  if(query == 3){
    strcpy(sql,"SELECT _name FROM _nurse INNER JOIN _on_call ON _on_call._nurse = _nurse._employee_id INNER JOIN _block ON _block._floor = _on_call._block_floor AND _block._code = _on_call._block_code INNER JOIN _room ON _room._block_floor = _block._floor AND _room._block_code = _block._code WHERE _room._number = 123;");
    r=SQLExecDirect(hstmt, sql, SQL_NTS);
    if(r!=SQL_SUCCESS){
      printf("cannot access [%s]\n", sql);
      SQLFreeHandle(SQL_HANDLE_STMT, hstmt);
      return 0;
    }
    printf("%30s\n" , "Nurse Name");
    while(1){
      r=SQLFetch(hstmt);
      if(r==SQL_SUCCESS||r==SQL_SUCCESS_WITH_INFO){
        r=SQLGetData(hstmt, 1, SQL_C_CHAR, str, 200, &n);
        printf("%30s\n", str);
      }
      else if(SQL_NO_DATA==r) break;
      else{
        printf("%s\n", "fail to fetch data");
        break;
      }
    }
  }

  // Q_4
  if(query == 4){
    strcpy(sql,"SELECT _patient._name as _name, _address FROM _patient INNER JOIN _prescribes ON _patient._ssn = _prescribes._patient INNER JOIN _medication ON _medication._code = _prescribes._medication WHERE _medication._name = \"remdesivir\";");
    r=SQLExecDirect(hstmt, sql, SQL_NTS);
    if(r!=SQL_SUCCESS){
      printf("cannot access [%s]\n", sql);
      SQLFreeHandle(SQL_HANDLE_STMT, hstmt);
      return 0;
    }
    printf("%30s %40s\n" , "Patient Name" , "Address");
    while(1){
      r=SQLFetch(hstmt);
      if(r==SQL_SUCCESS||r==SQL_SUCCESS_WITH_INFO){
        r=SQLGetData(hstmt, 1, SQL_C_CHAR, str, 200, &n);
        printf("%30s ", str);
        r=SQLGetData(hstmt, 2, SQL_C_CHAR, str, 200, &n);
        printf("%40s\n", str);
      }
      else if(SQL_NO_DATA==r) break;
      else{
        printf("%s\n", "fail to fetch data");
        break;
      }
    }
  }

  // Q_5
  if(query == 5){
    strcpy(sql,"SELECT _name, _insurance_id FROM _patient INNER JOIN _stay ON _stay._patient = _patient._ssn INNER JOIN _room ON _room._number = _stay._room WHERE _room._type = \"icu\" AND DATEDIFF(_stay._end , _stay._start) > 15;");
    r=SQLExecDirect(hstmt, sql, SQL_NTS);
    if(r!=SQL_SUCCESS){
      printf("cannot access [%s]\n", sql);
      SQLFreeHandle(SQL_HANDLE_STMT, hstmt);
      return 0;
    }
    printf("%30s %30s\n" , "Patient Name" , "Insurance ID");
    while(1){
      r=SQLFetch(hstmt);
      if(r==SQL_SUCCESS||r==SQL_SUCCESS_WITH_INFO){
        r=SQLGetData(hstmt, 1, SQL_C_CHAR, str, 200, &n);
        printf("%30s ", str);
        r=SQLGetData(hstmt, 2, SQL_C_CHAR, str, 200, &n);
        printf("%30s\n", str);
      }
      else if(SQL_NO_DATA==r) break;
      else{
        printf("%s\n", "fail to fetch data");
        break;
      }
    }
  }

  // Q_6
  if(query == 6){
    strcpy(sql,"SELECT _nurse._name as _nurse_name FROM _nurse INNER JOIN _undergoes ON _undergoes._assisting_nurse = _nurse._employee_id INNER JOIN _procedure ON _procedure._code = _undergoes._procedure WHERE _procedure._name = \"bypass surgery\";");
    r=SQLExecDirect(hstmt, sql, SQL_NTS);
    if(r!=SQL_SUCCESS){
      printf("cannot access [%s]\n", sql);
      SQLFreeHandle(SQL_HANDLE_STMT, hstmt);
      return 0;
    }
    printf("%30s\n" , "Nurse Name");
    while(1){
      r=SQLFetch(hstmt);
      if(r==SQL_SUCCESS||r==SQL_SUCCESS_WITH_INFO){
        r=SQLGetData(hstmt, 1, SQL_C_CHAR, str, 200, &n);
        printf("%30s\n", str);
      }
      else if(SQL_NO_DATA==r) break;
      else{
        printf("%s\n", "fail to fetch data");
        break;
      }
    }
  }

  // Q_7
  if(query == 7){
    strcpy(sql,"SELECT _nurse._name as _nurse_name, _nurse._position as _nurse_position, _physician._name as _physician_name FROM _nurse INNER JOIN _undergoes ON _undergoes._assisting_nurse = _nurse._employee_id INNER JOIN _procedure ON _undergoes._procedure = _procedure._code INNER JOIN _physician ON _physician._employee_id = _undergoes._physician WHERE _procedure._name = \"bypass surgery\";");
    r=SQLExecDirect(hstmt, sql, SQL_NTS);
    if(r!=SQL_SUCCESS){
      printf("cannot access [%s]\n", sql);
      SQLFreeHandle(SQL_HANDLE_STMT, hstmt);
      return 0;
    }
    printf("%30s %30s %30s\n" , "Nurse Name" , "Nurse Position" , "Physician Name");
    while(1){
      r=SQLFetch(hstmt);
      if(r==SQL_SUCCESS||r==SQL_SUCCESS_WITH_INFO){
        r=SQLGetData(hstmt, 1, SQL_C_CHAR, str, 200, &n);
        printf("%30s ", str);
        r=SQLGetData(hstmt, 2, SQL_C_CHAR, str, 200, &n);
        printf("%30s ", str);
        r=SQLGetData(hstmt, 3, SQL_C_CHAR, str, 200, &n);
        printf("%30s\n", str);
      }
      else if(SQL_NO_DATA==r) break;
      else{
        printf("%s\n", "fail to fetch data");
        break;
      }
    }
  }  

  // Q_8
  if(query == 8){
    strcpy(sql,"SELECT P._name FROM _physician as P INNER JOIN _undergoes as U ON U._physician = P._employee_id WHERE NOT EXISTS ( SELECT * FROM _trained_in WHERE _trained_in._physician = P._employee_id AND _trained_in._treatment = U._procedure );");
    r=SQLExecDirect(hstmt, sql, SQL_NTS);
    if(r!=SQL_SUCCESS){
      printf("cannot access [%s]\n", sql);
      SQLFreeHandle(SQL_HANDLE_STMT, hstmt);
      return 0;
    }
    printf("%30s\n", "Physician Name");
    while(1){
      r=SQLFetch(hstmt);
      if(r==SQL_SUCCESS||r==SQL_SUCCESS_WITH_INFO){
        r=SQLGetData(hstmt, 1, SQL_C_CHAR, str, 200, &n);
        printf("%30s\n", str);
      }
      else if(SQL_NO_DATA==r) break;
      else{
        printf("%s\n", "fail to fetch data");
        break;
      }
    }
  }

  // Q_9
  if(query == 9){
    strcpy(sql,"SELECT _name FROM _physician INNER JOIN _undergoes ON _undergoes._physician = _physician._employee_id INNER JOIN _trained_in ON _trained_in._physician = _physician._employee_id AND _trained_in._treatment = _undergoes._procedure WHERE DATEDIFF(_undergoes._date , _trained_in._certification_expires) > 0;");
    r=SQLExecDirect(hstmt, sql, SQL_NTS);
    if(r!=SQL_SUCCESS){
      printf("cannot access [%s]\n", sql);
      SQLFreeHandle(SQL_HANDLE_STMT, hstmt);
      return 0;
    }
    printf("%30s\n", "Physician Name");
    while(1){
      r=SQLFetch(hstmt);
      if(r==SQL_SUCCESS||r==SQL_SUCCESS_WITH_INFO){
        r=SQLGetData(hstmt, 1, SQL_C_CHAR, str, 200, &n);
        printf("%30s\n", str);
      }
      else if(SQL_NO_DATA==r) break;
      else{
        printf("%s\n", "fail to fetch data");
        break;
      }
    }
  }

  // Q_10
  if(query == 10){
    strcpy(sql,"SELECT _physician._name as _physician_name, _procedure._name as _procedure_name, _undergoes._date as _date, _patient._name as _patient_name FROM _physician INNER JOIN _undergoes ON _undergoes._physician = _physician._employee_id INNER JOIN _trained_in ON _trained_in._physician = _physician._employee_id AND _trained_in._treatment = _undergoes._procedure INNER JOIN _patient ON _patient._ssn = _undergoes._patient INNER JOIN _procedure ON _procedure._code = _undergoes._procedure WHERE DATEDIFF(_undergoes._date , _trained_in._certification_expires) > 0;");
    r=SQLExecDirect(hstmt, sql, SQL_NTS);
    if(r!=SQL_SUCCESS){
      printf("cannot access [%s]\n", sql);
      SQLFreeHandle(SQL_HANDLE_STMT, hstmt);
      return 0;
    }
    printf("%30s %30s %24s %30s\n", "Physician Name" , "Procedure Name" , "Date" , "Patient Name");
    while(1){
      r=SQLFetch(hstmt);
      if(r==SQL_SUCCESS||r==SQL_SUCCESS_WITH_INFO){
        r=SQLGetData(hstmt, 1, SQL_C_CHAR, str, 200, &n);
        printf("%30s ", str);
        r=SQLGetData(hstmt, 2, SQL_C_CHAR, str, 200, &n);
        printf("%30s ", str);
        r=SQLGetData(hstmt, 3, SQL_C_TYPE_TIMESTAMP, &create_timestamp, 0, &n);
        printf("          %d:%d:%d %d:%d:%d", create_timestamp.year , create_timestamp.month , create_timestamp.day , create_timestamp.hour , create_timestamp.minute , create_timestamp.second);
        r=SQLGetData(hstmt, 4, SQL_C_CHAR, str, 200, &n);
        printf("%30s\n", str);
      }
      else if(SQL_NO_DATA==r) break;
      else{
        printf("%s\n", "fail to fetch data");
        break;
      }
    }
  }

  // Q_11
  if(query == 11){
    strcpy(sql,"SELECT S._name as _patient_name, T._name as _physician_name FROM _patient as S INNER JOIN _physician as T ON S._pcp = T._employee_id WHERE EXISTS ( SELECT * FROM _prescribes WHERE _prescribes._physician = T._employee_id AND _prescribes._patient = S._ssn ) AND EXISTS ( SELECT * FROM _procedure INNER JOIN _undergoes ON _undergoes._procedure = _procedure._code WHERE _cost > 5000 AND _patient = S._ssn ) AND 2<=(SELECT COUNT(*) FROM _physician INNER JOIN _appointment ON _appointment._physician = _physician._employee_id INNER JOIN _affiliated_with ON _affiliated_with._physician = _physician._employee_id INNER JOIN _department ON _department._department_id = _affiliated_with._department WHERE _appointment._patient = S._ssn AND _department._name = \"cardiology\" ) AND NOT EXISTS (SELECT * FROM _department WHERE _department._head = T._employee_id );");
    r=SQLExecDirect(hstmt, sql, SQL_NTS);
    if(r!=SQL_SUCCESS){
      printf("cannot access [%s]\n", sql);
      SQLFreeHandle(SQL_HANDLE_STMT, hstmt);
      return 0;
    }
    printf("%30s %30s\n" , "Patient Name" , "Physician Name");
    while(1){
      r=SQLFetch(hstmt);
      if(r==SQL_SUCCESS||r==SQL_SUCCESS_WITH_INFO){
        r=SQLGetData(hstmt, 1, SQL_C_CHAR, str, 200, &n);
        printf("%30s ", str);
        r=SQLGetData(hstmt, 2, SQL_C_CHAR, str, 200, &n);
        printf("%30s\n", str);
      }
      else if(SQL_NO_DATA==r) break;
      else{
        printf("%s\n", "fail to fetch data");
        break;
      }
    }
  }

  // Q_12
  if(query == 12){
    strcpy(sql,"SELECT _name, _brand FROM _medication INNER JOIN (SELECT _medication, COUNT(*) as frequency FROM _prescribes GROUP BY _medication ORDER BY frequency DESC LIMIT 1) as M ON M._medication = _code;");
    r=SQLExecDirect(hstmt, sql, SQL_NTS);
    if(r!=SQL_SUCCESS){
      printf("cannot access [%s]\n", sql);
      SQLFreeHandle(SQL_HANDLE_STMT, hstmt);
      return 0;
    }
    printf("%30s %30s\n" , "Medicine Name" , "Brand");
    while(1){
      r=SQLFetch(hstmt);
      if(r==SQL_SUCCESS||r==SQL_SUCCESS_WITH_INFO){
        r=SQLGetData(hstmt, 1, SQL_C_CHAR, str, 200, &n);
        printf("%30s ", str);
        r=SQLGetData(hstmt, 2, SQL_C_CHAR, str, 200, &n);
        printf("%30s\n", str);
      }
      else if(SQL_NO_DATA==r) break;
      else{
        printf("%s\n", "fail to fetch data");
        break;
      }
    }
  }

  // Q_13
  if(query == 13){    // in the 13th query, take procedure name as input
    char procedure_name[100];
    printf("Enter procedure name: ");
    char temp;
    int idx = 0;
    getchar();
    while((temp = getchar()) != '\n'){
      procedure_name[idx++] = temp;
    }
    procedure_name[idx] = '\0';

    strcpy(sql,"SELECT _physician._name as _name FROM _physician INNER JOIN _trained_in ON _physician._employee_id = _trained_in._physician INNER JOIN _procedure ON _trained_in._treatment = _procedure._code WHERE _procedure._name = \"\0");
    strcat(sql , procedure_name);   // concatenate at appropriate places in 
    strcat(sql , "\";");
    //printf("Query : %s\n" , sql);
    
    r=SQLExecDirect(hstmt, sql, SQL_NTS);
    if(r!=SQL_SUCCESS){
      printf("cannot access [%s]\n", sql);
      SQLFreeHandle(SQL_HANDLE_STMT, hstmt);
      return 0;
    }
    printf("%30s\n", "Physician Name");
    while(1){
      r=SQLFetch(hstmt);
      if(r==SQL_SUCCESS||r==SQL_SUCCESS_WITH_INFO){
        r=SQLGetData(hstmt, 1, SQL_C_CHAR, str, 200, &n);
        printf("%30s\n", str);
      }
      else if(SQL_NO_DATA==r) break;
      else{
        printf("%s\n", "fail to fetch data");
        break;
      }
    }
  }

  SQLFreeHandle(SQL_HANDLE_STMT, hstmt);
}

int main()
{
  // Connect to database with database name and password
  Connect_to_database("MYSQL", "20CS10007", "20CS10007");
  while(1){
    printf("Hospital Database\n1. Query List\n2. Ask Queries\n3. Exit\nHow can I help you? ");  // output prompt
    int option;
    scanf("%d",&option);
    // print all sql queries supported by this database for user convenience
    if(option == 1){
      printf("1. Names of all physicians trained in bypass surgery\n");
      printf("2. Names of all physicians affiliated with the Cardiology department and trained in bypass surgery\n");
      printf("3. Names of all nurses who have ever been on call for room 123\n");
      printf("4. Names and addresses of patients who were prescribed Remdesivir\n");
      printf("5. Name and insurance IDs of all patients who have stayed in an ICU room for more than 15 days\n");
      printf("6. Names of all nurses who assisted in procedure bypass surgery\n");
      printf("7. Name and position of all nurses who assisted in bypass surgery along with names of accompanying physicians\n");
      printf("8. Names of all physicians who have performed a medical procedure they were never trained to perform\n");
      printf("9. Names of all physicians who performed a medical procedure after their certification period for the same expired\n");
      printf("10.Names of all physicians who performed a medical procedure after their certification period for the same expired along with the procedure str, date and the patient's str who underwent the procedure\n");
      printf("11.Names of all patients such that the patient has been prescribed some medication by their physician, the patient has undergone a procedure costlier than 5000 rupees, the patient has had at least 2 appointments with a physician affiliated with the Cardiology department and the patient's physician is not the head of any department\n");
      printf("12.Name and brand of the medication prescribed to maximum number of patients\n");
    }
    else if(option == 2){
      while(1){
        printf("Enter a query number [1-13] (anything else to return to menu): ");    // query number prompt
        int query;
        scanf("%d",&query);
        if(query < 1 || query > 13) break;   // in case of invalid query, revert to menu
        db_fetch(query);    // execute and print that query
      }
    }
    else if(option == 3){
      printf("Thank You!\n");   // exit program
      break;
    }
    else{
      printf("Invalid option!\n");    // 
    }

  }
  // disconnect database
  Disconnect_from_database();
  return 0;
}