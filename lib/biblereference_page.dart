import 'package:esoft_bible/chapter_page.dart';
import 'package:flutter/material.dart';

class BibleReference extends StatefulWidget {
  const BibleReference({Key key}) : super(key: key);

  @override
  _BibleReferenceState createState() => _BibleReferenceState();
}

class _BibleReferenceState extends State<BibleReference> {
  @override

  int selectedTab = 1;

  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 20,),
                Row(
                  children: [
                    SizedBox(width: 20,),
                    GestureDetector(
                      onTap: Navigator.of(context).pop,
                        child: Icon(Icons.arrow_back, color: Color(0xFF5D1AB2))),
                    SizedBox(width: 20,),
                    Text("References",
                      style: TextStyle(
                        fontSize: 20,
                        color: Color(0xFF5D1AB2)
                      ),
                    )
                  ],
                ),
                Divider(height: 40, thickness: 0.8,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      onTap: (){
                        setState(() {
                          selectedTab = 1;
                        });
                      },
                      child: Text("Books",
                        style: TextStyle(
                            fontSize: 20,
                            color: selectedTab == 1 ? Color(0xFF5D1AB2) : Color(0xFFB698DD)
                        ),
                      ),
                    ),
                    GestureDetector(
                        onTap: (){
                          setState(() {
                            selectedTab = 2;
                          });
                        },
                      child: Text("Chapter",
                        style: TextStyle(
                            fontSize: 20,
                            color: selectedTab == 2 ? Color(0xFF5D1AB2) : Color(0xFFB698DD)
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: (){
                        setState(() {
                          selectedTab = 3;
                        });
                      },
                      child: Text("Verses",
                        style: TextStyle(
                            fontSize: 20,
                            color: selectedTab == 3 ? Color(0xFF5D1AB2) : Color(0xFFB698DD)
                        ),
                      ),
                    ),
                  ],
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
