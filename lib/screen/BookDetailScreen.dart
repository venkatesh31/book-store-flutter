import 'package:book_store/response/Book.dart';
import 'package:book_store/utils/BookConstant.dart';
import 'package:book_store/utils/DataCard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BookDetailScreen extends StatelessWidget{
  final Book bookData;

  BookDetailScreen({Key key, this.bookData}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return new Scaffold(

      body: setdata(context, bookData),
    );
  }

  setdata(BuildContext context,Book book){
    var column = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        setImageView(context),
        DataCard(title:"Book Name" ,value: bookData.name,),
        DataCard(title:"Author" ,value: bookData.author,),
        DataCard(title:"Publisher" ,value: bookData.publisher,),
        DataCard(title:"Price" ,value: 'Rs: '+book.price.toString(),),
        DataCard(title:"About" ,value: 'Rs: '+book.description,),


      ],
    );
    var container = Container(margin: EdgeInsets.all(10),child: column,);
    return SingleChildScrollView(child: container,);
  }

  setImageView(BuildContext context){
    return  new Container(
      color: Colors.black,
      child: new Center(
        child: new Hero(
          tag: 'book-${bookData.bookId}',
          child: new Image(
            image: new NetworkImage(bookData.imageUrl),
            height: 200,
            width: MediaQuery.of(context).size.width,
          ),
        ),
      ),
    );
  }

  Widget setData(BuildContext context,String title,String value) {
    bool isValidTitle = title!=null && title.isNotEmpty;
    bool isValidValue = value!=null && value.isNotEmpty;
    var content = Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          isValidTitle?Text(
            title,
            maxLines: 1,
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w500,
              fontSize: 14,
            ),
          ):Container(height:0),
          Padding(
            padding: EdgeInsets.only(top: 5),
          ),
          isValidValue?Text(
            value,
            maxLines: 1,
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w500,
              fontSize: 12,
            ),
          ):Container(height:0),

        ],
      ),
    );


    var contanoner = Container(
      margin: EdgeInsets.only(top: 10, left: 10, right: 10),
      child: content,
    );

    return contanoner;
  }
}