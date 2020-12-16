import 'package:book_store/apicall/UserApiCalls.dart';
import 'package:book_store/request/LoginRequest.dart';
import 'package:book_store/response/UserResponse.dart';
import 'package:book_store/screen/BookScreen.dart';
import 'package:book_store/utils/BookConstant.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget{

  @override
  LoginScreenState createState() => LoginScreenState();

}

class LoginScreenState extends State<LoginScreen>{

  TextEditingController _userNameController = new TextEditingController();
  TextEditingController _passwordController = new TextEditingController();

  bool showPassword= true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Login"),),
      body: SingleChildScrollView(child: setBody(),),
    );
  }

  setBody(){
    var loginBtn = FloatingActionButton.extended(onPressed: onLoginClick, label: Text("Sign In"));
    var userNameEditView = TextFormField(
        controller: _userNameController,
        keyboardType: TextInputType.text,
        obscureText: false,
        style: TextStyle(color: Colors.black, fontFamily: 'SFUIDisplay'),
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: "User Name",
          prefixIcon: Icon(Icons.person_outline),

        ));

    final passwordEditView = TextFormField(
      keyboardType: TextInputType.text,
      controller: _passwordController,
      obscureText: showPassword,
      //This will obscure text dynamically
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: "Password",
        prefixIcon: Icon(Icons.lock),
        suffixIcon: IconButton(
          icon: Icon(
            // Based on passwordVisible state choose the icon
            showPassword ? Icons.visibility_off : Icons.visibility,
            color: Theme.of(context).primaryColorDark,
          ),
          onPressed: () {
            // Update the state i.e. toogle the state of passwordVisible variable
            setState(() {
              showPassword = !showPassword;
            });
          },
        ),
      ),
    );
    return Center(
      child: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(36.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: 50.0,
                child: Text("Welcome to book store",style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold,color:BookConstant.seconadryColour),),
              ),
              SizedBox(height: 25.0),
              userNameEditView,
              SizedBox(height: 25.0),
              passwordEditView,
              SizedBox(
                height: 35.0,
              ),
              loginBtn,
              SizedBox(
                height: 15.0,
              ),
            ],
          ),
        ),
      ),
    );
  }

  onLoginClick(){
    if(_userNameController.text==null || _userNameController.text.isEmpty ){
      showSnachBar("Please Enter UserName", context, false);
      return;
    }if(_passwordController.text==null || _passwordController.text.isEmpty ){
      showSnachBar("Please Enter Password", context, false);
      return;
    }
    LoginRequest loginRequest = LoginRequest();
    loginRequest.userName= _userNameController.text;
    loginRequest.password= _passwordController.text;
    UserApiCalls.login(loginRequest).then((value) => nextScreen(value));
  }

  nextScreen(UserResponse userResponse){
    if(userResponse==null || userResponse.recordinfo==null){
      showSnachBar("Invalid Creadentials", context, false);
      return;
    }
    showSnachBar("Login Sucessfully", context, true);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BookScreen(
        ),
      ),
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

}