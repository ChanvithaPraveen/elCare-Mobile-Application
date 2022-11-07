@startuml
set namespaceSeparator ::

class "elcare_application::alarm_and_pill::Alarm::alarm_page.dart::AlarmPage" {
  +_AlarmPageState createState()
}

"flutter::src::widgets::framework.dart::StatefulWidget" <|-- "elcare_application::alarm_and_pill::Alarm::alarm_page.dart::AlarmPage"

class "elcare_application::alarm_and_pill::Alarm::alarm_page.dart::_AlarmPageState" {
  +void initState()
  +void listenNotifications()
  +void onClickNotification()
  +Widget build()
}

"flutter::src::widgets::framework.dart::State" <|-- "elcare_application::alarm_and_pill::Alarm::alarm_page.dart::_AlarmPageState"

class "elcare_application::alarm_and_pill::Alarm::delete_alert.dart::Delete_alert" {
  +_Delete_alertState createState()
}

"flutter::src::widgets::framework.dart::StatefulWidget" <|-- "elcare_application::alarm_and_pill::Alarm::delete_alert.dart::Delete_alert"

class "elcare_application::alarm_and_pill::Alarm::delete_alert.dart::_Delete_alertState" {
  +Widget build()
}

"flutter::src::widgets::framework.dart::State" <|-- "elcare_application::alarm_and_pill::Alarm::delete_alert.dart::_Delete_alertState"

class "elcare_application::alarm_and_pill::Alarm::edit_alarm.dart::EditAlarm" {
  +_EditAlarmState createState()
}

"flutter::src::widgets::framework.dart::StatefulWidget" <|-- "elcare_application::alarm_and_pill::Alarm::edit_alarm.dart::EditAlarm"

class "elcare_application::alarm_and_pill::Alarm::edit_alarm.dart::_EditAlarmState" {
  -TextEditingController _textEditingController
  +Widget build()
}

"elcare_application::alarm_and_pill::Alarm::edit_alarm.dart::_EditAlarmState" o-- "flutter::src::widgets::editable_text.dart::TextEditingController"
"flutter::src::widgets::framework.dart::State" <|-- "elcare_application::alarm_and_pill::Alarm::edit_alarm.dart::_EditAlarmState"

class "elcare_application::alarm_and_pill::Alarm_Data::alarm_info.dart::AlarmInfo" {
  +TimeOfDay alarmDateTime
  +DateTime date
  +int PrescriptionID
  +String alarmTimeToDisplay
  +String description
  +bool isActive
  +List<bool> ActiveWeekdays
  +bool VibrateON
  +int AlarmNumber
  +List<Color> WeekdayButtonColor
  +bool PilltimeOrDaily
}

"elcare_application::alarm_and_pill::Alarm_Data::alarm_info.dart::AlarmInfo" o-- "flutter::src::material::time.dart::TimeOfDay"

class "elcare_application::alarm_and_pill::db::medi_database.dart::AppDatabase" {
  {static} +AppDatabase instance
  {static} -Database? _database
  +Future<Database> database
  -Future<Database> _initDB()
  -Future<dynamic> _createDB()
  +Future<MediData> addMediData()
  +Future<Prescription> addPrescription()
  +Future<PillTakeInfo> addPillTakeInfo()
  +Future<MediData> readMediData()
  +Future<Prescription> readPrescription()
  +Future<List<MediData>> readAllMediData()
  +Future<List<Prescription>> readAllPrescriptions()
  +Future<List<Medicine>> readAllMedicine()
  +Future<List<PillTakeInfo>> readAllPillTakeInfo()
  +Future<int> updateMediData()
  +Future<int> updatePrescription()
  +Future<int> deleteMediData()
  +Future<int> deletePrescription()
}

"elcare_application::alarm_and_pill::db::medi_database.dart::AppDatabase" o-- "elcare_application::alarm_and_pill::db::medi_database.dart::AppDatabase"
"elcare_application::alarm_and_pill::db::medi_database.dart::AppDatabase" o-- "sqflite_common::sqlite_api.dart::Database"

class "elcare_application::alarm_and_pill::Local_Notification::local_notification.dart::NotificationApi" {
  {static} -FlutterLocalNotificationsPlugin* _notification
  {static} +BehaviorSubject<String*>* onNotifications
  {static} -Future<dynamic>* _notificationDetails()
  {static} +Future<dynamic>* init()
  {static} +Future<dynamic>* showNotification()
}

