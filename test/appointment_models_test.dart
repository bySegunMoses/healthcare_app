import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_healthcare_app/src/model/available.dart';
import 'package:flutter_healthcare_app/src/model/patient_appointment.dart';
import 'package:flutter_healthcare_app/src/model/view_appointment.dart';

void main() {
  group('appointment models', () {
    test('view appointment maps API fields and round-trips JSON', () {
      final appointment = ViewAppointment.fromJson({
        'Id': 'appointment-1',
        'Patientuid': 'patient-7',
        'Doctorid': 'doctor-3',
        'Dates': '2026-11-08',
        'Reasons': 'Annual checkup',
        'Status': 'Pending',
        'doctorName': 'Dr. Lee',
        'appointmentTime': '09:30',
      });

      expect(appointment.id, 'appointment-1');
      expect(appointment.patientuid, 'patient-7');
      expect(appointment.doctorName, 'Dr. Lee');
      expect(appointment.toJson()['appointmentTime'], '09:30');
      expect(ViewAppointment.fromJson(appointment.toJson()).reasons,
          'Annual checkup');
    });

    test('patient appointment retains patient and visit details', () {
      final appointment = PatientAppointment.fromJson({
        'Id': 'appointment-2',
        'Patientuid': 'patient-8',
        'PatientName': 'Jordan',
        'Dates': '2026-11-09',
        'Gender': 'Female',
        'Age': '34',
        'appointmentTime': '14:15',
      });

      expect(appointment.patientName, 'Jordan');
      expect(appointment.gender, 'Female');
      expect(appointment.age, '34');
      expect(appointment.toJson()['appointmentTime'], '14:15');
    });

    test('availability parses nested time slots', () {
      final availability = availableaFromJson(
        '[{"Id":"day-1","Days":"Monday","TimeList":'
        '[{"Id":"time-1","Times":"09:00"},'
        '{"Id":"time-2","Times":"10:00"}]}]',
      ).single;

      expect(availability.days, 'Monday');
      expect(availability.timeList.length, 2);
      expect(availability.timeList.last.times, '10:00');
      expect(availableaFromJson(availableaToJson([availability])).single.days,
          'Monday');
    });
  });
}