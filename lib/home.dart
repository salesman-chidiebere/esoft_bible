import 'dart:io';
import 'package:esoft_bible/about_page.dart';
import 'package:esoft_bible/application.dart';
import 'package:esoft_bible/chapter_page.dart';
import 'package:esoft_bible/database.dart';
import 'package:esoft_bible/localization.dart';
import 'package:esoft_bible/models.dart';
import 'package:esoft_bible/read_page.dart';
import 'package:esoft_bible/settings_page.dart';
import 'package:esoft_bible/theme.dart';
import 'package:esoft_bible/widgets/books_widget.dart';
import 'package:esoft_bible/widgets/devotional_widget.dart';
import 'package:esoft_bible/widgets/notes_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  final int initialIndex;

  const HomePage({Key key, this.initialIndex}) : super(key: key);

  @override
  HomePageState createState() {
    return new HomePageState();
  }
}

class HomePageState extends State<HomePage> {
  bool searching = false;
  bool dark = false;
  SearchDelegate _searchDelegate;
  ThemeData theme = getAppTheme(theme: "blue");
  Book book;
  TabController tabController;

  int _bottomNavBarSelectedIndex;

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  void _onBottomNavBarItemTapped(int index) {
    setState(() {
      _bottomNavBarSelectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    theme = Theme.of(context);
    _searchDelegate = _MainSearchDelegate(_openBook, Theme.of(context));

    final _pageTitle = Text(AppLocalizations.of(context).text('app_title'));

    return Scaffold(
      key: _scaffoldKey,
      appBar: !Platform.isIOS
          ? AppBar(
              //title: _pageTitle,
              title: Row(
                children: [
                  Icon(Icons.apps),
                  SizedBox(width: 10,),
                  Text("Return to App")
                ],
              ),
              actions: <Widget>[
                _buildSearchAction(context),
                _buildTranslateMenu(context),
                _buildOverflowMenu(context),
              ],
              backgroundColor: Color(0xFF5D1AB2),
            )
          : CupertinoNavigationBar(
              middle: _pageTitle,
              leading: _buildTranslateMenu(context),
              trailing: _buildSearchAction(context),
            ),
      body: [
        this.book == null ? BooksWidget() : BooksWidget(book: this.book),
        DevotionalWidget(scaffoldKey: _scaffoldKey),
        NotesWidget(),
      ].elementAt(_bottomNavBarSelectedIndex),
      bottomNavigationBar: _buildBottomNavigationBar(context),
    );
  }

  @override
  void initState() {
    super.initState();
    _bottomNavBarSelectedIndex = widget.initialIndex;
  }

  _openBook(Book book) {
    setState(() {
      this.book = book;
    });
  }

  IconButton _buildSearchAction(BuildContext context) {
    return IconButton(
      tooltip: 'Search',
      icon: const Icon(Icons.search),
      onPressed: () async {
        await showSearch<dynamic>(
          context: context,
          delegate: _searchDelegate,
        );
      },
    );
  }

  _buildTranslateMenu(BuildContext context) {
    return PopupMenuButton(
      icon: Icon(Icons.translate),
      itemBuilder: (BuildContext context) {
        return <PopupMenuEntry>[
          /*PopupMenuItem(
            child: ListTile(
              title: Text('Shona'),
              onTap: () {
                application.onLocaleChanged(Locale('sn'));
                Navigator.of(context).pop();
              },
            ),
          ),*/
          PopupMenuItem(
            child: ListTile(
              title: Text('AMP'),
              onTap: () {
                //application.onLocaleChanged(Locale('sn'));
                Navigator.of(context).pop();
              },
            ),
          ),
          PopupMenuItem(
            child: ListTile(
              title: Text('ESV'),
              onTap: () {
                //application.onLocaleChanged(Locale('sn'));
                Navigator.of(context).pop();
              },
            ),
          ),
          PopupMenuItem(
            child: ListTile(
              title: Text('NKJV'),
              onTap: () {
                //application.onLocaleChanged(Locale('sn'));
                Navigator.of(context).pop();
              },
            ),
          ),
          PopupMenuItem(
            child: ListTile(
              title: Text('NLT'),
              onTap: () {
                //application.onLocaleChanged(Locale('sn'));
                Navigator.of(context).pop();
              },
            ),
          ),
          PopupMenuItem(
            child: ListTile(
              title: Text('English'),
              onTap: () {
                application.onLocaleChanged(Locale('en'));
                Navigator.of(context).pop();
              },
            ),
          ),
        ];
      },
    );
  }

  _buildOverflowMenu(BuildContext context) {
    return PopupMenuButton(
      itemBuilder: (BuildContext context) {
        return <PopupMenuEntry>[
//          PopupMenuItem(
//            child: ListTile(
//              title: Text('Dark / Light Theme'),
//              onTap: () {
//
//              },
//            ),
//          ),
          PopupMenuItem(
            child: ListTile(
              title: Text('Settings'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context,
                    MaterialPageRoute(builder: (BuildContext context) {
                  return SettingsPage();
                }));
              },
            ),
          ),
          PopupMenuItem(
            child: ListTile(
              title: Text('About'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context,
                    MaterialPageRoute(builder: (BuildContext context) {
                  return AboutPage();
                }));
              },
            ),
          ),
        ];
      },
    );
  }

  _buildIOSHome() {
    return CupertinoPageScaffold(
      child: Text("Not Text"),
    );
  }

