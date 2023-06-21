import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travel_app/component/Social.dart';

class SocialView extends StatefulWidget {
  const SocialView({Key? key}) : super(key: key);

  @override
  State<SocialView> createState() => _SocialViewState();
}

class _SocialViewState extends State<SocialView> {
  late FirebaseFirestore firestore;
  CollectionReference commentsCollection = FirebaseFirestore.instance.collection('Social');
  late SharedPreferences prefs;
  bool isLogged = false;
  String textVal = "";
  String userName = "";

  var _controller = TextEditingController();

  Future getPrefs() async {
    prefs = await SharedPreferences.getInstance();

    setState(() {
      isLogged = prefs.getBool('isLogged') ?? false;
      userName = prefs.getString('name') ?? '';
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPrefs();
  }

  void addComment(String comment) {
    _controller.clear();
    commentsCollection.add({
      'comment': textVal,
      'name': userName,
      'tarih': FieldValue.serverTimestamp()
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tartışma'),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8)
              ),
              child: Padding(
                padding: const EdgeInsets.all(11.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 9,
                      child: Column(
                        children: [
                          Container(
                            constraints: BoxConstraints(maxHeight: 100),
                            child: TextField(
                              controller: _controller,
                              onChanged: (value) {
                                textVal = value;
                              },
                              keyboardType: TextInputType.multiline,
                              maxLines: null,
                              enabled: isLogged,
                              decoration: InputDecoration(
                                fillColor: Colors.white,
                                filled: true,
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.green),
                                ),
                                hintText: 'yorum yaz...',
                              ),
                            ),
                          ),
                          Container(
                            width: double.infinity,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: Theme.of(context).primaryColor,
                              ),
                              child: Text('Gönder'),
                              onPressed:
                              isLogged ? () => addComment('comment') : null,
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
          SizedBox(
            height: 15,
          ),
          StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('Social')
                .orderBy('tarih', descending: true)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<DocumentSnapshot> items = snapshot.data!.docs;

                return Flexible(
                  child: ListView.separated(
                    separatorBuilder: (context, index){
                      return Divider(color: Colors.grey,);
                    },
                    itemCount: items.length,
                    itemBuilder: (context, index) {
                      Timestamp timestamp = items[index]['tarih'] ?? Timestamp.now();
                      var timeToNormal = DateTime.fromMicrosecondsSinceEpoch(timestamp == null ? DateTime.now().microsecondsSinceEpoch : timestamp.microsecondsSinceEpoch);
                      return Column(
                        children: [
                          Social(
                            userName: items[index]['name'],
                            comment: items[index]['comment'],
                            time: timeToNormal,
                          ),
                        ],
                      );
                    },
                  ),
                );
              } else {
                return CircularProgressIndicator();
              }
            },
          )
        ],
      ),
    );
  }
}
