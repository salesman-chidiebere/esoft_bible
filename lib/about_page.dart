import 'package:flutter/material.dart';

class AboutPage extends StatefulWidget {
  @override
  _AboutPageState createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About'),
        backgroundColor: Color(0xFF5D1AB2),
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: <Widget>[
                Text(
                  'Holy Bible',
                  style: Theme.of(context).textTheme.headline5,
                ),
                Text(
                  '\nThis application contains offline text for the Holy Bible'
                      'in English and other translations. \n\n'
                      'The Application is free for all, and contains no adverts.'
                      'We neither collect nor store any of your data.'
                      '\n\n'
                      'If you have any queries, please contact us at '
                      'info@esoftresponse.com. '
                      '\n\n'
                      '\u00a9 2022 - ${DateTime.now().year} eSoft Response',
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
