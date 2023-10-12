import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/CustomTextFormfield.dart';
import 'package:todo/DialogUtills.dart';
import 'package:todo/FireBaseMethod.dart';
import 'package:todo/HomeScreen.dart';
import 'package:todo/login&register/Login.dart';
import 'package:todo/models/User.dart';
import 'package:todo/providers/AuthProvider.dart';

class Register extends StatelessWidget {
  static String routeName="register";
  final nameController = TextEditingController(text: "jailan");
  final emailController = TextEditingController(text:"jailan@yahoo.com");
  final passController = TextEditingController(text: "123456");
  final confirmPassController = TextEditingController(text: "123456");
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Image.asset("assets/images/bg.png", width: double.infinity,fit: BoxFit.fill,),
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
                        controller: nameController,
                        label: "Name",
                        keyboardInput: TextInputType.text,
                        validator: (text) {
                          if(text==null|| text.trim().isEmpty){
                            return "name required";
                          }
                          return null;
                        },
                      ),
                    ),  Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CustomTextFormField(
                        controller: emailController,
                        label: "Email",
                        keyboardInput: TextInputType.emailAddress,
                        validator: (text) {
                          if(text==null|| text.trim().isEmpty){
                            return "Email required";
                          }
                          bool isValid=
                          RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                              .hasMatch(text);
                          if(!isValid){
                            return"invalid Email Format";
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
                          if(text.length<6){
                            return"weak password";

                          }
                          return null;
                        },
                      ),
                    ),  Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CustomTextFormField(
                        controller: confirmPassController,
                        label: "Password Confirmation",
                        keyboardInput: TextInputType.number,
                        validator: (text) {
                          if(text==null|| text.trim().isEmpty){
                            return "confirmation password required";
                          }
                          if(text!=passController.text){
                            return" password doesn't match";
                          }
                          return null;
                        },
                      ),
                    ),
                     Padding(
                       padding: const EdgeInsets.all(8.0),
                       child: ElevatedButton(onPressed:()=>RegisterMethod( context), child: Text("Register", style: TextStyle(fontSize: 20),), style: ElevatedButton.styleFrom(
                         padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20)
                       ),),
                     ),
                    TextButton(onPressed:(){
                      Navigator.popAndPushNamed(context, Login.routeName);
                    }, child: Text("Already have an account? ", style: TextStyle(fontSize: 17),))
                  ],
                ),
              ))
        ],
      ),
    );
  }
  RegisterMethod(BuildContext context) async{
    if(formKey.currentState?.validate()==true){
      DialogUtills.showLoading(context);
      try {
        final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text,
          password: passController.text,
        );
        MyUser user= MyUser(email: emailController.text, id: credential.user?.uid, name: nameController.text);
        FireBaseMethods.addUserToFireStore(user);
        var provider = Provider.of<AuthProvider>(context, listen: false);
        provider.updateUser(user);
        DialogUtills.hideLoading(context);
        DialogUtills.showMessage("login successfullu", context,actionName: "ok",action: (){
          Navigator.pushReplacementNamed(context, HomeScreen.routeName);
        });

      } on FirebaseAuthException catch (e) {
        DialogUtills.hideLoading(context);
        if (e.code == 'weak-password') {
          DialogUtills.showMessage("The password provided is too weak", context,actionName: "ok",action: (){
          });
          print('The password provided is too weak.');
        } else if (e.code == 'email-already-in-use') {
          DialogUtills.showMessage("email already in use", context,actionName: "ok",action: (){
          });
          print('The account already exists for that email.');
        }
      } catch (e) {
        DialogUtills.showMessage("${e.toString()}", context,actionName: "ok",action: (){
        });
        print(e);
      }
    }
  }
}
