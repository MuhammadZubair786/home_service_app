import "package:get/get.dart";

class LocalString extends Translations{
  @override
  //Todo: implement Keys
  Map <String,Map<String,String>> get keys=>{
    'en_US':{
      "hello":"hello ",
      "message":"Welcom To proto"
    },
    "zu_IN":{
      "hello":"CIAO",
      "message":"sjhdjhsdjh"
    }
  };
}