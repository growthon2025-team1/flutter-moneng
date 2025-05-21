import 'package:flutter/material.dart';

class SignupStartScreen extends StatefulWidget {
  const SignupStartScreen({super.key});

  @override
  State<SignupStartScreen> createState() => _SignupStartScreenState();
}

class _SignupStartScreenState extends State<SignupStartScreen> {
  int _step = 1;

  final _nameController = TextEditingController();
  final _idController = TextEditingController();
  final _passwordController = TextEditingController();
  final _rePasswordController = TextEditingController();

  bool _nameFocused = false;
  bool _idFocused = false;
  bool _passwordFocused = false;
  bool _rePasswordFocused = false;

  bool _nameCompleted = false;
  bool _idValid = false;
  bool _idTaken = false;
  bool _idChecked = false;

  bool _isPasswordValid(String password) {
    final regex = RegExp(r'^(?=.*[!@#\$&*~])(?=.*[a-zA-Z])(?=.*\d).{8,}$');
    return regex.hasMatch(password);
  }

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: h * 0.1),
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: w * 0.06),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: h * 0.1),

                    Text(
                      _step == 3
                          ? '거의 다 왔어요!'
                          : (_step == 4
                              ? '이제 냉장고를\n구경하러 갈까요?'
                              : '모두의 냉장고\n시작하기'),
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: h * 0.04),
                    Row(
                      children: [
                        Container(
                          width: 16,
                          height: 16,
                          decoration: const BoxDecoration(
                            color: Color(0xFF657AE3),
                            shape: BoxShape.circle,
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            '$_step',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(width: 6),
                        Text(
                          _step == 1
                              ? '이름을 입력해 주세요.'
                              : _step == 2
                                  ? '아이디를 입력해 주세요.'
                                  : _step == 3
                                      ? '비밀번호를 입력해 주세요.'
                                      : '비밀번호를 다시 한 번 입력해 주세요.',
                          style: const TextStyle(fontSize: 14),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),

                    if (_step == 1) _buildNameInput(),

                    if (_step == 2) ...[
                      _buildIdInput(),
                      if (_idChecked && _idTaken)
                        const Padding(
                          padding: EdgeInsets.only(top: 6, left: 4),
                          child: Text(
                            '이미 사용 중인 아이디 입니다.',
                            style: TextStyle(
                              color: Color(0xFFDE4242),
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      const SizedBox(height: 8),
                      _readonlyBox(_nameController.text),
                    ],

                    if (_step == 3) ...[
                      _buildPasswordInput(),
                      if (_passwordController.text.isNotEmpty &&
                          !_isPasswordValid(_passwordController.text))
                        const Padding(
                          padding: EdgeInsets.only(top: 6, left: 4),
                          child: Text(
                            '특수문자를 포함한 8자 이상으로 조합해 주세요.',
                            style: TextStyle(
                              color: Color(0xFFDE4242),
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      const SizedBox(height: 8),
                      _readonlyBox(_idController.text),
                      const SizedBox(height: 8),
                      _readonlyBox(_nameController.text),
                    ],

                    if (_step == 4) ...[
                      _buildRePasswordInput(),
                      if (_rePasswordController.text.isNotEmpty &&
                          (_rePasswordController.text !=
                                  _passwordController.text ||
                              !_isPasswordValid(_rePasswordController.text)))
                        const Padding(
                          padding: EdgeInsets.only(top: 6, left: 4),
                          child: Text(
                            '특수문자를 포함한 8자 이상으로 조합해 주세요.',
                            style: TextStyle(
                              color: Color(0xFFDE4242),
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      const SizedBox(height: 8),
                      _readonlyBox(_passwordController.text),
                      const SizedBox(height: 8),
                      _readonlyBox(_idController.text),
                      const SizedBox(height: 8),
                      _readonlyBox(_nameController.text),
                    ],
                  ],
                ),
              ),
            ),

            Positioned(
              left: w * 0.01,
              top: h * 0.05,
              width: w * 0.13,
              height: h * 0.06,
              child: GestureDetector(
                onTap: () {
                  if (_step > 1) {
                    setState(() => _step--);
                  } else {
                    Navigator.pop(context);
                  }
                },
                child: Image.asset('assets/images/angleleft.png'),
              ),
            ),

            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.only(
                  bottom: h * 0.08,
                  left: w * 0.06,
                  right: w * 0.06,
                ),
                child: SizedBox(
                  width: w * 0.92,
                  height: h * 0.07,
                  child: GestureDetector(
                    onTap: () {
                      if (_step == 1 && _nameCompleted) {
                        setState(() {
                          _step = 2;
                          _idController.clear();
                        });
                      } else if (_step == 2 && _idValid) {
                        setState(() => _step = 3);
                      } else if (_step == 3 &&
                          _isPasswordValid(_passwordController.text)) {
                        setState(() => _step = 4);
                      } else if (_step == 4 &&
                          _rePasswordController.text ==
                              _passwordController.text &&
                          _isPasswordValid(_rePasswordController.text)) {
                        Navigator.pushNamed(context, '/signupComplete');
                      }
                    },
                    child: Image.asset(
                      (_step == 1 && !_nameCompleted) ||
                              (_step == 2 && !_idValid) ||
                              (_step == 3 &&
                                  !_isPasswordValid(_passwordController.text)) ||
                              (_step == 4 &&
                                  (_rePasswordController.text !=
                                          _passwordController.text ||
                                      !_isPasswordValid(
                                          _rePasswordController.text)))
                          ? 'assets/images/Group233.png'
                          : (_step == 4
                              ? 'assets/images/ok.png'
                              : 'assets/images/Group235.png'),
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNameInput() => _styledInput(
        controller: _nameController,
        focused: _nameFocused,
        onFocusChange: (f) => setState(() => _nameFocused = f),
        onChanged: (text) => setState(() => _nameCompleted = text.isNotEmpty),
      );

  Widget _buildIdInput() => _styledInput(
        controller: _idController,
        focused: _idFocused,
        onFocusChange: (f) => setState(() => _idFocused = f),
        onChanged: (text) {
          setState(() {
            _idChecked = true;
            _idTaken = (text == 'dandan' || text == 'kitty0908');
            _idValid = (text == 'dandan2');
          });
        },
        suffix: _idChecked
            ? (_idTaken
                ? Image.asset('assets/images/error_icon.png', width: 18)
                : Image.asset('assets/images/check.png', width: 18))
            : null,
        borderColor: _idChecked
            ? (_idTaken ? const Color(0xFFDE4242) : const Color(0xFF657AE3))
            : (_idFocused ? const Color(0xFF657AE3) : const Color(0xFF929292)),
      );

  Widget _buildPasswordInput() => _styledInput(
        controller: _passwordController,
        focused: _passwordFocused,
        obscure: true,
        onFocusChange: (f) => setState(() => _passwordFocused = f),
        onChanged: (_) => setState(() {}),
        suffix: _passwordController.text.isEmpty
            ? null
            : (_isPasswordValid(_passwordController.text)
                ? Image.asset('assets/images/check.png', width: 18)
                : Image.asset('assets/images/error_icon.png', width: 18)),
        borderColor: _passwordController.text.isEmpty
            ? const Color(0xFFBCBCBC)
            : (_isPasswordValid(_passwordController.text)
                ? const Color(0xFF657AE3)
                : const Color(0xFFDE4242)),
      );

  Widget _buildRePasswordInput() {
    final isValid = _rePasswordController.text == _passwordController.text &&
        _isPasswordValid(_rePasswordController.text);
    return _styledInput(
      controller: _rePasswordController,
      focused: _rePasswordFocused,
      obscure: true,
      onFocusChange: (f) => setState(() => _rePasswordFocused = f),
      onChanged: (_) => setState(() {}),
      suffix: _rePasswordController.text.isEmpty
          ? null
          : (isValid
              ? Image.asset('assets/images/check1.png', width: 18)
              : Image.asset('assets/images/error_icon.png', width: 18)),
      borderColor: _rePasswordController.text.isEmpty
          ? const Color(0xFFBCBCBC)
          : (isValid ? const Color(0xFF657AE3) : const Color(0xFFDE4242)),
    );
  }

  Widget _styledInput({
    required TextEditingController controller,
    required bool focused,
    required Function(bool) onFocusChange,
    required Function(String) onChanged,
    Widget? suffix,
    bool obscure = false,
    Color? borderColor,
  }) {
    return FocusScope(
      child: Focus(
        onFocusChange: onFocusChange,
        child: Container(
          width: 346,
          height: 42,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: borderColor ??
                  (focused
                      ? const Color(0xFF657AE3)
                      : const Color(0xFFBCBCBC)),
              width: 1.5,
            ),
          ),
          alignment: Alignment.centerLeft,
          child: TextField(
            controller: controller,
            obscureText: obscure,
            cursorColor: const Color(0xFF657AE3),
            style: const TextStyle(fontSize: 14),
            decoration: InputDecoration(
              hintText: '내용을 입력해 주세요.',
              hintStyle: const TextStyle(color: Color(0xFF929292), fontSize: 14),
              border: InputBorder.none,
              suffixIcon: suffix,
            ),
            onChanged: onChanged,
          ),
        ),
      ),
    );
  }

  Widget _readonlyBox(String value) {
    return IgnorePointer(
      child: Container(
        width: 346,
        height: 42,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: const Color(0xFF929292), width: 1.5),
        ),
        alignment: Alignment.centerLeft,
        child: TextField(
          controller: TextEditingController(text: value),
          readOnly: true,
          style: const TextStyle(fontSize: 14, color: Color(0xFF929292)),
          decoration: const InputDecoration(border: InputBorder.none),
        ),
      ),
    );
  }
}