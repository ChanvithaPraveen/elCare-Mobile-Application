// import 'package:alarm_manager/db/medi_database.dart';
// import 'package:alarm_manager/services/MediData.dart';
// import 'package:alarm_manager/services/Medicine.dart';
// import 'package:alarm_manager/services/Prescription.dart';

import 'dart:io';

import 'package:elcare_application/alarm_and_pill/db/medi_database.dart';
import 'package:elcare_application/alarm_and_pill/services/MediData.dart';
import 'package:elcare_application/alarm_and_pill/services/Prescription.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';



class PTMedicineStore extends StatefulWidget {
  const PTMedicineStore({Key? key}) : super(key: key);

  @override
  _PTMedicineStoreState createState() => _PTMedicineStoreState();
}

class _PTMedicineStoreState extends State<PTMedicineStore> {

  // Map data = {};
  late List<MediData> medicines = [];
  late List<Prescription> prescriptions = [];
  late List<int> mediCount = [];
  bool isLoading = false;
  late String newQuantity;

  // List<Medicine> medicineList = [
  //   Medicine(name: 'Amoxicillin',description: 'Treat bacteria infections',quantity: 50),
  //   Medicine(name: 'Actos',description: 'Control blood sugar level',quantity: 20),
  //   Medicine(name: 'Vitamin C',description: 'Good for Immunity',quantity: 40),
  // ];

  Future refreshMediData() async {
    setState(() => isLoading = true);
    WidgetsFlutterBinding.ensureInitialized();
    this.medicines = await AppDatabase.instance.readAllMediData();
    if(this.medicines.length==0){
      var med = MediData(name: "Penadol", description: "Penadol", quantity: 0, image_path: '');//here
      await AppDatabase.instance.addMediData(med);
      this.medicines = await AppDatabase.instance.readAllMediData();
    }
    this.prescriptions = await AppDatabase.instance.readAllPrescriptions();
    //print(prescriptions.length);

    setState(() => isLoading = false);
  }

  @override
  void initState() {
    super.initState();
    refreshMediData();

  }

  // void getMedicineCount(){

  //   for(int i=0; i<medicines.length; i++){
  //     var name=medicines[i].name;
  //     int medi_count =0;

  //     for(int j=0; j<prescriptions.length; j++){
  //       medi_count+= prescriptions[j].getMedicineQuantity(name);
  //     }
  //   mediCount.add(medi_count);
  //   }
  //   print(prescriptions.length);
  // }

  int getRemainingDays(MediData medi, List<Prescription> prescriptions){

    int medi_count = 0;
    for(int j=0; j<prescriptions.length; j++){
      medi_count+= prescriptions[j].getMedicineQuantity(medi.name);
    }
    // print(medi.name);
    // print(prescriptions.length);
    int days;
    if(medi_count > 0)
    {
      days = (medi.quantity/medi_count).toInt();
      return days;
    }
    else
      return -1;

  }

  // Future refreshPrescription() async {
  //   setState(() => isLoading = true);
  //   WidgetsFlutterBinding.ensureInitialized();
  //   this.prescriptions = await AppDatabase.instance.readAllPrescriptions();

  //   setState(() => isLoading = false);
  // }

  // @override
  // void dispose() {
  //   NotesDatabase.instance.close();
  //
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    // var temp = ModalRoute.of(context)!.settings.arguments;
    // if(temp!=null){
    //   data = temp as Map;
    //   medicineList.add(Medicine(
    //       name:data['medicineName'],
    //       description: data['medicineDescription'],
    //       quantity: int.parse(data['medicineQuantity'])
    //   )
    //   );
    // }
    return Scaffold(

      appBar: AppBar(
        title:const Text('MEDICINE STORE',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
            )),
        centerTitle: true,
        backgroundColor: Colors.blue[900],
      ),

      backgroundColor: Colors.grey[850],

