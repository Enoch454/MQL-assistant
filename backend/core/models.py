from django.db import models


# Create your models here.
class Sueldo(models.Model):
    # TODO: verificar sueldo base
    base = models.DecimalField(max_digits=3)
    bono = models.DecimalField(max_digits=3)
    horas_extra = models.DecimalField()
    otros = models.DecimalField()
    fecha_pago = models.DateField()
    # TODO: Enlazar clase Operario
    id_operario = models.ManyToOneRel()


class Operario(models.Model):
    nombre = models.CharField(max_length=50, blank=False, null= False)
