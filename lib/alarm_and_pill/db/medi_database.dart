// import 'package:alarm_manager/services/Medicine.dart';
// import 'package:alarm_manager/services/MediData.dart';
// import 'package:alarm_manager/services/PillTakeInfo.dart';
// import 'package:alarm_manager/services/Prescription.dart';
import 'package:elcare_application/alarm_and_pill/services/MediData.dart';
import 'package:elcare_application/alarm_and_pill/services/Medicine.dart';
import 'package:elcare_application/alarm_and_pill/services/PillTakeInfo.dart';
import 'package:elcare_application/alarm_and_pill/services/Prescription.dart';
import 'package:flutter/widgets.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

//create 4 tables inside this for mediData,prescription,pillTakeInfo and Medicine related medicine details
class AppDatabase {
  static final AppDatabase instance = AppDatabase._init();

  static Database? _database;

  AppDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('notes.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    WidgetsFlutterBinding.ensureInitialized();
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    final idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    final textType = 'TEXT NOT NULL';
    final boolType = 'BOOLEAN NOT NULL';
    final integerType = 'INTEGER NOT NULL';

    await db.execute('''
CREATE TABLE $tableMedicineDetails ( 
  ${MediFields.id} $idType, 
  ${MediFields.name} $textType,
  ${MediFields.description} $textType,
  ${MediFields.quantity} $integerType,
  ${MediFields.image_path} $textType
  )
''');

    await db.execute('''
      CREATE TABLE $tablePrescriptions (
      ${PressFields.id} $idType,
      ${PressFields.time} $textType,
      ${PressFields.isAlarmOn} $boolType,
      ${PressFields.date} $textType,
      ${PressFields.numOfDays} $integerType
  )
''');


    await db.execute('''
      CREATE TABLE $tableMedicine (
      ${MedicineFields.id} $idType,
      ${MedicineFields.name} $textType,
      ${MedicineFields.quantity} $integerType,
      `prescription_id` INT NOT NULL
  )
''');


    await db.execute('''
      CREATE TABLE $tablePillTakeInfo (
      ${PillTakeInfoFields.id} $idType,
      ${PillTakeInfoFields.date} $textType,
      ${PillTakeInfoFields.time} $textType,
      `prescription_id` INT NOT NULL
  )
''');



  }

  Future<MediData> addMediData(MediData note) async {
    final db = await instance.database;

    final id = await db.insert(tableMedicineDetails, note.toJson());
    return note.copy(id: id);
  }

  Future<Prescription> addPrescription(Prescription prescription) async {
    final db = await instance.database;

    final id = await db.insert(tablePrescriptions, prescription.toJson());
    prescription = prescription.copy(id: id);

    //insert medicines into medicine table and populate prescription_medicine table
    var medicines = prescription.medicines;
    for(int i=0;i<medicines!.length;i++){
      prescription.medicines![i] = prescription.medicines![i].copy(prescription_id: prescription.id);
      final medi_id = await db.insert(tableMedicine,medicines[i].toJson());
      prescription.medicines![i].copy(id:medi_id);
    }
    return prescription;

  }

  Future<PillTakeInfo> addPillTakeInfo(PillTakeInfo info) async {
    final db = await instance.database;

    final id = await db.insert(tablePillTakeInfo, info.toJson());
    return info.copy(id: id);
  }

  Future<MediData> readMediData(int id) async {
    final db = await instance.database;

    final maps = await db.query(
      tableMedicineDetails,
      columns: MediFields.values,
      where: '${MediFields.id} = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return MediData.fromJson(maps.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

  Future<Prescription> readPrescription(int id) async {
    final db = await instance.database;

    final maps = await db.query(
      tablePrescriptions,
      columns: PressFields.values,
      where: '${PressFields.id} = ?',
      whereArgs: [id],
    );

    final result = await db.rawQuery(
        'SELECT * FROM $tableMedicine WHERE ${MedicineFields.prescription_id} = $id'
    );
    var medicineList = result.map((json) => Medicine.fromJson(json)).toList();



    if (maps.isNotEmpty) {

      var pres = Prescription.fromJson(maps.first);
      pres=pres.copy(medicines: medicineList);
      return pres;
    } else {
      throw Exception('ID $id not found');
    }
  }

  Future<List<MediData>> readAllMediData() async {
    final db = await instance.database;

    final orderBy = '${MediFields.name} ASC';
    // final result =
    //     await db.rawQuery('SELECT * FROM $tableNotes ORDER BY $orderBy');

    final result = await db.query(tableMedicineDetails, orderBy: orderBy);

    return result.map((json) => MediData.fromJson(json)).toList();
  }

  Future<List<Prescription>> readAllPrescriptions() async {
    final db = await instance.database;

    final orderBy = '${PressFields.id} ASC';
    final result =
    await db.rawQuery('SELECT * FROM $tablePrescriptions ORDER BY $orderBy');
    // print(result);

    //final result = await db.query(tableNotes);

    var prescriptionList = result.map((json) => Prescription.fromJson(json)).toList();

    for(int i=0;i<prescriptionList.length;i++){
      final result_two = await db.rawQuery('SELECT * FROM $tableMedicine WHERE ${MedicineFields.prescription_id} = ${prescriptionList[i].id}');
      var medicineList = result_two.map((json) => Medicine.fromJson(json)).toList();
      prescriptionList[i] = prescriptionList[i].copy(medicines: medicineList);

    }
    return prescriptionList;
  }

  Future<List<Medicine>> readAllMedicine() async {
    final db = await instance.database;

    final orderBy = '${MedicineFields.id} ASC';
    final result =
    await db.rawQuery('SELECT * FROM $tableMedicine ORDER BY $orderBy');
    //print(result);

    //final result = await db.query(tableNotes);

    return result.map((json) => Medicine.fromJson(json)).toList();
  }

  Future<List<PillTakeInfo>> readAllPillTakeInfo() async {
    final db = await instance.database;
    final result = await db.rawQuery('SELECT * FROM $tablePillTakeInfo');

    return result.map((json) => PillTakeInfo.fromJson(json)).toList();
  }



  Future<int> updateMediData(MediData note) async {
    final db = await instance.database;

    return db.update(
      tableMedicineDetails,
      note.toJson(),
      where: '${MediFields.id} = ?',
      whereArgs: [note.id],
    );
  }


  Future<int> updatePrescription(Prescription prescription) async {
    final db = await instance.database;

    return db.update(
      tablePrescriptions,
      prescription.toJson(),
      where: '${PressFields.id} = ?',
      whereArgs: [prescription.id],
    );
  }

  Future<int> deleteMediData(int id) async {
    final db = await instance.database;

    return await db.delete(
      tableMedicineDetails,
      where: '${MediFields.id} = ?',
      whereArgs: [id],
    );
  }

  Future<int> deletePrescription(int id) async {
    final db = await instance.database;

    await db.rawQuery(
        'DELETE FROM $tableMedicine WHERE ${MedicineFields.prescription_id} = $id'
    );
    return await db.delete(
      tablePrescriptions,
      where: '${PressFields.id} = ?',
      whereArgs: [id],
    );
  }




}
