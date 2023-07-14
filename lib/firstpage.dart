import 'dart:convert';
import 'dart:math';

import 'package:confetti/confetti.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_custom_cards/flutter_custom_cards.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:just_audio/just_audio.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';

class fii extends StatefulWidget {
  const fii({Key? key}) : super(key: key);

  @override
  State<fii> createState() => _fiiState();
}

class _fiiState extends State<fii> with WidgetsBindingObserver {
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // TODO: implement didChangeAppLifecycleState
    super.didChangeAppLifecycleState(state);

    if (state == AppLifecycleState.paused) {
      pausemusic();
    }
    if (state == AppLifecycleState.resumed) {
      playmusic();
    }
    print("${state}---------------------");
    // WidgetsBinding.instance.addObserver(this);
  }

  List answer = [];
  List bottom = [];
  List picture = [];
  List abcd = [];
  List swap = [];

  List temp = [];
  int i = 0;

  List<Color> fi = [];
  List<Color> sec = [];
  List<Color> thh = [];
  Map map = {};
  List<Color> errorcolor = [];
  String spelling = "";

  ///////////////////

  List someImages = [];
  String imagepath = "";
  List<String> spel = [];
  List move = [];
  Map mapp = {};
  bool staus = false;
  ConfettiController conn = ConfettiController();
  final FlutterTts flutterTts = FlutterTts();
  final player = AudioPlayer();
  bool volume = true;
  SharedPreferences? prefe;
  int coin = 0;

  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _initImages();
    conn = ConfettiController(duration: Duration(seconds: 1));
    loadmusic();
    playmusic();
    sharedprefe();

    // getlist();
  }

  void dispose() {
    // TODO: implement dispose
    super.dispose();

    WidgetsBinding.instance.removeObserver(this);
    pausemusic();
  }

  getlist() {
    setState(() {
      // abcd = ['a','b','c','d','e','f','g','h','i','j','k','l','m', 'n', 'o','p'];

      staus = false;

      fi = List.filled(10, Colors.white54);
      sec = List.filled(10, Colors.blueGrey.shade300);
      thh = List.filled(10, Colors.white54);
      swap = List.filled(spel.length, "");
      print("swappppppppppppppppp$swap");
      String abcddata = "abcdefghijklmnopqrstuvwxyz";
      List<String> abcd = abcddata.split("");
      abcd.shuffle(Random());

      temp = [];

      errorcolor = List.filled(
        swap.length,
        Color(0Xff181D31),
      );

      // bottom.add(answer);

      for (int i = 0; i < spel.length; i++) {
        bottom.add(spel[i]);
        temp.add(spel[i]);
      }
      for (int i = spel.length; i < 10; i++) {
        temp.add(abcd[i]);
      }
      print("llllllllllllll$bottom");
      print("llllllxxxxxxllllllll$temp");
      temp.shuffle(Random());

      speakletter(spelling);
    });
  }

  speak(String text) async {
    await flutterTts.setLanguage("en-US");
    await flutterTts.setPitch(1);
    await flutterTts.speak(text);
  }

  speakletter(String text) async {
    await flutterTts.setLanguage("en-US");
    await flutterTts.setPitch(1);
    await flutterTts.speak(text);
  }

  loadmusic() async {
    await player.setAsset("music/mphp.mp3");
    await player.setLoopMode(LoopMode.one);
  }

  playmusic() async {
    await player.play();
  }

  stopmusic() async {
    await player.stop();
  }

  pausemusic() async {
    await player.pause();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(
                    "imagee/BACKGROUND.png",
                  ),
                  fit: BoxFit.fill)),
          child: Column(children: [
            Container(
              child: ConfettiWidget(
                confettiController: conn,
                blastDirection: pi / 2,
                maxBlastForce: 5,
                minBlastForce: 1,
                emissionFrequency: 0.03,
                blastDirectionality: BlastDirectionality.directional,

                // 10 paticles will pop-up at a time
                numberOfParticles: 50,

                // particles will pop-up
                gravity: 0.1,
              ),
            ),
            volume
                ? Container(
                    margin: EdgeInsets.fromLTRB(40, 0, 0, 0),
                    child: IconButton(
                        onPressed: () {
                          setState(() {
                            volume = false;
                            stopmusic();
                          });
                        },
                        icon: Icon(
                          Icons.volume_up,
                          color: Colors.white,
                          size: 38,
                        )),
                  )
                : Container(
                    margin: EdgeInsets.fromLTRB(40, 0, 0, 0),
                    child: IconButton(
                        onPressed: () {
                          setState(() {
                            volume = true;
                            playmusic();
                          });
                        },
                        icon: Icon(Icons.volume_off,
                            color: Colors.white, size: 38)),
                  ),
            Container(
                margin: EdgeInsets.fromLTRB(90, 40, 90, 0),
                child: CustomCard(
                  height: 250,
                  borderRadius: 25,
                  elevation: 60,
                  borderWidth: 5,
                  borderColor: Colors.blueGrey,
                  child: imagepath != ""
                      ? Image(image: AssetImage(imagepath), fit: BoxFit.fill)
                      : Container(),
                )),
            SizedBox(
              height: 40,
            ),
            Expanded(
              child: Center(
                child: Container(
                  margin: EdgeInsets.fromLTRB(20, 10, 20, 0),
                  child: GridView.builder(
                    physics: BouncingScrollPhysics(),

                    // padding: EdgeInsets.symmetric(vertical: 35),
                    // shrinkWrap: true,
                    //shrinkWrap: true,
                    itemCount: swap.length,

                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: swap.length,
                        mainAxisExtent: 80,
                        crossAxisSpacing: 6),
                    itemBuilder: (context, index) {
                      // answer=picture[0].toString().split('');

                      return Container(
                        // margin: EdgeInsets.all(2),
                        decoration: BoxDecoration(
                            color: Color(0Xff181D31),
                            border: Border.all(
                              color: Colors.blueGrey,
                              width: 3,
                            ),
                            boxShadow: [
                              BoxShadow(color: Colors.blueGrey, blurRadius: 10)
                            ],
                            borderRadius: BorderRadius.circular(18)),
                        child: CustomCard(
                          onTap: () {
                            setState(() {
                              if (staus == false) {
                                if (swap[index] != "") {
                                  temp[mapp[index]] = swap[index];
                                  swap[index] = "";
                                  fi[mapp[index]] = Colors.white54;

                                  //errorcolor[i] = Colors.transparent;
                                  errorcolor[index] = Color(0Xff181D31);
                                }
                              } else {
                                // setState(() {
                                //   staus=false;
                                // });
                              }
                              print("length of spel${spel.length}");
                              print("indx$index");
                              // setState(() {
                              //   if(index+1==spel.length){
                              //
                              //     for(int i=0; i<=spel.length; i++){
                              //       if(spel[i]==swap[i]){
                              //         errorcolor[i]=Colors.green;
                              //       }
                              //     }
                              //   }
                              // });green
                            });
                          },
                          color: errorcolor[index],
                          elevation: 40,
                          child: Center(
                              child: Text("${swap[index]}",
                                  style: TextStyle(
                                      color: Colors.white70,
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold))),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
            SizedBox(height: 30),
            Container(
              margin: EdgeInsets.fromLTRB(20, 10, 20, 0),
              child: GridView.builder(
                shrinkWrap: true,
                //shrinkWrap: true,
                itemCount: 10,

                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 5),
                itemBuilder: (context, index) {
                  return Listener(
                    onPointerUp: (event) {
                      setState(() {
                        //fi[index] = thh[index];
                      });
                    },
                    onPointerDown: (event) {
                      setState(() {
                        //fi[index] = sec[index];
                      });
                    },
                    child: Container(
                      margin: EdgeInsets.all(6),
                      decoration: BoxDecoration(
                          color: Colors.white54,
                          borderRadius: BorderRadius.circular(10)),
                      child: CustomCard(
                        color: fi[index],
                        elevation: 60,
                        onTap: () {
                          setState(() {
                            print("bottttttttt${temp[index]}");
                            for (int i = 0; i <= spel.length; i++) {
                              if (swap[i] == "") {
                                setState(() {
                                  swap[i] = temp[index];
                                  temp[index] = "";
                                  mapp[i] = index;
                                  fi[index] = Colors.transparent;

                                  // {"0":5}
                                  // if (spel.toString() == swap.toString()) {
                                  //   setState(() {
                                  //     staus=true;
                                  //     errorcolor=List.filled(spel.length, Colors.green);
                                  //     conn.play();
                                  //
                                  //
                                  //   });
                                  //
                                  //   // Future.delayed(Duration(seconds: 1))
                                  //   //     .then((value) {
                                  //   //   //_initImages();
                                  //   //
                                  //   //
                                  //   //
                                  //   // });
                                  // }
                                  // else{
                                  print(
                                      'log : index ===> $index spel.length ==> ${spel.length}');
                                  if (!swap.contains('')) {
                                    if (listEquals(swap, spel)) {
                                      staus = true;
                                      errorcolor = List.filled(
                                          spel.length, Colors.green);
                                      pausemusic();
                                      conn.play();
                                      //pausemusic();

                                      speak("you are win");
                                      Future.delayed(Duration(seconds: 8))
                                          .then((value) {
                                        showDialog(
                                          context: context,
                                          builder: (context) {
                                            return Material(
                                              color: Colors.transparent,
                                              child: Container(
                                                height: 40,
                                                width: 60,
                                                margin: EdgeInsets.fromLTRB(120, 350, 140, 320),
                                                padding: EdgeInsets.all(20),
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                  color: Colors.blueGrey,
                                                ),
                                                child: Text("Next", style: TextStyle(fontSize: 27, color: Colors.white, )),
                                              ),
                                            );
                                          },
                                        );
                                      });
                                      //playmusic();

                                    } else {
                                      speak("sorry better luck next time");

                                      for (int j = 0; j <= spel.length; j++) {
                                        if (spel[j] == swap[j]) {
                                          errorcolor[j] = Colors.green;
                                        } else {
                                          errorcolor[j] = Colors.red;
                                        }
                                      }
                                    }
                                  }
                                  // }
                                });
                                print("sepl$spel");
                                print("swap$swap");

                                // if (spel[i] == swap[i]) {
                                //   errorcolor[i] = Colors.green;
                                // } else {
                                //   errorcolor[i] = Colors.red;
                                // }

                                break;
                              }
                            }
                          });
                        },
                        child: Center(
                            child: Text("${temp[index]}",
                                style: TextStyle(
                                    color: Color(0Xff181D31),
                                    fontSize: 35,
                                    fontWeight: FontWeight.bold))),
                      ),
                    ),
                  );
                },
              ),
            ),
            Row(
              children: [
                Container(
                  margin: EdgeInsets.fromLTRB(30, 15, 0, 0),
                  decoration: BoxDecoration(
                      color: Colors.white54,
                      borderRadius: BorderRadius.circular(10)),
                  child: CustomCard(
                      height: 60,
                      width: 60,
                      color: Colors.white54,
                      elevation: 60,
                      onTap: () {
                        setState(() {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return Material(
                                color: Colors.transparent,
                                child: Container(
                                  margin: EdgeInsets.fromLTRB(60, 90, 60, 200),
                                  //color: Colors.blueGrey,
                                  decoration: BoxDecoration(
                                    color: Colors.blueGrey.shade500,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Column(
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          setState(() {
                                            //coin=coin-100;
                                            prefe!.setInt("data", coin);
                                            showDialog(
                                              context: context,
                                              builder: (context) {
                                                return Material(
                                                  color: Colors.transparent,
                                                  child: Container(
                                                    height: 40,
                                                    width: 100,
                                                    margin: EdgeInsets.fromLTRB(
                                                        50, 200, 50, 500),
                                                    padding: EdgeInsets.all(20),
                                                    decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20)),
                                                    child: Text(
                                                        "Word is:   $spelling",
                                                        style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 27,
                                                        )),
                                                  ),
                                                );
                                              },
                                            );
                                          });
                                        },
                                        child: Container(
                                            margin: EdgeInsets.fromLTRB(
                                                10, 60, 10, 0),
                                            height: 100,
                                            width: 400,
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                border: Border.all(
                                                  color: Color(0Xff181D31),
                                                  width: 3,
                                                  style: BorderStyle.solid,
                                                )),
                                            child: Row(
                                              children: [
                                                Container(
                                                  margin: EdgeInsets.fromLTRB(
                                                      0, 20, 0, 25),
                                                  child: Text(
                                                    "SHOW WORD",
                                                    style: TextStyle(
                                                        color:
                                                            Color(0Xff181D31),
                                                        fontSize: 27),
                                                  ),
                                                ),
                                                Container(
                                                  // margin:
                                                  // EdgeInsets.fromLTRB(10, 0, 0, 10),
                                                  child: Image(
                                                    image: AssetImage(
                                                        "imagee/img_1.png"),
                                                    height: 45,
                                                    width: 45,
                                                  ),
                                                ),
                                                Container(
                                                  margin: EdgeInsets.fromLTRB(
                                                      0, 15, 10, 10),
                                                  child: Text(
                                                    "100",
                                                    style: TextStyle(
                                                        color:
                                                            Color(0Xff181D31),
                                                        fontSize: 24,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                              ],
                                            )),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          setState(() {
                                            //coin=coin-200;
                                            prefe!.setInt("data", coin);
                                            speak("${spelling}");
                                          });
                                        },
                                        child: Container(
                                            margin: EdgeInsets.fromLTRB(
                                                0, 20, 0, 0),
                                            height: 80,
                                            width: 280,
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                border: Border.all(
                                                  color: Color(0Xff181D31),
                                                  width: 3,
                                                  style: BorderStyle.solid,
                                                )),
                                            child: Row(
                                              children: [
                                                Container(
                                                  margin: EdgeInsets.fromLTRB(
                                                      0, 20, 0, 20),
                                                  child: Text(
                                                    "SPEAK LETTER",
                                                    style: TextStyle(
                                                        color:
                                                            Color(0Xff181D31),
                                                        fontSize: 25),
                                                  ),
                                                ),
                                                Container(
                                                  // margin:
                                                  // EdgeInsets.fromLTRB(10, 0, 0, 10),
                                                  child: Image(
                                                    image: AssetImage(
                                                        "imagee/img_1.png"),
                                                    height: 45,
                                                    width: 45,
                                                  ),
                                                ),
                                                Container(
                                                  margin: EdgeInsets.fromLTRB(
                                                      0, 15, 0, 10),
                                                  child: Text(
                                                    "200",
                                                    style: TextStyle(
                                                        color:
                                                            Color(0Xff181D31),
                                                        fontSize: 24,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                              ],
                                            )),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          //coin=coin-50;
                                          setState(() {
                                            prefe!.setInt("data", coin);
                                            speak(spel.toString());
                                          });
                                        },
                                        child: Container(
                                            margin: EdgeInsets.fromLTRB(
                                                10, 20, 10, 0),
                                            height: 80,
                                            width: 280,
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                border: Border.all(
                                                  color: Color(0Xff181D31),
                                                  width: 3,
                                                  style: BorderStyle.solid,
                                                )),
                                            child: Row(
                                              children: [
                                                Container(
                                                  margin: EdgeInsets.fromLTRB(
                                                      0, 20, 0, 25),
                                                  child: Text(
                                                    "SPEAK WORD",
                                                    style: TextStyle(
                                                        color:
                                                            Color(0Xff181D31),
                                                        fontSize: 27),
                                                  ),
                                                ),
                                                Container(
                                                  // margin:
                                                  // EdgeInsets.fromLTRB(10, 0, 0, 10),
                                                  child: Image(
                                                    image: AssetImage(
                                                        "imagee/img_1.png"),
                                                    height: 45,
                                                    width: 45,
                                                  ),
                                                ),
                                                Container(
                                                  margin: EdgeInsets.fromLTRB(
                                                      0, 15, 10, 10),
                                                  child: Text(
                                                    "50",
                                                    style: TextStyle(
                                                        color:
                                                            Color(0Xff181D31),
                                                        fontSize: 24,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                              ],
                                            )),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          Navigator.pop(context);
                                        },
                                        child: Container(
                                          margin: EdgeInsets.fromLTRB(
                                              10, 20, 10, 0),
                                          height: 80,
                                          width: 150,
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              border: Border.all(
                                                color: Color(0Xff181D31),
                                                width: 3,
                                                style: BorderStyle.solid,
                                              )),
                                          child: Row(children: [
                                            Container(
                                              margin: EdgeInsets.fromLTRB(
                                                  10, 20, 0, 20),
                                              child: Text(
                                                "BACK",
                                                style: TextStyle(
                                                    color: Color(0Xff181D31),
                                                    fontSize: 28),
                                              ),
                                            ),
                                            Container(
                                                margin: EdgeInsets.fromLTRB(
                                                    10, 20, 10, 28),
                                                child: Icon(
                                                  Icons.arrow_back,
                                                  size: 40,
                                                  color: Color(0Xff181D31),
                                                ))
                                          ]),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        });
                      },
                      child: Lottie.asset("animation/463.json")),
                ),
                Row(
                  children: [
                    Container(
                      margin: EdgeInsets.fromLTRB(40, 5, 0, 0),
                      child: Image(
                          image: AssetImage(
                              "imagee/icons8-dollar-coin-48-removebg-preview.png"),
                          width: 45,
                          height: 45),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(0, 5, 40, 0),
                      child: Text("$coin",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 30)),
                    )
                  ],
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(20, 15, 0, 0),
                  decoration: BoxDecoration(
                      color: Colors.white54,
                      borderRadius: BorderRadius.circular(10)),
                  child: CustomCard(
                      height: 60,
                      width: 60,
                      color: Colors.white54,
                      elevation: 60,
                      onTap: () {
                        setState(() {
                          // picture.shuffle(Random());
                          // temp.shuffle(Random());
                          _initImages();
                          getlist();
                        });
                      },
                      child: Lottie.asset("animation/93ld3ecUmA.json")),
                ),
              ],
            )
          ]),
        ),
      ),
    );
  }

  Future _initImages() async {
    // >> To get paths you need these 2 lines
    final manifestContent = await rootBundle.loadString('AssetManifest.json');

    final Map<String, dynamic> manifestMap = json.decode(manifestContent);
    // >> To get paths you need these 2 lines

    final imagePaths = manifestMap.keys
        .where((String key) => key.contains('images/'))
        .where((String key) => key.contains('.webp'))
        .toList();

    setState(() {
      someImages = imagePaths;
      print("someimages$someImages");
      int rr = Random().nextInt(someImages.length);
      imagepath = someImages[rr];
      print("imagepath$imagepath");
      spelling = imagepath.split("/")[1].split("\.")[0];
      print("============$spelling");

      spel = spelling.split("");
      print("//////////$spel");
    });
    // playmusic();
    getlist();
  }

  void win() {}

  Future<void> sharedprefe() async {
    prefe = await SharedPreferences.getInstance();
    coin = prefe!.getInt("data") ?? 500;
    // print("$aa");
  }
}
