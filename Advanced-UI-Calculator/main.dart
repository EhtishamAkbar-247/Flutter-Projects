import 'dart:math' as math;
import 'package:flutter/material.dart';

void main() {
  runApp(const CalculatorApp());
}

// --- Theme Definitions ---

class CalcTheme {
  final String name;
  final Color bg;
  final Color containerColor;
  final Color containerBorderColor;
  final Color displayColor;
  final Color displayShadowColor;
  final Color btnBase;
  final Color btnBaseText;
  final Color btnBaseBorder;
  final Color btnOperator;
  final Color btnOperatorText;
  final Color btnOperatorBorder;
  final Color btnAction;
  final Color btnActionText;
  final Color btnActionBorder;
  final Color btnEqual;
  final Color btnEqualText;
  final Color btnEqualBorder;
  final Color copyrightColor;
  final List<Color> glowColors;

  const CalcTheme({
    required this.name,
    required this.bg,
    required this.containerColor,
    required this.containerBorderColor,
    required this.displayColor,
    required this.displayShadowColor,
    required this.btnBase,
    required this.btnBaseText,
    required this.btnBaseBorder,
    required this.btnOperator,
    required this.btnOperatorText,
    required this.btnOperatorBorder,
    required this.btnAction,
    required this.btnActionText,
    required this.btnActionBorder,
    required this.btnEqual,
    required this.btnEqualText,
    required this.btnEqualBorder,
    required this.copyrightColor,
    required this.glowColors,
  });
}

final Map<String, CalcTheme> themes = {
  'neon': const CalcTheme(
    name: 'Neon Night',
    bg: Color(0xFF030712), // gray-950
    containerColor: Color(0xCC111827), // gray-900/80
    containerBorderColor: Color(0x4DCA8A04), // purple-500/30 (approx adjustment)
    displayColor: Color(0xFF22D3EE), // cyan-400
    displayShadowColor: Color(0x8022D3EE),
    btnBase: Color(0xFF1F2937), // gray-800
    btnBaseText: Color(0xFFE5E7EB), // gray-200
    btnBaseBorder: Color(0xFF374151), // gray-700
    btnOperator: Color(0xFF111827), // gray-900
    btnOperatorText: Color(0xFFC084FC), // purple-400
    btnOperatorBorder: Color(0x80581C87), // purple-900/50
    btnAction: Color(0xFF111827),
    btnActionText: Color(0xFFF87171), // red-400
    btnActionBorder: Color(0x807F1D1D),
    btnEqual: Color(0x66164E63), // cyan-900/40
    btnEqualText: Color(0xFF67E8F9), // cyan-300
    btnEqualBorder: Color(0xFF0E7490), // cyan-700
    copyrightColor: Colors.grey,
    glowColors: [Colors.purple, Colors.cyan],
  ),
  'cyber': const CalcTheme(
    name: 'Cyberpunk',
    bg: Color(0xFF422006), // yellow-950 approx
    containerColor: Color(0xE6713F12), // yellow-900/90
    containerBorderColor: Color(0xFFEAB308), // yellow-500
    displayColor: Color(0xFFFACC15), // yellow-400
    displayShadowColor: Colors.black26,
    btnBase: Color(0xFF111827),
    btnBaseText: Color(0xFFEAB308), // yellow-500
    btnBaseBorder: Color(0xFF854D0E), // yellow-800
    btnOperator: Color(0xFF000000),
    btnOperatorText: Color(0xFF22D3EE), // cyan-400
    btnOperatorBorder: Color(0xFF155E75), // cyan-800
    btnAction: Color(0xFF000000),
    btnActionText: Color(0xFFEF4444), // red-500
    btnActionBorder: Color(0xFF991B1B), // red-800
    btnEqual: Color(0xFFCA8A04), // yellow-600
    btnEqualText: Colors.black,
    btnEqualBorder: Color(0xFFEAB308), // yellow-400
    copyrightColor: Color(0xFFA16207), // yellow-700
    glowColors: [Colors.yellow, Colors.cyan],
  ),
  'ocean': const CalcTheme(
    name: 'Deep Ocean',
    bg: Color(0xFF172554), // blue-950
    containerColor: Color(0x991E3A8A), // blue-900/60
    containerBorderColor: Color(0x3360A5FA), // blue-400/20
    displayColor: Color(0xFFDBEAFE), // blue-100
    displayShadowColor: Colors.transparent,
    btnBase: Color(0x801E40AF), // blue-800/50
    btnBaseText: Color(0xFFDBEAFE), // blue-100
    btnBaseBorder: Color(0x801D4ED8), // blue-700/50
    btnOperator: Color(0xCC172554), // blue-950/80
    btnOperatorText: Color(0xFF5EEAD4), // teal-300
    btnOperatorBorder: Color(0x80134E4A), // teal-900/50
    btnAction: Color(0xCC172554),
    btnActionText: Color(0xFFFDA4AF), // rose-300
    btnActionBorder: Color(0x80881337), // rose-900/50
    btnEqual: Color(0xCC0D9488), // teal-600/80
    btnEqualText: Colors.white,
    btnEqualBorder: Color(0xFF14B8A6), // teal-500
    copyrightColor: Color(0x8060A5FA), // blue-400/50
    glowColors: [Colors.blue, Colors.tealAccent],
  ),
  'minimal': const CalcTheme(
    name: 'Clean White',
    bg: Color(0xFFF3F4F6), // gray-100
    containerColor: Color(0xE6FFFFFF), // white/90
    containerBorderColor: Color(0xFFE5E7EB), // gray-200
    displayColor: Color(0xFF1F2937), // gray-800
    displayShadowColor: Colors.transparent,
    btnBase: Color(0xFFF9FAFB), // gray-50
    btnBaseText: Color(0xFF4B5563), // gray-600
    btnBaseBorder: Color(0xFFE5E7EB), // gray-200
    btnOperator: Color(0xFFFFF7ED), // orange-50
    btnOperatorText: Color(0xFFEA580C), // orange-600
    btnOperatorBorder: Color(0xFFFFEDD5), // orange-100
    btnAction: Color(0xFFFEF2F2), // red-50
    btnActionText: Color(0xFFDC2626), // red-600
    btnActionBorder: Color(0xFFFEE2E2), // red-100
    btnEqual: Color(0xFF2563EB), // blue-600
    btnEqualText: Colors.white,
    btnEqualBorder: Color(0xFF2563EB),
    copyrightColor: Color(0xFF9CA3AF), // gray-400
    glowColors: [Colors.grey, Colors.blue],
  ),
};

