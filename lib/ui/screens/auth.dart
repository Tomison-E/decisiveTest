import 'package:decisive/core/services/api.dart';
import 'package:decisive/ui/screens/profile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:decisive/util/sizeConfig.dart';
import 'package:decisive/util/validators.dart';


class Auth extends StatelessWidget{
  final min = 500.0;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(leading: GestureDetector(child:Text('     cancel',style: TextStyle(color: Colors.black,fontSize: 11)),onTap: ()=>Navigator.pop(context)),elevation: 0,backgroundColor: Colors.transparent),
      body:ConstrainedBox(
          constraints: const BoxConstraints.expand(),
          child: SingleChildScrollView(
              child: ConstrainedBox(
                  constraints: BoxConstraints(
                      minHeight: min,
                      maxHeight: SizeConfig.blockSizeVertical * 100 > min
                          ? SizeConfig.blockSizeVertical * 100
                          : min),
                  child: Padding(padding: EdgeInsets.all(20.0),
                      child: Column(
                        children: <Widget>[
                                RichText(text: TextSpan(text: "Sign In\n\n",style: TextStyle(color: Colors.black,fontSize: 30.0,fontWeight: FontWeight.bold),children: [
                                  TextSpan(text: "Your  better financial lifestyle awaits.",style: TextStyle(color: Colors.black,fontSize: 13.0,fontWeight: FontWeight.normal),),
                                ]),textAlign: TextAlign.left),
                                Spacer(),
                                RegisterForm(_scaffoldKey),
                                Spacer(flex: 2),

                        ],crossAxisAlignment: CrossAxisAlignment.start,
                      ))
              )
          )
      ),backgroundColor: Colors.white,
    );
  }


}


class RegisterForm extends StatefulWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey;
  const RegisterForm(this._scaffoldKey,{Key key}) : super(key: key);


  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _autoValidate = false;
  bool _formWasEdited = false;
  Validators validate;
  bool p1 =true;
  String email,password;
  Api api = Api();


  @override
  void initState() {
    validate = Validators(_formWasEdited);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void showInSnackBar(String value) {
    widget._scaffoldKey.currentState.showSnackBar(new SnackBar(
        content: new Text(value)
    ));
  }



  Future<void> _handleSubmitted() async{
    final FormState form = _formKey.currentState;
    if (!form.validate()) {
      _autoValidate = true; // Start validating on every change.
      showInSnackBar('Please fix the errors in red before submitting.');
    } else {
      form.save();
      try {
        _showDialog(context);
        bool test =   await  api.signIn(email, password);
        if(test){
          Navigator.pop(context);
          _autoValidate = false;
          _reset(form);
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Profile()),
          );
        }
        else {
          Navigator.pop(context);
          showInSnackBar('SignIn Unsuccessful');
        }
      }
      catch(exception){
        print(exception);
        Navigator.pop(context);
        showInSnackBar('SignIn Unsuccessful');
      }

    }
  }

  void _reset(FormState form){
    form.reset();
  }

  Future<bool> _warnUserAboutInvalidData() async {
    final FormState form = _formKey.currentState;
    if (form == null || !_formWasEdited || form.validate())
      return true;

    return await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return new AlertDialog(
          title: const Text('This form has errors'),
          content: const Text('Really leave this form?'),
          actions: <Widget> [
            new FlatButton(
              child: const Text('YES'),
              onPressed: () { Navigator.of(context).pop(true); },
            ),
            new FlatButton(
              child: const Text('NO'),
              onPressed: () { Navigator.of(context).pop(false); },
            ),
          ],
        );
      },
    ) ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return  Form(
      key: _formKey,
      autovalidate: _autoValidate,
      onWillPop: _warnUserAboutInvalidData,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          TextFormField(
              decoration:  InputDecoration(
                  labelText: 'Email address',prefixIcon: Icon(Icons.message,color: Colors.black12),
                  focusColor: Color.fromRGBO(76, 232, 149, 1.0),enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Color.fromRGBO(76, 232, 149, 1.0),width: 1.0)),labelStyle: TextStyle(color: Color.fromRGBO(151, 151, 151, 1.0),fontSize: 13,fontWeight: FontWeight.w200),
                  focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Color.fromRGBO(76, 232, 149, 1.0),width: 1.0))
              ),keyboardType: TextInputType.emailAddress,onSaved: (String mail)=>email=mail, validator: (String mail)=>validate.validateEmail(mail)

          ),
          SizedBox(height: 20.0),
          TextFormField(
            decoration:  InputDecoration(
                labelText: 'Password',prefixIcon: Icon(Icons.lock_outline,color: Colors.black12),
                focusColor: Color.fromRGBO(76, 232, 149, 1.0),enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Color.fromRGBO(76, 232, 149, 1.0),width: 1.0)),labelStyle: TextStyle(color: Color.fromRGBO(151, 151, 151, 1.0),fontSize: 13,fontWeight: FontWeight.w200),
                focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Color.fromRGBO(76, 232, 149, 1.0),width: 1.0)),suffixIcon: IconButton(icon:p1?Icon(Icons.visibility):Icon(Icons.visibility_off),onPressed: ()=>setState(()=>p1=!p1))
            ),obscureText: p1,onSaved: (String passCode)=>password=passCode, validator: (String passCode)=>validate.validatePassword(passCode),
          ),
          SizedBox(height: 40.0),
          Row(
            children: <Widget>[
              RaisedButton(onPressed: ()=>_handleSubmitted(),child: Text("SIGN IN",style: TextStyle(fontWeight: FontWeight.w500)),color:Color.fromRGBO(76, 232, 149, 1.0),highlightColor: Colors.white,hoverColor: Colors.black,textColor: Colors.black87,padding: EdgeInsets.only(left: 60.0,right: 60.0),)
            ],mainAxisAlignment: MainAxisAlignment.center,
          ),
          SizedBox(height: 15.0),
          Row(
            children: <Widget>[
              Text("I am new here? ",style: TextStyle(color: Colors.black,fontSize: 12)),
              GestureDetector(child: Text("Create Account",style: TextStyle(color: Colors.black,fontSize: 12,fontWeight:FontWeight.bold)),onTap: (){})
            ],mainAxisAlignment: MainAxisAlignment.center,
          )
        ],mainAxisAlignment: MainAxisAlignment.center,
      ),
    );
  }

  void _showDialog(BuildContext context) {
    // flutter defined function
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        // return object of type Dialog
        return CupertinoAlertDialog(
          title: Text("Signing In"),
          content: Column(
              children:[
                SizedBox(height: 20.0),
                CupertinoActivityIndicator()
              ]),
        );
      },
    );
  }

}