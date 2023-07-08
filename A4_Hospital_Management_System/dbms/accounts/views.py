from django.contrib.auth import login, logout,authenticate
from django.shortcuts import redirect, render
from django.contrib import messages
from django.views.generic import CreateView
from django.http import HttpResponse
from django.contrib.auth.forms import AuthenticationForm
from .models import *
from .form import *
from django.core.mail import send_mail
from django.conf import settings
import datetime
import pytz
from django.conf import settings
from django.utils.timezone import make_aware
from django.http import HttpResponse

def register(request):
    return render(request, '../templates/register.html')

class patient_reg_help(CreateView):
    form_class = patient_register
    template_name = '../templates/pat_register.html'
    
    def get(self, request):
        if 'user' in self.request.session and 'type' in self.request.session and self.request.session['type']=='front_desk':
            user = front_desk.objects.get(Email_ID = self.request.session['user'])
            if user is not None:
                return render(request,'../templates/pat_register.html',{'form':patient_register,"url":"/"})
        return redirect("/")
         
    def form_valid(self,form):#form valid function
        if 'user' in self.request.session and 'type' in self.request.session and self.request.session['type']=='front_desk':#if request is from an authenticated user 
                print("hi")
                pa = form.save()
                return redirect("/")
        return redirect('/')
    
class doctor_register(CreateView):
    form_class = DoctorSignUpForm #student form specified
    template_name = '../templates/doctor_register.html' #template spcified

    def get(self, request):
        if 'user' in self.request.session and 'type' in self.request.session and self.request.session['type']=='db_admin':
            user = db_admin.objects.get(username = self.request.session['user'])
            if user is not None:
                return render(request,'../templates/doctor_register.html',{'whereto':'doctor_register','form':DoctorSignUpForm,'heading':"Register A Doctor","url":"/"})
        return redirect('/')

    def form_valid(self, form): #form valid check
        if 'user' in self.request.session and 'type' in self.request.session and self.request.session['type']=='db_admin':
            user = form.save() #save the form
            return redirect('/') #redirect to main index page
        return redirect('/')
    
class front_desk_register(CreateView):
    form_class = FrontSignUpForm #student form specified
    template_name = '../templates/front_desk_register.html' #template spcified

    def get(self, request):
        if 'user' in self.request.session and 'type' in self.request.session and self.request.session['type']=='db_admin':
            user = db_admin.objects.get(username = self.request.session['user'])
            if user is not None:
                return render(request,'../templates/front_desk_register.html',{'whereto':'front_desk_register','form':FrontSignUpForm,'heading':"Register A Front Desk Operator","url":"/"})
        return redirect('/')

    def form_valid(self, form): #form valid check
        if 'user' in self.request.session and 'type' in self.request.session and self.request.session['type']=='db_admin':
            user = form.save() #save the form
            return redirect('/') #redirect to main index page
        return redirect("/")
    
class data_entry_register(CreateView):
    form_class = DataSignUpForm #student form specified
    template_name = '../templates/data_entry_register.html' #template spcified
    
    def get(self, request):
        if 'user' in self.request.session and 'type' in self.request.session and self.request.session['type']=='db_admin':
            user = db_admin.objects.get(username = self.request.session['user'])
            if user is not None:
                return render(request,'../templates/data_entry_register.html',{'whereto':'data_entry_register','form':DataSignUpForm,'heading':"Register A Data Entry Operator","url":"/"})
        return redirect('/')    
    def form_valid(self, form): #form valid check
        if 'user' in self.request.session and 'type' in self.request.session and self.request.session['type']=='db_admin':
            user = form.save() #save the form
            return redirect('/') #redirect to main index page
        return redirect('/') #redirect to main index page

def login_admin(request):
    
    if request.method=='POST':#all requests withing the software are post and requests betwenn user and software is get
    
        username = request.POST['username']
        password = request.POST['password']
        
        try:
            
            user = db_admin.objects.get(username = username, password = password) 
            request.session['user'] = user.username
            request.session['type'] = "db_admin"
            return redirect('/')
            
        except Exception as e:
            print(e)
            return render(request, '../templates/login.html',#return to the template
                    context={'form':AuthenticationForm(), 'whereto':'admin_login'})
        
    elif request.method=='GET':
        if 'user' in request.session and 'type' in request.session:
            
            return redirect('/')
    return render(request, '../templates/login.html',#return to the template
    context={'form':AuthenticationForm(), 'whereto':'admin_login'})

def login_doctor(request):
    if request.method=='POST':#all requests withing the software are post and requests betwenn user and software is get

        username = request.POST['username']
        password = request.POST['password']
        
        try:
            user = physician.objects.get(Email_ID = username)
            if check_password(password, user.password):
                request.session['user'] = user.Email_ID
                request.session['type'] = "doctor"
                return redirect('/')    
        except:
            return render(request, '../templates/login.html',#return to the template
                    context={'form':AuthenticationForm(),'whereto':'doctor_login'})
    
        
    elif request.method=='GET':
        if 'user' in request.session and 'type' in request.session:
            
            return redirect('/')
    return render(request, '../templates/login.html',#return to the template
    context={'form':AuthenticationForm(),'whereto':'doctor_login'})

