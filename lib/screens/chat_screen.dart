import 'package:flutter/material.dart';
//import 'dialogflow.dart';
import 'dart:async';
import '../models/message_model.dart';
import 'package:flutter_dialogflow_v2/flutter_dialogflow.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final GlobalKey<AnimatedListState> _listKey = GlobalKey();

  TextEditingController _controller;
  ScrollController _listScrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _controller = new TextEditingController();
  }

  _buildMessage(Message message, bool isMe,Animation animation) {
    return SizeTransition(
      sizeFactor: animation,
      child:Container(
      margin: isMe
          ? EdgeInsets.only(top: 8, bottom: 8, right: 30, left: 250)
          : EdgeInsets.only(top: 8, bottom: 8, right: 200, left: 30),
      padding: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
      decoration: BoxDecoration(
          color:
              isMe ? Color(0xff7b38d5) : Color(0xffe3ebeb), //TODO: or #d4dbdb
          borderRadius: isMe
              ? BorderRadius.only(
                  topLeft: Radius.circular(15),
                  topRight: Radius.circular(15),
                  bottomLeft: Radius.circular(15))
              : BorderRadius.only(
                  topLeft: Radius.circular(15),
                  topRight: Radius.circular(15),
                  bottomRight: Radius.circular(15))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          /*TIME
          Text(
            message.time,
            style: TextStyle(
                color: isMe ? Colors.white : Colors.black, fontSize: 15),
          ),
          SizedBox(
            height: 5,
          ),*/
          Text(
            message.text,
            style: TextStyle(
                color: isMe ? Colors.white : Colors.black, fontSize: 18),
          ),
          SizedBox(
            height: 5,
          ),
        ],
      ),
    ),);
  }

  _buildMessageComposer() {
    String messageValue;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8),
      height: 70,
      color: Colors.white,
      child: Row(
        children: <Widget>[
          Expanded(
            child: TextField(
              textCapitalization: TextCapitalization.sentences,
              onChanged: (value) {
                messageValue = value;
              },
              decoration:
                  InputDecoration.collapsed(hintText: "Enter your query"),
              controller: _controller,
            ),
          ),
          IconButton(
            icon: Icon(Icons.send),
            iconSize: 25,
            color: Color(0xff7340dc),
            onPressed: () {

                messages.insert(
                  0,
                  Message(
                    sender: currentUser,
                    time: '5:30 PM',
                    text: '$messageValue',
                    isLiked: false,
                    unread: true,
                  ),
                );
                                _listKey.currentState.insertItem(
                  messages.length-1,
                  duration: Duration(milliseconds: 200),
                );
                agentResponse(messageValue);
                print('agentresp ${messages.length}');
//                _listKey.currentState.insertItem(
//                  messages.length-1,
//                  duration: Duration(milliseconds: 200),
//                );

                Timer(
                  Duration(milliseconds: 220),
                    () {
                    _listScrollController.animateTo(
                      _listScrollController.position.minScrollExtent,
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.ease,
                    );
                  },
                );

              _controller.clear();
            },
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          //TODO: Center 'Watcher' title vertically or delete
          preferredSize: Size.fromHeight(70.0),
          child: AppBar(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(20),
            )),
            centerTitle: true,
            title: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 15,
                ),
                Text(
                  "watcher",
                  style: TextStyle(
                    fontSize: 30,
                    //TODO: Change font family
                    //fontWeight: FontWeight.bold,
                    color: Colors.white,
                    letterSpacing: 5,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            flexibleSpace: Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: <Color>[
                    Color(0xff7340dc),
                    Color(0xffa838e4),
                  ])),
            ),
          ),
        ),
        body: Column(
          children: <Widget>[
            Expanded(
              child: Container(
                color: Colors.white,

                child: AnimatedList(
                  // Give the Animated list the global key
                  key: _listKey,
                  reverse: true,
                  controller: _listScrollController,
                  initialItemCount: messages.length,
                  // Similar to ListView itemBuilder, but AnimatedList has
                  // an additional animation parameter.
                  itemBuilder: (context, index, animation) {
                    print('in list ${messages.length}');
                    print('index ${index}');
                    final Message message = messages[index];
                    final bool isMe = message.sender.id == currentUser.id;
                    // Breaking the row widget out as a method so that we can
                    // share it with the _removeSingleItem() method.
                    return _buildMessage(message, isMe, animation);
                  },
                ),

                /*
                child: ListView.builder(
                  reverse: true,
                  itemCount: messages.length,
                  itemBuilder: (BuildContext context, int index) {
                    final Message message = messages[index];
                    final bool isMe = message.sender.id == currentUser.id;
                    return _buildMessage(message, isMe);
                  },
                ),*/
              ),
            ),
            _buildMessageComposer(),
          ],
        ));
  }

  void agentResponse(query) async {
    //_textController.clear();
    print('agent response $query');
    try {
    AuthGoogle authGoogle =
    await AuthGoogle(fileJson: "assets/the-watcher-tucjly-9b525f334c3a.json").build();
    print(authGoogle.toString());
    Dialogflow dialogFlow =
    Dialogflow(authGoogle: authGoogle, language: Language.english);
    AIResponse response = await dialogFlow.detectIntentFromText(query);
    print(response.toString());
    Message message = Message(
      text: response.getMessage() ??
        CardDialogflow(response.getListMessage()[0]).title,
      sender: james,
      time: '5:30 PM',
      //text: 'Hey, how\'s it going? What did you do today?',
      isLiked: false,
      unread: true,
    );
    //messages.insert(0, message);
    print(message);

      messages.insert(0, message);
      print(messages.length);
    _listKey.currentState.insertItem(
      messages.length-1,
      duration: Duration(milliseconds: 200),);


    }
    catch (error, trace){
      print(error);
      print(trace);
    }


  }

//
//  Widget _buildItem(Message item, Animation animation) {
//    return SizeTransition(
//      sizeFactor: animation,
//      child: Card(
//        child: ListTile(
//          title: Text(
//            item.text,
//            style: TextStyle(fontSize: 20),
//          ),
//        ),
//      ),
//    );
//  }
}
