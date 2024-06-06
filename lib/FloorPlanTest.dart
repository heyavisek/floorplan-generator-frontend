import 'dart:html';
import 'dart:io';

import 'package:floorplan_app/services/apis.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class FloorPlanTestActivity extends StatefulWidget{
  const FloorPlanTestActivity({super.key});


  @override
  State<FloorPlanTestActivity> createState() => _FloorPlanTestActivityState();
}

class _FloorPlanTestActivityState extends State<FloorPlanTestActivity> {
  var roomLabel = ['LivingRoom','MasterRoom','Kitchen','Bathroom','DiningRoom','ChildRoom','StudyRoom','SecondRoom','GuestRoom','Balcony'];
  var aboutText = "It is webpage for our project 2d floor plan generator that uses a CNN algorithms to generate 2d floor plan through the given input of length and width of the house.";

  final _formKeyLength = GlobalKey<FormState>();
  final _formKeyWidth = GlobalKey<FormState>();

  final TextEditingController lengthInput = TextEditingController();
  final TextEditingController widthInput = TextEditingController();
  var isImageLoaded = false;
  var isImageGenerating = false;
  var imageUrl = '';
  var roomNodeInfo = [];
  var status = true;

  generateImage()async{
    String time = DateTime.now().second.toString();
    var landSize = [int.tryParse(lengthInput.text), int.tryParse(widthInput.text)];
    var imageData = await Apis().generateFloorPlan(landSize);

    if (imageData != null){
      setState(() {
        roomNodeInfo = imageData["rooms"];
        status = imageData["status"];
        imageUrl = 'http://127.0.0.1:8000/floorplan/getPlan/' + time;
        isImageLoaded = true;
        isImageGenerating = false;
      });
    }
    print(roomNodeInfo.length);
  }