def login_fr(request):
    if request.method=='POST':#all requests withing the software are post and requests betwenn user and software is get

        username = request.POST['username']
        password = request.POST['password']
        
        
        try:
            user = front_desk.objects.get(Email_ID = username)
            if check_password(password, user.password):
                request.session['user'] = user.Email_ID
                request.session['type'] = "front_desk"
                return redirect('/')    
        except:
            return render(request, '../templates/login.html',#return to the template
                    context={'form':AuthenticationForm(),'whereto':'fr_login'})
    
        
    elif request.method=='GET':
        if 'user' in request.session and 'type' in request.session:
            return redirect('/')
    return render(request, '../templates/login.html',#return to the template
    context={'form':AuthenticationForm(),'whereto':'fr_login'})

def login_de(request):
    if request.method=='POST':#all requests withing the software are post and requests betwenn user and software is get

        username = request.POST['username']
        password = request.POST['password']
        
        
        try:
            user = data_entry.objects.get(Email_ID = username)
            if check_password(password, user.password):
                request.session['user'] = user.Email_ID
                request.session['type'] = "data_entry"
                return redirect('/')    
        except:
            return render(request, '../templates/login.html',#return to the template
                    context={'form':AuthenticationForm(),'whereto':'de_login'})
    
        
    elif request.method=='GET':
        if 'user' in request.session and 'type' in request.session:
            return redirect('/')
    return render(request, '../templates/login.html',#return to the template
    context={'form':AuthenticationForm(),'whereto':'de_login'})

def logout_view(request):#logout request
    if 'user' in request.session and 'type' in request.session:
        del request.session['user']
        del request.session['type']
        logout(request)#logout 
    return redirect('/')#redirect to accounts/index that will call index function

def handle_admit(request):
    if(request.method == 'GET'):
        if 'user' in request.session and 'type' in request.session and request.session['type']=='front_desk':
            user = front_desk.objects.get(Email_ID = (request.session['user']))
            if user is not None:
                pat = patient.objects.all()
                return render(request,'../templates/admin_user.html',{'whereto':'handle_admit','pat':pat,'user':user})
        return redirect('/')  
    elif request.method == 'POST':
        if 'user' in request.session and 'type' in request.session and request.session['type']=='front_desk':
            user = front_desk.objects.get(Email_ID = (request.session['user']))
            if user is not None:
                a = request.POST.get("comp_id")
                if a is not None:            
                    try:
                        user = patient.objects.get(Email_ID = a)     
                        if user.Status==1:
                            return redirect("/admit_discharge")     
                        values = {
                                'First_Name':user.First_Name,
                                'Last_Name':user.Last_Name,
                            }
                        form = admit_pat(values)
                        form.fields['First_Name'].widget.attrs['readonly']  =True
                        form.fields['Last_Name'].widget.attrs['readonly']  =True

                        return render(request,'../templates/admit_room.html',{'whereto':'patient_admit','form':form, 'Email_ID':user.Email_ID,})#display the form in the edit_details.html
                    except patient.DoesNotExist:
                        return redirect('/admit_discharge')
                a = request.POST.get("dis_id")
                if a is not None:
                    try:
                        user = patient.objects.get(Email_ID = a)
                        if user.Status!=1:
                            return redirect("/admit_discharge")  
                        first_admit = admission.objects.filter(Patient_Email = a).order_by('-Start').first()
                        naive_datetime = datetime.datetime.now()
                        naive_datetime.tzinfo  # None

                        settings.TIME_ZONE  # 'UTC'
                        aware_datetime = make_aware(naive_datetime)
                        aware_datetime.tzinfo  # <UTC>
                        first_admit.End =  aware_datetime
                        x = (first_admit.End - first_admit.Start)
                        
                        
                        user.Status=2
                        pat_room = room.objects.get(Room_ID = first_admit.Room_ID)
                        pat_room.Capacity += 1
                        # print(pat_room.Cost)
                        first_admit.Total_Cost =  (x.seconds/(60*24*60)) * pat_room.Cost
                        
                        user.save()
                        first_admit.save()
                        pat_room.save()
                        user = patient.objects.get(Email_ID = a)
                        admit = admission.objects.filter(Patient_Email = a).order_by("-Admission_ID")
                        return render(request,'../templates/company_details.html',{'user':user, 'admit':admit})
                    except Exception as e:
                        print(e)
                        return redirect("/admit_discharge")
                a = request.POST.get("info")
                if a is not None:
                    try:
                        user = patient.objects.get(Email_ID = a)
                        admit = admission.objects.filter(Patient_Email = a).order_by("-Admission_ID")
                        return render(request,'../templates/company_details.html',{'user':user, 'admit':admit})
                    except Exception as e:
                        print(e)
                        return redirect("/admit_discharge")
                return redirect("/admit_discharge")
        return redirect("/")
 
