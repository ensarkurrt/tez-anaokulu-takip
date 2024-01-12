// ignore_for_file: use_build_context_synchronously

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kindergarden_mobile/application_layer/components/button/tm_button.dart';
import 'package:kindergarden_mobile/application_layer/components/inputs/base_input.dart';
import 'package:kindergarden_mobile/application_layer/components/snack_bar/base_snack_bar.dart';
import 'package:kindergarden_mobile/application_layer/features/splash/splash_view.dart';
import 'package:kindergarden_mobile/main.dart';
import 'package:kindergarden_mobile/service_layer/extensions/context_extention.dart';
import 'package:kindergarden_mobile/service_layer/models/school_model.dart';
import 'package:kindergarden_mobile/service_layer/models/student_model.dart';
import 'package:kindergarden_mobile/service_layer/providers/session_management.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  String? email, password;
  bool _isLoading = false;
  bool _redirecting = false;

  Future<void> _signIn() async {
    try {
      setState(() {
        _isLoading = true;
      });
      await supabase.auth.signInWithPassword(
        email: email!,
        password: password!,
      );
      if (mounted) {
        var userId = supabase.auth.currentUser!.id;
        bool isSchoolOwner = await supabase.from('schools').count().eq('owner_id', userId) != 0;

        if (isSchoolOwner) {
          School response =
              await supabase.from('schools').select().eq('owner_id', userId).single().withConverter<School>((data) => School.fromJson(data));
          SessionManagement.include.school = response;
        } else {
          Student response =
              await supabase.from('students').select().eq('user_id', userId).single().withConverter<Student>((data) => Student.fromJson(data));
          SessionManagement.include.student = response;
        }

        return ShowSnackBar(context, text: "Giriş Başarılı");
      }
    } on AuthException catch (error) {
      return ShowSnackBar(context, text: error.message, alertType: CustomAlertType.Error);
    } catch (error) {
      return ShowSnackBar(context, text: "Bir hata oluştu. Lütfen tekrar deneyin.", alertType: CustomAlertType.Error);
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  void initState() {
    supabase.auth.onAuthStateChange.listen((data) {
      if (_redirecting) return;
      final session = data.session;
      if (session != null) {
        _redirecting = true;
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const SplashView()), (route) => false);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: context.themeColors.background,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        systemOverlayStyle: SystemUiOverlayStyle.light,
      ),
      body: SizedBox(
        height: height,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  const Column(
                    children: <Widget>[
                      Text(
                        "Giriş Yap",
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Hesabınıza giriş yapın",
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: Column(
                      children: <Widget>[
                        InputField(
                          label: "E-mail",
                          keyboardType: TextInputType.emailAddress,
                          onChanged: (val) => setState(() => email = val),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        InputField(
                          label: "Şifre",
                          onChanged: (val) => setState(() => password = val),
                          obsecureText: true,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: TMButton(
                      isActive: !_isLoading,
                      onTap: () async {
                        _signIn();
                      },
                      title: "Giriş Yap",
                    ),
                  ),
                  SizedBox(
                    height: height / 10,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
