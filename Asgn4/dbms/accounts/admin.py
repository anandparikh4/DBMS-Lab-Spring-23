from django.contrib import admin
from .models import *

admin.site.register(db_admin)
admin.site.register(front_desk)
admin.site.register(data_entry)
admin.site.register(physician)
admin.site.register(room)
admin.site.register(patient)
admin.site.register(prescribes)
admin.site.register(tested)
admin.site.register(health_record)
admin.site.register(appointment)
admin.site.register(admission)
admin.site.register(tests)
admin.site.register(treatment)
admin.site.register(undergoes)