// --- Math Parser ---

class MathParser {
  // A simple recursive descent parser or similar logic to evaluate expressions string
  // For a single file solution without external libs like math_expressions.

  double evaluate(String expression) {
    String cleanExpr = expression
        .replaceAll('×', '*')
        .replaceAll('÷', '/')
        .replaceAll('π', math.pi.toString())
        .replaceAll('e', math.e.toString())
        .replaceAll(' ', '');

    // Handle Factorial manually before parsing standard operators if possible,
    // or inside the parser. A regex replace is tricky for nested logic.
    // Let's rely on a basic tokenizer and shunting-yard algorithm for robustness.
    try {
      List<String> rpn = _shuntingYard(cleanExpr);
      return _evaluateRPN(rpn);
    } catch (e) {
      throw Exception('Error');
    }
  }

  // Operators precedence
  int _precedence(String op) {
    if (['sin', 'cos', 'tan', 'log', 'ln', 'sqrt', 'abs', 'fact'].contains(op)) {
      return 4;
    }
    if (op == '^') return 3;
    if (op == '*' || op == '/' || op == '%') return 2;
    if (op == '+' || op == '-') return 1;
    return 0;
  }

  bool _isOperator(String c) {
    return ['+', '-', '*', '/', '^', '%'].contains(c);
  }

  bool _isFunction(String s) {
    return ['sin', 'cos', 'tan', 'log', 'ln', 'sqrt', 'abs', 'fact'].contains(s);
  }

