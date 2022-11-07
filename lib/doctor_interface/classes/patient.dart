// import 'package:doctor_interface/classes/prescription.dart';
import 'package:elcare_application/alarm_and_pill/services/PIllTakeInfo.dart';
import 'package:elcare_application/alarm_and_pill/services/Prescription.dart';

// class PatientDetails {
//   String name ;
//   String email ;
//   List<PillTakeInfo> presciptionsList;

//   PatientDetails(
//     this.name,
//     this.email,
//     this.presciptionsList,
//   );
// }

class PatientDetails{
  final String  name;
  final String email;
  final List<PillTakeInfo>? prescriptionsList;

  const PatientDetails({
    required this.name,
    required this.email,
    required this.prescriptionsList,
    

  });

  PatientDetails copy({
    String? name,
    String? email,
    List<PillTakeInfo>? prescriptionList,
    
  }) =>
       PatientDetails(
         name: name??this.name,
         email:email??this.email,
         prescriptionsList: prescriptionsList??this.prescriptionsList,
  
      );
}