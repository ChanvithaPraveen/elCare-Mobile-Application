import 'package:elcare_application/alarm_and_pill/services/MedicalFirebase.dart';
import 'package:elcare_application/alarm_and_pill/services/Medicine.dart';
import 'package:elcare_application/alarm_and_pill/services/Prescription.dart';
import 'package:elcare_application/doctor_interface/classes/patient.dart';
import 'package:elcare_application/doctor_interface/screens/profile_sc.dart';
import 'package:elcare_application/doctor_interface/widgets/home/cards.dart';
import 'package:elcare_application/shared_pref/shared_pref_output.dart';
import 'package:elcare_application/user_profiles/regular_user_profile/User_Personal_Page/user_personal_details.dart';
import 'package:flutter/material.dart';

import 'dart:ui';

import 'package:flutter/material.dart';

import 'alarm_and_pill/services/PIllTakeInfo.dart';
import 'doctor_interface/screens/details_screen.dart';
// import 'package:doctor_interface/widgets/home/cards.dart';
//  import 'package:elcare_application/doctor_interfaces/';
// import 'package:doctor_interface/screens/pill_timer_info_sc.dart';
// import 'package:doctor_interface/screens/profile_sc.dart';
// import 'package:doctor_interface/screens/details_sc.dart';
// import 'package:doctor_interface/classes/medicine.dart';
// import 'package:doctor_interface/classes/patient_details.dart';
// import 'package:doctor_interface/classes/prescription.dart';





//medicine list

List<Medicine> Aone = [
  Medicine(name: "Clindamycin",quantity: 1,id: 1,prescription_id: 1),
  Medicine(name: "Cyclosporine",quantity: 2,id: 1,prescription_id: 1),
  Medicine(name: "Metphomin",quantity: 1,id: 1,prescription_id: 1),
   Medicine(name: "paracetamol",quantity: 3,id: 1,prescription_id: 1),
   Medicine(name: "Enarapril",quantity: 1,id: 1,prescription_id: 1),

];
List<Medicine> Atwo = [
  Medicine(name: "Clindamycin",quantity: 1,id: 1,prescription_id: 1),
  Medicine(name: "Cyclosporine",quantity: 2,id: 1,prescription_id: 1),
  Medicine(name: "Metphomin",quantity: 1,id: 1,prescription_id: 1),

];
List<Medicine> Athree = [
  Medicine(name: "Clindamycin",quantity: 1,id: 1,prescription_id: 1),
  Medicine(name: "Cyclosporine",quantity: 2,id: 1,prescription_id: 1),
  Medicine(name: "Metphomin",quantity: 1,id: 1,prescription_id: 1),
   Medicine(name: "paracetamol",quantity: 3,id: 1,prescription_id: 1),
   Medicine(name: "Enarapril",quantity: 1,id: 1,prescription_id: 1),

];
List<Medicine> Afour = [
  Medicine(name: "Clindamycin",quantity: 1,id: 1,prescription_id: 1),
  Medicine(name: "Cyclosporine",quantity: 2,id: 1,prescription_id: 1),
  Medicine(name: "Metphomin",quantity: 1,id: 1,prescription_id: 1),

];
List<Medicine> Afive = [
  Medicine(name: "Clindamycin",quantity: 1,id: 1,prescription_id: 1),
  Medicine(name: "Cyclosporine",quantity: 2,id: 1,prescription_id: 1),
  Medicine(name: "Metphomin",quantity: 1,id: 1,prescription_id: 1),
   Medicine(name: "paracetamol",quantity: 3,id: 1,prescription_id: 1),
 Medicine(name: "Enarapril",quantity: 1,id: 1,prescription_id: 1),
   

];

List<Medicine> B1 = [
  Medicine(name: "Amoxcilin",quantity: 1,id: 1,prescription_id: 1),
  Medicine(name: "Panadol",quantity: 2,id: 1,prescription_id: 1),
  Medicine(name: "Vitamin C",quantity: 3,id: 1,prescription_id: 1),


];

List<Medicine> B2 = [

  Medicine(name: "Panadol",quantity: 2,id: 1,prescription_id: 1),
  Medicine(name: "Vitamin C",quantity: 3,id: 1,prescription_id: 1),
  Medicine(name: "Enarapril",quantity: 2,id: 1,prescription_id: 1),
   Medicine(name: "Metphomin",quantity: 2,id: 1,prescription_id: 1),

];

