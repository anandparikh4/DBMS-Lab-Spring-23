// Anand Manojkumar Parikh
// Roll : 20CS10007
// Database Management Systems Assignment 3
// Spring 2023
// Database Connectivity in Java

package com.company;
import java.sql.*;                  // import all java sql packages, including JDBC driver manager library to connect to database
// import java.sql.DriverManager;      // JDBC driver manager library to connect to database
import java.util.Scanner;           // taking input
import java.util.Formatter;         // for formatting input

public class Main {

    public static void main(String[] args){
        String url;                 // url to connect to
        Connection con = null;      // object of class <Connection>
        try{
            Class.forName("com.mysql.cj.jdbc.Driver");      // set driver
            url="jdbc:mysql://10.5.18.68:3306/20CS10007";   // set url
            con = DriverManager.getConnection(url,"20CS10007","20CS10007");     // connect to database
            Statement stmt = con.createStatement();         // each sql query is run as a Statement
            ResultSet rs;       // store the resultant table in a ResultSet

            // store all queries in strings, and reuse as per input from user
            String q_1 = "SELECT _physician._name as _name FROM _physician INNER JOIN _trained_in ON _physician._employee_id = _trained_in._physician INNER JOIN _procedure ON _trained_in._treatment = _procedure._code WHERE _procedure._name = \"bypass surgery\";";
            String q_2 = "SELECT _physician._name as _name FROM _physician INNER JOIN _affiliated_with ON _physician._employee_id = _affiliated_with._physician INNER JOIN _department ON _department._department_id = _affiliated_with._department INNER JOIN _trained_in ON _trained_in._physician = _physician._employee_id INNER JOIN _procedure ON _procedure._code = _trained_in._treatment WHERE _procedure._name = \"bypass surgery\" AND _department._name = \"cardiology\";";
            String q_3 = "SELECT _name FROM _nurse INNER JOIN _on_call ON _on_call._nurse = _nurse._employee_id INNER JOIN _block ON _block._floor = _on_call._block_floor AND _block._code = _on_call._block_code INNER JOIN _room ON _room._block_floor = _block._floor AND _room._block_code = _block._code WHERE _room._number = 123;";
            String q_4 = "SELECT _patient._name as _name, _address FROM _patient INNER JOIN _prescribes ON _patient._ssn = _prescribes._patient INNER JOIN _medication ON _medication._code = _prescribes._medication WHERE _medication._name = \"remdesivir\";";
            String q_5 = "SELECT _name, _insurance_id FROM _patient INNER JOIN _stay ON _stay._patient = _patient._ssn INNER JOIN _room ON _room._number = _stay._room WHERE _room._type = \"icu\" AND DATEDIFF(_stay._end , _stay._start) > 15;";
            String q_6 = "SELECT _nurse._name as _nurse_name FROM _nurse INNER JOIN _undergoes ON _undergoes._assisting_nurse = _nurse._employee_id INNER JOIN _procedure ON _procedure._code = _undergoes._procedure WHERE _procedure._name = \"bypass surgery\";";
            String q_7 = "SELECT _nurse._name as _nurse_name, _nurse._position as _nurse_position, _physician._name as _physician_name FROM _nurse INNER JOIN _undergoes ON _undergoes._assisting_nurse = _nurse._employee_id INNER JOIN _procedure ON _undergoes._procedure = _procedure._code INNER JOIN _physician ON _physician._employee_id = _undergoes._physician WHERE _procedure._name = \"bypass surgery\";";
            String q_8 = "SELECT P._name FROM _physician as P INNER JOIN _undergoes as U ON U._physician = P._employee_id WHERE NOT EXISTS ( SELECT * FROM _trained_in WHERE _trained_in._physician = P._employee_id AND _trained_in._treatment = U._procedure );";
            String q_9 = "SELECT _name FROM _physician INNER JOIN _undergoes ON _undergoes._physician = _physician._employee_id INNER JOIN _trained_in ON _trained_in._physician = _physician._employee_id AND _trained_in._treatment = _undergoes._procedure WHERE DATEDIFF(_undergoes._date , _trained_in._certification_expires) > 0;";
            String q_10= "SELECT _physician._name as _physician_name, _procedure._name as _procedure_name, _undergoes._date as _date, _patient._name as _patient_name FROM _physician INNER JOIN _undergoes ON _undergoes._physician = _physician._employee_id INNER JOIN _trained_in ON _trained_in._physician = _physician._employee_id AND _trained_in._treatment = _undergoes._procedure INNER JOIN _patient ON _patient._ssn = _undergoes._patient INNER JOIN _procedure ON _procedure._code = _undergoes._procedure WHERE DATEDIFF(_undergoes._date , _trained_in._certification_expires) > 0;";
            String q_11= "SELECT S._name as _patient_name, T._name as _physician_name FROM _patient as S INNER JOIN _physician as T ON S._pcp = T._employee_id WHERE EXISTS ( SELECT * FROM _prescribes WHERE _prescribes._physician = T._employee_id AND _prescribes._patient = S._ssn ) AND EXISTS ( SELECT * FROM _procedure INNER JOIN _undergoes ON _undergoes._procedure = _procedure._code WHERE _cost > 5000 AND _patient = S._ssn ) AND 2<=(SELECT COUNT(*) FROM _physician INNER JOIN _appointment ON _appointment._physician = _physician._employee_id INNER JOIN _affiliated_with ON _affiliated_with._physician = _physician._employee_id INNER JOIN _department ON _department._department_id = _affiliated_with._department WHERE _appointment._patient = S._ssn AND _department._name = \"cardiology\" ) AND NOT EXISTS (SELECT * FROM _department WHERE _department._head = T._employee_id );";
            String q_12= "SELECT _name, _brand FROM _medication INNER JOIN (SELECT _medication, COUNT(*) as frequency FROM _prescribes GROUP BY _medication ORDER BY frequency DESC LIMIT 1) as M ON M._medication = _code;";

            while(true) {
                System.out.print("Hospital Database\n1. Query List\n2. Ask Queries\n3. Exit\nHow can I help you? ");    // print menu
                Scanner sc = new Scanner(System.in);            // new scanner object for taking input
                int option = Integer.parseInt(sc.nextLine());   // take query number as input
                if (option == 1) {      // print all queries supported by this database interface for user convenience
                    System.out.println("1. Names of all physicians trained in bypass surgery");
                    System.out.println("2. Names of all physicians affiliated with the Cardiology department and trained in bypass surgery");
                    System.out.println("3. Names of all nurses who have ever been on call for room 123");
                    System.out.println("4. Names and addresses of patients who were prescribed Remdesivir");
                    System.out.println("5. Name and insurance IDs of all patients who have stayed in an ICU room for more than 15 days");
                    System.out.println("6. Names of all nurses who assisted in procedure bypass surgery");
                    System.out.println("7. Name and position of all nurses who assisted in bypass surgery along with names of accompanying physicians");
                    System.out.println("8. Names of all physicians who have performed a medical procedure they were never trained to perform");
                    System.out.println("9. Names of all physicians who performed a medical procedure after their certification period for the same expired");
                    System.out.println("10.Names of all physicians who performed a medical procedure after their certification period for the same expired along with the procedure name, date and the patient's name who underwent the procedure");
                    System.out.println("11.Names of all patients such that the patient has been prescribed some medication by their physician, the patient has undergone a procedure costlier than 5000 rupees, the patient has had at least 2 appointments with a physician affiliated with the Cardiology department and the patient's physician is not the head of any department");
                    System.out.println("12.Name and brand of the medication prescribed to maximum number of patients");
                }
                else if (option == 2) {     // keep asking for queries until invalid input is given, in which case, revert to the menu

                    while(true) {
                        System.out.print("Enter a query number [1-13] (anything else to return to menu): ");    // query number input prompt
                        int query = Integer.parseInt(sc.nextLine());
                        if(query < 1 || query > 13) break;      // stop in case of invalid query

                        else if (query == 1) {
                            Formatter fmt = new Formatter();    // make a new formatter object to format output in tables
                            rs = stmt.executeQuery(q_1);        // execute the query, taking the corresponding as input in string format
                            fmt.format("%30s\n" , "Physician Name");    // format tables
                            while(rs.next()){
                                fmt.format("%30s\n" , rs.getString("_name"));   // print all table entries
                            }
                            System.out.print(fmt);              // print query output
                        }
                        else if (query == 2) {
                            Formatter fmt = new Formatter();
                            rs = stmt.executeQuery(q_2);
                            fmt.format("%30s\n" , "Physician Name");
                            while(rs.next()){
                                fmt.format("%30s\n" , rs.getString("_name"));
                            }
                            System.out.print(fmt);
                        }
                        else if (query == 3) {
                            Formatter fmt = new Formatter();
                            rs = stmt.executeQuery(q_3);
                            fmt.format("%30s\n" , "Nurse Name");
                            while(rs.next()){
                                fmt.format("%30s\n" , rs.getString("_name"));
                            }
                            System.out.print(fmt);
                        }
                        else if (query == 4) {
                            Formatter fmt = new Formatter();
                            rs = stmt.executeQuery(q_4);
                            fmt.format("%30s %40s\n" , "Patient Name" , "Address");
                            while(rs.next()){
                                fmt.format("%30s %40s\n" , rs.getString("_name") , rs.getString("_address"));
                            }
                            System.out.print(fmt);
                        }
                        else if (query == 5) {
                            Formatter fmt = new Formatter();
                            rs = stmt.executeQuery(q_5);
                            fmt.format("%30s %30s\n", "Patient Name", "Insurance ID");
                            while (rs.next()) {
                                fmt.format("%30s %30s\n", rs.getString("_name"), rs.getString("_insurance_id"));
                            }
                            System.out.print(fmt);
                        }
                        else if (query == 6) {
                            Formatter fmt = new Formatter();
                            rs = stmt.executeQuery(q_6);
                            fmt.format("%30s\n" , "Nurse Name");
                            while(rs.next()){
                                fmt.format("%30s\n" , rs.getString("_nurse_name"));
                            }
                            System.out.print(fmt);
                        }
                        else if (query == 7) {
                            Formatter fmt = new Formatter();
                            rs = stmt.executeQuery(q_7);
                            fmt.format("%30s %30s %30s\n", "Nurse Name", "Nurse Position" , "Physician Name");
                            while (rs.next()) {
                                fmt.format("%30s %30s %30s\n", rs.getString("_nurse_name"), rs.getString("_nurse_position"), rs.getString("_physician_name"));
                            }
                            System.out.print(fmt);
                        }
                        else if (query == 8) {
                            Formatter fmt = new Formatter();
                            rs = stmt.executeQuery(q_8);
                            fmt.format("%30s\n" , "Physician Name");
                            while(rs.next()){
                                fmt.format("%30s\n" , rs.getString("_name"));
                            }
                            System.out.print(fmt);
                        }
                        else if (query == 9) {
                            Formatter fmt = new Formatter();
                            rs = stmt.executeQuery(q_9);
                            fmt.format("%30s\n" , "Physician Name");
                            while(rs.next()){
                                fmt.format("%30s\n" , rs.getString("_name"));
                            }
                            System.out.print(fmt);
                        }
                        else if (query == 10) {
                            Formatter fmt = new Formatter();
                            rs = stmt.executeQuery(q_10);
                            fmt.format("%30s %30s %30s %30s\n" , "Physician Name" , "Procedure" , "Date" , "Patient Name");
                            while(rs.next()){
                                fmt.format("%30s %30s %30s %30s\n" , rs.getString("_physician_name") , rs.getString("_procedure_name") , rs.getString("_date") , rs.getString("_patient_name"));
                            }
                            System.out.print(fmt);
                        }
                        else if (query == 11) {
                            Formatter fmt = new Formatter();
                            rs = stmt.executeQuery(q_11);
                            fmt.format("%30s %30s\n" , "Patient Name" , "Physician Name");
                            while(rs.next()){
                                fmt.format("%30s %30s\n" , rs.getString("_patient_name") , rs.getString("_physician_name"));
                            }
                            System.out.print(fmt);
                        }
                        else if (query == 12) {
                            Formatter fmt = new Formatter();
                            rs = stmt.executeQuery(q_12);
                            fmt.format("%30s %30s\n" , "Medicine Name" , "Brand");
                            while(rs.next()){
                                fmt.format("%30s %30s\n" , rs.getString("_name") , rs.getString("_brand"));
                            }
                            System.out.print(fmt);
                        }
                        else if (query == 13) {     // in the 13th query, take the procedure name as input
                            Formatter fmt = new Formatter();
                            System.out.print("Enter procedure name : ");
                            String procedure_name = sc.nextLine();
                            // concatenate the procedure name into the sql query appropriately
                            String q_13 = "SELECT _physician._name as _name FROM _physician INNER JOIN _trained_in ON _physician._employee_id = _trained_in._physician INNER JOIN _procedure ON _trained_in._treatment = _procedure._code WHERE _procedure._name = \"" + procedure_name + "\";";
                            rs = stmt.executeQuery(q_13);
                            fmt.format("%30s\n" , "Physician Name");
                            while(rs.next()){
                                fmt.format("%30s\n" , rs.getString("_name"));
                            }
                            System.out.print(fmt);
                        }
                    }

                }
                else if (option == 3) {     // exit program
                    System.out.println("Thank You!");
                    break;
                }
                else {      // in case of invalid option, revert to menu
                    System.out.println("Invalid option!");
                }
            }

        }
        catch(Exception e){     // all the above code was in a try block, so in case of any exception, it is caught and output here
            System.out.println(e.toString());
        }
    }
}
