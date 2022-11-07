import 'Medicine.dart';


final String tablePrescriptions = 'Prescription';

class PressFields{
  static final List<String> values = [
    /// Add all fields
    id, time, isAlarmOn,date,numOfDays,
  ];

  static final String id = '_id';
  static final String time = 'time';
  static final String isAlarmOn = 'alarm_status';
  static final String date = 'date';
  static final String numOfDays = 'num_days';


}

class Prescription {
  final int? id;
  final String time;
  final bool isAlarmOn;
  final List<Medicine>? medicines;
  final String date;
  final int numOfDays;



  const Prescription({
    this.id,
    required this.time,
    required this.isAlarmOn,
    required this.date,
    required this.numOfDays,
    this.medicines,


  });

  Prescription copy({
    int? id,
    String? time,
    bool? isAlarmOn,
    List<Medicine> ? medicines,
  }) =>
      Prescription(
        id: id ?? this.id,
        time: time ?? this.time,
        isAlarmOn: isAlarmOn ?? this.isAlarmOn,
        medicines: medicines ?? this.medicines,
        date:   this.date,
        numOfDays: this.numOfDays,
      );

  static Prescription fromJson(Map<String, Object?> json) => Prescription(
    id: json[PressFields.id] as int?,
    time: json[PressFields.time] as String,
    isAlarmOn: json[PressFields.isAlarmOn] == 1,
    date: json[PressFields.date] as String,
    numOfDays: json[PressFields.numOfDays] as int,
  );

  Map<String, Object?> toJson() => {
    PressFields.id: id,
    PressFields.time: time,
    PressFields.isAlarmOn: isAlarmOn?1:0,
    PressFields.date:date,
    PressFields.numOfDays:numOfDays
  };

  @override
  String toString() {
    return 'Prescription{id: $id, time: $time, isAlarmOn: $isAlarmOn, medicines: $medicines}';
  }

  int getMedicineQuantity(String medicineName){
    int mediCount = 0;
    for(int i=0;i<medicines!.length;i++){
      if(medicines![i].name == medicineName){
        mediCount+=medicines![i].quantity;
      }
    }
    return mediCount;
  }

}