class admit_patient(CreateView):
    model = undergoes
    form_class = admit_pat
    template_name = '../templates/admit_room.html'
    
    def get(self,request):
        return redirect("/admit_discharge")
    
    def form_valid(self,form):#form valid function
        if 'user' in self.request.session and 'type' in self.request.session and self.request.session['type']=='front_desk':#if request is from an authenticated user 
            Email_ID = self.request.POST.get("my_variable")
            user = front_desk.objects.get(Email_ID = (self.request.session['user']))
            if user is not None:
                user = patient.objects.get(Email_ID = Email_ID)
                if user is not None:
                    First_Name,Last_Name, Room_ID, Start, PCP_Email = form.save()#get data from form
                    doct = physician.objects.get(Email_ID = PCP_Email)
                    if(Room_ID!="-1" and doct is not None):
                        # print(First_Name,Last_Name, Room_ID, Start)
                        pa = admission(Patient_Email =Email_ID, Room_ID = Room_ID, Start=Start, End=Start, PCP_Email = PCP_Email)

                        pat = patient.objects.get(Email_ID =Email_ID)
                        pat.Status = 1
                        pat_room = room.objects.get(Room_ID = Room_ID)
                        pat_room.Capacity -= 1 
                        pat_room.save()
                        pa.save()
                        pat.save()
        return redirect('/')

def scheduler(request):
    if(request.method == 'POST'):
        user = front_desk.objects.get(Email_ID = (request.session['user']))
        if user is not None:
            a = request.POST.get("checker")
            if a is not None:
                pat = patient.objects.get(Email_ID = a)
                doc = request.POST.get("Physician_Email")
                date = request.POST.get("Start")
                fee = request.POST.get("Appointment_Fee")
                emergency = request.POST.get("Emergency")
                values = {
                    'Physician_Email': doc,
                    'Start': date,
                    'Appointment_Fee': fee,
                    'Emergency': emergency,
                }
                print(values)
                date = datetime.datetime.strptime(date, '%Y-%m-%d')
                date = make_aware(date)
                appoints = []
                for i in range(10,20,1):
                    appoint = appointment.objects.filter(Physician_Email = doc, Start = (date+datetime.timedelta(hours=i)))
                    treat = undergoes.objects.filter(Physician_Email=doc, Date = (date+datetime.timedelta(hours=i)))

                    if (emergency or ((appoint is None or len(appoint) == 0) and (treat is None or len(treat) == 0))):
                        time = str("{0:02d}:00 - {1:02d}:00".format(i, i+1))

                        appoints.append({
                            'id' : i,
                            'time' : time
                        })
                form = schedule_app(values)
                return render(request,'../templates/scheduler.html',{'whereto':'scheduler', 'form':form, 'pat':pat,'user':user, 'slots':appoints, 'vals':values,'heading':"Schedule an Appointment", 'url':"/schedule_appointment"})
            a = request.POST.get("slot_id")
            if a is not None:
                a = int(a)
                pat = request.POST.get("Patient_Email")
                doc = request.POST.get("Physician_Email")
                date = request.POST.get("Start")
                fee = request.POST.get("Appointment_Fee")
                print(pat,doc,date,fee,a)
                date = datetime.datetime.strptime(date, '%Y-%m-%d')
                aware_date = make_aware(date)
                aware_date = aware_date + datetime.timedelta(hours=a)
                check_appoint = appointment.objects.filter(Physician_Email = doc, Start = aware_date)
                if check_appoint is not None and len(check_appoint) > 0:
                    print("Appointment already exists!")
                    print("Deleting the appointment")
                    check_appoint = check_appoint[0]
                    temp_pat = patient.objects.get(Email_ID = check_appoint.Patient_Email)
                    temp_doc = physician.objects.get(Email_ID = check_appoint.Physician_Email)
                    e_mess_comp = "Hello <b>" + temp_pat.First_Name + " " + temp_pat.Last_Name + "</b>,<br><br>Your appointment with <b>DR. " + temp_doc.First_Name + " " + temp_doc.Last_Name + "</b> on <b>" + str(check_appoint.Start) + "</b> has been cancelled due to a Emergency Appointment request.<br>We are sorry for the incovinience caused. Please contact the Front Desk operators to reschedule your appointment.<br><br><br>Regards,<br>Hospital Team"
                    send_mail(
                        "Appointment Cancelled due to Emergency", #subject
                        "", #message
                        "opigs.iitkgp@gmail.com", #from_email
                        [check_appoint.Patient_Email], #to_email_list
                        fail_silently=True,
                        html_message= e_mess_comp
                    )
                    check_appoint.delete()
                appoint = appointment(Patient_Email = pat, Physician_Email = doc, Start = (date+datetime.timedelta(hours=a)),Appointment_Fee = fee)
                appoint.save()
            return redirect('/schedule_appointment')
    return redirect('/')

def schedule_appoint(request):
    if(request.method == 'GET'):
        if 'user' in request.session and 'type' in request.session:
            user = front_desk.objects.get(Email_ID = (request.session['user']))
            if user is not None:
                pat = patient.objects.all()
                # print(pat)
                return render(request,'../templates/schedule_appoint.html',{'whereto':'schedule_appoint','pat':pat,'user':user,'heading':"Schedule a Appointement", 'url':"/schedule_appointment"})
        return redirect('/') 
    elif request.method == 'POST':
        if 'user' in request.session and 'type' in request.session:
            user = front_desk.objects.get(Email_ID = (request.session['user']))
            if user is not None:
                a = request.POST.get("comp_id")
                if a is not None:
                    pat = patient.objects.get(Email_ID = a)
                    # print(pat)
                    # form = schedule_appoint()
                    if pat is not None:
                        return render(request,'../templates/scheduler.html',{'whereto':'scheduler','form':schedule_app,'user':user,'pat':pat,'heading':"Schedule an Appointment", 'url':"/schedule_appointment"})
    return redirect('/')