"elcare_application::alarm_and_pill::Local_Notification::local_notification.dart::NotificationApi" o-- "flutter_local_notifications::src::flutter_local_notifications_plugin.dart::FlutterLocalNotificationsPlugin"
"elcare_application::alarm_and_pill::Local_Notification::local_notification.dart::NotificationApi" o-- "rxdart::src::subjects::behavior_subject.dart::BehaviorSubject<String>"

class "elcare_application::alarm_and_pill::Local_Notification::medicine_took_yes_no.dart::Confirmation_MSG" {
  +_Confirmation_MSGState createState()
}

"flutter::src::widgets::framework.dart::StatefulWidget" <|-- "elcare_application::alarm_and_pill::Local_Notification::medicine_took_yes_no.dart::Confirmation_MSG"

class "elcare_application::alarm_and_pill::Local_Notification::medicine_took_yes_no.dart::_Confirmation_MSGState" {
  +Widget build()
}

"flutter::src::widgets::framework.dart::State" <|-- "elcare_application::alarm_and_pill::Local_Notification::medicine_took_yes_no.dart::_Confirmation_MSGState"

class "elcare_application::alarm_and_pill::pages::pthome.dart::PTHome" {
  +_PTHomeState createState()
}

"flutter::src::widgets::framework.dart::StatefulWidget" <|-- "elcare_application::alarm_and_pill::pages::pthome.dart::PTHome"

class "elcare_application::alarm_and_pill::pages::pthome.dart::_PTHomeState" {
  +void initState()
  +void listenNotifications()
  +void onClickNotification()
  +Widget build()
}

"flutter::src::widgets::framework.dart::State" <|-- "elcare_application::alarm_and_pill::pages::pthome.dart::_PTHomeState"

class "elcare_application::alarm_and_pill::pages::pt_add_medicine.dart::AddMedicine" {
  +_AddMedicineState createState()
}

"flutter::src::widgets::framework.dart::StatefulWidget" <|-- "elcare_application::alarm_and_pill::pages::pt_add_medicine.dart::AddMedicine"

class "elcare_application::alarm_and_pill::pages::pt_add_medicine.dart::_AddMedicineState" {
  -GlobalKey<FormBuilderState> _formKey
  +File? image
  -String _imagepath
  +void initState()
  +Future<dynamic> pickImage()
  +Future<File> saveImagePermanently()
  +Widget build()
  +void saveImage()
  +void loadImage()
}

"elcare_application::alarm_and_pill::pages::pt_add_medicine.dart::_AddMedicineState" o-- "flutter::src::widgets::framework.dart::GlobalKey<FormBuilderState>"
"elcare_application::alarm_and_pill::pages::pt_add_medicine.dart::_AddMedicineState" o-- "dart::io::File"
"flutter::src::widgets::framework.dart::State" <|-- "elcare_application::alarm_and_pill::pages::pt_add_medicine.dart::_AddMedicineState"

class "elcare_application::alarm_and_pill::pages::pt_handle_prescription.dart::HandlePrescription" {
  +_HandlePrescriptionState createState()
}

"flutter::src::widgets::framework.dart::StatefulWidget" <|-- "elcare_application::alarm_and_pill::pages::pt_handle_prescription.dart::HandlePrescription"

class "elcare_application::alarm_and_pill::pages::pt_handle_prescription.dart::_HandlePrescriptionState" {
  +bool status
  +List<String> items_list
  +String item
  +String newDays
  +List<MediData> medicines
  +List<int> quantity_list
  +int quantity
  +List<String> add_item
  +List<int> add_quantity
  +bool isLoading
  +TextEditingController nameController
  -TimeOfDay _time
  +dynamic mainAxisAlignment
  +void initState()
  +Future<dynamic> refreshMediData()
  +void setupItemsList()
  +void addItemToList()
  -void _selectTime()
  +Widget build()
}

"elcare_application::alarm_and_pill::pages::pt_handle_prescription.dart::_HandlePrescriptionState" o-- "flutter::src::widgets::editable_text.dart::TextEditingController"
"elcare_application::alarm_and_pill::pages::pt_handle_prescription.dart::_HandlePrescriptionState" o-- "flutter::src::material::time.dart::TimeOfDay"
"flutter::src::widgets::framework.dart::State" <|-- "elcare_application::alarm_and_pill::pages::pt_handle_prescription.dart::_HandlePrescriptionState"

class "elcare_application::alarm_and_pill::pages::pt_medicine_store.dart::PTMedicineStore" {
  +_PTMedicineStoreState createState()
}

"flutter::src::widgets::framework.dart::StatefulWidget" <|-- "elcare_application::alarm_and_pill::pages::pt_medicine_store.dart::PTMedicineStore"

