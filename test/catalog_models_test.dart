import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_healthcare_app/src/model/lab_test_category.dart';
import 'package:flutter_healthcare_app/src/model/service.dart';

void main() {
  group('service catalog models', () {
    test('service list maps server fields and serializes them', () {
      final services = serviceFromJson(
        '[{"Id":"service-1","Name":"Urgent care",'
        '"Description":"Same-day appointments","Isactive":true}]',
      );

      expect(services, hasLength(1));
      expect(services.single.name, 'Urgent care');
      expect(services.single.description, 'Same-day appointments');
      expect(serviceFromJson(serviceToJson(services)).single.id, 'service-1');
    });

    test('lab test category retains the API category identifiers', () {
      final category = LabTestCategory.fromJson({
        'Id': 'row-4',
        'Catid': 'category-2',
        'Cattesttype': 'Blood',
        'Cattestname': 'Routine panels',
      });

      expect(category.catid, 'category-2');
      expect(category.cattesttype, 'Blood');
      expect(category.toJson()['Cattestname'], 'Routine panels');
    });
  });
}