      body: SafeArea(
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/fonts/images/regular_user_back.jpg"),
                fit: BoxFit.cover),
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0xff232526), Color(0xff414345)]),
          ),
          child: Padding(
            padding: const EdgeInsets.all(15.0),

            child: Container(

              constraints: const BoxConstraints.expand(),
              decoration: BoxDecoration(
                  color: Colors.black54,
                  // gradient: LinearGradient(
                  //     begin: Alignment.bottomCenter,
                  //     end: Alignment.topCenter,
                  //     colors: Colors.black54,
                ),

              child: ListView.builder(                //prescription listview
                padding: const EdgeInsets.all(8),
                itemCount: medicines.length,
                itemBuilder: (BuildContext context, int index) {
                  for(int i = 0; i< medicines.length; i++){
                    print("Image path : " + medicines[i].image_path);
                  }

                  int num_of_days = getRemainingDays(medicines[index], prescriptions);
                  String advice = '';
                  if(num_of_days>=0){
                    advice = "This will be enough for ${num_of_days} days";
                  }
                  else{
                    advice = "No prescriptions from this medicine";
                  }



                  Widget _buildPopupDialog(BuildContext context, index) {

                    return AlertDialog(
                      title: const Text('Add New Stock Quantity'),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,

                        children: <Widget>[
                          FormBuilderTextField(
                            name: 'medi_name_txt',          //need to add database
                            keyboardType: TextInputType.number,
                            cursorColor: Colors.black,
                            style: const TextStyle(
                                color: Colors.black
                            ),

                            onChanged: (newText) {
                              newQuantity = newText!;
                              print('Hello');

                            },

                            decoration: const InputDecoration(
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.green,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.orange,
                                  width: 2,
                                ),
                              ),
                              prefixIcon: Icon(
                                Icons.production_quantity_limits,
                                color: Colors.green,
                              ),
                              labelText: "Quantity",
                              hintText: "Enter Quantity",
                              labelStyle: TextStyle(color: Colors.black),
                              hintStyle: TextStyle(color: Colors.black),
                            ),
                          ),
                        ],
                      ),

                      actions: <Widget>[
                        RaisedButton.icon(
                          onPressed: () async {
                            Navigator.of(context).pop();
                            int newQuantityPrint = int.parse(newQuantity);
                            var quantity = medicines[index].quantity+newQuantityPrint;
                            medicines[index]= medicines[index].copy(quantity:quantity);
                            await AppDatabase.instance.updateMediData(medicines[index]);
                            setState(() {

                            });
                            // print(newQuantityPrint);
                          },
                          textColor: Theme.of(context).primaryColor,
                          icon: const Icon(Icons.save, color: Colors.white,),
                          label:const Text('Save',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          color: Colors.green.shade900,
                          elevation: 7.0,
                        ),
                      ],
                    );
                  }

                  return Container(
                    height: 150,
                    margin: const EdgeInsets.all(8),
                    color: medicines[index]==1? Colors.green.shade800: Colors.green.shade800,

                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          //const SizedBox(height: 10.0),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [

                              RaisedButton.icon(
                                color: Colors.black,
                                elevation: 7.0,
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) => _buildPopupDialog(context, index),
                                  );
                                },
                                icon: const Icon(Icons.add, color: Colors.white,),
                                label: const Text('Qty', style: TextStyle(color: Colors.white),),
                                //color: Colors.purple,
                              ),

                              Container(
                                alignment: Alignment.topLeft,
                                child: Padding(
                                  padding: EdgeInsets.all(10.0),

                                  child: Text(
                                    medicines[index].name,
                                    style: const TextStyle(
                                      fontSize: 17.0,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: Colors.grey[850],
                                ),
                              ),

                              const SizedBox(width: 10.0),

                              // CircleAvatar(
                              //   radius: 33,
                              //   backgroundImage: FileImage(File(medicines[index].image_path)),
                                
                              // ),
                              medicines[index].image_path!=''
                            ?CircleAvatar(backgroundImage: FileImage(File(medicines[index].image_path)), radius: 33,) 
                            : CircleAvatar(
                              radius: 33,
                              backgroundImage:AssetImage(
                                'assets/pill.png'
                              ),
                          )


                            ],
                          ),

                          Container(
                            alignment: Alignment.topLeft,
                            child: Padding(
                              padding: EdgeInsets.all(2.0),
                              child: Text(
                                "${medicines[index].quantity} pills available in the store",
                                style: const TextStyle(
                                  fontSize: 15.0,
                                  color: Colors.white,
                                ),
                              ),
                            ),

                          ),

                          const SizedBox(height: 5.0),

                          Container(
                            alignment: Alignment.topLeft,
                            child: Padding(
                              padding: EdgeInsets.all(2.0),
                              child: Text(
                                "$advice",
                                style: TextStyle(
                                  fontSize: 15.0,
                                  color: Colors.white,
                                ),
                              ),
                            ),

                          ),

                        ],
                      ),
                    ),
                  );


                },
              ),
            ),
          ),
        ),
      ),
    );


    // return Scaffold(
    //   appBar: AppBar(
    //     title: Text('Medicine Store'),
    //   ),
    //   body: ListView.builder(
    //         itemCount: medicines.length,
    //         itemBuilder: (context,index){
    //           return Card(
    //             // child: ListTile(
    //             //   onTap: (){},
    //             //   title:Text('${medicineList[index].name}         quantity: ${medicineList[index].quantity}' ),
    //             //   subtitle:Text(medicineList[index].description),
    //             //
    //             //
    //             //
    //             // ),
    //             child:Column(
    //               children: <Widget>[
    //                 Text(medicines[index].name),
    //                 Text(medicines[index].description),
    //                 Text('Available quantity: ${medicines[index].quantity}'),
    //               ],
    //             ),
    //           );
    //         }
    //       ),
    //
    //
    //
    //
    //
    //   );




  }
}