  @override
  Widget build(BuildContext context) {
  return Scaffold(
          body: Scrollbar(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(200.0, 20, 200.0 , 10),
              child: Center(
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          height: 80,
                          width: 80,
                          child: Image.asset(
                            'assets/logo.png',
                            fit: BoxFit.fitHeight,
                          ),
                        ),
                        const SizedBox(width: 16,),
                        const Expanded(
                            child: Text(
                              'Floor Plan Generator',
                              style: TextStyle(
                                fontSize: 40,
                                color: Colors.blue
                              ),
                            )
                        )
                      ],
                    ),
                    const SizedBox(height: 16,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child:
                              Column(
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Form(
                                          key: _formKeyLength,
                                          child: TextFormField(
                                            controller: lengthInput,
                                            validator: (value) {
                                              if (value == null || value.isEmpty || int.tryParse(value) == null){
                                                return 'Input correct Length.';
                                              }
                                              return null;
                                            },
                                            decoration: InputDecoration(
                                              labelText: 'width (ft)',
                                              enabledBorder: OutlineInputBorder(
                                                borderRadius: BorderRadius.circular(50),
                                                  borderSide: const BorderSide(
                                                      width: 2.0,
                                                      color: Colors.blue
                                                  )
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderRadius: BorderRadius.circular(50),
                                                  borderSide: const BorderSide(
                                                      width: 2.0,
                                                      color: Colors.green
                                                  )
                                              ),
                                              errorBorder: OutlineInputBorder(
                                                borderRadius: BorderRadius.circular(50),
                                                  borderSide: const BorderSide(
                                                      width: 2.0,
                                                      color: Colors.green
                                                  )
                                              ),
                                              focusedErrorBorder: OutlineInputBorder(
                                                borderRadius: BorderRadius.circular(50),
                                                  borderSide: const BorderSide(
                                                      width: 2.0,
                                                      color: Colors.green
                                                  )
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 16),
                                      Expanded(
                                        child: Form(
                                          key: _formKeyWidth,
                                          child: TextFormField(
                                            controller: widthInput,
                                            validator: (value) {
                                              if (value == null || value.isEmpty || int.tryParse(value) == null){
                                                return 'Input correct Width.';
                                              }
                                              return null;
                                            },
                                            decoration: InputDecoration(
                                              labelText: 'Length (ft)',
                                              enabledBorder: OutlineInputBorder(
                                                  borderRadius: BorderRadius.circular(50),
                                                  borderSide: const BorderSide(
                                                      width: 2.0,
                                                      color: Colors.blue
                                                  )
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                  borderRadius: BorderRadius.circular(50),
                                                  borderSide: const BorderSide(
                                                      width: 2.0,
                                                      color: Colors.green
                                                  )
                                              ),
                                              errorBorder: OutlineInputBorder(
                                                  borderRadius: BorderRadius.circular(50),
                                                  borderSide: const BorderSide(
                                                      width: 2.0,
                                                      color: Colors.green
                                                  )
                                              ),
                                              focusedErrorBorder: OutlineInputBorder(
                                                  borderRadius: BorderRadius.circular(50),
                                                  borderSide: const BorderSide(
                                                      width: 2.0,
                                                      color: Colors.green
                                                  )
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 16),
                                  ElevatedButton(
                                    onPressed:  () {
                                      if ( _formKeyLength.currentState!.validate() && _formKeyWidth.currentState!.validate()){
                                        if (isImageGenerating){
                                        }else {
                                          setState(() {
                                            isImageLoaded = false;
                                            isImageGenerating = true;
                                            imageUrl = '';
                                          });
                                          generateImage();
                                        }
                                      }


                                    },
                                    style: ElevatedButton.styleFrom(
                                        padding: const EdgeInsets.all(5),
                                        minimumSize: const Size(200, 60)

                                    ),
                                    child: const Text('Generate',
                                      style: TextStyle(
                                        color: Colors.blue,
                                        fontSize: 20,
                                        fontWeight: FontWeight.normal
                                      ),
                                    ),
                                  ),
                                ],
                              )
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text('Message: ${isImageGenerating ? 'Engine is busy now.' : 'Engine is active now.'}'),
                                  const SizedBox(width: 10,),
                                  isImageLoaded ? Text('Status: ${status? 'In size' : 'Random'}'): Text(''),
                                ],
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(color: status ? Colors.blue : Colors.red, width: 3)
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(17),
                                  child: Container(
                                    width: 400,
                                    height: 400,
                                    color: const Color.fromRGBO(230, 230, 230, 1),
                                    child: isImageLoaded ? Image.network(
                                      imageUrl,
                                      fit: BoxFit.fitHeight,
                                    ):isImageGenerating ? SizedBox(
                                      child: Container(
                                        color: Colors.white,
                                        child: Image.asset(
                                            'assets/construction.gif',
                                        ),
                                      ),
                                    ) : Container(
                                      color: Colors.white,
                                      child: Image.asset(
                                        'assets/under_construction.gif'
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20,),
                    SizedBox(
                      height: 50,
                      child: Visibility(
                        visible: isImageLoaded,
                        child: Row(
                          children: List.generate(roomNodeInfo.length,
                                  (index) => SizedBox(
                                    width: 200,
                                    child: Row(
                                      children: [
                                        Text(roomLabel[roomNodeInfo[index][0]], style: const TextStyle( fontSize: 20),),
                                        const SizedBox(width: 15,),
                                        Container(
                                          width: 30,
                                          height: 30,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(10),
                                            color: Color.fromRGBO(roomNodeInfo[index][1], roomNodeInfo[index][2], roomNodeInfo[index][3], 1),
                                          ),

                                        )
                                      ],
                                    ),
                                  ),
                            ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16,),
                    Container(
                      height: 2,
                      width: double.infinity,
                      color: Colors.blue,
                    ),
                    Container(
                      width: double.infinity,
                      color: Colors.white10,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                  child: Expanded(
                                      child: Text(
                                        'About',
                                        style: TextStyle(
                                          fontSize: 30,
                                          color: Colors.black87,
                                        ),
                                      )
                                  )
                              ),
                              SizedBox(
                                width: 700,
                                child: Expanded(
                                    child: Text(
                                      aboutText,
                                      textAlign: TextAlign.justify,
                                      style: const TextStyle(
                                        fontSize: 20,
                                        color: Colors.grey,
                                      ),
                                    )
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(width: 50),
                          SizedBox(
                            width: 250,
                            height: 250,
                            child: Center(
                              child: Transform.rotate(
                                angle: -180 * 14,
                                child: Image.asset(
                                  'assets/footer_image.png',
                                  fit: BoxFit.fitHeight,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                  ],

                ),
              ),
            ),
          ),
    );
  }
}