  List<String> _shuntingYard(String expr) {
    List<String> outputQueue = [];
    List<String> operatorStack = [];
    
    // Tokenizer
    RegExp regex = RegExp(r'(\d+(\.\d+)?)|([a-z]+)|([\+\-\*\/\^\%\!\(\)])');
    Iterable<Match> matches = regex.allMatches(expr);

    String? prevToken;

    for (var match in matches) {
      String token = match.group(0)!;

      // Handle unary minus: if '-' is first or follows an operator or '('
      if (token == '-' && (prevToken == null || _isOperator(prevToken) || prevToken == '(')) {
        // Treat as negative number part or special unary. 
        // For simplicity in this demo, let's just push 0 then -
        outputQueue.add('0');
        while (operatorStack.isNotEmpty && 
               operatorStack.last != '(' && 
               _precedence(operatorStack.last) >= _precedence('-')) {
          outputQueue.add(operatorStack.removeLast());
        }
        operatorStack.add('-');
      } 
      else if (double.tryParse(token) != null) {
        outputQueue.add(token);
      } else if (token == 'fact') { // Treat fact as function if typed 'fact('
         operatorStack.add(token);
      } else if (_isFunction(token)) {
        operatorStack.add(token);
      } else if (token == ',') {
        while (operatorStack.isNotEmpty && operatorStack.last != '(') {
          outputQueue.add(operatorStack.removeLast());
        }
      } else if (_isOperator(token)) {
        while (operatorStack.isNotEmpty &&
            operatorStack.last != '(' &&
            (_precedence(operatorStack.last) > _precedence(token) ||
                (_precedence(operatorStack.last) == _precedence(token) && token != '^'))) {
          outputQueue.add(operatorStack.removeLast());
        }
        operatorStack.add(token);
      } else if (token == '(') {
        operatorStack.add(token);
      } else if (token == ')') {
        while (operatorStack.isNotEmpty && operatorStack.last != '(') {
          outputQueue.add(operatorStack.removeLast());
        }
        if (operatorStack.isNotEmpty && operatorStack.last == '(') {
          operatorStack.removeLast(); // Pop '('
          if (operatorStack.isNotEmpty && _isFunction(operatorStack.last)) {
            outputQueue.add(operatorStack.removeLast());
          }
        }
      } else if (token == '!') {
         // Postfix factorial
         // We can treat it as an operator with high precedence or immediate action
         // Let's add a special function '!'
         outputQueue.add('!');
      }

      prevToken = token;
    }

    while (operatorStack.isNotEmpty) {
      outputQueue.add(operatorStack.removeLast());
    }

    return outputQueue;
  }

  double _evaluateRPN(List<String> rpn) {
    List<double> stack = [];

    for (String token in rpn) {
      if (double.tryParse(token) != null) {
        stack.add(double.parse(token));
      } else if (token == '!') {
         if (stack.isEmpty) throw Exception("Invalid");
         double a = stack.removeLast();
         stack.add(_factorial(a));
      } else if (_isOperator(token) || _isFunction(token)) {
        if (_isFunction(token)) {
          if (stack.isEmpty) throw Exception("Args");
          double a = stack.removeLast();
          if (token == 'sin') {
            stack.add(math.sin(a));
          } else if (token == 'cos') {
            stack.add(math.cos(a));
          } else if (token == 'tan') {
            stack.add(math.tan(a));
          } else if (token == 'log') {
            stack.add(math.log(a) / math.ln10);
          } else if (token == 'ln') {
            stack.add(math.log(a));
          } else if (token == 'sqrt') {
            stack.add(math.sqrt(a));
          } else if (token == 'abs') {
            stack.add(a.abs());
          } else if (token == 'fact') {
            stack.add(_factorial(a));
          }
        } else {
          // Binary ops
          if (stack.length < 2) throw Exception("Args");
          double b = stack.removeLast();
          double a = stack.removeLast();
          if (token == '+') {
            stack.add(a + b);
          } else if (token == '-') {
            stack.add(a - b);
          } else if (token == '*') {
            stack.add(a * b);
          } else if (token == '/') {
            stack.add(a / b);
          } else if (token == '^') {
            stack.add(math.pow(a, b).toDouble());
          } else if (token == '%') {
            stack.add(a % b);
          }
        }
      }
    }
    if (stack.length != 1) throw Exception("Result");
    return stack.single;
  }

  double _factorial(double n) {
    if (n < 0) return double.nan;
    if (n == 0 || n == 1) return 1;
    double res = 1;
    for (int i = 2; i <= n.toInt(); i++) {
      res *= i;
    }
    return res;
  }
}


// --- Main App Widget ---

