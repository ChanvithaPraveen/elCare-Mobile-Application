import 'package:flutter/material.dart';

class CardsClass extends StatelessWidget {
  final void Function() view;
  final eachPatient;

  const CardsClass({
    required this.eachPatient,
    required this.view,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
color: Colors.transparent,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.black54,
            borderRadius: const BorderRadius.all(Radius.circular(10.0)),
          ),
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child:
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch, 
                  children: [
                    Text(
                      eachPatient.name,
                      style: const TextStyle(
                        fontSize: 18.0,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(
                      height: 8.0,
                    ),
                  InkWell(
                    onTap: view,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                              width: 140.0,
                              height: 35,
                              alignment: Alignment.bottomRight,
                              decoration: BoxDecoration(
                                color: Colors.teal[300],
                                borderRadius: const BorderRadius.all(Radius.circular(15.0)),
                              ),
                              child: Center(
                                child: Row(
                                  children: [
                                    const SizedBox(
                                      width: 7.0,
                                    ),
                                    Icon(Icons.attach_file, color: Colors.white,),
                                    SizedBox(
                                      width: 4.0,
                                    ),
                                    Text(
                                      'View Details',
                                      style:
                                          TextStyle(color: Colors.white, fontSize: 16.0, fontWeight: FontWeight.bold),
                                    ),
                                ]),
                              )),
                        ],
                      ),
                    ),
                  ),
        ]),
      ),
    ));
  }
}