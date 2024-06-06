import 'package:floorplan_app/FloorPlanTest.dart';
import 'package:floorplan_app/services/apis.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class FloorPlanActivity extends StatefulWidget{
  const FloorPlanActivity({super.key});


  @override
  State<FloorPlanActivity> createState() => _FloorPlanActivityState();
}

class _FloorPlanActivityState extends State<FloorPlanActivity> {

  var landSize = [0,0];
  var imageLinkList = [];

  var isLoaded = false;
  final _lengthController = TextEditingController();
  final _widthController = TextEditingController();

  final imageCount = 2;
  @override
  void initState(){
    super.initState();
    getGeneratedImage();

  }

  getGeneratedImage()async{
    var list = await Apis().generateFloorPlan(landSize);

    if (list != null){
      setState(() {
        isLoaded = true;
        imageLinkList = list;
        // print(probabilityList[0]);
        print(list);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          constraints: const BoxConstraints(
            maxWidth: 1512,
          ),
          child: SingleChildScrollView(
            child: Wrap(
              spacing: 96,
              runSpacing: 96,
              direction: Axis.horizontal,
              alignment: WrapAlignment.center,
              runAlignment: WrapAlignment.center,
              children: [
                _form(),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Column(
                      children: [
                        _outputImage(),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            for (var i = 0; i < imageCount; i++)
                              Container(
                                height: 48,
                                width: 48,
                                margin: const EdgeInsets.symmetric(
                                  horizontal: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFEEEEEE),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(width: 32),
                    _buildLegend(),
                  ],
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(width: 103),
                    Expanded(
                      child: _aboutSection(),
                    ),
                    const SizedBox(width: 32),
                    _placeholderImage(),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _form() {
    return IntrinsicWidth(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Image.asset("assets/logo.png", width: 168),
              Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Text(
                  "2d Floor Plan Generator",
                  textAlign: TextAlign.center,
                  style: Theme.of(context)
                      .textTheme
                      .headlineLarge!
                      .copyWith(color: Colors.black.withOpacity(0.6)),
                ),
              ),
            ],
          ),
          const SizedBox(height: 48),
          Row(
            children: [
              Flexible(
                child: TextFormField(
                  controller: _lengthController,
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    hintText: "Length",
                    hintStyle: TextStyle(
                      color: Colors.black.withOpacity(0.3),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(32),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Text(
                "X",
                style: Theme.of(context)
                    .textTheme
                    .headlineLarge!
                    .copyWith(color: Colors.grey),
              ),
              const SizedBox(width: 16),
              Flexible(
                child: TextFormField(
                  controller: _widthController,
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    hintText: "Width",
                    hintStyle: TextStyle(
                      color: Colors.black.withOpacity(0.3),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(32),
                    ),
                  ),
                ),
              )
            ],
          ),
          const SizedBox(height: 32),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFB8A7FF),
              minimumSize: const Size.fromHeight(64),
              shape: StadiumBorder(
                  side: BorderSide(
                    color: Colors.black.withOpacity(0.4),
                    width: 2,
                  )),
            ),
            child: Text(
              "Generate",
              style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                color: Colors.black.withOpacity(0.4),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _outputImage() {
    return Container(
      width: 421,
      height: 421,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        border: Border.all(
          width: 5,
          color: Colors.grey,
        ),
        borderRadius: BorderRadius.circular(32),
      ),
      child: Text(
        "Image Output",
        style: Theme.of(context)
            .textTheme
            .displaySmall!
            .copyWith(color: Colors.grey),
      ),
    );
  }

  Widget _buildLegend() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              height: 48,
              width: 48,
              decoration: BoxDecoration(
                color: const Color(0xFFB8A7FF),
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            const SizedBox(width: 8),
            Text('Room', style: Theme.of(context).textTheme.titleLarge),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Container(
              height: 48,
              width: 48,
              decoration: BoxDecoration(
                color: const Color(0xFFFFE6A7),
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            const SizedBox(width: 8),
            Text('Living Room', style: Theme.of(context).textTheme.titleLarge),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Container(
              height: 48,
              width: 48,
              decoration: BoxDecoration(
                color: const Color(0xFFFFA7A7),
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            const SizedBox(width: 8),
            Text('Toilet/Bathroom',
                style: Theme.of(context).textTheme.titleLarge),
          ],
        ),
        const SizedBox(height: 48 + 8),
      ],
    );
  }

  Widget _aboutSection() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Divider(),
        Text(
          "About",
          style: Theme.of(context).textTheme.headlineMedium!.copyWith(
            color: Colors.black.withOpacity(0.6),
          ),
        ),
        const SizedBox(height: 16),
        Text(
          "It is webpage for our project 2d floor plane generator that uses a CNN algorithoms to generate 2d floor plan through the given input of length and weidth of the house.",
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
            color: Colors.black.withOpacity(0.6),
          ),
        ),
      ],
    );
  }

  Widget _placeholderImage() {
    return Transform.rotate(
      angle: 180 * 14,
      child: SizedBox(
        width: 256,
        height: 256,
        child: Image.asset(
          'assets/plan.png',
        ),
      ),
    );
  }
}