class "elcare_application::alarm_and_pill::pages::pt_medicine_store.dart::_PTMedicineStoreState" {
  +List<MediData> medicines
  +List<Prescription> prescriptions
  +List<int> mediCount
  +bool isLoading
  +String newQuantity
  +Future<dynamic> refreshMediData()
  +void initState()
  +int getRemainingDays()
  +Widget build()
}

"flutter::src::widgets::framework.dart::State" <|-- "elcare_application::alarm_and_pill::pages::pt_medicine_store.dart::_PTMedicineStoreState"

class "elcare_application::alarm_and_pill::pages::pt_view_prescription.dart::ViewPrescriptions" {
  +_ViewPrescriptionsState createState()
}

"flutter::src::widgets::framework.dart::StatefulWidget" <|-- "elcare_application::alarm_and_pill::pages::pt_view_prescription.dart::ViewPrescriptions"

class "elcare_application::alarm_and_pill::pages::pt_view_prescription.dart::_ViewPrescriptionsState" {
  +List<Prescription> prescriptions
  +bool status
  +bool isLoading
  +void initState()
  +Future<dynamic> refreshPrescription()
  +Widget build()
}

"flutter::src::widgets::framework.dart::State" <|-- "elcare_application::alarm_and_pill::pages::pt_view_prescription.dart::_ViewPrescriptionsState"

class "elcare_application::alarm_and_pill::services::MedicalFirebase.dart::MedicalFirebase" {
  {static} +List<Prescription> prList
  {static} +dynamic addMedicalDataToFirebase()
  {static} +Future<List<PillTakeInfo>> getMedicalInfoFromFirebase()
}

class "elcare_application::alarm_and_pill::services::Medicine.dart::MedicineFields" {
  {static} +List<String> values
  {static} +String id
  {static} +String name
  {static} +String quantity
  {static} +String prescription_id
}

class "elcare_application::alarm_and_pill::services::Medicine.dart::Medicine" {
  +int? id
  +String name
  +int quantity
  +int? prescription_id
  +Medicine copy()
  {static} +Medicine fromJson()
  +Map<String, Object?> toJson()
}

class "elcare_application::alarm_and_pill::services::MediData.dart::MediFields" {
  {static} +List<String> values
  {static} +String id
  {static} +String name
  {static} +String description
  {static} +String quantity
  {static} +String image_path
}

class "elcare_application::alarm_and_pill::services::MediData.dart::MediData" {
  +int? id
  +String name
  +String description
  +int quantity
  +String image_path
  +MediData copy()
  {static} +MediData fromJson()
  +Map<String, Object?> toJson()
}

class "elcare_application::alarm_and_pill::services::PIllTakeInfo.dart::PillTakeInfoFields" {
  {static} +List<String> values
  {static} +String id
  {static} +String date
  {static} +String time
  {static} +String prescription_id
}

class "elcare_application::alarm_and_pill::services::PIllTakeInfo.dart::PillTakeInfo" {
  +int? id
  +String date
  +String time
  +int prescription_id
  +List<Medicine>? medicines
  +PillTakeInfo copy()
  {static} +PillTakeInfo fromJson()
  +Map<String, Object?> toJson()
}

class "elcare_application::alarm_and_pill::services::Prescription.dart::PressFields" {
  {static} +List<String> values
  {static} +String id
  {static} +String time
  {static} +String isAlarmOn
  {static} +String date
  {static} +String numOfDays
}

class "elcare_application::alarm_and_pill::services::Prescription.dart::Prescription" {
  +int? id
  +String time
  +bool isAlarmOn
  +List<Medicine>? medicines
  +String date
  +int numOfDays
  +Prescription copy()
  {static} +Prescription fromJson()
  +Map<String, Object?> toJson()
  +String toString()
  +int getMedicineQuantity()
}

class "elcare_application::alarm_and_pill::services::SetupPillTimerData.dart::SetupData" {
  {static} +List<Prescription> prList
  {static} +List<PillTakeInfo> piList
  {static} +Future<void> refreshAlarms()
  {static} +Future<void> loadPillInfo()
}

class "elcare_application::controllers::google_signin_controller.dart::GoogleSignInController" {
  -GoogleSignIn _googleSignIn
  +GoogleSignInAccount? googleSignInAccount
  +dynamic login()
  +dynamic logout()
}

"elcare_application::controllers::google_signin_controller.dart::GoogleSignInController" o-- "google_sign_in::google_sign_in.dart::GoogleSignIn"
"elcare_application::controllers::google_signin_controller.dart::GoogleSignInController" o-- "google_sign_in::google_sign_in.dart::GoogleSignInAccount"
"flutter::src::foundation::change_notifier.dart::ChangeNotifier" <|-- "elcare_application::controllers::google_signin_controller.dart::GoogleSignInController"

