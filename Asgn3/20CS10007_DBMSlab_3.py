# Anand Manojkumar Parikh
# Roll : 20CS10007
# Database Management Systems Assignment 3
# Spring 2023
# Database Connectivity in Python

import mysql.connector as mysql     # connector module
from tabulate import tabulate       # for formatting sql-like output

if __name__ == '__main__':

    HOST = "10.5.18.68"         # Host's IP
    DATABASE = "20CS10007"      # Database name
    USER = "20CS10007"          # User name
    PASSWORD = "20CS10007"      # Password

    db = mysql.connect(host=HOST, database=DATABASE, user=USER, password=PASSWORD)  # connect to database on local/remote host

    cursor = db.cursor()    # create a cursor object

    # run queries
    while True:
        print("Hospital Database\n1. Query List\n2. Ask Queries\n3. Exit")  # print menu
        option = int(input("How can I help you: "))     # Query prompt
        if(option == 1):    # Print all queries supported by this database interface for user's convenience
            print("1. Names of all physicians trained in bypass surgery")
            print("2. Names of all physicians affiliated with the Cardiology department and trained in bypass surgery")
            print("3. Names of all nurses who have ever been on call for room 123")
            print("4. Names and addresses of patients who were prescribed Remdesivir")
            print("5. Name and insurance IDs of all patients who have stayed in an ICU room for more than 15 days")
            print("6. Names of all nurses who assisted in procedure bypass surgery")
            print("7. Name and position of all nurses who assisted in bypass surgery along with names of accompanying physicians")
            print("8. Names of all physicians who have performed a medical procedure they were never trained to perform")
            print("9. Names of all physicians who performed a medical procedure after their certification period for the same expired")
            print("10.Names of all physicians who performed a medical procedure after their certification period for the same expired along with the procedure name, date and the patient's name who underwent the procedure")
            print("11.Names of all patients such that the patient has been prescribed some medication by their physician, the patient has undergone a procedure costlier than 5000 rupees, the patient has had at least 2 appointments with a physician affiliated with the Cardiology department and the patient's physician is not the head of any department")
            print("12.Name and brand of the medication prescribed to maximum number of patients")

        elif(option == 2):  # ask which query to run
            while True:
                query = int(input("Enter a query number [1-13] (anything else to return to menu): "))   # take input

                if(query < 1 or query > 13):    # if invalid query is input, return to menu
                    break

                elif(query == 1):
                    # execute query
                    cursor.execute("SELECT _physician._name as _name FROM _physician INNER JOIN _trained_in ON _physician._employee_id = _trained_in._physician INNER JOIN _procedure ON _trained_in._treatment = _procedure._code WHERE _procedure._name = \"bypass surgery\";")
                    result = cursor.fetchall()  # fetch the results
                    print(tabulate(result, headers=["Physician name"], tablefmt="psql"))    # print results in sql-like tabulated format

                elif(query == 2):
                    cursor.execute("SELECT _physician._name as _name FROM _physician INNER JOIN _affiliated_with ON _physician._employee_id = _affiliated_with._physician INNER JOIN _department ON _department._department_id = _affiliated_with._department INNER JOIN _trained_in ON _trained_in._physician = _physician._employee_id INNER JOIN _procedure ON _procedure._code = _trained_in._treatment WHERE _procedure._name = \"bypass surgery\" AND _department._name = \"cardiology\";")
                    result = cursor.fetchall()
                    print(tabulate(result, headers=["Physician name"], tablefmt="psql"))

                elif(query == 3):
                    cursor.execute("SELECT _name FROM _nurse INNER JOIN _on_call ON _on_call._nurse = _nurse._employee_id INNER JOIN _block ON _block._floor = _on_call._block_floor AND _block._code = _on_call._block_code INNER JOIN _room ON _room._block_floor = _block._floor AND _room._block_code = _block._code WHERE _room._number = 123;")
                    result = cursor.fetchall()
                    print(tabulate(result, headers=["Nurse name"], tablefmt="psql"))

                elif(query == 4):
                    cursor.execute("SELECT _patient._name as _name, _address FROM _patient INNER JOIN _prescribes ON _patient._ssn = _prescribes._patient INNER JOIN _medication ON _medication._code = _prescribes._medication WHERE _medication._name = \"remdesivir\";")
                    result = cursor.fetchall()
                    print(tabulate(result, headers=["Patient name" , "Address"], tablefmt="psql"))

                elif(query == 5):
                    cursor.execute("SELECT _name, _insurance_id FROM _patient INNER JOIN _stay ON _stay._patient = _patient._ssn INNER JOIN _room ON _room._number = _stay._room WHERE _room._type = \"icu\" AND DATEDIFF(_stay._end , _stay._start) > 15;")
                    result = cursor.fetchall()
                    print(tabulate(result, headers=["Patient name" , "Insurance ID"], tablefmt="psql"))

                elif(query == 6):
                    cursor.execute("SELECT _nurse._name as _nurse_name FROM _nurse INNER JOIN _undergoes ON _undergoes._assisting_nurse = _nurse._employee_id INNER JOIN _procedure ON _procedure._code = _undergoes._procedure WHERE _procedure._name = \"bypass surgery\";")
                    result = cursor.fetchall()
                    print(tabulate(result, headers=["Nurse name"], tablefmt="psql"))

                elif(query == 7):
                    cursor.execute("SELECT _nurse._name as _nurse_name, _nurse._position as _nurse_position, _physician._name as _physician_name FROM _nurse INNER JOIN _undergoes ON _undergoes._assisting_nurse = _nurse._employee_id INNER JOIN _procedure ON _undergoes._procedure = _procedure._code INNER JOIN _physician ON _physician._employee_id = _undergoes._physician WHERE _procedure._name = \"bypass surgery\";")
                    result = cursor.fetchall()
                    print(tabulate(result, headers=["Nurse name" , "Nurse position" , "Physician name"], tablefmt="psql"))

                elif(query == 8):
                    cursor.execute("SELECT P._name FROM _physician as P INNER JOIN _undergoes as U ON U._physician = P._employee_id WHERE NOT EXISTS ( SELECT * FROM _trained_in WHERE _trained_in._physician = P._employee_id AND _trained_in._treatment = U._procedure );")
                    result = cursor.fetchall()
                    print(tabulate(result, headers=["Physician name"], tablefmt="psql"))

                elif(query == 9):
                    cursor.execute("SELECT _name FROM _physician INNER JOIN _undergoes ON _undergoes._physician = _physician._employee_id INNER JOIN _trained_in ON _trained_in._physician = _physician._employee_id AND _trained_in._treatment = _undergoes._procedure WHERE DATEDIFF(_undergoes._date , _trained_in._certification_expires) > 0;")
                    result = cursor.fetchall()
                    print(tabulate(result, headers=["Physician name"], tablefmt="psql"))

                elif(query == 10):
                    cursor.execute("SELECT _physician._name as _physician_name, _procedure._name as _procedure_name, _undergoes._date as _date, _patient._name as _patient_name FROM _physician INNER JOIN _undergoes ON _undergoes._physician = _physician._employee_id INNER JOIN _trained_in ON _trained_in._physician = _physician._employee_id AND _trained_in._treatment = _undergoes._procedure INNER JOIN _patient ON _patient._ssn = _undergoes._patient INNER JOIN _procedure ON _procedure._code = _undergoes._procedure WHERE DATEDIFF(_undergoes._date , _trained_in._certification_expires) > 0;")
                    result = cursor.fetchall()
                    print(tabulate(result, headers=["Physician name", "Procedure name", "Date", "Patient name"], tablefmt="psql"))

                elif(query == 11):
                    cursor.execute("SELECT S._name as _patient_name, T._name as _physician_name FROM _patient as S INNER JOIN _physician as T ON S._pcp = T._employee_id WHERE EXISTS ( SELECT * FROM _prescribes WHERE _prescribes._physician = T._employee_id AND _prescribes._patient = S._ssn ) AND EXISTS ( SELECT * FROM _procedure INNER JOIN _undergoes ON _undergoes._procedure = _procedure._code WHERE _cost > 5000 AND _patient = S._ssn ) AND 2<=(SELECT COUNT(*) FROM _physician INNER JOIN _appointment ON _appointment._physician = _physician._employee_id INNER JOIN _affiliated_with ON _affiliated_with._physician = _physician._employee_id INNER JOIN _department ON _department._department_id = _affiliated_with._department WHERE _appointment._patient = S._ssn AND _department._name = \"cardiology\" ) AND NOT EXISTS (SELECT * FROM _department WHERE _department._head = T._employee_id );")
                    result = cursor.fetchall()
                    print(tabulate(result, headers=["Patient name", "Physician name"], tablefmt="psql"))

                elif(query == 12):
                    cursor.execute("SELECT _name, _brand FROM _medication INNER JOIN (SELECT _medication, COUNT(*) as frequency FROM _prescribes GROUP BY _medication ORDER BY frequency DESC LIMIT 1) as M ON M._medication = _code;")
                    result = cursor.fetchall()
                    print(tabulate(result, headers=["Medicine name", "Brand"], tablefmt="psql"))

                elif(query == 13):
                    procedure_name = input("Enter a procedure name: ")      # in the 13th query, take procedure name as input from the user
                    cursor.execute("SELECT _physician._name as _name FROM _physician INNER JOIN _trained_in ON _physician._employee_id = _trained_in._physician INNER JOIN _procedure ON _trained_in._treatment = _procedure._code WHERE _procedure._name = \"" + procedure_name + "\";")
                    result = cursor.fetchall()
                    print(tabulate(result, headers=["Physician name"], tablefmt="psql"))

        elif(option == 3):  # exit program
            print("Thank you!")
            break
        else:               # else, notify user of invalid input and prompt menu again
            print("Invalid option!")