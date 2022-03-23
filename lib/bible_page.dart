import 'package:esoft_bible/biblereference_page.dart';
import 'package:flutter/material.dart';

class BiblePage extends StatefulWidget {
  const BiblePage({Key key}) : super(key: key);

  @override
  _BiblePageState createState() => _BiblePageState();
}

class _BiblePageState extends State<BiblePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context)
                        => BibleReference())),
                      child: Container(
                        width: MediaQuery.of(context).size.width / 1.8,
                        decoration: BoxDecoration(
                          color: Color(0xFFEDE5F7),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(18),
                            bottomLeft: Radius.circular(18),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(14.0),
                          child: Text("Genesis 1"),
                        ),
                      ),
                    ),
                    SizedBox(width: 5,),
                    Container(
                      width: MediaQuery.of(context).size.width / 3.3,
                      decoration: BoxDecoration(
                        color: Color(0xFFEDE5F7),
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(18),
                          bottomRight: Radius.circular(18),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(14.0),
                        child: Text("ESV"),
                      ),
                    )
                  ],
                ),
                Divider(height: 40, thickness: 1,),
                Container(
                  height: MediaQuery.of(context).size.height / 1.33,
                ),
                Container(
                  height: 60,
                  alignment: Alignment(0.0, -1.0),
                  decoration: BoxDecoration(
                    color: Color(0xFF5D1AB2),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(18),
                      topRight: Radius.circular(18),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Back to App",
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        decoration: TextDecoration.underline,
                      ),),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(bottom: 40.0, left: 40, right: 10),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                FloatingActionButton(
                  backgroundColor: Colors.white,
                  child: Icon(
                      Icons.arrow_back_ios,
                    color: Color(0xFF5D1AB2),
                  ),
                  onPressed: () {
                    //...
                  },
                  heroTag: null,
                ),
                SizedBox(
                  height: 10,
                ),
                FloatingActionButton(
                  backgroundColor: Colors.white,
                  child: Icon(
                      Icons.arrow_forward_ios,
                    color: Color(0xFF5D1AB2),
                  ),
                  onPressed: null,
                  heroTag: null,
                )
              ]
          ),
        )
    );
  }
}
