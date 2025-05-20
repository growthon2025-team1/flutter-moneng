import 'package:flutter/material.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';


class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _pwController = TextEditingController();
  bool _isButtonEnabled = false;

  void _checkFields() {
    String id = _idController.text;
    String pw = _pwController.text;

    final passwordRegExp = RegExp(r'^(?=.*[!@#\$&*~])[A-Za-z\d!@#\$&*~]{8,}$');

    setState(() {
      _isButtonEnabled = id.isNotEmpty && passwordRegExp.hasMatch(pw);
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
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        toolbarHeight: 200,
        flexibleSpace: Padding(
          padding: const EdgeInsets.only(top: 82, left: 125),
          child: SizedBox(
            child: Center(
              child: Text(
                '혼자여도 함께인 식탁',
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 16,
                  height: 29.7 / 16,
                  color: Color(0xFF232323),
                ),
              ),
            ),
          ),
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 22),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 49),
              Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '아이디',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 12,
                        height: 19.8 / 12,
                        color: Color(0xFF232323),
                      ),
                    ),
                    SizedBox(height: 8),
                    Container(
                      width: 346,
                      height: 42,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Color(0xFF929292), width: 1.5),
                      ),
                      padding: const EdgeInsets.only(left: 18),
                      alignment: Alignment.centerLeft,
                      child: TextField(
                        controller: _idController,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: '아이디를 입력해 주세요.',
                          hintStyle: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                            height: 29.7 / 14,
                            color: Colors.grey.shade600,
                          ),
                          isDense: true,
                          contentPadding: EdgeInsets.zero,
                        ),
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    SizedBox(height: 14),
                    Text(
                      '비밀번호',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 12,
                        height: 19.8 / 12,
                        color: Color(0xFF232323),
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                      width: 346,
                      height: 42,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Color(0xFF929292), width: 1.5),
                      ),
                      padding: const EdgeInsets.only(left: 18),
                      alignment: Alignment.centerLeft,
                      child: TextField(
                        controller: _pwController,
                        obscureText: true,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: '비밀번호(특수문자 포함 8자 이상)',
                          hintStyle: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                            height: 29.7 / 14,
                            color: Colors.grey.shade600,
                          ),
                          isDense: true,
                          contentPadding: EdgeInsets.zero,
                        ),
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 17),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () {
                      // 아이디 찾기
                    },
                    child: Text(
                      '아이디 찾기',
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 15,
                        height: 29.7 / 10,
                        color: Color(0xFF232323),
                      ),
                    ),
                  ),
                  SizedBox(width: 38),
                  TextButton(
                    onPressed: () {
                      // 비밀번호 찾기
                    },
                    child: Text(
                      '비밀번호 찾기',
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 15,
                        height: 29.7 / 10,
                        color: Color(0xFF232323),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 30),
              Center(
                child: Container(
                  width: 346,
                  height: 60,
                  decoration: BoxDecoration(
                    color: Color(0xFFD9E2FB),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: TextButton(
                    onPressed: _isButtonEnabled ? () {
                      // 로그인 로직
                    } : null,
                    style: TextButton.styleFrom(
                      disabledForegroundColor: Colors.grey.shade400,
                      disabledBackgroundColor: Color(0xFFD9E2FB),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      '로그인 하기',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        height: 29.7 / 16,
                        color: _isButtonEnabled
                            ? Colors.black
                            : Colors.grey.shade600,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 100),
              Center(
                child: GestureDetector(
                  onTap: () {
                    void kakaoLogin() async {
                      try {
                        bool isInstalled = await isKakaoTalkInstalled();
                        if (isInstalled) {
                          await UserApi.instance.loginWithKakaoTalk();
                        } else {
                          await UserApi.instance.loginWithKakaoAccount();
                        }

                        final user = await UserApi.instance.me();
                        print('카카오 로그인 성공: ${user.kakaoAccount?.email}');
                      } catch (e) {
                        print('카카오 로그인 실패: $e');
                      }
                    }

                  },
                  child: Container(
                    width: 350,
                    height: 60,
                    decoration: BoxDecoration(
                      color: Color(0xFFFEE500),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(
                      child: Text(
                        '카카오로 시작하기',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          height: 29.7 / 16,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 16),
              Center(
                child: TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/register');
                  },
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                    minimumSize: Size(350, 60),
                  ),
                  child: Container(
                    width: 350,
                    height: 60,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Color(0xFFD9D9D9), width: 1.5),
                                  ),
                    child: Center(
                      child: Text(
                        '회원가입 시작하기',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