class "elcare_application::controllers::login_controller.dart::LoginController" {
  -GoogleSignIn _googleSignIn
  +GoogleSignInAccount? googleSignInAccount
  +UserDetails? userDetails
  +dynamic googleLogin()
  +dynamic logout()
}

"elcare_application::controllers::login_controller.dart::LoginController" o-- "google_sign_in::google_sign_in.dart::GoogleSignIn"
"elcare_application::controllers::login_controller.dart::LoginController" o-- "google_sign_in::google_sign_in.dart::GoogleSignInAccount"
"elcare_application::controllers::login_controller.dart::LoginController" o-- "elcare_application::model::user_details.dart::UserDetails"
"flutter::src::foundation::change_notifier.dart::ChangeNotifier" <|-- "elcare_application::controllers::login_controller.dart::LoginController"

class "elcare_application::doctor_interface::classes::patient.dart::PatientDetails" {
  +String name
  +String email
  +List<PillTakeInfo>? prescriptionsList
  +PatientDetails copy()
}

class "elcare_application::doctor_interface::classes::settings_class.dart::Settings" {
  +String name
  +String hospitalName
  +String email
  +String password
  +String additionalInfo
}

class "elcare_application::doctor_interface::screens::details_screen.dart::PatientDetailsScreen" {
  +PatientDetails eachPatient
  +Widget build()
}

"elcare_application::doctor_interface::screens::details_screen.dart::PatientDetailsScreen" o-- "elcare_application::doctor_interface::classes::patient.dart::PatientDetails"
"flutter::src::widgets::framework.dart::StatelessWidget" <|-- "elcare_application::doctor_interface::screens::details_screen.dart::PatientDetailsScreen"

class "elcare_application::doctor_interface::screens::pill_timer_info.dart::PillTimerInfo" {
  +dynamic eachPatient
  +Widget build()
}

"flutter::src::widgets::framework.dart::StatelessWidget" <|-- "elcare_application::doctor_interface::screens::pill_timer_info.dart::PillTimerInfo"

class "elcare_application::doctor_interface::screens::profile_sc.dart::ProfilePage" {
  +_ProfilePageState createState()
}

"flutter::src::widgets::framework.dart::StatefulWidget" <|-- "elcare_application::doctor_interface::screens::profile_sc.dart::ProfilePage"

class "elcare_application::doctor_interface::screens::profile_sc.dart::_ProfilePageState" {
  -bool _isObscure
  -TextEditingController _nameController
  -TextEditingController _hospital_nameController
  -TextEditingController _emailController
  -TextEditingController _passwordController
  -TextEditingController _additionalInfoController
  -PreferencesService _preferencesService
  +String name
  +String hospitalName
  +String email
  +String password
  +String additionalNote
  -void _saveSettings()
  -void _populateFields()
  +void initState()
  +Widget build()
}

"elcare_application::doctor_interface::screens::profile_sc.dart::_ProfilePageState" o-- "flutter::src::widgets::editable_text.dart::TextEditingController"
"elcare_application::doctor_interface::screens::profile_sc.dart::_ProfilePageState" o-- "elcare_application::doctor_interface::user_data::user_preferences.dart::PreferencesService"
"flutter::src::widgets::framework.dart::State" <|-- "elcare_application::doctor_interface::screens::profile_sc.dart::_ProfilePageState"

class "elcare_application::doctor_interface::user_data::user_preferences.dart::PreferencesService" {
  +Future<dynamic> saveSettings()
  +Future<Settings> getSettings()
}

class "elcare_application::doctor_interface::widgets::home::cards.dart::CardsClass" {
  +void Function() view
  +dynamic eachPatient
  +Widget build()
}

"elcare_application::doctor_interface::widgets::home::cards.dart::CardsClass" o-- "null::void Function()"
"flutter::src::widgets::framework.dart::StatelessWidget" <|-- "elcare_application::doctor_interface::widgets::home::cards.dart::CardsClass"

class "elcare_application::doctor_interface::widgets::patient_details::row_template.dart::Row_Template" {
  +PillTakeInfo eachpres
  +Widget build()
}

"elcare_application::doctor_interface::widgets::patient_details::row_template.dart::Row_Template" o-- "elcare_application::alarm_and_pill::services::PIllTakeInfo.dart::PillTakeInfo"
"flutter::src::widgets::framework.dart::StatelessWidget" <|-- "elcare_application::doctor_interface::widgets::patient_details::row_template.dart::Row_Template"

class "elcare_application::doctor_user_menu.dart::DoctorMenu" {
  +_DoctorMenuState createState()
}

