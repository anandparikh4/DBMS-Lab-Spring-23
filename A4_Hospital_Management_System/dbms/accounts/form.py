import json
from django import forms
from django.db import transaction
from .models import *
from django.core.exceptions import ValidationError
from django.utils.translation import gettext_lazy as _
from django.contrib.auth.hashers import make_password, check_password
from django.forms.widgets import DateTimeInput,DateInput
from django.forms.widgets import SelectDateWidget
import datetime
from django.utils.timezone import make_aware

BLOOD_GROUP_CHOICES = [
    ('A+', 'A+'),
    ('A-', 'A-'),
    ('B+', 'B+'),
    ('B-', 'B-'),
    ('O+', 'O+'),
    ('O-', 'O-'),
    ('AB+', 'AB+'),
    ('AB-', 'AB-'),
]
test_option = [
    (0, 'Test'),
    (1, 'Treatment'),
    
]

depart = [
        ('cardiology', 'Cardiology'),
        ('dermatology', 'Dermatology'),
        ('endocrinology', 'Endocrinology'),
        ('gastroenterology', 'Gastroenterology'),
        ('neurology', 'Neurology'),
        ('oncology', 'Oncology'),
        ('ophthalmology', 'Ophthalmology'),
        ('orthopedics', 'Orthopedics'),
        ('pediatrician', 'Pediatrician'),
        ('psychiatry', 'Psychiatry'),
        ('pulmonology', 'Pulmonology'),
        ('radiology', 'Radiology'),
        ('urology', 'Urology'),
    ]

POSITION_CHOICES = [
        ('Head', 'Department Head'),
        ('Attending Physician', 'Attending Physician'),
        ('Consultant', 'Consultant'),
        ('Resident Physician', 'Resident Physician'),
        ('Physician Assistant', 'Physician Assistant')
    ]

class DoctorSignUpForm(forms.ModelForm):#form and formfields defined
    
    Email_ID = forms.EmailField()
    Employee_ID = forms.IntegerField(required=True)
    First_Name =forms.CharField(required=True,label="First Name")
    Last_Name =forms.CharField(required=True,label="Last Name")
    Position =forms.ChoiceField(choices= POSITION_CHOICES, required=True)
    Department = forms.ChoiceField(choices=depart,required=True)
    confirm = forms.CharField(required=True, widget=forms.PasswordInput, label="Password")
    password = forms.CharField(required=True, widget=forms.PasswordInput, label="Confirm Password")

    class Meta(forms.ModelForm):#Model Meta is basically used to change the behavior of your model fields like changing order options,verbose_name and lot of other options.
        model = physician
        # Order of Fields in the Form
        fields = ['Email_ID','Employee_ID','First_Name','Last_Name','Position','Department', 'confirm', 'password']
    
    def clean_password(self,*args,**kwargs):
        password = make_password(self.cleaned_data.get('password'))
        confirm = self.cleaned_data.get('confirm')
        print(self.cleaned_data.get('confirm') , self.cleaned_data.get('password'))
        if confirm != self.cleaned_data.get('password'):
            raise forms.ValidationError(_("Password Mismatch"),code='mismatch_password')
        else:
            return password



    @transaction.atomic  #if an exception occurs changes are not saved
    def save(self):
        Email_ID =  self.cleaned_data.get('Email_ID')
        First_Name = self.cleaned_data.get('First_Name').title()#get the data from form which would be stored in self.cleaned and store it in upper case
        Last_Name = self.cleaned_data.get('Last_Name').title()
        Position = self.cleaned_data.get('Position').title() #extract email from form
        Employee_ID = self.cleaned_data.get('Employee_ID')
        Department = self.cleaned_data.get('Department')
        password = self.cleaned_data.get('password')
       
        doctor = physician(Email_ID=Email_ID, First_Name=First_Name,Last_Name = Last_Name,Position = Position, Employee_ID = Employee_ID, Department = Department, password=password)
        doctor.save()
        return doctor

