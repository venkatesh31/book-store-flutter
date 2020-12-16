import 'package:book_store/apicall/BookApiCalls.dart';
import 'package:book_store/apicall/UserApiCalls.dart';
import 'package:book_store/request/LoginRequest.dart';
import 'package:book_store/response/Book.dart';
import 'package:book_store/response/BookData.dart';
import 'package:book_store/response/BookResponse.dart';
import 'package:book_store/response/UserResponse.dart';
import 'package:book_store/screen/BookDetailScreen.dart';
import 'package:book_store/utils/BookConstant.dart';
import 'package:book_store/utils/CustomHeading.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BookScreen extends StatefulWidget{

  @override
  BookScreenState createState() => BookScreenState();

}

class BookScreenState extends State<BookScreen>{

  TextEditingController _controller = new TextEditingController();

  List<BookData> filteredList = new List();
  List<BookData> bookDataInitList = new List();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Book List"),),
      body: getHomeRecentData(context),
    );
  }
  @override
  initState() {
    super.initState();
   getUserDetails();

  }

  Future<Null> getUserDetails() async {
    BookResponse response = await BookApiCalls.getBook();

    setState(() {
      bookDataInitList.addAll(response.data);
    });
  }


  getHomeRecentData( BuildContext context) {
    if (bookDataInitList == null ||
        bookDataInitList.isEmpty) {
      print("NO IEM");
      return Center(child: CircularProgressIndicator());
    }

    var ex =  new Container(
      child: filteredList.length != 0 || _controller.text.isNotEmpty
          ? setListView(filteredList): setListView(bookDataInitList),
    );

    var searchView =  new Container(
      margin: const EdgeInsets.all(15.0),
      padding: const EdgeInsets.all(3.0),
      decoration: BoxDecoration(
          border: Border.all(color: BookConstant.appColour)
      ),
      child: ListTile(
        leading: new Icon(Icons.search),
        title: new TextField(
          controller: _controller,
          decoration: new InputDecoration(
              hintText: 'Search', border: InputBorder.none),
          onChanged: filterData,
        ),
        trailing: new IconButton(icon: new Icon(Icons.cancel), onPressed: () {
          _controller.clear();
          filterData('');
        },),
      ),
    );
    var column = ListView(children: [
      Padding(padding:EdgeInsets.all(10),child: searchView,),ex
    ],);
    return column;
  }

  setListView(List<BookData> bookDataList){
   return ListView.builder(
      scrollDirection: Axis.vertical,
      itemCount: bookDataList.length,
      itemBuilder: (context, index) {
        BookData bookData = bookDataList[index];
        return getSectionItem(bookData, context);
      },
      shrinkWrap: true,
      physics:
      ClampingScrollPhysics(),
    );
  }

  Future showSnachBar(
      String value, BuildContext context, bool isSucess) {
    Color color = isSucess ? Colors.green : Colors.red;
    IconData icon = isSucess ? Icons.beenhere : Icons.cancel;
    String title = isSucess ? "Yah!" : "Sorry!";
    Flushbar(
      flushbarPosition: FlushbarPosition.BOTTOM,
      title: title,
      message: value,
      showProgressIndicator: true,
      icon: Icon(
        icon,
        size: 28.0,
        color: Colors.white,
      ),
      backgroundColor: color,
      duration: Duration(seconds: 2),
    )..show(context);
  }



  filterData(String searchText ){
    print("Search Start");
    filteredList.clear();
    if(searchText==null || searchText.isEmpty){
     setState(() {

     });
      return;
    }
    print("Not Empty Search Start");
    bookDataInitList.forEach((bookData) {
      List<Book> books = new List();
      bookData.books.forEach((book) {
        if(book.name.toLowerCase().contains(searchText.toLowerCase())){
          print("Search "+book.name);
          books.add(book);
        }

      });
      if(books.isNotEmpty){
        BookData bookData1 = new BookData();
        bookData1.books = books;
        bookData1.category = bookData.category;
        filteredList.add(bookData1);
      }

    });

    setState(() {

    });
    print("Search End");

  }

  getSectionItem( BookData diaryGroupData, BuildContext context) {

    var heading = CustomHeading(
        title: diaryGroupData.category.name
    );
    if (diaryGroupData.books != null && diaryGroupData.books.isNotEmpty) {
      return Column(
        children: <Widget>[
          heading,
          _buildStoryListView(diaryGroupData.books),
        ],
      );
    }
  }

  _buildStoryListView(List<Book> bookList) {
    return ListView.builder(
      itemCount: bookList.length,
      shrinkWrap: true,
      physics: ClampingScrollPhysics(),
      scrollDirection: Axis.vertical,
      itemBuilder: (BuildContext context, int index) {
          Book book = bookList[index];
          return InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => BookDetailScreen(bookData: book),
                ),
              );
            },
            child: setCard(book
            ),
          );
        },
      );
  }

  setCard(Book book){

    final imageView = new Container(
      alignment: new FractionalOffset(0.0, 0.5),
      margin: const EdgeInsets.only(left: 24.0),
      child: new Hero(
        tag: 'book-${book.bookId}',
        child: new Image(
          image: new NetworkImage(book.imageUrl),
          height: 100,
          width: 100,
        ),
      ),
    );
    var card= new Container(
            height: 124.0,
            margin: new EdgeInsets.only(left: 46.0),
        decoration: new BoxDecoration(
          color: BookConstant.appColour,
          shape: BoxShape.rectangle,
         borderRadius: new BorderRadius.circular(8.0),
          boxShadow: <BoxShadow>[
            new BoxShadow(
              color: Colors.black12,
              blurRadius: 10.0,
              offset: new Offset(0.0, 10.0),
            ),
          ],
        ),
      child: new Container(
        margin: const EdgeInsets.only(top: 16.0, left: 72.0),
        constraints: new BoxConstraints.expand(),
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            new Text(book.name, style: TextStyle(
                color: BookConstant.seconadryColour,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.bold,
                fontSize: 24.0
            )),
            new Text(book.author, style: TextStyle(
                color: Colors.white,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w500,
                fontSize: 14.0
            )),
            new Text(book.publisher, style: TextStyle(
                color: Colors.white,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w500,
                fontSize: 14.0
            )),
            new Text("Rs : "+book.price.toString(), style: TextStyle(
                color: Colors.white,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w500,
                fontSize: 14.0
            )),
          ],
        ),
      ),
    );

    return Container(
              height: 120.0,
              margin: const EdgeInsets.symmetric(
            vertical: 16.0,
                horizontal: 24.0,
              ),
          child: new Stack(
            children: <Widget>[
              card,
              imageView,
            ],
          )
        );
  }
}