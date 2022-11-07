
// import 'package:alarm_manager/services/Medicine.dart';
import 'package:elcare_application/alarm_and_pill/services/Medicine.dart';

final String tablePillTakeInfo = 'Pill_take_info';

class PillTakeInfoFields{
  static final List<String> values = [
    /// Add all fields
    id, date, time, prescription_id
  ];

  static final String id = '_id';
  static final String date = 'date';
  static final String time = 'time';
  static final String prescription_id = 'prescription_id';


}


class PillTakeInfo{
  final int? id;
  final String date;
  // late String description;
  final String time;
  final int prescription_id;
  final List<Medicine>? medicines;

  const PillTakeInfo({
    this.id,
    required this.date,
    required this.time,
    required this.prescription_id,
    this.medicines,

  });

  PillTakeInfo copy({
    int? id,
    String? date,
    String? time,
    int? prescription_id,
    List<Medicine>? medicines,
  }) =>
      PillTakeInfo(
          id: id ?? this.id,
          date: date ?? this.date,
          time: time ?? this.time,
          prescription_id:prescription_id?? this.prescription_id,
          medicines: medicines ?? this.medicines,
      );

  static PillTakeInfo fromJson(Map<String, Object?> json) => PillTakeInfo(
    id: json[PillTakeInfoFields.id] as int,
    date: json[PillTakeInfoFields.date] as String,
    time: json[PillTakeInfoFields.time] as String,
    prescription_id: json[PillTakeInfoFields.prescription_id] as int,
  );

  Map<String, Object?> toJson() => {
    PillTakeInfoFields.id: id,
    PillTakeInfoFields.date: date,
    PillTakeInfoFields.time: time,
    PillTakeInfoFields.prescription_id: prescription_id
  };






}