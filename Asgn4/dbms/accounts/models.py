from django.db import models

class db_admin(models.Model):
    
    username = models.CharField(max_length=255, primary_key=True)
    password = models.CharField(max_length=255)
    
    def __str__(self):
        return self.username

class front_desk(models.Model):
    
    First_Name = models.CharField(max_length=255)
    Last_Name = models.CharField(max_length=255)
    Email_ID = models.EmailField(primary_key=True)
    Employee_ID = models.IntegerField(unique=True)
    password = models.CharField(max_length=512)
    
    def __str__(self):
        return self.Email_ID
    
class data_entry(models.Model):
    
    First_Name = models.CharField(max_length=255)
    Last_Name = models.CharField(max_length=255)
    Email_ID = models.EmailField(primary_key=True)
    Employee_ID = models.IntegerField(unique=True)
    password = models.CharField(max_length=512)
    
    def __str__(self):
        return self.Email_ID

class physician(models.Model):
    
    Email_ID = models.EmailField(primary_key=True)
    Employee_ID = models.IntegerField(unique=True)
    First_Name = models.CharField(max_length = 255)
    Last_Name = models.CharField(max_length = 255)
    Position = models.CharField(max_length = 255)
    Department = models.CharField(max_length=255)
    password = models.CharField(max_length=512)
    
        
    def __str__(self):
        return self.First_Name+" "+self.Last_Name
    
class tested(models.Model):

    Tested_ID = models.AutoField(primary_key=True)
    Patient_Email = models.EmailField()
    Test_ID = models.IntegerField()
    Date = models.DateTimeField()
    Test_result = models.TextField()
    Test_Image = models.BinaryField()
   
 
    def __str__(self):
        return str(self.Tested_ID)+" "+self.Patient_Email

class tests(models.Model):

    Test_ID = models.AutoField(primary_key=True)
    Test_Name = models.CharField(max_length = 255)
    Cost = models.IntegerField()
   
 
    def __str__(self):
        return str(self.Test_ID) + " " + self.Test_Name

class treatment(models.Model):

    Treatment_ID = models.AutoField(primary_key=True)
    Treatment_Name = models.CharField(max_length = 255)
    Cost = models.IntegerField()
   
 
    def __str__(self):
        return str(self.Treatment_ID) + " " + self.Treatment_Name

class room(models.Model):

    Room_ID = models.AutoField(primary_key=True)
    Type = models.CharField(max_length = 255)
    Room_name = models.CharField(max_length=255)
    Capacity = models.IntegerField()
    Cost = models.IntegerField()
   

 
    def __str__(self):
        return str(self.Room_ID) + " " + str(self.Room_name)
    
class patient(models.Model):

    Email_ID = models.EmailField(primary_key=True)
    SSN = models.IntegerField(unique=True)
    First_Name = models.CharField(max_length = 255)
    Last_Name = models.CharField(max_length = 255)
    Address = models.CharField(max_length = 255)
    Phone = models.CharField(max_length = 255)
    Insurance_ID = models.IntegerField()
    Age = models.IntegerField()
    Gender = models.CharField(max_length=255)
    Blood_Group = models.CharField(max_length=255)
    Status = models.IntegerField()
   
 
    def __str__(self):
        return self.Email_ID
    
class undergoes(models.Model):

    Undergoes_ID = models.AutoField(primary_key=True)
    Patient_Email = models.EmailField()
    Treatment_ID = models.IntegerField()
    Date = models.DateTimeField()
    Physician_Email = models.EmailField()
    Remarks = models.TextField()
 
    def __str__(self):
        return str(self.Undergoes_ID) + " " + str(self.Patient) 
    
class admission(models.Model):
    Admission_ID = models.AutoField(primary_key=True)
    Patient_Email = models.EmailField()
    Room_ID = models.IntegerField()
    Start = models.DateTimeField()
    End = models.DateTimeField()
    PCP_Email = models.EmailField()
    Total_Cost = models.IntegerField()
    
 
    def __str__(self):
        return str(self.Admission_ID) + " " + str(self.Patient_Email)   

class prescribes(models.Model):

    Prescribe_ID = models.AutoField(primary_key=True)
    Physician_Email = models.EmailField()
    Patient_Email = models.EmailField()
    Date = models.DateTimeField()
    Prescription = models.TextField()
   
 
    def __str__(self):
        return str(self.Prescribe_ID) + " " + str(self.Patient_Email) 

class health_record(models.Model):

    Record_ID = models.AutoField(primary_key=True)
    Admission_ID = models.IntegerField()
    Date = models.DateTimeField()
    Vitals = models.TextField()
    Remarks = models.TextField()
 
    def __str__(self):
        return str(self.Record_ID) + " " + str(self.Admission_ID)
    
class appointment(models.Model):

    Appointment_ID = models.AutoField(primary_key=True)
    Patient_Email = models.EmailField()
    Physician_Email = models.EmailField()
    Start = models.DateTimeField()
    Appointment_Fee = models.IntegerField()
    
 
    def __str__(self):
        return str(self.Appointment_ID)+" "+self.Patient_Email
    

    
