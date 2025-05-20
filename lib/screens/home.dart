/*import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _pwController = TextEditingController();
  bool _isButtonEnabled = false;

  void _checkFields() {
    setState(() {
      _isButtonEnabled = _idController.text.isNotEmpty && _pwController.text.isNotEmpty;
    });
  }

  @override
  void initState() {
    super.initState();
    _idController.addListener(_checkFields);
    _pwController.addListener(_checkFields);
  }

  @override
  void dispose() {
    _idController.dispose();
    _pwController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('로그인')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(
              controller: _idController,
              decoration: InputDecoration(labelText: '아이디'),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _pwController,
              obscureText: true,
              decoration: InputDecoration(labelText: '비밀번호'),
            ),
            SizedBox(height: 24),
            ElevatedButton(
              onPressed: _isButtonEnabled ? () {
                // 로그인 로직 작성
              } : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: _isButtonEnabled ? Colors.blue : Colors.grey,
              ),
              child: Text('로그인하기'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // 카카오 로그인 로직
              },
              child: Text('카카오로 시작하기'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/register');
              },
              child: Text('회원가입 시작하기'),
            )
          ],
        ),
      ),
    );
  }
}
*/