import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static const _databaseName = 'billing_register.db';
  static const _databaseVersion = 3;

  // Tables
  static const billingTableName = 'BillingRegister';
  static const sahalTableName = 'SahalRegister';

  // Common Columns
  static const columnActionType = 'ActionType';
  static const columnFirstName = 'FirstName';
  static const columnMiddleName = 'MiddleName';
  static const columnLastName = 'LastName';
  static const columnFourName = 'FourName';
  static const columnMotherName = 'MotherName';
  static const columnEmail = 'Email';
  static const columnPlaceOfBirth = 'PlaceOfBirth';
  static const columnMobileNumber = 'MobileNumber';
  static const columnAddress = 'Address';
  static const columnJobInformation = 'JobInformation';
  static const columnStateAlt = 'State';
  static const columnContactPersonName = 'ContactPersonName';
  static const columnContactPersonTel = 'ContactPersonTel';
  static const columnContactPersonAddress = 'ContactPersonAddress';
  static const columnInheritedName = 'InheritedName';
  static const columnIDCardNumber = 'IDCardNumber';
  static const columnTel = 'Tel';
  static const columnAddressLine1 = 'AddressLine1';
  static const columnRelationship = 'Relationship';
  static const columnImage = 'Image';

  // Instance to the Database
  static Database? _database;

  DatabaseHelper._privateConstructor();

  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final documentsDirectory = await getApplicationDocumentsDirectory();
    final dbPath = join(documentsDirectory.path, _databaseName);
    return await openDatabase(
      dbPath,
      version: _databaseVersion,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $billingTableName (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        $columnActionType TEXT,
        $columnFirstName TEXT,
        $columnMiddleName TEXT,
        $columnLastName TEXT,
        $columnFourName TEXT,
        $columnMotherName TEXT,
        $columnEmail TEXT,
        $columnPlaceOfBirth TEXT,
        $columnMobileNumber TEXT,
        $columnAddress TEXT,
        $columnJobInformation TEXT,        
        $columnStateAlt TEXT,
        $columnContactPersonName TEXT,
        $columnContactPersonTel TEXT,
        $columnContactPersonAddress TEXT,
        $columnInheritedName TEXT,
        $columnIDCardNumber TEXT,
        $columnTel TEXT,
        $columnAddressLine1 TEXT,
        $columnRelationship TEXT
      )
    ''');

    await db.execute('''
      CREATE TABLE $sahalTableName (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        $columnActionType TEXT,
        $columnFirstName TEXT,
        $columnMiddleName TEXT,
        $columnLastName TEXT,
        $columnFourName TEXT,
        $columnMotherName TEXT,
        $columnEmail TEXT,
        $columnPlaceOfBirth TEXT,
        $columnMobileNumber TEXT,
        $columnAddress TEXT,
        $columnJobInformation TEXT,        
        $columnStateAlt TEXT,
        $columnContactPersonName TEXT,
        $columnContactPersonTel TEXT,
        $columnContactPersonAddress TEXT,
        $columnInheritedName TEXT,
        $columnIDCardNumber TEXT,
        $columnTel TEXT,
        $columnAddressLine1 TEXT,
        $columnRelationship TEXT,
        $columnImage TEXT
      )
    ''');
    debugPrint('$billingTableName && $sahalTableName are created');
  }

  Future<int?> insertData(String tableName, Map<String, dynamic> formData) async {
    try {
      final db = await database;

      // Check if the mobile number already exists
      final String mobileNumber = formData[DatabaseHelper.columnMobileNumber];
      final List<Map<String, dynamic>> existingRecords = await db.query(
        tableName,
        where: '${DatabaseHelper.columnMobileNumber} = ?',
        whereArgs: [mobileNumber],
      );

      if (existingRecords.isNotEmpty) {
        log('Data already exists for mobile number: $mobileNumber');
        return null; // Data already exists, so skip insertion
      }

      return await db.insert(tableName, formData); // Insert new data
    } catch (e) {
      log('Error inserting data: $e');
      return null;
    }
  }

  Future<List<Map<String, dynamic>>?> getAllData(String tableName) async {
    try {
      final db = await database;
      return await db.query(tableName);
    } catch (e) {
      log('Error retrieving data: $e');
      return null;
    }
  }

  Future<int?> updateData(String tableName, int id, Map<String, dynamic> formData) async {
    try {
      final db = await database;
      return await db.update(
        tableName,
        formData,
        where: 'id = ?',
        whereArgs: [id],
      );
    } catch (e) {
      log('Error updating data: $e');
      return null;
    }
  }

  Future<int?> deleteData(String tableName, int id) async {
    try {
      final db = await database;
      return await db.delete(
        tableName,
        where: 'id = ?',
        whereArgs: [id],
      );
    } catch (e) {
      log('Error deleting data: $e');
      return null;
    }
  }
}
