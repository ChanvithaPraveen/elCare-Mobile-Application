import 'package:flutter/material.dart';

import 'package:flutter_dialpad/flutter_dialpad.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';



class EmergencyDialer extends StatefulWidget {
  const EmergencyDialer({ Key? key }) : super(key: key);

  @override
  _EmergencyDialerState createState() => _EmergencyDialerState();
}

class _EmergencyDialerState extends State<EmergencyDialer> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.black,
        body: SafeArea(
            child:
            DialPad(
                enableDtmf: true,
                outputMask: "(000) 000-0000",
                backspaceButtonIconColor: Colors.red,
                makeCall: (number)  {
                  FlutterPhoneDirectCaller.callNumber(number);
                  print("Hello");
                }
            )
        ),
      ),
    );
  }
}