import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/CustomTextFormfield.dart';
import 'package:todo/DialogUtills.dart';
import 'package:todo/FireBaseMethod.dart';
import 'package:todo/HomeScreen.dart';
import 'package:todo/login&register/Register.dart';
import 'package:todo/providers/AuthProvider.dart';

class Login extends StatelessWidget {
  static String routeName="login";

  final emailController = TextEditingController(text: "jailan@yahoo.com");
  final passController = TextEditingController(text: "123456");

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Image.asset("assets/images/bg.png", width: double.infinity, fit: BoxFit.fill,),
          Form(
              key: formKey,
              child: Container(

                margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.3),
                child: Column(
crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                     Padding(
                       padding: const EdgeInsets.all(8.0),
                       child: CustomTextFormField(
                        controller: emailController,
                        label: "Email",
                        keyboardInput: TextInputType.emailAddress,
                        validator: (text) {
                          if(text==null|| text.trim().isEmpty){
                            return "Email required";
                          }

                          return null;
                        },
                    ),
                     ),  Padding(
                       padding: const EdgeInsets.all(8.0),
                       child: CustomTextFormField(
                        controller: passController,
                        label: "password",
                        keyboardInput: TextInputType.number,
                        validator: (text) {
                          if(text==null|| text.trim().isEmpty){
                            return "password required";
                          }

                          return null;
                        },
                    ),
                     ),
                     Padding(
                       padding: const EdgeInsets.all(8.0),
                       child: ElevatedButton(onPressed:()=>RegisterMethod( context), child: Text("Login", style: TextStyle(fontSize: 20),), style: ElevatedButton.styleFrom(
                           padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20)
                       ),),),

                    TextButton(onPressed:(){
                      Navigator.popAndPushNamed(context, Register.routeName);
                    }, child: Text("Dont have an account?  SignUp ", style: TextStyle(fontSize: 17)))
                  ],
                ),
              ))
        ],
      ),
    );
  }
  RegisterMethod(BuildContext context) async{
    if(formKey.currentState?.validate()==true){
      try {
        DialogUtills.showLoading(context);
        final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: emailController.text,
            password: passController.text
        );
        var user = await FireBaseMethods.getUserFromFirestore(credential.user?.uid??"");
        if(user== null){return;}
        var provider = Provider.of<AuthProvider>(context, listen: false);
        provider.updateUser(user);
        DialogUtills.hideLoading(context);
        DialogUtills.showMessage("logged in successfully", context,actionName: "ok",action: (){
          Navigator.pushReplacementNamed(context, HomeScreen.routeName);
        });
      } on FirebaseAuthException catch (e) {
        DialogUtills.hideLoading(context);
        if (e.code == 'user-not-found') {
          DialogUtills.showMessage("No user found for that email.", context,actionName: "ok",action: (){
          });
          print('No user found for that email.');
        } else if (e.code == 'wrong-password') {
          DialogUtills.showMessage("Wrong password provided for that user.", context,actionName: "ok",action: (){
          });
          print('Wrong password provided for that user.');
        }
      }
    }
  }
}
