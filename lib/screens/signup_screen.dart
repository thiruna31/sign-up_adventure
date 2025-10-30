import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../widgets/progress_tracker.dart';
import '../widgets/avatar_picker.dart';
import '../widgets/password_strength.dart';
import 'success_screen.dart';

class SignupScreen extends StatefulWidget {
  static const String routeName = '/signup';
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _email = TextEditingController();
  final _dob = TextEditingController();
  final _password = TextEditingController();

  bool showPassword = false;
  bool loading = false;
  int avatarIndex = 0;

  double get progress {
    int fields = 4;
    int filled = 0;
    if (_name.text.isNotEmpty) filled++;
    if (_email.text.isNotEmpty) filled++;
    if (_dob.text.isNotEmpty) filled++;
    if (_password.text.isNotEmpty) filled++;
    return (filled / fields) * 100;
  }

  @override
  void initState() {
    super.initState();
    _name.addListener(() => setState(() {}));
    _email.addListener(() => setState(() {}));
    _dob.addListener(() => setState(() {}));
    _password.addListener(() => setState(() {}));
  }

  Future pickDate() async {
    DateTime? d = await showDatePicker(
      context: context,
      initialDate: DateTime(2000),
      firstDate: DateTime(1970),
      lastDate: DateTime.now(),
    );
    if (d != null) {
      _dob.text = DateFormat('dd/MM/yyyy').format(d);
      setState(() {});
    }
  }

  submit() {
    if (!_formKey.currentState!.validate()) return;
    setState(() => loading = true);

    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => SuccessScreen(
            userName: _name.text,
            avatarIndex: avatarIndex,
          ),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Your Account Enjoy 🎉'),
        backgroundColor: const Color.fromARGB(255, 243, 236, 254),
      ),
      body: Padding(
        padding: const EdgeInsets.all(18),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(children: [
              ProgressTracker(percent: progress),
              const SizedBox(height: 20),
              TextFormField(
                controller: _name,
                decoration: _dec("Adventure Name", Icons.person),
                validator: (v) =>
                    v!.isEmpty ? "Enter your adventure name" : null,
              ),
              const SizedBox(height: 15),
              TextFormField(
                controller: _email,
                decoration: _dec("Email Address", Icons.email),
                validator: (v) =>
                    v!.contains("@") ? null : "Enter valid email address",
              ),
              const SizedBox(height: 15),
              TextFormField(
                controller: _dob,
                readOnly: true,
                onTap: pickDate,
                decoration: _dec("Date of Birth", Icons.calendar_today)
                    .copyWith(suffixIcon: Icon(Icons.date_range)),
                validator: (v) => v!.isEmpty ? "Select date" : null,
              ),
              const SizedBox(height: 15),
              TextFormField(
                controller: _password,
                obscureText: !showPassword,
                decoration: _dec("Secret Password", Icons.lock).copyWith(
                  suffixIcon: IconButton(
                    icon: Icon(showPassword
                        ? Icons.visibility
                        : Icons.visibility_off),
                    onPressed: () => setState(() => showPassword = !showPassword),
                  ),
                ),
                validator: (v) =>
                    v!.length < 6 ? "Minimum 6 characters" : null,
              ),
              PasswordStrengthMeter(password: _password.text),
              const SizedBox(height: 20),
              AvatarPicker(
                selectedIndex: avatarIndex,
                onSelect: (i) => setState(() => avatarIndex = i),
              ),
              const SizedBox(height: 20),
              AnimatedContainer(
                duration: Duration(milliseconds: 300),
                height: 56,
                width: loading ? 60 : double.infinity,
                child: loading
                    ? Center(
                        child: CircularProgressIndicator(
                          valueColor:
                              AlwaysStoppedAnimation(Colors.deepPurple),
                        ),
                      )
                    : ElevatedButton(
                        onPressed: submit,
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.deepPurple),
                        child: const Text("Start My Adventures"),
                      ),
              )
            ]),
          ),
        ),
      ),
    );
  }

  InputDecoration _dec(String label, IconData icon) => InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: Colors.deepPurple),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        filled: true,
        fillColor: Colors.grey[50],
      );
}
