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
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BookScreen extends StatefulWidget{

  @override
  BookScreenState createState() => BookScreenState();

}

class BookScreenState extends State<BookScreen>{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Book List"),),
      body: getFuture(context),
    );
  }

  FutureBuilder<BookResponse> getFuture(BuildContext context) {
    return FutureBuilder<BookResponse>(
        future: BookApiCalls.getBook(),
        builder: (context, snapshot) {
          if (snapshot.hasError) print(snapshot.error);
          return snapshot.hasData
              ? getHomeRecentData(snapshot.data, context)
              : Center(child: CircularProgressIndicator());
        });
  }

  getHomeRecentData(BookResponse diaryGroupResponse, BuildContext context) {
    if (diaryGroupResponse == null ||
        diaryGroupResponse.data == null ||
        diaryGroupResponse.data.isEmpty) {
      print("NO IEM");
      return Text("No Data Found");
    }
    return ListView.builder(
      padding: EdgeInsets.all(10),
      scrollDirection: Axis.vertical,
      itemCount: diaryGroupResponse.data.length,
      itemBuilder: (context, index) {
        BookData diaryGroupData = diaryGroupResponse.data[index];
        return getSectionItem(diaryGroupData, context);
      },
      shrinkWrap: true,
      physics:
      ClampingScrollPhysics(),
    );
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