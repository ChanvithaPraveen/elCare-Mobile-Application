// import 'package:alarm_manager/services/Prescription.dart';

final String tableMedicine = 'Medicine';

class MedicineFields{
  static final List<String> values = [
    /// Add all fields
    id, name, quantity, prescription_id
  ];

  static final String id = '_id';
  static final String name = 'name';
  static final String quantity = 'quantity';
  static final String prescription_id = 'prescription_id';


}


class Medicine{
  final int? id;
  final String name;
  // late String description;
  final int quantity;
  final int? prescription_id;
  // late String image;//url for medicine image

  //Medicine.noArg();
  // Medicine.twoArg({required this.name,required this.quantity});
  // Medicine({required this.name,required this.description,required this.quantity});

  const Medicine({
    this.id,
    required this.name,
    required this.quantity,
    this.prescription_id,

  });

  Medicine copy({
    int? id,
    String? name,
    int? quantity,
    int? prescription_id
  }) =>
      Medicine(
          id: id ?? this.id,
          name: name ?? this.name,
          quantity: quantity ?? this.quantity,
          prescription_id:prescription_id??this.prescription_id
      );

  static Medicine fromJson(Map<String, Object?> json) => Medicine(
    id: json[MedicineFields.id] as int?,
    name: json[MedicineFields.name] as String,
    quantity: json[MedicineFields.quantity] as int,
    prescription_id: json[MedicineFields.prescription_id] as int,
  );

  Map<String, Object?> toJson() => {
    MedicineFields.id: id,
    MedicineFields.name: name,
    MedicineFields.quantity: quantity,
    MedicineFields.prescription_id: prescription_id
  };






}