class FrontSignUpForm(forms.ModelForm):#form and formfields defined
   
    Email_ID = forms.EmailField()
    First_Name =forms.CharField(required=True, label="First Name")
    Last_Name =forms.CharField(required=True, label="Last Name")
    Employee_ID = forms.IntegerField(required=True)
    confirm = forms.CharField(required=True, widget=forms.PasswordInput, label="Password")
    password = forms.CharField(required=True, widget=forms.PasswordInput, label="Confirm Password")
    

    class Meta():#Model Meta is basically used to change the behavior of your model fields like changing order options,verbose_name and lot of other options.
        model = front_desk
        # Order of Fields in the Form
        fields = ['Email_ID','First_Name', 'Last_Name', 'Employee_ID','confirm','password']
    
    def clean_password(self,*args,**kwargs):
        password = make_password(self.cleaned_data.get('password'))
        confirm = self.cleaned_data.get('confirm')
        print(self.cleaned_data.get('confirm') , self.cleaned_data.get('password'))
        if confirm != self.cleaned_data.get('password'):
            raise forms.ValidationError(_("Password Mismatch"),code='mismatch_password')
        else:
            return password


    @transaction.atomic  #if an exception occurs changes are not saved
    def save(self):

        First_Name = self.cleaned_data.get('First_Name').title()#get the data from form which would be stored in self.cleaned and store it in upper case
        Last_Name = self.cleaned_data.get('Last_Name').title() #extract email from form
        Employee_ID = self.cleaned_data.get('Employee_ID')
        Email_ID = self.cleaned_data.get('Email_ID')
        password = self.cleaned_data.get('password')
        front = front_desk(First_Name=First_Name,Last_Name = Last_Name, Employee_ID = Employee_ID, password=password, Email_ID = Email_ID)
        front.save()
        return front
    
class DataSignUpForm(forms.ModelForm):#form and formfields defined
    
    Email_ID = forms.EmailField()
    First_Name =forms.CharField(required=True, label="First Name")
    Last_Name =forms.CharField(required=True, label="Last Name")
    Employee_ID = forms.IntegerField(required=True)
    confirm = forms.CharField(required=True, widget=forms.PasswordInput, label="Password")
    password = forms.CharField(required=True, widget=forms.PasswordInput, label="Confirm Password")
    

    class Meta():#Model Meta is basically used to change the behavior of your model fields like changing order options,verbose_name and lot of other options.
        model = data_entry
        # Order of Fields in the Form
        fields = ['Email_ID','First_Name', 'Last_Name', 'Employee_ID','confirm','password']
    
    def clean_password(self,*args,**kwargs):
        password = make_password(self.cleaned_data.get('password'))
        confirm = self.cleaned_data.get('confirm')
        print(self.cleaned_data.get('confirm') , self.cleaned_data.get('password'))
        if confirm != self.cleaned_data.get('password'):
            raise forms.ValidationError(_("Password Mismatch"),code='mismatch_password')
        else:
            return password


    @transaction.atomic  #if an exception occurs changes are not saved
    def save(self):

        First_Name = self.cleaned_data.get('First_Name').title()#get the data from form which would be stored in self.cleaned and store it in upper case
        Last_Name = self.cleaned_data.get('Last_Name').title() #extract email from form
        Employee_ID = self.cleaned_data.get('Employee_ID')
        Email_ID = self.cleaned_data.get('Email_ID')
        password = self.cleaned_data.get('password')
        front = data_entry(First_Name=First_Name,Last_Name = Last_Name, Employee_ID = Employee_ID, password=password, Email_ID = Email_ID)
        front.save()
        return front

class admit_pat(forms.ModelForm):
    
    First_Name = forms.CharField(max_length = 255,required=True)
    Last_Name = forms.CharField(max_length = 255,required=True)
    Room = forms.ChoiceField(choices=[])
    Start = forms.DateTimeField(widget=DateTimeInput(attrs={'type': 'datetime-local','min':'2022-05-20'}))
    PCP_Name = forms.ChoiceField(choices=[], label="Physician Name")
    
    def get_pcp(self):
        # Retrieve the choices from the database or some other source
        # and return them as a list of tuples in the format (value, label)
        patient_list=[]
        doct = physician.objects.all()
        for x in doct:
            print(x.Email_ID) 
            patient_list.append((x.Email_ID,"DR. " + x.First_Name+" "+x.Last_Name))
        return patient_list
    def get_my_choices(self):
        # Retrieve the choices from the database or some other source
        # and return them as a list of tuples in the format (value, label)
        all_room=[]
        rooms = room.objects.all()
        for x in rooms: 
            if(x.Capacity>=1):
                all_room.append((x.Room_ID,x.Room_name+" "+str(x.Type)))
        if all_room == []:
                all_room.append((-1, "NO ROOM AVAILABLE"))
        return all_room
    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)
        self.fields['Room'].choices = self.get_my_choices()
        self.fields['PCP_Name'].choices = self.get_pcp()
        date = datetime.datetime.now(tz=datetime.timezone.utc)
        date = date + datetime.timedelta(days=1)
        date = date.strftime("%Y-%m-%dT%H:%M")
        self.fields['Start'].widget.attrs['min'] = date
    
    class Meta():
        model = patient
        fields = ['First_Name','Last_Name', "Room", 'Start', "PCP_Name"]
        


    @transaction.atomic  #if an exception occurs changes are not saved
    def save(self):
        return self.cleaned_data.get('First_Name').title(),self.cleaned_data.get("Last_Name").title(),self.cleaned_data.get('Room'),self.cleaned_data.get('Start'), self.cleaned_data.get("PCP_Name")

