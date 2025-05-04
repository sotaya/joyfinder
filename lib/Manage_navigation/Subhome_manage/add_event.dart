import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gradient_app_bar/flutter_gradient_app_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:joyfinder/Manage_navigation/navi_manage.dart';

//イベント追加画面用Widget
class AddEvent extends StatefulWidget {
  AddEvent(this.user);
  final User user;
  @override
  _AddEventState createState() => _AddEventState(user);
}

class _AddEventState extends State<AddEvent> {
  String Event_Name = '';
  String Event_Contents = '';
  String Event_Spot = '';
  String Event_Day = '';
  String Event_Ticket = '';
  String Event_Num = '';
  String Event_Careful = '';
  String infoText = '';
  TextEditingController _DateController = TextEditingController();
  File? _backgroundImage = null;

  _AddEventState(this.user);
  final User user;
  Future<void> _pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _backgroundImage = File(pickedFile.path);
      });
    }
  }

  Map<String, dynamic> eventData = {};

  void addEventID(eventData) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    try {
      await firestore
          .collection('data')
          .doc(user.email!)
          .collection('events')
          .add(eventData);
      await firestore.collection('events').add(eventData);
    } catch (error) {
      setState(() {
        infoText = 'もう一度やり直してください';
      });
    }
  }

  Future<void> uploadImageAndSaveEvent() async {
    try {
      String fileName = _backgroundImage!.path.split('/').last;
      Reference storageRef =
          FirebaseStorage.instance.ref().child('event_images/$fileName');
      UploadTask uploadTask = storageRef.putFile(_backgroundImage!);
      TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => null);
      String imageUrl = await taskSnapshot.ref.getDownloadURL();
      eventData = {
        'event_image': imageUrl,
        'event_name': Event_Name,
        'event_contents': Event_Contents,
        'event_spot': Event_Spot,
        'event_day': Event_Day,
        'event_ticket': Event_Ticket,
        'event_num': Event_Num
      };
      addEventID(eventData);
    } catch (error) {
      setState(() {
        infoText = 'もう一度やり直してください';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: GradientAppBar(
              leading: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.arrow_back)),
              title: Center(
                  child: Text(
                '新規イベント作成',
                style: GoogleFonts.abyssinicaSil(color: Colors.black),
              )),
              gradient:
                  LinearGradient(colors: [Colors.greenAccent, Colors.yellow]),
            ),
            body: Padding(
                padding: const EdgeInsets.all(16),
                child: Form(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        GestureDetector(
                          onTap: _pickImage,
                          child: Container(
                            width: 250,
                            height: 150,
                            decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.circular(10),
                              image: _backgroundImage != null
                                  ? DecorationImage(
                                      image: FileImage(_backgroundImage!),
                                      fit: BoxFit.cover,
                                    )
                                  : null,
                            ),
                            child: _backgroundImage == null
                                ? Icon(
                                    Icons.camera_alt,
                                    size: 50,
                                    color: Colors.white,
                                  )
                                : null,
                          ),
                        ),
                        SizedBox(height: 16),
                        Text(
                          'イベント画像をタップして変更',
                          style: TextStyle(fontSize: 16),
                        ),
                        SizedBox(height: 16),
                        TextField(
                          decoration: InputDecoration(
                            labelText: 'イベント名',
                            border: OutlineInputBorder(),
                          ),
                          onChanged: (String value) {
                            setState(() {
                              Event_Name = value;
                            });
                          },
                        ),
                        SizedBox(height: 16.0),
                        TextFormField(
                          maxLines: 5,
                          decoration: InputDecoration(
                            labelText: '概要',
                            alignLabelWithHint: true,
                            border: OutlineInputBorder(),
                          ),
                          onChanged: (String value) {
                            setState(() {
                              Event_Contents = value;
                            });
                          },
                        ),
                        SizedBox(height: 16.0),
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: '開催場所',
                            border: OutlineInputBorder(),
                          ),
                          onChanged: (String value) {
                            setState(() {
                              Event_Spot = value;
                            });
                          },
                        ),
                        SizedBox(height: 16.0),
                        TextField(
                          controller: _DateController,
                          decoration: InputDecoration(
                            labelText: '開催日',
                            border: OutlineInputBorder(),
                          ),
                          onTap: () async {
                            final DateTime? pickedDate = await showDatePicker(
                              locale: const Locale("ja"),
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime.now(),
                              lastDate: DateTime(2101),
                            );

                            if (pickedDate != null) {
                              Event_Day =
                                  "${pickedDate.year}/${pickedDate.month}/${pickedDate.day}";
                              setState(() {
                                _DateController.text = Event_Day;
                              });
                            }
                          },
                        ),
                        SizedBox(height: 16.0),
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: 'チケット金額（0円の場合は無料）',
                            border: OutlineInputBorder(),
                          ),
                          keyboardType: TextInputType.number,
                          onChanged: (String value) {
                            setState(() {
                              Event_Ticket = value;
                            });
                          },
                        ),
                        SizedBox(height: 16.0),
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: '枚数（定員）',
                            border: OutlineInputBorder(),
                          ),
                          keyboardType: TextInputType.number,
                          onChanged: (String value) {
                            setState(() {
                              Event_Num = value;
                            });
                          },
                        ),
                        SizedBox(height: 16.0),
                        TextFormField(
                          maxLines: 3,
                          decoration: InputDecoration(
                            labelText: 'その他注意事項',
                            alignLabelWithHint: true,
                            border: OutlineInputBorder(),
                          ),
                          onChanged: (String value) {
                            setState(() {
                              Event_Careful = value;
                            });
                          },
                        ),
                        SizedBox(height: 16.0),
                        Container(
                          padding: EdgeInsets.all(8),
                          child: Text(
                            infoText,
                            style: TextStyle(color: Colors.red),
                          ),
                        ),
                        ElevatedButton(
                            onPressed: () {
                              if (_backgroundImage != null &&
                                  Event_Name.isNotEmpty &&
                                  Event_Contents.isNotEmpty &&
                                  Event_Spot.isNotEmpty &&
                                  Event_Day.isNotEmpty &&
                                  Event_Ticket.isNotEmpty &&
                                  Event_Num.isNotEmpty &&
                                  Event_Careful.isNotEmpty) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          HomePage_manage(user)),
                                );
                              } else {
                                setState(() {
                                  infoText = '登録に不備があります';
                                });
                              }
                            },
                            child: Text('作成'))
                      ],
                    ),
                  ),
                ))));
  }
}