List<Medicine> B3 = [
  Medicine(name: "Amoxcilin",quantity: 1,id: 1,prescription_id: 1),
  Medicine(name: "Panadol",quantity: 2,id: 1,prescription_id: 1),
  Medicine(name: "Vitamin C",quantity: 3,id: 1,prescription_id: 1),
   Medicine(name: "Enarapril",quantity: 2,id: 1,prescription_id: 1),
   Medicine(name: "Metphomin",quantity: 2,id: 1,prescription_id: 1),


];

List<Medicine> B4 = [

  Medicine(name: "Panadol",quantity: 2,id: 1,prescription_id: 1),
  Medicine(name: "Vitamin C",quantity: 3,id: 1,prescription_id: 1),
   Medicine(name: "Enarapril",quantity: 2,id: 1,prescription_id: 1),
   Medicine(name: "Metphomin",quantity: 2,id: 1,prescription_id: 1),


];


//prescription list
// List<PillTakeInfo> presList = [
//  // PillTakeInfo(id: 1 ,date: '2020', time: '4.00a.m', prescription_id: 1)

// ];

/*
// used to fill data through firebase                     ///////////////////

//add medicines to medList
void fill_pillTimer_Medicine(String medName, double medQun) {
  Medicine obj = Medicine(medName, medQun);
  medList.add(obj);
}
*/
//add presciptions to presList

List<PillTakeInfo> presList = [
  // PillTakeInfo(date: '2021/12/01', time: '7.00a.m', prescription_id: 1, medicines: Aone),
  // PillTakeInfo(date: '2021/12/02', time: '5.00p.m', prescription_id: 1, medicines: Atwo),
  // PillTakeInfo(date: '2021/12/03', time: '7.00a.m', prescription_id: 1, medicines: Athree),
  // PillTakeInfo(date: '2021/12/04', time: '5.00p.m', prescription_id: 1, medicines: Afour),
  // PillTakeInfo(date: '2021/12/05', time: '7.00a.m', prescription_id: 1, medicines: Afive),
] ;

// List<PillTakeInfo> hello = [];
// PillTakeInfo inf1 = PillTakeInfo(date: "11/3",id: 3)
List<PillTakeInfo> presListOneOne = [
  PillTakeInfo(date: '2021/12/01', time: '7.30a.m', prescription_id: 1, medicines: B1),
  PillTakeInfo(date: '2021/12/02', time: '2.00p.m', prescription_id: 1, medicines: B2),
  PillTakeInfo(date: '2021/12/02', time: '2.00p.m', prescription_id: 1, medicines: B3),
  PillTakeInfo(date: '2021/12/02', time: '2.00p.m', prescription_id: 1, medicines: B4),
] ;

void fill_pillTimer_Prescriptions() async
{
  //String email =  await getString("email");
  print("fill pill timer athule");
   presList =   await MedicalFirebase.getMedicalInfoFromFirebase('amalpereraa@gmail.com');
    print("await palleha");
    print("lengee is ${presList.length}");
    for(int i=0; i<presList.length;i++){
      print(presList[i].date);
    }
 // Prescription obj = Prescription(date, medList, time);
  //presList.add(obj);
}

int patientIndex = 0;
List<PatientDetails> patient = [
  
   PatientDetails(
    name:'Rusiru Gunarathne', 
    email:'rus@gmail.comn', 
    prescriptionsList: presListOneOne),
  PatientDetails(
    name:'Nilupa Illangarathne', 
    email:'nilupa@gmail.com', 
    prescriptionsList: presList),
  PatientDetails(
    name:'Nishalya Pethiyagoda', 
    email:'peth@gmail.comn', 
    prescriptionsList: presList),
  PatientDetails(
    name:'Chanvitha Praveen', 
    email:'chanvitha@hotmail.com', 
    prescriptionsList: presList),

 // PatientDetails('nilupa illangarathne', 'nilipa@gmail.comn', presList),
];

// PatientDetails a =  PatientDetails('nishalya pethiyagoda', 'peth@gmail.comn', presList);
// print(a.name);





int count = 1;

//Home class
class DoctorMenu extends StatefulWidget {
  @override
  _DoctorMenuState createState() => _DoctorMenuState();
}

class _DoctorMenuState extends State<DoctorMenu> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();