def index(request): # to return homepage depending upon the logged in user
    if(request.method == 'POST'):
        
        if 'user' in request.session and 'type' in request.session:
            try:
                
                user = db_admin.objects.get(username = (request.session['user']))
                id = request.POST.get("front_id")
                if id is not None:    
                    front = front_desk.objects.get(Email_ID = id)
                    front.delete()
                id = request.POST.get("data_id")
                if id is not None:    
                    front = data_entry.objects.get(Email_ID = id)
                    front.delete()
                id = request.POST.get("doct_id")
                if id is not None:    
                    front = physician.objects.get(Email_ID = id)
                    front.delete()
                    
                front = front_desk.objects.all()
                print(front)
                data = data_entry.objects.all()
                print(data)
                doct = physician.objects.all()
                
                print(doct)
                return render(request, 'index.html', {'user': user, 'type':type, 'status':1,'whereto':'index','fronts':front,'datas':data,'docts':doct})
                
            except Exception as e:
                print(e)
                return redirect('/')  
    if(request.method == 'GET'):
        user_id = request.session.get('user')
        type = request.session.get('type')

        if type == 'doctor':
            try:
                user = physician.objects.get(Email_ID = user_id)
                if user is not None:
                    #  get count of all past appointments of the doctor
                    aware_date = make_aware(datetime.datetime.now())
                    past_appoint = appointment.objects.filter(Physician_Email = user.Email_ID, Start__lt = aware_date)
                    past_appoint_count = len(past_appoint)

                    # get count of the no of patients who have visited the doctor
                    past_patients = set()
                    for appoint in past_appoint:
                        past_patients.add(appoint.Patient_Email)

                    past_patients_count = len(past_patients)

                    # get count of the no of patients operated by the doctor in the past
                    past_patients_operated = []
                    operations = undergoes.objects.filter(Physician_Email = user.Email_ID, Date__lt = aware_date)
                    for oprn in operations:
                        past_patients_operated.append(oprn.Patient_Email)

                    no_of_ops = len(past_patients_operated)




                return render(request, 'index.html', {'user': user, 'type':type, 'status':1, 'past_appoint_count':past_appoint_count, 'past_patients_count':past_patients_count, 'no_of_ops':no_of_ops})

            except physician.DoesNotExist:
                return render(request, 'index.html', {'user': {}, 'type':"none"})

        elif type == 'front_desk':
            try:
                user = front_desk.objects.get(Email_ID = user_id)
                rooms = room.objects.all()
                return render(request, 'index.html', {'user': user, 'type':type, 'status':1, 'rooms':rooms})

            except front_desk.DoesNotExist:
                return render(request, 'index.html', {'user': {}, 'type':"none"})

        elif type == 'db_admin':
            try:
                user = db_admin.objects.get(username = user_id)
                front = front_desk.objects.all()
                print(front)
                data = data_entry.objects.all()
                print(data)
                doct = physician.objects.all()
                print(doct)
                return render(request, 'index.html', {'user': user, 'type':type, 'status':1,'whereto':'index','fronts':front,'datas':data,'docts':doct})
                

            except :
                return render(request, 'index.html', {'user': {}, 'type':"none"})

        elif type == 'data_entry':
            try:
                user = data_entry.objects.get(Email_ID = user_id)
                
                return render(request, 'index.html', {'user': user, 'type':type, 'status':1})

            except data_entry.DoesNotExist:
                return render(request, 'index.html', {'user': {}, 'type':"none"})

        else:
            return render(request, 'index.html')