class patient_register(forms.ModelForm):
    
    Email_ID = forms.EmailField()   
    SSN = forms.IntegerField(required=True, label="SSN")
    First_Name = forms.CharField(max_length = 255,required=True)
    Last_Name = forms.CharField(max_length = 255,required=True)
    Address = forms.CharField(max_length = 255,required=True)
    Phone = forms.CharField(max_length = 255,required=True)
    Insurance_ID = forms.IntegerField(required=False)
    Age = forms.IntegerField(required=True)
    Blood_Group = forms.ChoiceField(choices = BLOOD_GROUP_CHOICES, label="Blood Group")
    Gender = forms.CharField(required=True)
    
    class Meta():
        model = patient
        fields = ['Email_ID','SSN','First_Name','Last_Name','Address','Phone','Insurance_ID','Age', 'Blood_Group','Gender']


    @transaction.atomic  #if an exception occurs changes are not saved
    def save(self):
        
        Email_ID = self.cleaned_data.get("Email_ID")
        First_Name = self.cleaned_data.get("First_Name").title()
        Last_Name = self.cleaned_data.get("Last_Name").title()
        SSN = self.cleaned_data.get("SSN")
        Address = self.cleaned_data.get("Address")
        Age = self.cleaned_data.get("Age")
        Insurance_ID = self.cleaned_data.get("Insurance_ID")
        Blood_Group = self.cleaned_data.get("Blood_Group")
        Phone = self.cleaned_data.get("Phone")
        Gender = self.cleaned_data.get("Gender")
        pa = patient(First_Name=First_Name,Last_Name=Last_Name,SSN = SSN, Address = Address, Age = Age, Insurance_ID = Insurance_ID,Blood_Group=Blood_Group,
                               Phone=Phone, Status = 0, Gender=Gender,Email_ID=Email_ID)
        pa.save()
        return pa
class prescribe_form(forms.ModelForm):
    
    First_Name = forms.CharField(max_length = 255,required=True)
    Last_Name = forms.CharField(max_length = 255,required=True)
    Age = forms.IntegerField(required=True)
    Gender = forms.CharField(max_length = 255,required=True)
    Blood_Group = forms.ChoiceField(choices = BLOOD_GROUP_CHOICES, label="Blood Group")
    Prescribe_Date = forms.DateTimeField(widget=DateTimeInput(attrs={'type': 'date', 'max': '2022-05-20'}))
    Prescription = forms.Textarea(attrs={"cols": "35", "rows": "10"})
    
    
    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)
        date = datetime.datetime.now(tz=datetime.timezone.utc)
        date = date + datetime.timedelta(days=1)
        date = date.strftime("%Y-%m-%d")
        # print(date)
        self.fields['Prescribe_Date'].widget.attrs['max'] = date


    class Meta():
        model = prescribes
        fields = ['First_Name','Last_Name','Age', 'Gender', 'Blood_Group','Prescribe_Date','Prescription']

    @transaction.atomic  #if an exception occurs changes are not saved
    def save(self):
        return self.cleaned_data.get('First_Name').title(),self.cleaned_data.get('Last_Name').title(),self.cleaned_data.get('Age'),self.cleaned_data.get('Gender'),self.cleaned_data.get('Blood_Group'),self.cleaned_data.get('Prescribe_Date'),self.cleaned_data.get('Prescription')
        

class schedule_app(forms.ModelForm):
    Physician_Email = forms.ChoiceField(choices=[],label="Physician Name")
    Start = forms.DateField(widget=DateInput(attrs={'type': 'date', 'min': '2022-05-20'}),label="Appointment Date", required=True)
    Appointment_Fee = forms.IntegerField(required=True)
    Emergency = forms.BooleanField(required=False, initial=False ,label="Is This Emergency?")

    def get_pcp(self):
        # Retrieve the choices from the database or some other source
        # and return them as a list of tuples in the format (value, label)
        patient_list=[]
        doct = physician.objects.all()
        for x in doct:
            patient_list.append((x.Email_ID,"DR. " + x.First_Name+" "+x.Last_Name))
        return patient_list
    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)
        self.fields['Physician_Email'].choices = self.get_pcp()
        date = datetime.datetime.now(tz=datetime.timezone.utc)
        date = date + datetime.timedelta(days=1)
        date = date.strftime("%Y-%m-%d")
        self.fields['Start'].widget.attrs['min'] = date

    class Meta():
        model = appointment
        fields = ['Physician_Email','Start','Appointment_Fee','Emergency']
    
    @transaction.atomic  #if an exception occurs changes are not saved
    def save(self):
        return self.cleaned_data.get('Physician_Email'),self.cleaned_data.get('Start'),self.cleaned_data.get('Appointment_Fee'),self.cleaned_data.get('Emergency')

