import 'package:auth/services/Snackbar.dart';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';

class loginPage extends StatefulWidget {
  const loginPage({Key? key}) : super(key: key);

  @override
  State<loginPage> createState() => _loginPageState();
}

class _loginPageState extends State<loginPage> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _userPasswordController = TextEditingController();


  @override
  void dispose() {
    _userNameController.dispose();
    _userPasswordController.dispose();
    super.dispose();
  }

  Future<void> login() async{
    final navigator = Navigator.of(context);
    try{
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _userNameController.text.trim(),
          password: _userPasswordController.text.trim());

    }
    on FirebaseAuthException catch(e){
      print('что то пошло не так');
      if(e.code =='user-not-found'){
        SnackBarService.showSnackBar(context, 'Пользователь не существует', true);
        return;
      }
      else if(e.code == 'wrong-password'){
        SnackBarService.showSnackBar(context, 'Неправильный пароль', true);
        return;
      }
      else{
        SnackBarService.showSnackBar(context, 'Что то пошло не так!', true);
      }

    }
    Navigator.of(context).pushNamedAndRemoveUntil('/home', (Route<void> route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('Login page'),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Positioned(child: Container(
            padding: const EdgeInsets.all(10),
            height: MediaQuery.of(context).size.height-20,
            width: MediaQuery.of(context).size.width-40,
            margin: EdgeInsets.symmetric(vertical: 10,horizontal: 20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [BoxShadow(
                color: Colors.black.withOpacity(0.3),
                blurRadius: 15,
                spreadRadius: 3,
              )]
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextField(
                  controller: _userNameController,
                  keyboardType: TextInputType.emailAddress,
                  autocorrect: false,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    hintText: 'UserName'
                  ),
                ),
                const SizedBox(height: 20,),
                TextField(
                  controller: _userPasswordController,
                  obscureText: true,
                  autocorrect: false,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    hintText: 'Пароль',
                  ),
                ),
                const SizedBox(height: 30,),
                ElevatedButton(
                    onPressed: (){
                      login();
                    },
                    child: const Text('Войти'),),
                const SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Нет аккаунта?',
                      style:TextStyle(
                        color: Colors.grey,
                      ),),
                    const SizedBox(width: 10,),

                    TextButton(
                        onPressed: (){
                          setState(() {
                            Navigator.pushNamed(context, '/register');
                          });
                        },
                        child: const Text('Зарегистрироваться!', style: TextStyle(
                          color: Colors.blue,
                        ),)),

                  ],
                ),

              ],
            ),
          ))
        ],
      )
    );
  }
}
