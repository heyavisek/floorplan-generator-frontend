import 'dart:convert';
import 'package:http/http.dart' as http;

class Apis{
  var apiUrl = 'http://127.0.0.1:8000';
  // var apiUrl = "http://10.0.2.2:8000";

  Future generateFloorPlan(var landSize) async {
    var imageLink = [];
    var client = http.Client();
    var headers = {'Content-Type': 'application/json'};
    Uri generateLink = Uri.parse('http://127.0.0.1:8000/floorplan/generate/');
    // Uri generateLink = Uri.parse('${apiUrl}/floorplan/generate/');
    // Uri generateLink = Uri.http('127.0.0.1:8000','/floorplan/generate/');
    var response = await client.post(generateLink, headers: headers, body: jsonEncode({"land_size":landSize}));
    var imageData;
    if(response.statusCode == 200){
      print(response.body);
      imageData = jsonDecode(response.body);;
    }
    return imageData;
  }

  Future getPlan() async {
    var client = http.Client();
    var headers = {'Content-Type': 'application/json'};
    Uri generateLink = Uri.parse('http://127.0.0.1:8000/floorplan/getPlan/');
    // Uri generateLink = Uri.parse('${apiUrl}/floorplan/generate/');
    // Uri generateLink = Uri.http('127.0.0.1:8000','/floorplan/generate/');
    var response = await client.get(generateLink, headers: headers);
    var imageLink = '';
    if(response.statusCode == 200){
      imageLink = jsonDecode(response.body);
    }
    return imageLink;
  }

}