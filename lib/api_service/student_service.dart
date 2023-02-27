import 'package:http/http.dart' as http;

class StudentService {

  Future postArticle(String url, dynamic data, int imageId) async{
    var request = http.Request('POST',
        Uri.parse('https://jsonplaceholder.typicode.com/posts/1/comments?postId=1&id=1&name=postName&email=testing@gmail.com&body=afdfsdsadfsf')
    );

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    }
    else {
      print(response.reasonPhrase);
    }

  }
}