"flutter::src::widgets::framework.dart::StatefulWidget" <|-- "elcare_application::doctor_user_menu.dart::DoctorMenu"

class "elcare_application::doctor_user_menu.dart::_DoctorMenuState" {
  -TextEditingController _nameController
  -TextEditingController _emailController
  +void settingState()
  +void fill_patient_details()
  +Widget build()
}

"elcare_application::doctor_user_menu.dart::_DoctorMenuState" o-- "flutter::src::widgets::editable_text.dart::TextEditingController"
"flutter::src::widgets::framework.dart::State" <|-- "elcare_application::doctor_user_menu.dart::_DoctorMenuState"

class "elcare_application::emergency_caller::emergency_caller.dart::Person" {
  +String name
  +String phoneNumber
}

class "elcare_application::emergency_caller::emergency_caller.dart::EmergencyCaller" {
  +_EmergencyCallerState createState()
}

"flutter::src::widgets::framework.dart::StatefulWidget" <|-- "elcare_application::emergency_caller::emergency_caller.dart::EmergencyCaller"

class "elcare_application::emergency_caller::emergency_caller.dart::_EmergencyCallerState" {
  +Box<dynamic> box
  -bool _textFieldReadOnly
  +Person person1
  +Person person2
  +Person person3
  +TextEditingController nameController1
  +TextEditingController phoneNumberController1
  +TextEditingController nameController2
  +TextEditingController phoneNumberController2
  +TextEditingController nameController3
  +TextEditingController phoneNumberController3
  +String? nameName
  -dynamic _callNumber()
  -dynamic _saveContacts()
  -dynamic _getContactInfo()
  +void initState()
  +void dispose()
  -dynamic _addInfo()
  -dynamic _getInfo()
  -dynamic _updateInfo()
  -dynamic _deleteInfo()
  +Widget build()
}

"elcare_application::emergency_caller::emergency_caller.dart::_EmergencyCallerState" o-- "hive::hive.dart::Box<dynamic>"
"elcare_application::emergency_caller::emergency_caller.dart::_EmergencyCallerState" o-- "elcare_application::emergency_caller::emergency_caller.dart::Person"
"elcare_application::emergency_caller::emergency_caller.dart::_EmergencyCallerState" o-- "flutter::src::widgets::editable_text.dart::TextEditingController"
"flutter::src::widgets::framework.dart::State" <|-- "elcare_application::emergency_caller::emergency_caller.dart::_EmergencyCallerState"

class "elcare_application::emergency_caller::emergency_dialer.dart::EmergencyDialer" {
  +_EmergencyDialerState createState()
}

"flutter::src::widgets::framework.dart::StatefulWidget" <|-- "elcare_application::emergency_caller::emergency_dialer.dart::EmergencyDialer"

class "elcare_application::emergency_caller::emergency_dialer.dart::_EmergencyDialerState" {
  +Widget build()
}

"flutter::src::widgets::framework.dart::State" <|-- "elcare_application::emergency_caller::emergency_dialer.dart::_EmergencyDialerState"

class "elcare_application::login_screen.dart::LoginScreen" {
  +_LoginScreenState createState()
}

"flutter::src::widgets::framework.dart::StatefulWidget" <|-- "elcare_application::login_screen.dart::LoginScreen"

class "elcare_application::login_screen.dart::_LoginScreenState" {
  -Future<FirebaseApp> _initialization
  +CollectionReference<Object?> users
  -bool _checkboxvalue
  +String? username
  +String? password
  +TextEditingController emailController
  +TextEditingController passwordController
  +TextEditingController nameController
  +String usertype
  +Future<void> addUser()
  +void initState()
  +Widget build()
  +dynamic loginUI()
  +dynamic loggedInUI()
  +dynamic loginController()
}

"elcare_application::login_screen.dart::_LoginScreenState" o-- "cloud_firestore::cloud_firestore.dart::CollectionReference<Object>"
"elcare_application::login_screen.dart::_LoginScreenState" o-- "flutter::src::widgets::editable_text.dart::TextEditingController"
"flutter::src::widgets::framework.dart::State" <|-- "elcare_application::login_screen.dart::_LoginScreenState"

class "elcare_application::login_screen.dart::LoginButtons" {
  +String? text
  +IconData? icon
  +Color? color
  +int? acc
  +TextEditingController emailController
  +TextEditingController passwordController
  +TextEditingController nameController
  +String usertype
  +CollectionReference<Object?> users
  +bool validateEmail()
  +void addUser()
  +Widget build()
}