class CalculatorApp extends StatelessWidget {
  const CalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Modern Calculator',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Roboto', // Default flutter font
        useMaterial3: true,
      ),
      home: const CalculatorScreen(),
    );
  }
}

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> with TickerProviderStateMixin {
  String _currentThemeKey = 'neon';
  // Mode logic removed to stay basic
  String _input = '';
  String _result = '';
  final List<String> _history = [];
  bool _isCalculated = false;

  final MathParser _parser = MathParser();

  void _onThemeChanged(String key) {
    setState(() {
      _currentThemeKey = key;
    });
  }

  void _handlePress(String val) {
    setState(() {
      if (_isCalculated && !['DEL', 'C'].contains(val)) {
        if (['+', '-', '×', '÷', '^', '%'].contains(val)) {
          _input = _result + val;
          _isCalculated = false;
        } else {
          _input = '';
          _isCalculated = false;
        }
      }
      
      if (_isCalculated && ['DEL', 'C'].contains(val)) {
          _isCalculated = false;
      }

      if (val == 'C') {
        _input = '';
        _result = '';
        _isCalculated = false;
      } else if (val == 'DEL') {
        if (_input.isNotEmpty) {
          _input = _input.substring(0, _input.length - 1);
        }
      } else if (val == '=') {
        try {
          if (_input.isEmpty) return;
          double res = _parser.evaluate(_input);
          String resStr = res.toString();
          if (resStr.endsWith('.0')) resStr = resStr.substring(0, resStr.length - 2);
          
          _history.insert(0, '$_input = $resStr');
          if (_history.length > 5) _history.removeLast();
          
          _result = resStr;
          _isCalculated = true;
        } catch (e) {
          _result = 'Error';
          _isCalculated = true;
        }
      } else {
        _input += val;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = themes[_currentThemeKey]!;
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < 600;

    // Background Blobs (Simple decorative containers)
    return Scaffold(
      backgroundColor: theme.bg,
      body: Stack(
        children: [
          // Ambient Glows
          Positioned(
            top: -100,
            left: -100,
            child: Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: theme.glowColors[0].withValues(alpha: 0.2),
                boxShadow: [
                  BoxShadow(color: theme.glowColors[0], blurRadius: 100, spreadRadius: 20)
                ]
              ),
            ),
          ),
          Positioned(
            bottom: -100,
            right: -100,
            child: Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: theme.glowColors[1].withValues(alpha: 0.2),
                boxShadow: [
                  BoxShadow(color: theme.glowColors[1], blurRadius: 100, spreadRadius: 20)
                ]
              ),
            ),
          ),

          // Main Content
          Center(
            child: SingleChildScrollView(
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 500),
                width: 380, // Fixed width for Basic Mode
                constraints: const BoxConstraints(maxWidth: 600),
                margin: const EdgeInsets.all(16),
                padding: const EdgeInsets.all(16), // Reduced padding
                decoration: BoxDecoration(
                  color: theme.containerColor,
                  borderRadius: BorderRadius.circular(32),
                  border: Border.all(color: theme.containerBorderColor, width: 1),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.3),
                      blurRadius: 30,
                      offset: const Offset(0, 10),
                    )
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Header
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: themes.keys.map((k) {
                            final isActive = _currentThemeKey == k;
                            return GestureDetector(
                              onTap: () => _onThemeChanged(k),
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 300),
                                margin: const EdgeInsets.only(right: 8),
                                width: isActive ? 28 : 24,
                                height: isActive ? 28 : 24,
                                decoration: BoxDecoration(
                                  color: k == 'neon' ? Colors.purple : 
                                         k == 'cyber' ? Colors.yellow :
                                         k == 'ocean' ? Colors.blue : Colors.grey,
                                  shape: BoxShape.circle,
                                  border: isActive ? Border.all(color: Colors.white, width: 2) : null,
                                  boxShadow: isActive ? [const BoxShadow(color: Colors.white, blurRadius: 10)] : null,
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                        // Mode Text Removed as requested
                      ],
                    ),

                    const SizedBox(height: 10),

                    // Display - FIXED HEIGHT CONTAINER to prevent layout shift
                    Container(
                      height: 120, // Fixed height reserved for input and result
                      alignment: Alignment.bottomRight,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                           Text(
                            _history.isNotEmpty ? _history.first : '',
                            style: TextStyle(color: theme.copyrightColor, fontSize: 14),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 4),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            reverse: true,
                            child: Text(
                              _input.isEmpty ? '0' : _input,
                              style: TextStyle(
                                color: theme.displayColor,
                                fontSize: 36,
                                fontWeight: FontWeight.w300,
                                shadows: [
                                  Shadow(color: theme.displayShadowColor, blurRadius: 10)
                                ]
                              ),
                            ),
                          ),
                          // Result is always part of layout stack, just empty if null to prevent jump
                          SizedBox(
                            height: 32, 
                            child: _result.isNotEmpty ? Text(
                              '= $_result',
                              style: TextStyle(
                                color: theme.displayColor.withValues(alpha: 0.8),
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ) : null,
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 10),
                    Divider(color: Colors.white.withValues(alpha: 0.1)),
                    const SizedBox(height: 10),

                    // Keypad
                    LayoutBuilder(
                      builder: (context, constraints) {
                        // Basic Mode = 4 Columns
                        const cols = 4;
                        const gap = 10.0;
                        final itemWidth = (constraints.maxWidth - (cols - 1) * gap) / cols;
                        final itemHeight = isMobile ? 55.0 : 60.0; // Slightly reduced height

                        // Generate Buttons List
                        List<Widget> buttons = [];
                        
                        // Helper to add button
                        void addBtn(String label, {String? display, String type = 'base', int colSpan = 1}) {
                          buttons.add(
                            CalcButton(
                              label: label,
                              displayLabel: display,
                              type: type,
                              theme: theme,
                              width: itemWidth * colSpan + (gap * (colSpan - 1)),
                              height: itemHeight,
                              onTap: () => _handlePress(label),
                            )
                          );
                        }

                        // --- BASIC BUTTON LAYOUT ---
                        
                        // Row 1
                        addBtn('C', type: 'action');
                        addBtn('DEL', type: 'action');
                        addBtn('%', type: 'operator');
                        addBtn('÷', type: 'operator');
                        
                        // Row 2
                        addBtn('7');
                        addBtn('8');
                        addBtn('9');
                        addBtn('×', type: 'operator');

                        // Row 3
                        addBtn('4');
                        addBtn('5');
                        addBtn('6');
                        addBtn('-', type: 'operator');

                        // Row 4
                        addBtn('1');
                        addBtn('2');
                        addBtn('3');
                        addBtn('+', type: 'operator');

                        // Row 5
                        addBtn('0', colSpan: 2);
                        addBtn('.');
                        addBtn('=', type: 'equal'); // Only 1 width in Basic

                        return Wrap(
                          spacing: gap,
                          runSpacing: gap,
                          children: buttons,
                        );
                      },
                    ),

                    const SizedBox(height: 20),

                    // Copyright
                    Column(
                      children: [
                        Text(
                          '© 2026 Ehtisham Akbar || FA23-BCS-247',
                          style: TextStyle(
                            color: theme.copyrightColor,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 2,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'All Rights Reserved',
                          style: TextStyle(
                            color: theme.copyrightColor.withValues(alpha: 0.5),
                            fontSize: 9,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CalcButton extends StatefulWidget {
  final String label;
  final String? displayLabel;
  final String type; // base, operator, action, equal
  final CalcTheme theme;
  final double width;
  final double height;
  final VoidCallback onTap;

  const CalcButton({
    super.key,
    required this.label,
    this.displayLabel,
    required this.type,
    required this.theme,
    required this.width,
    required this.height,
    required this.onTap,
  });

  @override
  State<CalcButton> createState() => _CalcButtonState();
}

class _CalcButtonState extends State<CalcButton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    Color bg, text, border;
    switch (widget.type) {
      case 'operator':
        bg = widget.theme.btnOperator;
        text = widget.theme.btnOperatorText;
        border = widget.theme.btnOperatorBorder;
        break;
      case 'action':
        bg = widget.theme.btnAction;
        text = widget.theme.btnActionText;
        border = widget.theme.btnActionBorder;
        break;
      case 'equal':
        bg = widget.theme.btnEqual;
        text = widget.theme.btnEqualText;
        border = widget.theme.btnEqualBorder;
        break;
      default:
        bg = widget.theme.btnBase;
        text = widget.theme.btnBaseText;
        border = widget.theme.btnBaseBorder;
    }

    return GestureDetector(
      onTapDown: (_) => setState(() => _isPressed = true),
      onTapUp: (_) {
        setState(() => _isPressed = false);
        widget.onTap();
      },
      onTapCancel: () => setState(() => _isPressed = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 100),
        width: widget.width,
        height: widget.height,
        transform: Matrix4.diagonal3Values(
          _isPressed ? 0.95 : 1.0, 
          _isPressed ? 0.95 : 1.0, 
          1.0
        ),
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: border),
          boxShadow: _isPressed 
            ? [] 
            : [
              if (widget.type == 'equal' || widget.type == 'operator')
                 BoxShadow(color: border.withValues(alpha: 0.3), blurRadius: 10, spreadRadius: 1)
            ],
        ),
        alignment: Alignment.center,
        child: Text(
          widget.displayLabel ?? widget.label,
          style: TextStyle(
            color: text,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}