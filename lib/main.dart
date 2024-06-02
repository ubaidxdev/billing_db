import 'package:billing_db/db_helper.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: TestScreen(),
    );
  }
}

class TestScreen extends StatelessWidget {
  final DatabaseHelper dbHelper = DatabaseHelper.instance;

  final Map<String, dynamic> sampleBillingData = {
    DatabaseHelper.columnActionType: 'Billing',
    DatabaseHelper.columnFirstName: 'John',
    DatabaseHelper.columnMiddleName: 'A.',
    DatabaseHelper.columnLastName: 'Doe',
    DatabaseHelper.columnFourName: 'Callsub',
    DatabaseHelper.columnMotherName: 'Jane Doe',
    DatabaseHelper.columnEmail: 'john.doe@example.com',
    DatabaseHelper.columnPlaceOfBirth: 'New York',
    DatabaseHelper.columnMobileNumber: '1234567890',
    DatabaseHelper.columnAddress: '123 Main St',
    DatabaseHelper.columnJobInformation: 'Software Engineer',
    DatabaseHelper.columnStateAlt: 'New York',
    DatabaseHelper.columnContactPersonName: 'Jane Doe',
    DatabaseHelper.columnContactPersonTel: '0987654321',
    DatabaseHelper.columnContactPersonAddress: '456 Elm St',
    DatabaseHelper.columnInheritedName: 'John Doe Sr.',
    DatabaseHelper.columnIDCardNumber: 'AB123456',
    DatabaseHelper.columnTel: '555-1234',
    DatabaseHelper.columnAddressLine1: 'Apartment 1A',
    DatabaseHelper.columnRelationship: 'Son',
  };

  final Map<String, dynamic> sampleSahalData = {
    DatabaseHelper.columnActionType: 'Sahal',
    DatabaseHelper.columnFirstName: 'Alice',
    DatabaseHelper.columnMiddleName: 'B.',
    DatabaseHelper.columnLastName: 'Smith',
    DatabaseHelper.columnFourName: 'Callsub',
    DatabaseHelper.columnMotherName: 'Mary Smith',
    DatabaseHelper.columnEmail: 'alice.smith@example.com',
    DatabaseHelper.columnPlaceOfBirth: 'Los Angeles',
    DatabaseHelper.columnMobileNumber: '2345678901',
    DatabaseHelper.columnAddress: '456 Oak St',
    DatabaseHelper.columnJobInformation: 'Designer',
    DatabaseHelper.columnStateAlt: 'California',
    DatabaseHelper.columnContactPersonName: 'Mary Smith',
    DatabaseHelper.columnContactPersonTel: '9876543210',
    DatabaseHelper.columnContactPersonAddress: '789 Pine St',
    DatabaseHelper.columnInheritedName: 'Alice Smith Sr.',
    DatabaseHelper.columnIDCardNumber: 'CD789012',
    DatabaseHelper.columnTel: '555-5678',
    DatabaseHelper.columnAddressLine1: 'Suite 2B',
    DatabaseHelper.columnRelationship: 'Daughter',
    DatabaseHelper.columnImage: 'Images',
  };

  TestScreen({super.key});

  void insertBillingData() async {
    await dbHelper.insertData(DatabaseHelper.billingTableName, sampleBillingData);
  }

  void insertSahalData() async {
    await dbHelper.insertData(DatabaseHelper.sahalTableName, sampleSahalData);
  }

  void getAllBillingData() async {
    List<Map<String, dynamic>>? data = await dbHelper.getAllData(DatabaseHelper.billingTableName);
    if (data != null) {
      for (var record in data) {
        print(record);
      }
    }
  }

  void getAllSahalData() async {
    List<Map<String, dynamic>>? data = await dbHelper.getAllData(DatabaseHelper.sahalTableName);
    if (data != null) {
      for (var record in data) {
        print(record);
      }
    }
  }

  void updateBillingData() async {
    await dbHelper.updateData(DatabaseHelper.billingTableName, 1, sampleBillingData);
  }

  void deleteBillingData() async {
    await dbHelper.deleteData(DatabaseHelper.billingTableName, 1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Database Test Screen'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: insertBillingData,
              child: const Text('Insert Billing Data'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: insertSahalData,
              child: const Text('Insert Sahal Data'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: getAllBillingData,
              child: const Text('Get All Billing Data'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: getAllSahalData,
              child: const Text('Get All Sahal Data'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: updateBillingData,
              child: const Text('Update Billing Data'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: deleteBillingData,
              child: const Text('Delete Billing Data'),
            ),
          ],
        ),
      ),
    );
  }
}
