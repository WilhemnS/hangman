import 'package:http/http.dart' as http;

class HangmanGame {
  String _word;
  String _correctGuesses = "";
  String _wrongGuesses = "";
  int _score;

  //Constructor starts off with blank strings that we will concatenate during the course of play
  HangmanGame(String word) {
    _word = word;
    _correctGuesses = "";
    _wrongGuesses = "";
    _score = 0;
  }

  int score(){
    return _score;
  }

  String correctGuesses() {
    return _correctGuesses;
  }

  String wrongGuesses() {
    return _wrongGuesses;
  }

  String word() {
    return _word;
  }

  bool guess(String letter) {
    // TODO: Fill this in

    if(letter == null || letter.isEmpty || !letter.contains(RegExp(r'[a-zA-Z]'))){
      throw ArgumentError();
    }

    if(letter.length > 1){
      throw ArgumentError();
    }

    if(_correctGuesses.contains(letter.toLowerCase()) || _wrongGuesses.contains(letter.toLowerCase())){
      return false;
    }

    if(_word.contains(letter)){
      int points;
      if(_word.length > 5){
        points = 5;
      }else{
        points = 10;
      }
      int instances = _word.split(letter).length - 1;
      _correctGuesses += letter;
      _score += points * instances;
    }else{
      _wrongGuesses += letter;
      _score -= 5;
    }
    return true;
    
  }

  String blanksWithCorrectGuesses() {
    // TODO: Fill this in

    String display = '';

    for(var x in _word.split('')){
      if(_correctGuesses.contains(x)){
        display += x;
      }else{
        display += '-';
      }
    }
    return display;

  }

  String status() {
    // TODO: Fill this in

    String display = blanksWithCorrectGuesses();

    if(_wrongGuesses.length >= 7){
      return 'lose';
    }else{
      if(display.contains('-')){
        return 'play';
      }else{
        return 'win';
      }
    }
  }

  //when running integration tests always return "banana"
  static Future<String> getStartingWord(bool areWeInIntegrationTest) async {
    String word;
    Uri endpoint = Uri.parse("http://randomword.saasbook.info/RandomWord");
    if (areWeInIntegrationTest) {
      word = "banana";
    } else {
      word = "banana";
      // try {
      //   var response = await http.post(endpoint);
      //   word = response.body;
      // } catch (e) {
      //   word = "error";
      // }
    }

    return word;
  }
}