def doctor_pat_record(request):
    if (request.method == 'GET'):
        if 'user' in request.session and 'type' in request.session and request.session['type']=='doctor':
            # try:
            user = physician.objects.get(Email_ID = (request.session['user']))
            # print(user.Email_ID)
            if user is not None:
            # get details of patients' who have had an appointment with the doctor
                doctor_apts = appointment.objects.filter(Physician_Email = user.Email_ID)
                # print(doctor_apts)
                doctor_appoints = set()
                for apt in doctor_apts:
                    doctor_appoints.add(apt.Patient_Email)
                patients = []
                for apt in doctor_appoints: 
                    pat = patient.objects.get(Email_ID = apt)
                    patients.append(pat)

                return render(request, '../templates/doctor_pat_record.html', {'user': user, 'whereto': 'doctor_pat_record', 'patients':patients})
        return redirect("/")
            # except Exception as e:
            #     print(e)
                # return redirect('/')
    if (request.method == 'POST'):
        if 'user' in request.session and 'type' in request.session and request.session['type']=='doctor':
            # try:
            user = physician.objects.get(Email_ID = (request.session['user']))
            if user is not None:
                a = request.POST.get('comp_id')
                if a is not None:
                    pat = patient.objects.get(Email_ID = a)
                    values = {
                        'First_Name': pat.First_Name,
                        'Last_Name': pat.Last_Name,
                        'Age': pat.Age,
                        'Gender': pat.Gender,
                        'Blood_Group': pat.Blood_Group
                    }
                    form = prescribe_form(values)
                    form.fields['First_Name'].widget.attrs['readonly']  =True
                    form.fields['Last_Name'].widget.attrs['readonly']  =True
                    form.fields['Age'].widget.attrs['readonly']  =True
                    form.fields['Gender'].widget.attrs['readonly']  =True
                    form.fields['Blood_Group'].widget.attrs['readonly']  =True
                    return render(request, '../templates/doctor_prescribes.html', {'user': user, 'whereto': 'prescribe_medic', 'form': form, 'pat':pat})
                
                b = request.POST.get('pat_email_health')
                if b is not None:
                    pat = patient.objects.get(Email_ID = b)

                    # get all the prescriptions of the patient which have been prescribed by the doctor
                    curr_date = make_aware(datetime.datetime.now())
                    pat_presriptions = prescribes.objects.filter(Patient_Email = pat.Email_ID, Physician_Email = user.Email_ID, Date__lte = curr_date)
                    # print(pat_presriptions)
                    
                    # get all the health records of the patient who have been admitted to the hospital and have PCP as the doctor
                    pat_health_records = []
                    pat_admits = admission.objects.filter(Patient_Email = pat.Email_ID, PCP_Email = user.Email_ID)
                    for admit in pat_admits:
                        temp = health_record.objects.filter(Admission_ID = admit.Admission_ID)
                        for t in temp:
                            pat_health_records.append(t)

                    return render(request, '../templates/patient_health_records.html', {'user': user, 'whereto': 'doctor_pat_record', 'pat':pat, 'prescriptions':pat_presriptions, 'records': pat_health_records})
                
                a = request.POST.get('pat_test_result')
                if a is not None:
                    pat = patient.objects.get(Email_ID = a)
                    pat_tests = tested.objects.filter(Patient_Email = pat.Email_ID).order_by('-Date')
                    records = []
                    for test in pat_tests:
                        record = {}
                        record['Test_ID'] = test.Test_ID
                        record['Test_Name'] = tests.objects.get(Test_ID = test.Test_ID).Test_Name
                        record['Date'] = test.Date
                        record['Test_result'] = test.Test_result
                        record['Test_Image'] = test.Test_Image
                        records.append(record)
                    return render(request, '../templates/patient_test_results.html', {'user': user, 'whereto': 'doctor_pat_record', 'pat':pat, 'records':records})
    return redirect('/')
        
class doctor_prescribe(CreateView):
    model = prescribes
    form_class = prescribe_form
    template_name = '../templates/doctor_prescribes.html'

    def get(self, request):
        return redirect('doctor_pat_record')
        
    def form_valid(self, form):
        if 'user' in self.request.session and 'type' in self.request.session and self.request.session['type']=='doctor':
            user = physician.objects.get(Email_ID = (self.request.session['user']))
            if user is not None:
                print(user.Email_ID)
                First_Name,Last_Name,Age, Gender, Blood_Group,Prescribe_Date,Prescription = form.save()
                print(First_Name,Last_Name,Age, Gender, Blood_Group,Prescribe_Date,Prescription,self.request.POST.get('patient_id'))
                pres = prescribes(Physician_Email = user.Email_ID, Patient_Email = self.request.POST.get('patient_id'), Date=Prescribe_Date, Prescription=Prescription)
                pres.save()
                return redirect('doctor_pat_record')
            return redirect("/")
        else:
            return redirect('/')

def show_upcoming_appts(request):
    if (request.method == 'GET'):
        if 'user' in request.session and 'type' in request.session and request.session['type']=='doctor':

            user = physician.objects.get(Email_ID = (request.session['user']))
            
            if user is not None:
                
                # get all doctor appointments starting from current day's appointment
                date = datetime.datetime.date(make_aware(datetime.datetime.now()))
                # print(date)
                # aware_datetime = datetime.datetime
                doctor_apts = appointment.objects.filter(Physician_Email = user.Email_ID, Start__gte = date).order_by('Start')
                # doctor_apts = appointment.objects.filter(Physician_Email = user.Email_ID, Start__gte = make_aware(datetime.datetime.now()))
                # print(doctor_apts)
                patients = set()
                for apt in doctor_apts:
                    pat = patient.objects.get(Email_ID = apt.Patient_Email)
                    patients.add(pat)

                # print(patients)

                return render(request, '../templates/doctor_apts.html', {'user': user, 'whereto': 'show_upcoming_appts', 'appointments': doctor_apts, 'patients': patients})
    return redirect("/")
    