  BottomNavigationBar _buildBottomNavigationBar(BuildContext context) {
    return BottomNavigationBar(
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.local_library),
          label: AppLocalizations.of(context).text('bible'),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.calendar_today),
          label: AppLocalizations.of(context).text('devotional'),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.book),
          label: AppLocalizations.of(context).text('notes'),
        ),
      ],
      currentIndex: _bottomNavBarSelectedIndex,
      //selectedItemColor: Theme.of(context).accentColor,
      selectedItemColor: Color(0xFF5D1AB2),
      onTap: _onBottomNavBarItemTapped,
    );
  }
}

//TODO: Set the theme for search delegate to match rest of application
class _MainSearchDelegate extends SearchDelegate {
  final db = DatabaseProvider();
  final ThemeData theme;
  final void Function(Book) _openBook;

  _MainSearchDelegate(this._openBook, this.theme);

  @override
  ThemeData appBarTheme(BuildContext context) {
    return Theme.of(context);
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return <Widget>[
      query.isEmpty
          ? IconButton(
              tooltip: 'Voice Search',
              icon: const Icon(Icons.mic),
              onPressed: () {
                query = 'TODO: implement voice input';
              },
            )
          : IconButton(
              tooltip: 'Clear',
              icon: const Icon(Icons.clear),
              onPressed: () {
                query = '';
                showSuggestions(context);
              },
            )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      tooltip: 'Back',
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, null);
      },
    );
  }

  ///This method builds the results for the search query on submit
  ///The results are built first from the list of book, then a full text search.
  ///
  ///todo: search better than this
  @override
  Widget buildResults(BuildContext context) {
    return Container(
      child: FutureBuilder(
          future: db.openDefault(context).then((_) => db.searchText(query)),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data != null && snapshot.data.length > 0) {
                List<Verse> results = snapshot.data;
                return Column(
                  children: <Widget>[
                    Text(
                      results.length.toString() + ' results',
                      style: Theme.of(context).textTheme.bodyText2,
                    ),
                    Expanded(child: _resultList(results))
                  ],
                );
              } else {
                return Text('Nothing.');
              }
            } else if (snapshot.hasError) {
              return Text("""An error has occured,
              ${snapshot.error}
              Please retry.""");
            }
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('Waiting for resultss'),
                CircularProgressIndicator(),
              ],
            );
          }),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Container(
      child: FutureBuilder<List<Book>>(
        future: db.openDefault(context).then((value) => db.getBooks()),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            List<Book> allBooks = snapshot.data.toList();
            List<Book> suggestions = allBooks
                .where((book) =>
                    book.name.toLowerCase().contains(query.toLowerCase()))
                .toList();
            if (suggestions.length > 0) {
              return _suggestionList(suggestions);
            }
          } else if (snapshot.hasError) {
            return Text("""Error
            ${snapshot.error}""");
          }
          return Container();
        },
      ),
    );
  }

  Widget _suggestionList(suggestions) {
    return ListView.builder(
      itemBuilder: (BuildContext context, int index) {
        String suggestion = suggestions[index].name;
        int indexOfQuery =
            suggestion.toLowerCase().indexOf(query.toLowerCase());
        return ListTile(
          onTap: () {
            Navigator.of(context).pop();
            _goToBook(context, suggestions[index]);
          },
          title: RichText(
            text: TextSpan(
              children: indexOfQuery > 0
                  ? <TextSpan>[
                      TextSpan(
                        text: suggestion.substring(0, indexOfQuery),
                        style: theme.textTheme.bodyText2,
                      ),
                      TextSpan(
                        text: suggestion.substring(
                            indexOfQuery, indexOfQuery + query.length),
                        style: theme.textTheme.bodyText2
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                      TextSpan(
                        text: suggestion.substring(indexOfQuery + query.length),
                        style: theme.textTheme.bodyText2,
                      ),
                    ]
                  : <TextSpan>[
                      TextSpan(
                        text: suggestion.substring(0, query.length),
                        style: theme.textTheme.bodyText2
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                      TextSpan(
                        text: suggestion.substring(query.length),
                        style: theme.textTheme.bodyText2,
                      ),
                    ],
            ),
          ),
        );
      },
      itemCount: suggestions.length,
    );
  }

  void _goToBook(BuildContext context, Book book) {
    Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) {
      return ChapterListPage(book: book);
    }));
  }

  Widget _resultList(List<Verse> results) {
    return ListView.builder(
      itemBuilder: (BuildContext context, int index) {
        Verse verse = results[index];
        String verseText = verse.text;
        int indexOfQuery =
            verse.text.toLowerCase().indexOf(query.toLowerCase());
        return ListTile(
          onTap: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (BuildContext context) {
              return ReadPage(
                book: Book(id: verse.book, name: verse.bookName),
                chapter: Chapter(
                  id: verse.chapter,
                  book: verse.book,
                  chapter: verse.chapter,
                ),
              );
            }));
          },
          title: Text(
            verse.bookName +
                ' ' +
                verse.chapter.toString() +
                ':' +
                verse.verse.toString(),
          ),
          subtitle: RichText(
            text: TextSpan(
              children: indexOfQuery > 0
                  ? <TextSpan>[
                      TextSpan(
                        text: verseText.substring(0, indexOfQuery),
                        style: theme.textTheme.bodyText2,
                      ),
                      TextSpan(
                        text: verseText.substring(
                            indexOfQuery, indexOfQuery + query.length),
                        style: theme.textTheme.bodyText2
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                      TextSpan(
                        text: verseText.substring(indexOfQuery + query.length),
                        style: theme.textTheme.bodyText2,
                      ),
                    ]
                  : <TextSpan>[
                      TextSpan(
                        text: verseText.substring(0, query.length),
                        style: theme.textTheme.bodyText2
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                      TextSpan(
                        text: verseText.substring(query.length),
                        style: theme.textTheme.bodyText2,
                      ),
                    ],
            ),
          ),
        );
      },
      itemCount: results.length,
    );
  }
}
