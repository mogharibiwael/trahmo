# Generated by Django 4.2.4 on 2023-08-25 06:38

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('project', '0004_alter_tabraa_completed_date'),
    ]

    operations = [
        migrations.AddField(
            model_name='tabraa',
            name='benefactor',
            field=models.ManyToManyField(to='project.benefactor'),
        ),
    ]