def patient_data_entry(request):
    if(request.method == 'GET'):
        if 'user' in request.session and 'type' in request.session and request.session['type']=='data_entry':
            user = data_entry.objects.get(Email_ID = (request.session['user']))
            if user is not None:
                pat = patient.objects.all()
                return render(request,'../templates/pat_list.html',{'whereto':'patient_data_entry','pat':pat,'user':user})
        return redirect('/')  
    elif request.method == 'POST':
        user = data_entry.objects.get(Email_ID = (request.session['user']))
        if user is not None:
            a = request.POST.get("completion")
            print(a)
            if a is not None:     
                print(a)       
                try:
                    user = patient.objects.get(Email_ID = a)           
                    return render(request,'../templates/test_treatment.html',{'whereto':'patient_test','form':test_treatment,'user':user,'pat':user})
                except Exception as e:
                    print(e)
                   
                    return redirect('/patient_data_entry')
            a = request.POST.get("schedule_test")
            if a is not None:
                pat = patient.objects.get(Email_ID = a)
                if pat is not None:
                    return render(request,'../templates/scheduler.html',{'whereto':'scheduler_test','pat':pat,'user':user,'form':schedule_test,'heading':"Schedule a Test", 'url':"/patient_data_entry"})                
            a = request.POST.get("schedule_treatment")
            if a is not None:
                pat = patient.objects.get(Email_ID = a)
                if pat is not None:
                    return render(request,'../templates/scheduler.html',{'whereto':'scheduler_treatment','pat':pat,'user':user,'form':schedule_treatment,'heading':"Schedule a Treatment", 'url':"/patient_data_entry"})                
            a = request.POST.get("prescribe")
            if a is not None:            
                try:
                    user = patient.objects.get(Email_ID = a)          
                    prescri = prescribes.objects.filter(Patient_Email = a)
                   
                    prescription_list = []
                    
                    for i in prescri:
                        
                        prescription_list.append({
                                'id' : i.Prescribe_ID,
                                'Date' :i.Date,
                                'Physician_Name':physician.objects.get(Email_ID = i.Physician_Email).First_Name+" "+physician.objects.get(Email_ID = i.Physician_Email).Last_Name,
                                'Prescription': i.Prescription,
                             })
                        name = user.First_Name+" "+user.Last_Name
                    
                    return render(request,'../templates/presc_list.html',{'whereto':'patient_operation', 'Email_ID':user.Email_ID, 'name':name,'presc': prescription_list})#display the form in the edit_details.html
                except patient.DoesNotExist:
                    return redirect('/patient_test')
            a = request.POST.get("health")
            if a is not None:            
                try:
                    user = patient.objects.get(Email_ID = a)   
                    values = {
                                'Patient_Email':user.Email_ID,
                                'First_Name':user.First_Name,
                                'Last_Name':user.Last_Name,
                                }
                    form = HealthRecordForm(values)
                    form.fields['Patient_Email'].widget.attrs['readonly']  =True
                    form.fields['First_Name'].widget.attrs['readonly']  =True
                    form.fields['Last_Name'].widget.attrs['readonly']  =True
                    
                    
                    return render(request,'../templates/edit_details.html',{'whereto':'test_health','form':form, 'Email_ID':user.Email_ID, "heading":"Enter Health Details"})#display the form in the edit_details.html
                                          
                except patient.DoesNotExist:
                    return redirect('/patient_test')
    return redirect("/")
 
