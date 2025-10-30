import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../widgets/progress_tracker.dart';
import '../widgets/avatar_picker.dart';
import '../widgets/password_strength.dart';
import '../widgets/shake_animation.dart';
import '../widgets/bounce_animation.dart';
import '../widgets/sound_service.dart';
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

  // Animation helpers
  bool shakeName = false;
  bool bounceName = false;
  bool shakeEmail = false;
  bool bounceEmail = false;
  bool shakeDob = false;
  bool bounceDob = false;
  bool shakePassword = false;
  bool bouncePassword = false;

  FocusNode nameFocus = FocusNode();
  FocusNode emailFocus = FocusNode();
  FocusNode dobFocus = FocusNode();
  FocusNode passwordFocus = FocusNode();

  double get progress {
    int fields = 4;
    int filled = 0;
    if (_name.text.isNotEmpty) filled++;
    if (_email.text.isNotEmpty) filled++;
    if (_dob.text.isNotEmpty) filled++;
    if (_password.text.isNotEmpty) filled++;
    double v = (filled / fields) * 100;
    if (v == 25 || v == 50 || v == 75 || v == 100) {
      SoundService.playMilestone();
    }
    return v;
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
      setState(() {
        bounceDob = true;
        shakeDob = false;
      });
    }
  }

  void submit() {
    setState(() {
      shakeName = false;
      shakeEmail = false;
      shakeDob = false;
      shakePassword = false;
      bounceName = false;
      bounceEmail = false;
      bounceDob = false;
      bouncePassword = false;
    });

    bool valid = _formKey.currentState!.validate();

    if (!valid) {
      setState(() {
        if (_name.text.isEmpty) shakeName = true;
        if (!_email.text.contains('@')) shakeEmail = true;
        if (_dob.text.isEmpty) shakeDob = true;
        if (_password.text.length < 6) shakePassword = true;
      });
      return;
    }

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

  InputDecoration _dec(String label, IconData icon, {bool highlight = false}) => InputDecoration(
    labelText: label,
    prefixIcon: Icon(icon, color: Colors.deepPurple),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(
        color: highlight ? Colors.green : Colors.grey,
        width: highlight ? 2 : 1,
      ),
    ),
    filled: true,
    fillColor: highlight ? Colors.green[50] : Colors.grey[50],
  );

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
              ShakeWidget(
                shake: shakeName,
                child: BounceWidget(
                  bounce: bounceName,
                  child: TextFormField(
                    controller: _name,
                    focusNode: nameFocus,
                    decoration: _dec(
                      "Adventure Name",
                      Icons.person,
                      highlight: nameFocus.hasFocus && _name.text.isNotEmpty,
                    ).copyWith(
                      suffixIcon: _name.text.isNotEmpty
                          ? const Icon(Icons.check_circle, color: Colors.green)
                          : null,
                    ),
                    validator: (v) {
                      if (v == null || v.isEmpty) return "Enter your adventure name";
                      setState(() {
                        bounceName = true;
                        shakeName = false;
                      });
                      return null;
                    },
                  ),
                ),
              ),
              const SizedBox(height: 15),
              ShakeWidget(
                shake: shakeEmail,
                child: BounceWidget(
                  bounce: bounceEmail,
                  child: TextFormField(
                    controller: _email,
                    focusNode: emailFocus,
                    decoration: _dec(
                      "Email Address",
                      Icons.email,
                      highlight: emailFocus.hasFocus && _email.text.contains("@"),
                    ).copyWith(
                      suffixIcon: _email.text.contains("@")
                          ? const Text('🎉', style: TextStyle(fontSize: 18))
                          : null,
                    ),
                    validator: (v) {
                      if (v == null || !v.contains("@")) return "Enter valid email address";
                      setState(() {
                        bounceEmail = true;
                        shakeEmail = false;
                      });
                      return null;
                    },
                  ),
                ),
              ),
              const SizedBox(height: 15),
              ShakeWidget(
                shake: shakeDob,
                child: BounceWidget(
                  bounce: bounceDob,
                  child: TextFormField(
                    controller: _dob,
                    focusNode: dobFocus,
                    readOnly: true,
                    onTap: pickDate,
                    decoration: _dec(
                      "Date of Birth",
                      Icons.calendar_today,
                      highlight: dobFocus.hasFocus && _dob.text.isNotEmpty,
                    ).copyWith(suffixIcon: const Icon(Icons.date_range)),
                    validator: (v) {
                      if (v == null || v.isEmpty) return "Select date";
                      setState(() {
                        bounceDob = true;
                        shakeDob = false;
                      });
                      return null;
                    },
                  ),
                ),
              ),
              const SizedBox(height: 15),
              ShakeWidget(
                shake: shakePassword,
                child: BounceWidget(
                  bounce: bouncePassword,
                  child: TextFormField(
                    controller: _password,
                    focusNode: passwordFocus,
                    obscureText: !showPassword,
                    decoration: _dec(
                      "Secret Password",
                      Icons.lock,
                      highlight: passwordFocus.hasFocus && _password.text.length >= 6,
                    ).copyWith(
                      suffixIcon: IconButton(
                        icon: Icon(
                          showPassword ? Icons.visibility : Icons.visibility_off,
                        ),
                        onPressed: () => setState(() => showPassword = !showPassword),
                      ),
                    ),
                    validator: (v) {
                      if (v == null || v.length < 6) return "Minimum 6 characters";
                      setState(() {
                        bouncePassword = true;
                        shakePassword = false;
                      });
                      return null;
                    },
                  ),
                ),
              ),
              PasswordStrengthMeter(password: _password.text),
              const SizedBox(height: 20),
              AvatarPicker(
                selectedIndex: avatarIndex,
                onSelect: (i) => setState(() => avatarIndex = i),
              ),
              const SizedBox(height: 20),
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                height: 56,
                width: loading ? 60 : double.infinity,
                child: loading
                    ? const Center(
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation(Colors.deepPurple),
                        ),
                      )
                    : ElevatedButton(
                        onPressed: submit,
                        style: ElevatedButton.styleFrom(backgroundColor: Colors.deepPurple),
                        child: const Text("Start My Adventures"),
                      ),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