class test_treatment(forms.ModelForm):
    Test = forms.ChoiceField(choices=test_option,label="Test or Treatment")
    
    
    class Meta():
        model = undergoes
        fields = ['Test']
    
    @transaction.atomic  #if an exception occurs changes are not saved
    def save(self):
        return self.cleaned_data.get('Test')


class patient_test_form(forms.ModelForm):

    First_Name = forms.CharField(max_length = 255,required=True)
    Last_Name = forms.CharField(max_length = 255,required=True)
    Tested_ID = forms.CharField(max_length = 255,required=True)
    Test_Name = forms.CharField(max_length = 255,required=True)
    Date = forms.DateTimeField(widget=DateTimeInput(attrs={'type': 'datetime-local'}))
    Test_Result = forms.CharField(widget=forms.Textarea)
    Test_Image = forms.ImageField(required=False)
    
    class Meta():
        model = patient
        fields = ['First_Name','Last_Name', "Test_Name", "Tested_ID", 'Date', "Test_Result", "Test_Image"]
        


    @transaction.atomic  #if an exception occurs changes are not saved
    def save(self):
        return self.cleaned_data.get('First_Name').title(),self.cleaned_data.get("Last_Name").title(),self.cleaned_data.get('Tested_ID'),self.cleaned_data.get('Test_Name'),self.cleaned_data.get('Date'), self.cleaned_data.get("Test_Result"), self.cleaned_data.get("Test_Image")


class patient_treatment_form(forms.ModelForm):

    First_Name = forms.CharField(max_length = 255,required=True)
    Last_Name = forms.CharField(max_length = 255,required=True)
    Treatment_ID = forms.CharField(max_length = 255,required=True)
    Treatment_Name = forms.CharField(max_length = 255,required=True)
    Date = forms.DateTimeField(widget=DateTimeInput(attrs={'type': 'datetime-local'}))
    Physician_Email = forms.EmailField()
    Remarks = forms.CharField(widget=forms.Textarea)
    
    class Meta():
        model = patient
        fields = ['First_Name','Last_Name', "Treatment_Name", "Treatment_ID", 'Date',"Physician_Email","Remarks"]
        


    @transaction.atomic  #if an exception occurs changes are not saved
    def save(self):
        return self.cleaned_data.get('First_Name').title(),self.cleaned_data.get("Last_Name").title(),self.cleaned_data.get('Treatment_ID'),self.cleaned_data.get('Treatment_Name'),self.cleaned_data.get('Date'), self.cleaned_data.get("Physician_Email"),self.cleaned_data.get("Remarks")


class schedule_test(forms.ModelForm):
    Physician_Email = forms.ChoiceField(choices=[],label="Prescribing Physician")
    Test_ID = forms.ChoiceField(choices=[], label="Choose a Test")
    Start = forms.DateField(widget=DateInput(attrs={'type': 'date', 'min': '2022-05-20'}),label="Appointment Date", required=True)
    

    def get_pcp(self):
        # Retrieve the choices from the database or some other source
        # and return them as a list of tuples in the format (value, label)
        patient_list=[]
        doct = physician.objects.all()
        for x in doct:
            patient_list.append((x.Email_ID,"DR. " + x.First_Name+" "+x.Last_Name))
        return patient_list
    def get_test(self):
        # Retrieve the choices from the database or some other source
        # and return them as a list of tuples in the format (value, label)
        all_test=[]
        test = tests.objects.all()
        for x in test: 
            all_test.append((x.Test_ID,x.Test_Name))
        if len(all_test)==0:
                all_test.append((-1, "NO TESTS AVAILABLE"))
        return all_test
    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)
        self.fields['Physician_Email'].choices = self.get_pcp()
        self.fields['Test_ID'].choices = self.get_test()
        date = datetime.datetime.now(tz=datetime.timezone.utc)
        date = date + datetime.timedelta(days=1)
        date = date.strftime("%Y-%m-%d")
        self.fields['Start'].widget.attrs['min'] = date

    class Meta():
        model = appointment
        fields = ['Physician_Email','Test_ID','Start']
    
    @transaction.atomic  #if an exception occurs changes are not saved
    def save(self):
        return self.cleaned_data.get('Physician_Email'),self.cleaned_data.get('Test_ID'),self.cleaned_data.get('Start')