"elcare_application::login_screen.dart::LoginButtons" o-- "flutter::src::widgets::icon_data.dart::IconData"
"elcare_application::login_screen.dart::LoginButtons" o-- "dart::ui::Color"
"elcare_application::login_screen.dart::LoginButtons" o-- "flutter::src::widgets::editable_text.dart::TextEditingController"
"elcare_application::login_screen.dart::LoginButtons" o-- "cloud_firestore::cloud_firestore.dart::CollectionReference<Object>"
"flutter::src::widgets::framework.dart::StatelessWidget" <|-- "elcare_application::login_screen.dart::LoginButtons"

class "elcare_application::main.dart::MyApp" {
  +Future<bool> getIfLoggedIn()
  +Future<bool> getIfDoctor()
  +Widget build()
  +dynamic routeLogin()
}

"flutter::src::widgets::framework.dart::StatelessWidget" <|-- "elcare_application::main.dart::MyApp"

class "elcare_application::main_menu.dart::MainMenu" {
  +_MainMenuState createState()
}

"flutter::src::widgets::framework.dart::StatefulWidget" <|-- "elcare_application::main_menu.dart::MainMenu"

class "elcare_application::main_menu.dart::_MainMenuState" {
  {static} +String? userType
  +Widget build()
}

"flutter::src::widgets::framework.dart::State" <|-- "elcare_application::main_menu.dart::_MainMenuState"

class "elcare_application::model::user_details.dart::UserDetails" {
  +String? displayName
  +String? email
  +String? photoURL
  +Map<String, dynamic> toJson()
}

class "elcare_application::regular_user_menu.dart::RegularUserMain" {
  +_RegularUserMainState createState()
}

"flutter::src::widgets::framework.dart::StatefulWidget" <|-- "elcare_application::regular_user_menu.dart::RegularUserMain"

class "elcare_application::regular_user_menu.dart::_RegularUserMainState" {
  +Widget build()
}

"flutter::src::widgets::framework.dart::State" <|-- "elcare_application::regular_user_menu.dart::_RegularUserMainState"

class "elcare_application::sleep_tracker::sleep_duration.dart::SleepDuration" {
  +String? date
  +double? duration
  +Color backColor
}

"elcare_application::sleep_tracker::sleep_duration.dart::SleepDuration" o-- "charts_common::src::common::color.dart::Color"

class "elcare_application::sleep_tracker::sleep_duration_chart.dart::SleepDurationChart" {
  +List<SleepDuration> data
  +Widget build()
}

"flutter::src::widgets::framework.dart::StatelessWidget" <|-- "elcare_application::sleep_tracker::sleep_duration_chart.dart::SleepDurationChart"

class "elcare_application::sleep_tracker::sleep_quality.dart::SleepQuality" {
  +String? date
  +double? quality
  +Color backColor
}

"elcare_application::sleep_tracker::sleep_quality.dart::SleepQuality" o-- "charts_common::src::common::color.dart::Color"

class "elcare_application::sleep_tracker::sleep_quality_chart.dart::SleepQualityChart" {
  +List<SleepQuality> data
  +Widget build()
}

"flutter::src::widgets::framework.dart::StatelessWidget" <|-- "elcare_application::sleep_tracker::sleep_quality_chart.dart::SleepQualityChart"

class "elcare_application::sleep_tracker::sleep_quality_data.dart::SleepQualityData" {
  {static} +Box<dynamic>? sleepQualityBox
}

"elcare_application::sleep_tracker::sleep_quality_data.dart::SleepQualityData" o-- "hive::hive.dart::Box<dynamic>"

class "elcare_application::sleep_tracker::sleep_tracker.dart::SleepTracker" {
  +_SleepTrackerState createState()
}

"flutter::src::widgets::framework.dart::StatefulWidget" <|-- "elcare_application::sleep_tracker::sleep_tracker.dart::SleepTracker"

class "elcare_application::sleep_tracker::sleep_tracker.dart::_SleepTrackerState" {
  +Box<dynamic> sleepQualityBox
  +Box<dynamic> sleepDurationBox
  -GlobalKey<ScaffoldState> _scaffoldKey
  -CustomTimerController _controller
  +bool isStarted
  +DateTime now
  +DateTime wakeTime1
  +DateTime wakeTime2
  +DateTime wakeTime3
  +DateTime wakeTime4
  +DateTime wakeTime5
  +DateTime wakeTime
  +String dndModeTo
  +bool isDNDOn
  -String _filterName
  -bool _isNotificationPolicyAccessGranted
  +String isRoomSuitable
  +int max_light
  +int low_light
  +double avg_lux
  -String? _luxString
  -Light _light
  -StreamSubscription<dynamic> _subscription
  +int wakeMinute
  +int wakeUpHour
  +int wakeUpMinute
  +DateTime timerBeginTime
  +DateTime timerStoppedTime
  -TimeOfDay _time
  +void onData()
  +void stopListening()
  +void startListening()
  +void initState()
  -dynamic _addInfo()
  -dynamic _getInfo()
  -dynamic _updateInfo()
  -dynamic _deleteInfo()
  +Future<void> initPlatformState()
  +void didChangeAppLifecycleState()
  +void didChangeDependencies()
  +void updateUI()
  +void setInterruptionFilter()
  -void _selectTime()
  +void timerStoppedOrFinishedFunction()
  +double calculateSleepQuality()
  +int getTimerRunTime()
  +Widget build()
}