def patient_test(request):
    if(request.method == 'POST'):
        user = data_entry.objects.get(Email_ID = (request.session['user']))
        if user is not None:
            a = request.POST.get("checker")
            if a is not None:
                pat = patient.objects.get(Email_ID = a)
                email = request.POST.get("email")
                Test = request.POST.get("Test")
                
                if Test == '0':
                    
                    form= test_treatment
                    values = {
                         'Patient_Email':email,
                         'Test':Test,
                     }
                    form= test_treatment({"Test":Test})
                    test_pat = []
                    test = tested.objects.filter(Patient_Email = email)
                    for i in test:
                        if len(i.Test_result)==0:
                             test_pat.append({
                                'id' : i.Tested_ID,
                                'Date' :i.Date,
                                'Test_ID':i.Test_ID,
                                'Test_Name': tests.objects.get(Test_ID = i.Test_ID).Test_Name
                             })
                  
                
                    return render(request,'../templates/test_treatment.html',{'whereto':'patient_test', 'form':form, 'pat':pat,'user':user, 'slots':test_pat, 'vals':values})
            
                elif Test == '1':
                    
                    form= test_treatment({"Test":Test})
                    values = {
                         'Patient_Email':email,
                         'Test':Test,
                         
                     }
                    undergoes_pat = []
                    operation = undergoes.objects.filter(Patient_Email = email)
                    
                    for i in operation:
                        if len(i.Remarks)==0:
                             undergoes_pat.append({
                                'id' : i.Undergoes_ID,
                                'Date' :i.Date,
                                'Treatment_ID':i.Treatment_ID,
                                'Treatment_Name': treatment.objects.get(Treatment_ID = i.Treatment_ID).Treatment_Name,

                             })
                    
                
                    return render(request,'../templates/test_treatment.html',{'whereto':'patient_test', 'form':form, 'pat':pat,'user':user, 'undergoes':undergoes_pat, 'vals':values})
            
            a = request.POST.get("slot_id")
            if a is not None:
                type = request.POST.get("type")
                if type=="test":
                    test_id = int(a)
                    
                
                
                    test = request.POST.get("Test_ID")
                    pat = request.POST.get("Patient_Email")
                    
                    
                    pat_record = patient.objects.get(Email_ID = pat)
                    Test_taken = tested.objects.get(Tested_ID = test_id)
                    test_record = tests.objects.get(Test_ID = int(test))
                    
                    values = {
                                'First_Name':pat_record.First_Name,
                                'Last_Name':pat_record.Last_Name,
                                'Tested_ID' : Test_taken.Tested_ID,
                                'Test_Name': test_record.Test_Name,
                                'Date' : Test_taken.Date,
                            }
                    form = patient_test_form(values)
                    form.fields['First_Name'].widget.attrs['readonly']  =True
                    form.fields['Last_Name'].widget.attrs['readonly']  =True
                    form.fields['Tested_ID'].widget.attrs['readonly']  = True
                    form.fields['Test_Name'].widget.attrs['readonly']  =True
                    form.fields['Date'].widget.attrs['readonly']  =True
                    
                    return render(request,'../templates/edit_details.html',{'whereto':'test_update','form':form, 'Email_ID':user.Email_ID, 'heading':"Test Result Form"})#display the form in the edit_details.html
                
                elif type=="treatment":
                    type = request.POST.get("type")

                    undergoes_id = int(a)
                    
                
                
                    test = request.POST.get("Treatment_ID")
                    pat = request.POST.get("Patient_Email")
                    
                    
                    pat_record = patient.objects.get(Email_ID = pat)
                    Treatment_taken = undergoes.objects.get(Undergoes_ID = undergoes_id)
                    Treatment_details = treatment.objects.get(Treatment_ID = int(test))
                    
                    values = {
                                'First_Name':pat_record.First_Name,
                                'Last_Name':pat_record.Last_Name,
                                'Treatment_ID' : Treatment_taken.Treatment_ID,
                                'Treatment_Name': Treatment_details.Treatment_Name,
                                'Date' : Treatment_taken.Date,
                                'Physician_Email':Treatment_taken.Physician_Email
                            }
                    form = patient_treatment_form(values)
                    form.fields['First_Name'].widget.attrs['readonly']  =True
                    form.fields['Last_Name'].widget.attrs['readonly']  =True
                    form.fields['Treatment_Name'].widget.attrs['readonly']  = True
                    form.fields['Treatment_ID'].widget.attrs['readonly']  =True
                    form.fields['Date'].widget.attrs['readonly']  =True
                    form.fields['Physician_Email'].widget.attrs['readonly']  =True
                    
                    return render(request,'../templates/edit_details.html',{'whereto':'treatment_update','form':form, 'Email_ID':user.Email_ID, 'heading':"Treatment Status Form"})#display the form in the edit_details.html
    return redirect("/patient_data_entry")

class test_update(CreateView):
    model = tested
    form_class = patient_test_form
    template_name = '../templates/edit_details.html'
    
    def get(self, request):
        return redirect('/patient_data_entry')
    
    def form_valid(self,form):#form valid function
        if 'user' in self.request.session and 'type' in self.request.session and self.request.session['type']=='data_entry':#if request is from an authenticated user 
            user = data_entry.objects.get(Email_ID = self.request.session['user'])
            if user is not None:
                First_Name,Last_Name, Tested_ID, Test_Name, Date, Test_Result, Test_Image= form.save()#get data from form
                tested_pat = tested.objects.get(Tested_ID = Tested_ID)
                tested_pat.Test_result = Test_Result
                tested_pat.Test_Image = Test_Image.read()
                tested_pat.save()
        return redirect('/patient_data_entry')

class test_health(CreateView):
    model = health_record
    form_class = HealthRecordForm
    template_name = '../templates/edit_details.html'
    
    def get(self, request):
        return redirect('/patient_data_entry')
    
    def form_valid(self,form):#form valid function
        if 'user' in self.request.session and 'type' in self.request.session and self.request.session['type']=='data_entry':#if request is from an authenticated user 
            user = data_entry.objects.get(Email_ID = self.request.session['user'])
            if user is not None:
                Email_ID,First_Name,Last_Name, Admission_ID, Date, Vitals, Remarks= form.save()#get data from form
                tested_pat = health_record(Admission_ID=Admission_ID,Date=Date,Vitals=Vitals,Remarks=Remarks)
                temp_pat = patient.objects.get(Email_ID = Email_ID)
                admit = admission.objects.get(Admission_ID = Admission_ID)
                temp_doc = physician.objects.get(Email_ID =admit.PCP_Email)
                e_mess_comp = "Hello <b>DR. " + temp_doc.First_Name + " " + temp_doc.Last_Name + "</b>,<br><br>Health Record of <b>" + temp_pat.First_Name + " " + temp_pat.Last_Name + "</b> of <b>" + str(Date.strftime("%B %d, %Y, %I:%M:%S %p %Z")) + "</b> are as follows: <br><br> Vitals:<br>"+Vitals+"<br>Remarks:<br>"+Remarks+".<br><br><br>Regards,<br>Hospital Team"
                # print(e_mess_comp)
                # print(temp_doc.Email_ID)
                send_mail(
                    "Health Record Update", #subject
                    "", #message
                    "opigs.iitkgp@gmail.com", #from_email
                    [temp_doc.Email_ID], #to_email_list
                    fail_silently=True,
                    html_message= e_mess_comp
                )
                
                tested_pat.save()
        return redirect('/patient_data_entry')

