import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:joyfinder/LoginPage/regist.dart';
import 'package:joyfinder/Manage_navigation/navi_manage.dart';
import 'package:joyfinder/Participate_navigation/navi_partici.dart';

//アカウント設定画面用Widget
class AccountPage extends StatefulWidget {
  AccountPage(this.email, this.password);
  final String email;
  final String password;
  @override
  _AccountPageState createState() => _AccountPageState(email, password);
}

enum GenderList { men, woman, other }

enum ObjectiveList { participant, manager }

class _AccountPageState extends State<AccountPage> {
  // メールアドレス・パスワード
  _AccountPageState(this.email, this.password);
  String email;
  String password;

  @override
  void initState() {
    super.initState();
    main();
  }

  // 設定済みアカウント取得
  var Datalist = [];
  Future<void> main() async {
    final querySnapshot =
        await FirebaseFirestore.instance.collection('data').get();
    for (var postDoc in querySnapshot.docs) {
      Datalist.add(postDoc.get('account'));
    }
  }

  // メッセージ表示用
  String infoText = '';
  // 入力したアカウント
  String account = '';
  // 入力した年齢
  String? age = '20歳';
  // 入力した性別
  GenderList genders = GenderList.men;
  // 選択した使用目的
  ObjectiveList objectives = ObjectiveList.participant;
  // アカウント変更
  bool pass = true;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Center(
        child: Column(children: <Widget>[
          Expanded(
            child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.greenAccent, Colors.yellow],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                padding: EdgeInsets.all(24),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text('JoyFinder',
                          style: GoogleFonts.abyssinicaSil(
                              textStyle: TextStyle(
                                  color: Colors.white, fontSize: 40))),
                      Container(
                        padding: EdgeInsets.all(10),
                      ),
                      TextFormField(
                        decoration: InputDecoration(labelText: 'アカウント名'),
                        onChanged: (String value) {
                          setState(() {
                            account = value;
                          });
                        },
                      ),
                      Container(
                        padding: EdgeInsets.all(8),
                      ),
                      ListTile(
                        title: Text('男性'),
                        leading: Radio(
                          value: GenderList.men,
                          groupValue: genders,
                          onChanged: (value) {
                            setState(() {
                              genders = value!;
                            });
                          },
                        ),
                      ),
                      ListTile(
                        title: Text('女性'),
                        leading: Radio(
                          value: GenderList.woman,
                          groupValue: genders,
                          onChanged: (value) {
                            setState(() {
                              genders = value!;
                            });
                          },
                        ),
                      ),
                      ListTile(
                        title: Text('その他'),
                        leading: Radio(
                          value: GenderList.other,
                          groupValue: genders,
                          onChanged: (value) {
                            setState(() {
                              genders = value!;
                            });
                          },
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(8),
                      ),
                      ListBody(children: [
                        DropdownButton(
                          items: List.generate(100, (index) {
                            return DropdownMenuItem(
                              child: Text('${index + 1}歳'),
                              value: '${index + 1}歳',
                            );
                          }),
                          onChanged: (String? value) {
                            setState(() {
                              age = value;
                            });
                          },
                          //7
                          value: age,
                        ),
                      ]),
                      Container(
                        padding: EdgeInsets.all(8),
                      ),
                      Text(
                        'イベントの関わり方',
                        style: TextStyle(color: Colors.black),
                      ),
                      ListTile(
                        title: Text('参加者'),
                        leading: Radio(
                          value: ObjectiveList.participant,
                          groupValue: objectives,
                          onChanged: (value) {
                            setState(() {
                              objectives = value!;
                            });
                          },
                        ),
                      ),
                      ListTile(
                        title: Text('運営者'),
                        leading: Radio(
                          value: ObjectiveList.manager,
                          groupValue: objectives,
                          onChanged: (value) {
                            setState(() {
                              objectives = value!;
                            });
                          },
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(8),
                        // メッセージ表示
                        child: Text(
                          infoText,
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        // ユーザー登録ボタン
                        child: ElevatedButton(
                            child: Text('ユーザー登録'),
                            style: TextButton.styleFrom(
                                backgroundColor: Colors.blue[400],
                                foregroundColor: Colors.white),
                            onPressed: () async {
                              if (account.isNotEmpty) {
                                if (Datalist.contains(account)) {
                                  setState(() {
                                    infoText = "アカウント名が既に存在します";
                                  });
                                } else {
                                  String gender;
                                  String objective;
                                  switch (genders) {
                                    case GenderList.men:
                                      gender = '男性';
                                      break;
                                    case GenderList.woman:
                                      gender = '女性';
                                      break;
                                    case GenderList.other:
                                      gender = 'その他';
                                      break;
                                  }
                                  switch (objectives) {
                                    case ObjectiveList.participant:
                                      objective = '参加者';
                                      break;
                                    case ObjectiveList.manager:
                                      objective = '運営者';
                                      break;
                                  }
                                  await FirebaseFirestore.instance
                                      .collection('data')
                                      .doc(email)
                                      .set({
                                    'account': account,
                                    'age': age,
                                    'gender': gender,
                                    'objective': objective
                                  });
                                  try {
                                    // メール/パスワードでユーザー登録
                                    final FirebaseAuth auth =
                                        FirebaseAuth.instance;
                                    final result = await auth
                                        .createUserWithEmailAndPassword(
                                      email: email,
                                      password: password,
                                    );
                                    if (objective == '参加者') {
                                      // ユーザー登録に成功した場合
                                      // チャット画面に遷移＋ログイン画面を破棄
                                      await Navigator.of(context)
                                          .pushReplacement(
                                        MaterialPageRoute(builder: (context) {
                                          return HomePage_partici(result.user!);
                                        }),
                                      );
                                    } else {
                                      await Navigator.of(context)
                                          .pushReplacement(
                                        MaterialPageRoute(builder: (context) {
                                          return HomePage_manage(result.user!);
                                        }),
                                      );
                                    }
                                  } catch (e) {
                                    setState(() async {
                                      infoText = "登録に失敗しました";
                                      await Navigator.of(context)
                                          .pushReplacement(
                                        MaterialPageRoute(builder: (context) {
                                          return RegistPage();
                                        }),
                                      );
                                    });
                                  }
                                }
                              } else {
                                setState(() {
                                  infoText = "アカウントを設定してください";
                                });
                              }
                            }),
                      ),
                      Container(
                        // ユーザー登録ボタン
                        child: TextButton(
                          child: Text(
                            '戻る',
                            style: TextStyle(color: Colors.black),
                          ),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => RegistPage()));
                          },
                        ),
                      )
                    ],
                  ),
                )),
          )
        ]),
      ),
    ));
  }
}