"elcare_application::sleep_tracker::sleep_tracker.dart::_SleepTrackerState" o-- "hive::hive.dart::Box<dynamic>"
"elcare_application::sleep_tracker::sleep_tracker.dart::_SleepTrackerState" o-- "flutter::src::widgets::framework.dart::GlobalKey<ScaffoldState>"
"elcare_application::sleep_tracker::sleep_tracker.dart::_SleepTrackerState" o-- "custom_timer::src::custom_timer_controller.dart::CustomTimerController"
"elcare_application::sleep_tracker::sleep_tracker.dart::_SleepTrackerState" o-- "light::light.dart::Light"
"elcare_application::sleep_tracker::sleep_tracker.dart::_SleepTrackerState" o-- "dart::async::StreamSubscription<dynamic>"
"elcare_application::sleep_tracker::sleep_tracker.dart::_SleepTrackerState" o-- "flutter::src::material::time.dart::TimeOfDay"
"flutter::src::widgets::framework.dart::State" <|-- "elcare_application::sleep_tracker::sleep_tracker.dart::_SleepTrackerState"
"flutter::src::widgets::binding.dart::WidgetsBindingObserver" <|-- "elcare_application::sleep_tracker::sleep_tracker.dart::_SleepTrackerState"

class "elcare_application::sleep_tracker::sleep_tracker_charts.dart::SleepTrackerCharts" {
  +State<SleepTrackerCharts> createState()
}

"flutter::src::widgets::framework.dart::StatefulWidget" <|-- "elcare_application::sleep_tracker::sleep_tracker_charts.dart::SleepTrackerCharts"

class "elcare_application::sleep_tracker::sleep_tracker_charts.dart::_SleepTrackerChartsState" {
  +Box<dynamic> sleepQualityBox
  +Box<dynamic> sleepDurationBox
  +List<dynamic> qualityKeyList
  +List<dynamic> qualityValueList
  +List<dynamic> durationKeyList
  +List<dynamic> durationValueList
  +List<dynamic> firebaseQualityKeyList
  +List<dynamic> firebaseQualityValueList
  +List<dynamic> firebaseDurationKeyList
  +List<dynamic> firebaseDurationValueList
  +List<dynamic> allQualityKeys
  +List<dynamic> allDurationKeys
  +List<SleepDuration> durationData
  +List<SleepQuality> qualityData
  +void fillQualityKeys()
  +void fillDurationKeys()
  +void fillQualityValues()
  +void fillDurationValues()
  -dynamic _addInfo()
  -dynamic _getInfo()
  -List<dynamic> _getKeys()
  -dynamic _getValues()
  +void addSleepQualityDatatoChart()
  +void addSleepDurationDatatoChart()
  +void initState()
  +Widget build()
}

"elcare_application::sleep_tracker::sleep_tracker_charts.dart::_SleepTrackerChartsState" o-- "hive::hive.dart::Box<dynamic>"
"flutter::src::widgets::framework.dart::State" <|-- "elcare_application::sleep_tracker::sleep_tracker_charts.dart::_SleepTrackerChartsState"

class "elcare_application::sleep_tracker::sleep_tracker_firebase_charts.dart::SleepTrackerFirebaseCharts" {
  +State<SleepTrackerFirebaseCharts> createState()
}

"flutter::src::widgets::framework.dart::StatefulWidget" <|-- "elcare_application::sleep_tracker::sleep_tracker_firebase_charts.dart::SleepTrackerFirebaseCharts"

class "elcare_application::sleep_tracker::sleep_tracker_firebase_charts.dart::_SleepTrackerFirebaseChartsState" {
  +List<dynamic> qualityKeyList
  +List<dynamic> qualityValueList
  +List<dynamic> durationKeyList
  +List<dynamic> durationValueList
  +List<SleepDuration> durationData
  +List<SleepQuality> qualityData
  +void addSleepQualityDatatoChart()
  +void addSleepDurationDatatoChart()
  +void addAllData()
  +void initState()
  +Widget build()
}

