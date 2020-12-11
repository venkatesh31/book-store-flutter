import 'package:flutter/material.dart';

class DataCard extends StatelessWidget {
  final String title, value;

  const DataCard(
      {Key key,
      @required this.title,
        @required this.value,
   })
      : super(key: key);

  Widget build(BuildContext buildContext) {
    Size screenSize = MediaQuery.of(buildContext).size;
    bool isValidTitle = title!=null && title.isNotEmpty;
    bool isValidValue = value!=null && value.isNotEmpty;

    var card = Container(
      margin: EdgeInsets.only(top: 10, left: 0, right: 0),
      padding:  EdgeInsets.only(top: 0, left: 10, right: 10),
      decoration: new BoxDecoration(
        color: Colors.white,
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
      child: Column(

          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 10.0),
            isValidTitle?_buildReceiptTitle(title):Container(height: 0,),
            isValidTitle?_buildSeparator(screenSize):Container(height: 0,),
            isValidTitle?SizedBox(height: 10.0):Container(height: 0,),
            isValidValue?_buildReceiptDetails(value):Container(height: 0,),
            isValidValue?SizedBox(height: 10.0):Container(height: 0,),
          ]),
    );
    return card;

  }


  Widget _buildReceiptTitle(String textToShow) {
    TextStyle _nameTextStyle = TextStyle(
      fontFamily: 'Roboto',
      color: Colors.black54,
      fontSize: 16.0,
      fontStyle: FontStyle.italic,
      fontWeight: FontWeight.w400,
    );

    return Text(
      textToShow,
      style: _nameTextStyle,
      textAlign: TextAlign.left,
    );
  }

  Widget _buildReceiptDetails(String textToShow) {
    TextStyle _nameTextStyle = TextStyle(
      fontFamily: 'Roboto',
      color: Colors.black,
      fontSize: 20.0,
      fontWeight: FontWeight.w700,
    );

    return Text(
      textToShow,
      style: _nameTextStyle,
      textAlign: TextAlign.left,
    );
  }

  Widget _buildSeparator(Size screenSize) {
    return Container(
      width: screenSize.width / 1.1,
      height: 2.0,
      color: Colors.black12,
      margin: EdgeInsets.only(top: 4.0),
    );
  }
}
