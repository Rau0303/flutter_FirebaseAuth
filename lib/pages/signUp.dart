import 'package:auth/services/Snackbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class signUp extends StatefulWidget {
  const signUp({Key? key}) : super(key: key);

  @override
  State<signUp> createState() => _signUpState();
}

class _signUpState extends State<signUp> {
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _userPassController = TextEditingController();
  final TextEditingController _userPassRepeatController = TextEditingController();


  @override
  void dispose() {
    _userNameController.dispose();
    _userPassController.dispose();
    _userPassRepeatController.dispose();
    super.dispose();
  }
  Future<void> SignUp() async{
    if(_userPassController.text == _userPassRepeatController){
      SnackBarService.showSnackBar(context, 'Пароли должны совпасть', true);
      return;
    }
    try{
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _userNameController.text.trim(),
          password: _userPassController.text.trim());
    }on FirebaseAuthException catch(e){
      if(e.code == 'email-alreay-in-use'){
        SnackBarService.showSnackBar(context, 'Такой Email уже используется, повторите попытку с использованием другого Email', true);
        return;
      }
      else{
        SnackBarService.showSnackBar(context, 'Что - то пошло не так!', true);
      }
    }
    Navigator.of(context).pushNamedAndRemoveUntil('/home', (Route<void> route) => false);
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Регистрация!',
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),),
      ),
      body:  Stack(
        children: [
          Positioned(
              child:Container(
                height: MediaQuery.of(context).size.height-100,
                width: MediaQuery.of(context).size.width-40,
                margin:const  EdgeInsets.symmetric(horizontal: 20,vertical: 50),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    blurRadius: 15,
                    spreadRadius: 3,
                  )]
                ),

                child: Container(
                  height: MediaQuery.of(context).size.height*80,
                  width: MediaQuery.of(context).size.width-20,
                  margin:const  EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextField(
                        controller: _userNameController,
                        keyboardType: TextInputType.emailAddress,
                        autocorrect: false,
                        decoration:InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          hintText: 'Email',
                        ),
                      ),
                      const SizedBox(height: 20,),
                      TextField(
                        controller: _userPassController,
                        autocorrect: false,
                        obscureText: true,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16)
                          ),
                          hintText: 'Пароль',
                        ),
                      ),
                      const SizedBox(height: 20,),
                      TextField(
                        controller: _userPassRepeatController,
                        autocorrect: false,
                        obscureText: true,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16)
                          ),
                          hintText: 'Повтор пароля',
                        ),
                      ),
                      const SizedBox(height: 30),
                      ElevatedButton(
                        onPressed: SignUp,
                        child: const Center(child: Text('Зарегистрироваться')),
                      ),
                      const SizedBox(height: 20,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children:   [
                          const Text('Уже есть аккаунт? ',
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 14,
                            ),
                          ),
                          TextButton(onPressed: (){
                            Navigator.pushNamed(context, '/');
                          },
                              child: const Text('Войдите!',style:TextStyle(
                                color: Colors.black,
                              ),)),
                        ],
                      )
                    ],
                  ),
                ),
              ) )
        ],
      )
    );
  }
}