"flutter::src::widgets::framework.dart::State" <|-- "elcare_application::sleep_tracker::sleep_tracker_firebase_charts.dart::_SleepTrackerFirebaseChartsState"

class "elcare_application::usertype_selection_screen.dart::UserSelection" {
  +_UserSelectionState createState()
}

"flutter::src::widgets::framework.dart::StatefulWidget" <|-- "elcare_application::usertype_selection_screen.dart::UserSelection"

class "elcare_application::usertype_selection_screen.dart::_UserSelectionState" {
  {static} +String? userType
  +LoginController? model
  +void mean()
  +Widget build()
}

"elcare_application::usertype_selection_screen.dart::_UserSelectionState" o-- "elcare_application::controllers::login_controller.dart::LoginController"
"flutter::src::widgets::framework.dart::State" <|-- "elcare_application::usertype_selection_screen.dart::_UserSelectionState"

class "elcare_application::user_profiles::regular_user_profile::constants::enums.dart::MenuType" {
  +int index
  {static} +List<MenuType> values
  {static} +MenuType Personal
  {static} +MenuType Medical
}

"elcare_application::user_profiles::regular_user_profile::constants::enums.dart::MenuType" o-- "elcare_application::user_profiles::regular_user_profile::constants::enums.dart::MenuType"
"dart::core::Enum" <|-- "elcare_application::user_profiles::regular_user_profile::constants::enums.dart::MenuType"

class "elcare_application::user_profiles::regular_user_profile::models::menu_info.dart::MenuInfo" {
  +MenuType menuType
  +String title
  +String imageSource
  +dynamic updateMenu()
}

"elcare_application::user_profiles::regular_user_profile::models::menu_info.dart::MenuInfo" o-- "elcare_application::user_profiles::regular_user_profile::constants::enums.dart::MenuType"
"flutter::src::foundation::change_notifier.dart::ChangeNotifier" <|-- "elcare_application::user_profiles::regular_user_profile::models::menu_info.dart::MenuInfo"

class "elcare_application::user_profiles::regular_user_profile::settings_class.dart::Settings" {
  +String name
  +String hospitalName
  +String email
  +String password
  +String additionalInfo
}

class "elcare_application::user_profiles::regular_user_profile::User_Personal_Page::user_personal_details.dart::UserProfilePage" {
  +_UserProfilePageState createState()
}

"flutter::src::widgets::framework.dart::StatefulWidget" <|-- "elcare_application::user_profiles::regular_user_profile::User_Personal_Page::user_personal_details.dart::UserProfilePage"

class "elcare_application::user_profiles::regular_user_profile::User_Personal_Page::user_personal_details.dart::_UserProfilePageState" {
  -bool _isObscure
  -TextEditingController _nameController
  -TextEditingController _doctorEmailController
  -TextEditingController _emailController
  -TextEditingController _passwordController
  -TextEditingController _additionalInfoController
  -PreferencesService _preferencesService
  +String name
  +String hospitalName
  +String email
  +String password
  +String additionalNote
  -void _saveSettings()
  -void _populateFields()
  +void initState()
  +Widget build()
}

"elcare_application::user_profiles::regular_user_profile::User_Personal_Page::user_personal_details.dart::_UserProfilePageState" o-- "flutter::src::widgets::editable_text.dart::TextEditingController"
"elcare_application::user_profiles::regular_user_profile::User_Personal_Page::user_personal_details.dart::_UserProfilePageState" o-- "elcare_application::user_profiles::regular_user_profile::user_preferences.dart::PreferencesService"
"flutter::src::widgets::framework.dart::State" <|-- "elcare_application::user_profiles::regular_user_profile::User_Personal_Page::user_personal_details.dart::_UserProfilePageState"

class "elcare_application::user_profiles::regular_user_profile::user_preferences.dart::PreferencesService" {
  +Future<dynamic> saveSettings()
  +Future<Settings> getSettings()
}

class "elcare_application::user_profiles::regular_user_profile::views::personal_details.dart::User_Profile_Page" {
  +_User_Profile_PageState createState()
}

"flutter::src::widgets::framework.dart::StatefulWidget" <|-- "elcare_application::user_profiles::regular_user_profile::views::personal_details.dart::User_Profile_Page"

class "elcare_application::user_profiles::regular_user_profile::views::personal_details.dart::_User_Profile_PageState" {
  +Widget build()
  +Widget buildMenuButton()
}

"flutter::src::widgets::framework.dart::State" <|-- "elcare_application::user_profiles::regular_user_profile::views::personal_details.dart::_User_Profile_PageState"


@enduml