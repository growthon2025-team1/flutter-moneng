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
        child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: w * 0.06),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
                  SizedBox(height: h * 0.03),
                  GestureDetector(
                    onTap: () {
                       if (_step > 1) {
                         setState(() => _step--);
                       } else {
                          Navigator.pop(context);
                             }
                          },
                        child: Image.asset('assets/images/angleleft.png', width: 24, height: 24),
                         ), 
                  SizedBox(height: h * 0.03),
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
                      style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
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
                    (_rePasswordController.text != _passwordController.text ||
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

              SizedBox(height: h * 0.03),

              Center(
                child: GestureDetector(
                  onTap: () {
                    if (_step == 1 && _nameCompleted) {
                      setState(() {
                        _step = 2;
                        _idController.clear();
                      });
                    } else if (_step == 2 && _idValid) {
                      setState(() => _step = 3);
                    } else if (_step == 3 && _isPasswordValid(_passwordController.text)) {
                      setState(() => _step = 4);
                    } else if (_step == 4 &&
                        _rePasswordController.text == _passwordController.text &&
                        _isPasswordValid(_rePasswordController.text)) {
                    }
                  },
                  child: Image.asset(
                    (_step == 1 && !_nameCompleted) ||
                            (_step == 2 && !_idValid) ||
                            (_step == 3 && !_isPasswordValid(_passwordController.text)) ||
                            (_step == 4 &&
                                (_rePasswordController.text != _passwordController.text ||
                                    !_isPasswordValid(_rePasswordController.text)) {
                                      Navigator.pushNamed(context, '/registered');
                                    })
                        ? 'assets/images/Group233.png'
                        : (_step == 4
                            ? 'assets/images/ok.png'
                            : 'assets/images/Group235.png'),
                    width: 346,
                    height: 53,
                  ),
                ),
              ),
              SizedBox(height: h * 0.03),
            ],
          ),
        ),
      ),
     ),
    );
  }

  Widget _buildNameInput() {
    return FocusScope(
      child: Focus(
        onFocusChange: (hasFocus) => setState(() => _nameFocused = hasFocus),
        child: Container(
          width: 346,
          height: 42,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: _nameFocused ? const Color(0xFF657AE3) : const Color(0xFFBCBCBC),
              width: 1.2,
            ),
          ),
          alignment: Alignment.centerLeft,
          child: TextField(
            controller: _nameController,
            cursorColor: const Color(0xFF657AE3),
            style: const TextStyle(fontSize: 14),
            decoration: InputDecoration(
              hintText: '내용을 입력해 주세요.',
              hintStyle: TextStyle(
                color: _nameFocused ? Colors.black45 : Colors.black38,
                fontSize: 14,
              ),
              border: InputBorder.none,
            ),
            onChanged: (text) {
              setState(() {
                _nameCompleted = text.isNotEmpty;
              });
            },
          ),
        ),
      ),
    );
  }

  Widget _buildIdInput() {
    return FocusScope(
      child: Focus(
        onFocusChange: (hasFocus) => setState(() => _idFocused = hasFocus),
        child: Container(
          width: 346,
          height: 42,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: _idChecked
                  ? (_idTaken ? const Color(0xFFDE4242) : const Color(0xFF657AE3))
                  : (_idFocused ? const Color(0xFF657AE3) : const Color(0xFF929292)),
              width: 1.5,
            ),
          ),
          alignment: Alignment.centerLeft,
          child: TextField(
            controller: _idController,
            cursorColor: const Color(0xFF657AE3),
            style: const TextStyle(fontSize: 14),
            decoration: InputDecoration(
              hintText: '내용을 입력해 주세요.',
              hintStyle: const TextStyle(color: Color(0xFF929292), fontSize: 14),
              border: InputBorder.none,
              suffixIcon: _idChecked
                  ? (_idTaken
                      ? Image.asset('assets/images/error_icon.png', width: 18)
                      : Image.asset('assets/images/check.png', width: 18))
                  : null,
            ),
            onChanged: (text) {
              setState(() {
                bool _isIdValid(String id) {
                  final regex = RegExp(r'^[a-zA-Z0-9]{4,12}$');
                  return regex.hasMatch(id);
                }

                _idChecked = true;
                _idTaken = (text == 'dandan' || text == 'kitty0908');
                _idValid = _isIdValid(text) && !_idTaken;
              });
            },
          ),
        ),
      ),
    );
  }

  Widget _buildPasswordInput() {
    return FocusScope(
      child: Focus(
        onFocusChange: (hasFocus) => setState(() => _passwordFocused = hasFocus),
        child: Container(
          width: 346,
          height: 42,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: _passwordController.text.isEmpty
                  ? const Color(0xFFBCBCBC)
                  : (_isPasswordValid(_passwordController.text)
                      ? const Color(0xFF657AE3)
                      : const Color(0xFFDE4242)),
              width: 1.5,
            ),
          ),
          alignment: Alignment.centerLeft,
          child: TextField(
            controller: _passwordController,
            obscureText: true,
            cursorColor: const Color(0xFF657AE3),
            style: const TextStyle(fontSize: 14),
            decoration: InputDecoration(
              hintText: '내용을 입력해 주세요.',
              hintStyle: const TextStyle(color: Color(0xFF929292), fontSize: 14),
              border: InputBorder.none,
              suffixIcon: _passwordController.text.isEmpty
                  ? null
                  : (_isPasswordValid(_passwordController.text)
                      ? Image.asset('assets/images/check.png', width: 18)
                      : Image.asset('assets/images/error_icon.png', width: 18)),
            ),
            onChanged: (text) => setState(() {}),
          ),
        ),
      ),
    );
  }

  Widget _buildRePasswordInput() {
  final isValid = _rePasswordController.text == _passwordController.text &&
      _isPasswordValid(_rePasswordController.text);
  return FocusScope(
    child: Focus(
      onFocusChange: (hasFocus) => setState(() => _rePasswordFocused = hasFocus),
      child: Container(
        width: 346,
        height: 42,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: _rePasswordController.text.isEmpty
                ? const Color(0xFFBCBCBC)
                : isValid
                    ? const Color(0xFF657AE3)
                    : const Color(0xFFDE4242),
            width: 1.5,
          ),
        ),
       alignment: Alignment.centerLeft,
        child: TextField(
          controller: _rePasswordController,
          obscureText: true,
          cursorColor: const Color(0xFF657AE3),
          style: const TextStyle(fontSize: 14),
          decoration: InputDecoration(
            hintText: '내용을 입력해 주세요.',
            hintStyle: const TextStyle(color: Color(0xFF929292), fontSize: 14),
            border: InputBorder.none,
            suffixIcon: _rePasswordController.text.isEmpty
                ? null
                : (_rePasswordController.text == _passwordController.text &&
                        _isPasswordValid(_rePasswordController.text))
                    ? Image.asset('assets/images/check1.png', width: 18)
                    : Image.asset('assets/images/error_icon.png', width: 18),
          ),
          onChanged: (text) => setState(() {}),
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