import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mentor_mate/globals.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final FirebaseAuth auth = FirebaseAuth.instance;
Map<String, dynamic>? userMap;

String chatRoomId(String user1, String user2) {
  if (user1[0].toLowerCase().codeUnits[0] > user2.toLowerCase().codeUnits[0]) {
    return "$user1$user2";
  } else {
    return "$user2$user1";
  }
}

String roomId = chatRoomId(auth.currentUser!.displayName!, userMap?['name']);

void getUser() async {
  _firestore.collection("users").doc(auth.currentUser!.uid).get().then((value) {
    print(value.data());
    print(value.data()!['name']);
    currentUser = value.data()!['name'];
  });
}

void onSendMessage() async {
  var user;
  await _firestore
      .collection("users")
      .doc(auth.currentUser!.uid)
      .get()
      .then((value) {
    print(value.data());
    print(value.data()!['name']);
    currentUser = value.data()!['name'];
    user = value.data();
  });

  if (message.text.isNotEmpty || messageTitle.text.isNotEmpty) {
    print(message.text);
    final DateTime now = DateTime.now();
    print('this is user data inside doubts----------------------------------');
    print(user['name']);
    if (message.text.isNotEmpty) {
      type = 'message';
    } else if (messageTitle.text.isNotEmpty) {
      type = 'doubt';
    }

    Map<String, dynamic> messages = {
      "sendby": user['role'].toString(),
      'to': to,
      'type': type,
      'description': messageDescription.text,
      'solved': false,
      "message": message.text,
      'title': messageTitle.text,
      "time": '${now.hour} : ${now.minute}',
      'name': user['name'].toString(),
      'studentKey':
          '${user['year']} ${user['branch']} ${user['div']} ${user['roll']}'
    };
    message.clear();
    messageTitle.clear();
    messageDescription.clear();
    if (type == 'doubt') {
      addDoubts(messages);
    }

    type = null;

    await _firestore
        .collection('chatroom')
        .doc(roomId)
        .collection('chats')
        .doc(roomId)
        .collection('doubts')
        .add(messages);
  } else {
    print('Enter Some Text');
  }
}

void addDoubts(Map<String, dynamic> doubtmessage) async {
  await _firestore.collection('doubts').add(doubtmessage);
}
