import 'package:flutter/material.dart';
//import 'package:flutter_dialogflow/flutter_dialogflow.dart';
import '../models/message_model.dart';
import 'package:flutter_dialogflow_v2/flutter_dialogflow.dart';


/*
class FlutterFactsChatBot extends StatefulWidget {
  FlutterFactsChatBot({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _FlutterFactsChatBotState createState() => new _FlutterFactsChatBotState();
}
*/
void agentResponse(query) async {
  //_textController.clear();
  AuthGoogle authGoogle =
  await AuthGoogle(fileJson: "assets/the-watcher-tucjly-cdc5d593c043.json").build();
  Dialogflow dialogFlow =
  Dialogflow(authGoogle: authGoogle, language: Language.english);
  AIResponse response = await dialogFlow.detectIntent(query);
  Message message = Message(
    text: response.getMessage() ??
      CardDialogflow(response.getListMessage()[0]).title,
    sender: james,
    time: '5:30 PM',
    //text: 'Hey, how\'s it going? What did you do today?',
    isLiked: false,
    unread: true,
  );
  messages.insert(0, message);
  /*
    setState(() {
      messageList.insert(0, message);
    });*/
}
/*
class Response /*extends State<FlutterFactsChatBot>*/ {
  final List<Message> messageList = <Message>[]; //list fact created
  final TextEditingController _textController = new TextEditingController();

 /* Widget _queryInputWidget(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(30))),
      child: Padding(
        padding: const EdgeInsets.only(left:8.0, right: 8),
        child: Row(
          children: <Widget>[
            Flexible(
              child: TextField(
                controller: _textController,
                onSubmitted: _submitQuery,
                decoration: InputDecoration.collapsed(hintText: "Send a message"),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 4.0),
              child: IconButton(
                icon: Icon(Icons.send, color: Colors.green[400],),
                onPressed: () => _submitQuery(_textController.text)),
            ),
          ],
        ),
      ),
    );
  }*/

  void agentResponse(query) async {
    _textController.clear();
    AuthGoogle authGoogle =
    await AuthGoogle(fileJson: "assets/NewAgent-81fafa8cda2c.json").build();
    Dialogflow dialogFlow =
    Dialogflow(authGoogle: authGoogle, language: Language.english);
    AIResponse response = await dialogFlow.detectIntent(query);
    Message message = Message(
      text: response.getMessage() ??
        CardDialogflow(response.getListMessage()[0]).title,
      sender: james,
      time: '5:30 PM',
      //text: 'Hey, how\'s it going? What did you do today?',
      isLiked: false,
      unread: true,
    );
    messageList.insert(0, message);
    /*
    setState(() {
      messageList.insert(0, message);
    });*/
  }
/*
  void _submitQuery(String text) {
    _textController.clear();
    Message message = new Message(
      text: text,
      sender: james,
      time: '5:30 PM',
      //text: 'Hey, how\'s it going? What did you do today?',
      isLiked: false,
      unread: true,
    );
    /*
    setState(() {
      messageList.insert(0, message);
    });*/
    messageList.insert(0, message);
    agentResponse(text);
  }*/
  /*
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Flutter Facts", style: TextStyle(color: Colors.green[400]),),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(children: <Widget>[
        Flexible(
          child: ListView.builder(
            padding: EdgeInsets.all(8.0),
            reverse: true, //To keep the latest messages at the bottom
            itemBuilder: (_, int index) => messageList[index],
            itemCount: messageList.length,
          )),
        _queryInputWidget(context),
      ]),
    );
  } */
}
*/

/* VERY IMP
 
  void agentResponse(query) async {
    _textController.clear();
    AuthGoogle authGoogle =
    await AuthGoogle(fileJson: "assets/the-watcher-tucjly-cdc5d593c043.json").build();
    Dialogflow dialogFlow =
    Dialogflow(authGoogle: authGoogle, language: Language.english);
    AIResponse response = await dialogFlow.detectIntent(query);
    Facts message = Facts(
      text: response.getMessage() ??
          CardDialogflow(response.getListMessage()[0]).title,
      name: "Flutter",
      type: false,
    );
    setState(() {
      messageList.insert(0, message);
    });
  }

  void _submitQuery(String text) {
    _textController.clear();
    Facts message = new Facts(
      text: text,
      name: "User",
      type: true,
    );
    setState(() {
      messageList.insert(0, message);
    });
    agentResponse(text);
  }

 */



/*MAYBE WASTE
  Dialogflow dialogflow = Dialogflow(token: "Your Token");
  AIResponse response = await dialogflow.sendQuery("Your Query");
  */


  /* BETTER
  AuthGoogle authGoogle = await AuthGoogle(fileJson: "assets/").build(); 
Dialogflow dialogFlow =
Dialogflow(authGoogle: authGoogle, language: Language.english);
AIResponse response = await dialogFlow.detectIntent(query);
   */