import 'dart:convert';
import 'dart:io' as Io;
import 'package:path/path.dart' as path;
import 'package:http/http.dart' as http;
main(){
    final filename = 'file.txt';
  
    
var result;
 bool value = true;
  final data = path.join('C:/flutterProjects/FlutterDemos/demo/song','songname.raw');
  final bytes = Io.File(data).readAsBytesSync();
  final img64 = base64Encode(bytes);
  if(img64!=null){
    print('printing');
    print(img64.substring(0,100));
  }
  else{
    print('empty');
  }

 var body = img64.substring(0,300000);
http.post("https://shazam.p.rapidapi.com/songs/detect" , body: body, headers: {
      //"x-rapidapi-host": "shazam.p.rapidapi.com",
      'x-rapidapi-key': '3e7ab7e94emshca396c25538373fp14c862jsna3dd4addf531',
      'content-type': 'text/plain',
     'useQueryString': 'true'
}).then((response) {
     // JsonEncoder encoder = new JsonEncoder.withIndent(' ');  
    
      //result= encoder.convert(response.body);
   result = json.decode(response.body);
   // result = response.body;
    print('printing result');
    
   print("song : ${result['share']['subject']}");  // song
    print("images/bgimage: ${result['track']['images']['background']}");   //bgimages
    print("images /coverart: ${result['track']['images']['coverart']}"); //coverart
    print("key : ${result['track']['key']}");   //key
    print("lyrics : ${result['track']['sections'][1]['text']}");  //lyrics

       
    }).catchError((onError){
      print('error: ${onError}');
    });


new Io.File(filename).writeAsString(img64.substring(0,300000)).catchError((error){
    print('error');
  });
 
}