class schedule_treatment(forms.ModelForm):
    Physician_Email = forms.ChoiceField(choices=[],label="Treating Physician")
    Treatment_ID = forms.ChoiceField(choices=[], label="Choose a Treatment")
    Start = forms.DateField(widget=DateInput(attrs={'type': 'date', 'min': '2022-05-20'}),label="Appointment Date", required=True)
    

    def get_pcp(self):
        # Retrieve the choices from the database or some other source
        # and return them as a list of tuples in the format (value, label)
        patient_list=[]
        doct = physician.objects.all()
        for x in doct:
            patient_list.append((x.Email_ID,"DR. " + x.First_Name+" "+x.Last_Name))
        return patient_list
    def get_treatment(self):
        # Retrieve the choices from the database or some other source
        # and return them as a list of tuples in the format (value, label)
        all_treatment=[]
        treat = treatment.objects.all()
        for x in treat: 
            all_treatment.append((x.Treatment_ID,x.Treatment_Name))
        if len(all_treatment)==0:
                all_treatment.append((-1, "NO TREATMENTS AVAILABLE"))
        return all_treatment
    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)
        self.fields['Physician_Email'].choices = self.get_pcp()
        self.fields['Treatment_ID'].choices = self.get_treatment()
        date = datetime.datetime.now(tz=datetime.timezone.utc)
        date = date + datetime.timedelta(days=1)
        date = date.strftime("%Y-%m-%d")
        self.fields['Start'].widget.attrs['min'] = date

    class Meta():
        model = appointment
        fields = ['Physician_Email','Treatment_ID','Start']
    
    @transaction.atomic  #if an exception occurs changes are not saved
    def save(self):
        return self.cleaned_data.get('Physician_Email'),self.cleaned_data.get('Treatment_ID'),self.cleaned_data.get('Start')
    
    
class HealthRecordForm(forms.ModelForm):#form and formfields defined
    
    Patient_Email = forms.EmailField(label="Patient's Email ID")
    First_Name =forms.CharField(required=True,label="First Name")
    Last_Name =forms.CharField(required=True,label="Last Name")
    Admission_ID =forms.ChoiceField(choices= [], required=True, label="Admission Details (Physician Time)")
    Date = forms.DateTimeField(widget=DateTimeInput(attrs={'type': 'date', 'max': '2022-05-20'}))
    Vitals = forms.CharField(widget=forms.Textarea)
    Remarks = forms.CharField(widget=forms.Textarea)
    
    def get_admission(self,patient_email):

        admission_list=[]
        admit = admission.objects.filter(Patient_Email = patient_email)
        for x in admit:
            doc = physician.objects.get(Email_ID = x.PCP_Email)
            admission_list.append((x.Admission_ID,"DR. " + doc.First_Name+" "+doc.Last_Name+" | "+str(x.Start)))
        return admission_list
    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)
        self.fields['Admission_ID'].choices = self.get_admission(self.data.get('Patient_Email'))
        
        date = datetime.datetime.now(tz=datetime.timezone.utc)
        date = date + datetime.timedelta(days=1)
        date = date.strftime("%Y-%m-%d")
        self.fields['Date'].widget.attrs['max'] = date

    
    class Meta(forms.ModelForm):#Model Meta is basically used to change the behavior of your model fields like changing order options,verbose_name and lot of other options.
        model = health_record
        # Order of Fields in the Form
        fields = ['Patient_Email','First_Name','Last_Name','Admission_ID','Date', 'Vitals', 'Remarks']
   
    @transaction.atomic  #if an exception occurs changes are not saved
    def save(self):
        Patient_Email =  self.cleaned_data.get('Patient_Email')
        First_Name = self.cleaned_data.get('First_Name').title()#get the data from form which would be stored in self.cleaned and store it in upper case
        Last_Name = self.cleaned_data.get('Last_Name').title()
        Admission_ID = self.cleaned_data.get('Admission_ID')
        Date = self.cleaned_data.get('Date')
        Vitals = self.cleaned_data.get('Vitals')
        Remarks = self.cleaned_data.get('Remarks')
       
        return Patient_Email, First_Name, Last_Name, Admission_ID, Date, Vitals, Remarks

