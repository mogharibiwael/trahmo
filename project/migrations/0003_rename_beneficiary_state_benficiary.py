# Generated by Django 4.2.4 on 2023-08-24 14:55

from django.db import migrations


class Migration(migrations.Migration):

    dependencies = [
        ('project', '0002_rename_beneficiary_state_beneficiary'),
    ]

    operations = [
        migrations.RenameField(
            model_name='state',
            old_name='beneficiary',
            new_name='benficiary',
        ),
    ]