class treatment_update(CreateView):
    model = tested
    form_class = patient_treatment_form
    template_name = '../templates/edit_details.html'
    
    def get(self, request):
        return redirect('/patient_data_entry')
    
    def form_valid(self,form):#form valid function
        if 'user' in self.request.session and 'type' in self.request.session and self.request.session['type']=='data_entry':#if request is from an authenticated user 
            user = data_entry.objects.get(Email_ID = self.request.session['user'])
            if user is not None:
                First_Name,Last_Name, Treatment_ID, Treatment_Name, Date,Email, Remarks= form.save()#get data from form
                operation = undergoes.objects.get(Treatment_ID = Treatment_ID)
                operation.Remarks = Remarks
                operation.save()
            
        return redirect('/patient_data_entry')


def scheduler_test(request):
    if(request.method == 'POST'):
        user = data_entry.objects.get(Email_ID = (request.session['user']))
        if user is not None:
            a = request.POST.get("checker")
            if a is not None:
                pat = patient.objects.get(Email_ID = a)
                doc = request.POST.get("Physician_Email")
                date = request.POST.get("Start")
                test_id = int(request.POST.get("Test_ID"))
                if test_id<0:
                    return redirect('/patient_data_entry')
                values = {
                    'Physician_Email':doc,
                    'Start':date,
                    'Test_ID':test_id,
                }
                date = datetime.datetime.strptime(date, '%Y-%m-%d')
                date = make_aware(date)
                
                appoints = []
                for i in range(10,20,1):
                    appoint = tested.objects.filter(Test_ID = test_id, Date = (date+datetime.timedelta(hours=i)))
                    
                    if (appoint is None or len(appoint) < 5):
                        time = str("{0:02d}:00 - {1:02d}:00".format(i, i+1))
                        appoints.append({
                            'id' : i,
                            'time' : time
                        })
                
                form = schedule_test(values)
                return render(request,'../templates/scheduler.html',{'whereto':'scheduler_test', 'form':form, 'pat':pat,'user':user, 'slots':appoints, 'vals':values,'heading':"Schedule a Test", 'url':"/patient_data_entry"})
            a = request.POST.get("slot_id")
            if a is not None:
                a = int(a)
                pat = request.POST.get("Patient_Email")
                doc = request.POST.get("Physician_Email")
                date = request.POST.get("Start")
                test_id = int(request.POST.get("Test_ID"))
                date = datetime.datetime.strptime(date, '%Y-%m-%d')
                date = make_aware(date)
                date = date+datetime.timedelta(hours=a)
                test = tested(Patient_Email = pat, Date = date, Test_ID = test_id)
                test.save()
        return redirect("/patient_data_entry")
    return redirect("/")

def scheduler_treatment(request):
    if(request.method == 'POST'):
        user = data_entry.objects.get(Email_ID = (request.session['user']))
        if user is not None:
            a = request.POST.get("checker")
            if a is not None:
                pat = patient.objects.get(Email_ID = a)
                doc = request.POST.get("Physician_Email")
                date = request.POST.get("Start")
                treatment_id = int(request.POST.get("Treatment_ID"))
                if treatment_id < 0:
                    return redirect('/patient_data_entry')
                values = {
                    'Physician_Email':doc,
                    'Start':date,
                    'Treatment_ID':treatment_id,
                }
                date = datetime.datetime.strptime(date, '%Y-%m-%d')
                date = make_aware(date)
                
                appoints = []
                for i in range(10,20,1):
                    treat = undergoes.objects.filter(Physician_Email=doc, Date = (date+datetime.timedelta(hours=i)))
                    appoint = appointment.objects.filter(Physician_Email=doc, Start = (date+datetime.timedelta(hours=i)))
                    
                    if ((appoint is None or len(appoint) == 0) and (treat is None or len(treat) == 0)):
                        time = str("{0:02d}:00 - {1:02d}:00".format(i, i+1))
                        appoints.append({
                            'id' : i,
                            'time' : time
                        })
                
                form = schedule_treatment(values)
                return render(request,'../templates/scheduler.html',{'whereto':'scheduler_treatment', 'form':form, 'pat':pat,'user':user, 'slots':appoints, 'vals':values, 'heading':"Schedule a Treatment", 'url':"/patient_data_entry"})
            a = request.POST.get("slot_id")
            if a is not None:
                a = int(a)
                pat = request.POST.get("Patient_Email")
                doc = request.POST.get("Physician_Email")
                date = request.POST.get("Start")
                treatment_id = request.POST.get("Treatment_ID")
                date = datetime.datetime.strptime(date, '%Y-%m-%d')
                date = make_aware(date)
                date = date+datetime.timedelta(hours=a)
                treat = undergoes(Patient_Email = pat, Physician_Email = doc, Date = date, Treatment_ID = treatment_id)
                treat.save()
        return redirect("/patient_data_entry")
    return redirect("/")
