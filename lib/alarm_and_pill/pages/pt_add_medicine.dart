import 'dart:io';
// import 'package:alarm_manager/db/medi_database.dart';
// import 'package:alarm_manager/services/MediData.dart';
// import 'package:alarm_manager/services/Medicine.dart';
import 'package:elcare_application/alarm_and_pill/db/medi_database.dart';
import 'package:elcare_application/alarm_and_pill/pages/pt_medicine_store.dart';
import 'package:elcare_application/alarm_and_pill/services/MediData.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';



class AddMedicine extends StatefulWidget {
  const AddMedicine({Key? key}) : super(key: key);

  @override
  _AddMedicineState createState() => _AddMedicineState();
}

class _AddMedicineState extends State<AddMedicine> {
  final _formKey = GlobalKey<FormBuilderState>();
// Medicine medicine = Medicine.noArg();
  File? image;
  late String _imagepath='';//here

  @override//here
 void initState() {
   super.initState();
   
   //loadImage();
   _imagepath = "";
  //  readFile();
   print(_imagepath);
 }


  Future pickImage(ImageSource source) async{
    try{
      final image =  await ImagePicker().pickImage(source: source);
      if(image== null) return;

      // final imageTemporary = File(image.path);
      // final imagePermanent = await saveImagePermanently(image.path);
      var imagePermanent = await saveImagePermanently(image.path);
      _imagepath= imagePermanent.path;
     // imagePermanent = File("");
      print('This ass ${imagePermanent.path}');
      setState(()=>this.image = imagePermanent);
    }
    on PlatformException catch(e){
      print('Failed to pick image: $e');
    }

  }

  Future<File> saveImagePermanently(String imagePath) async{
    final directory = await getApplicationDocumentsDirectory();
    final name = basename(imagePath);
    final image = File('${directory.path}/$name');

    return File(imagePath).copy(image.path);
  }


  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title:const Text('ADD NEW MEDICINE',
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

              constraints: BoxConstraints.expand(),
              decoration: BoxDecoration(
                color: Colors.black54,
                // gradient: LinearGradient(
                //     begin: Alignment.bottomCenter,
                //     end: Alignment.topCenter,
                //     colors: Colors.black54,
              ),

              child: SingleChildScrollView(
                child: Center(
                  child: FormBuilder(
                    key:_formKey,
                    child:Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,

                      children: [
                        const SizedBox(height: 30.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            _imagepath!=''
                            ?CircleAvatar(backgroundImage: FileImage(File(_imagepath)), radius: 40,) 
                            : CircleAvatar(
                              radius: 40,
                              backgroundImage:image!=null?Image.file(image!).image:AssetImage(
                                'assets/pill.png'
                              ),
                          ),
                            // CircleAvatar(
                            //   radius: 40,
                            //   backgroundImage:image!=null?Image.file(image!).image:AssetImage(
                            //       'assets/pill.png'
                            //   ),
                            // ),

                            RaisedButton.icon(
                              onPressed: (){
                                pickImage(ImageSource.gallery);
                                loadImage();
                              },
                              icon: Icon(Icons.upload, color: Colors.white,),
                              color: Colors.green.shade500,
                              elevation: 7.0,
                              label: const Text('Upload',
                                  style: TextStyle(
                                    color: Colors.white,
                                  )
                              ),
                            ),

                            RaisedButton.icon(
                              onPressed: (){
                                pickImage(ImageSource.camera);
                                loadImage();
                              },
                              icon: Icon(Icons.camera, color: Colors.white,),
                              color: Colors.green.shade500,
                              elevation: 7.0,
                              label:const Text('Camera',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),

                            ),
                          ],
                        ),

                        const SizedBox(height: 20.0),

                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            children: [

                              FormBuilderTextField(
                                name: 'medi_name_txt',
                                cursorColor: Colors.black,
                                style: const TextStyle(
                                    color: Colors.white
                                ),

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
                                    Icons.medical_services_outlined,
                                    color: Colors.green,
                                  ),
                                  labelText: "Medicine",
                                  hintText: "Enter Medicine",
                                  labelStyle: TextStyle(color: Colors.white),
                                  hintStyle: TextStyle(color: Colors.white),
                                ),
                              ),

                              const SizedBox(height: 15.0),

                              FormBuilderTextField(
                                maxLines: 5,
                                name: 'medi_description_txt',
                                style: const TextStyle(
                                    color: Colors.white
                                ),

                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.white,
                                      width: 2,
                                      
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.orange,
                                      width: 2,
                                    ),
                                  ),
                                  prefixIcon: Icon(
                                    Icons.description,
                                    color: Colors.green,
                                  ),
                                  labelText: "Description",
                                  hintText: "Enter Description",
                                  labelStyle: TextStyle(color: Colors.white),
                                  hintStyle: TextStyle(color: Colors.white),
                                ),
                              ),

                              const SizedBox(height: 15.0),

                              FormBuilderTextField(
                                name: 'medi_quantity_txt',
                                keyboardType: TextInputType.number,
                                style: const TextStyle(
                                    color: Colors.white
                                ),
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
                                  labelStyle: TextStyle(color: Colors.white),
                                  hintStyle: TextStyle(color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 15.0),

                        RaisedButton.icon(
                          onPressed: () async {
                            //get the input data
                            var name = _formKey.currentState!.fields['medi_name_txt']!.value;
                            var description = _formKey.currentState!.fields['medi_description_txt']!.value;
                            var quantity = _formKey.currentState!.fields['medi_quantity_txt']!.value;

                            print("athule $_imagepath");
                            final note = MediData(
                              name: name,
                              description: description,
                              quantity: int.parse(quantity),
                              image_path: _imagepath,//here
                            );

                            // Navigator.pushReplacementNamed(context,'/medicine',
                            //   arguments: {
                            //     'medicineName':name,
                            //     'medicineDescription':description,
                            //     'medicineQuantity':quantity,
                            //   },
                            // );

                           var medi = await AppDatabase.instance.addMediData(note);
                           print("added medicine ${medi.id}");

                           Get.off(PTMedicineStore());
                           saveImage(_imagepath);//here
                            _imagepath = '';
                          },
                          icon: const Icon(Icons.save, color: Colors.white,),
                          label:const Text('Save',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          color: Colors.green.shade500,
                          elevation: 7.0,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),

    );
  }

  void saveImage(path) async {//here
    SharedPreferences saveImage = await SharedPreferences.getInstance();
    saveImage.setString("imagepath", path);
  }

  void loadImage() async {//here
    SharedPreferences saveImage = await SharedPreferences.getInstance();
    setState(() {
      // if (_imagepath == null) {
      //   _imagepath = saveImage.getString("imagepath") ?? ''; 
        
      // }
      _imagepath =  saveImage.getString("imagepath")!; 
      
    });
   
  }


}