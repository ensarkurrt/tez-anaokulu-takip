import 'package:flutter/material.dart';
import 'package:kindergarden_mobile/main.dart';
import 'package:kindergarden_mobile/service_layer/models/school_model.dart';
import 'package:kindergarden_mobile/service_layer/models/student_model.dart';
import 'package:kindergarden_mobile/service_layer/models/user_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as supabaseFlutter;

// ignore: constant_identifier_names

class SessionManagement with ChangeNotifier {
  static final SessionManagement include = SessionManagement();

  User _user = User.empty();
  User get user => _user;

  Student _student = Student.empty();
  Student get student => _student;

  School _school = School.empty();
  School get school => _school;

  bool get isSchool => _school.id != 0;
  bool get isStudent => _student.id != 0;

  set user(User value) {
    _user = value;
    notifyListeners();
  }

  set student(Student value) {
    _student = value;
    notifyListeners();
  }

  set school(School value) {
    _school = value;

    notifyListeners();
  }

  void signOut() {
    _user = User.empty();
    _student = Student.empty();
    _school = School.empty();
    notifyListeners();
  }

  Future updateSession() async {
    if (supabase.auth.currentUser == null) return signOut();
    var userId = supabase.auth.currentUser!.id;
    bool isSchoolOwner = await supabase.from('schools').count().eq('owner_id', userId) != 0;
    SessionManagement.include.user = User.fromSupabase(supabase.auth.currentUser!.toJson());

    if (isSchoolOwner) {
      School response = await supabase
          .from('schools')
          .select('*, classes(*)')
          .eq('owner_id', userId)
          .single()
          .withConverter<School>((data) => School.fromJson(data));
      _school = response;
    } else {
      Student response =
          await supabase.from('students').select().eq('user_id', userId).single().withConverter<Student>((data) => Student.fromJson(data));
      await supabase.auth.updateUser(supabaseFlutter.UserAttributes(data: {'name': "Eymen KURT"}));
      _student = response;
    }
    notifyListeners();
  }
}