// void settingState ()
// {
//   fill_pillTimer_Prescriptions();
//   setState(() {
   
//   });
// }

@override
  void initState() {
    // TODO: implement initState
    super.initState();
    fill_pillTimer_Prescriptions();
  }


// @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     setState(() {
//       // fill_pillTimer_Prescriptions();
//     });
//   }


//add people and details to patients
void fill_patient_details(String name, String email) {
  
  PatientDetails obj = PatientDetails(
    name:name,
    email: email,
    prescriptionsList: presList);

 setState(() {
   
    patient.add(obj); 
 });                           //
  setState(() {
    
  });
}


  @override
  Widget build(BuildContext context) {
    fill_pillTimer_Prescriptions();

   // print(patient[0].prescriptionsList!.length);

    return Scaffold(
        backgroundColor: Colors.transparent,
        
        appBar: AppBar(
          toolbarHeight: 50,
          centerTitle: true,
          elevation: 0.0,
          backgroundColor: Colors.blue[900],
          title: const Text(
            'Home',
            style: TextStyle(fontSize: 23, color: Colors.white),
          ),
         
        ),
        floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add your onPressed code here!
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => ProfilePage()));
        },
        child: const Icon(Icons.person),
        backgroundColor: Colors.blue[600],
      ),
        body: SafeArea(
          child: Container(
            padding: const EdgeInsets.all(18.0),
            decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/fonts/images/regular_user_back.jpg"),
                fit: BoxFit.cover),
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0xff232526), Color(0xff414345)]),
          ),
           child: ListView.builder(
                itemCount: patient.length,
                itemBuilder: (context, index) {
                  if (index + 1 >= patient.length  ) {
                    count = count+1;
                    return Container(
                      margin: EdgeInsets.all(5),
                        height: 159,
                        padding: const EdgeInsets.all(18.0),
                        decoration: BoxDecoration(
                          color: Colors.black54,
                          borderRadius: BorderRadius.all(Radius.circular(5.0)),
                        ),
                        child: Column(children: [
                          const SizedBox(
                            width: 8.0,
                          ),
                          
                          
                          TextField(
                            controller: _emailController,
                            //
                            style: const TextStyle(color: Colors.white),
                            decoration: const InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.orange,
                                        width: 2,
                                      ),
                                    ),
                              labelText: "Email ",
                              labelStyle: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.white
                              ),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(16.0),
                                  ),
                                  borderSide: BorderSide()),
                            ),
                            keyboardType: TextInputType.emailAddress,
                            
                          ),
                          const SizedBox(
                            height: 14.0,
                          ),
                          TextButton(
                            child: const Text(
                                'Add Patient',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                ),
                              ),
                              style: TextButton.styleFrom(
                                primary: Colors.white,
                                backgroundColor: Colors.teal[400],
                              ),
                              /////////  onpresssed        ////////////////////////////////////////
                            onPressed: () {
                              //  bool findEmail = _emailController;
        
                            if (1 < 3) {
                              
        
               setState(() {
           fill_patient_details('sudharaka fernando',_emailController.text);
        
               });
        
        setState(() {
          
        });
        
        
          int i = 0, j = 0, numberOfMedicines = 0, numberOfPrescriptions = 0;
          String medName = '', date = '', time = '';
          double medQun = 0;
        /*
          while (i < numberOfPrescriptions) {
            while (j < numberOfMedicines) {
              fill_pillTimer_Medicine(medName, medQun); //filled to 'medList'
              j++;
            }
            fill_pillTimer_Prescriptions(date, medList, time);    //filled to 'presList'
            setState(() {
            });
            medList.clear();
            i++;
          }
          setState(() {
            });
          presList.clear();
        
          fill_patient_details(_nameController.toString(),_emailController.toString());
            */
                            } else {
                              print('error in adding patient');
                            }
setState(() {
_emailController.text = "";  
});


                            },
                              ),
                              
                        ]));
                    
                  } else {
                    count = count+1;
                    return CardsClass(
        
                        eachPatient: patient[index],
                        //  eachPerson: allDetails[index],
                        view: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PatientDetailsScreen(
                                    eachPatient: patient[index]),
                                //            eachPerson: allDetails[index],
                              ));
                        });
                  }
                }),
           //         ],
            
            ),
        ),);
  }
}
