/**
 * Test the sequence of console messages and time intervals between them.
 */
import 'dart:io';

String currentTime() {
    var now = DateTime.now();

    String minute = now.minute.toString().padLeft(2, '0');
    String second = now.second.toString().padLeft(2, '0');

    return '$minute:$second';
}

Future<String> B() async {
    print('[${currentTime()}]                 B() begin');

    print('[${currentTime()}]                 B() BEFORE SLEEP');

    sleep(const Duration(seconds: 3));
    
    print('[${currentTime()}]                 B() AFTER SLEEP');

    print('[${currentTime()}]                 B() BEFORE DELAY');
    
    String b = await Future<String>.delayed(Duration(seconds: 3), () => 'World');

    print('[${currentTime()}]                 B() AFTER DELAY');
    
    print('[${currentTime()}]                 B() end');
    
    return b;
}

Future<String> A() async {
    print('[${currentTime()}]         A() begin');

    print('[${currentTime()}]         A() BEFORE SLEEP');

    sleep(const Duration(seconds: 3));
    
    print('[${currentTime()}]         A() AFTER SLEEP');

    print('[${currentTime()}]         A() BEFORE call B()');

    String b = await B();

    print('[${currentTime()}]         A() AFTER call B()');

    print('[${currentTime()}]         A() BEFORE DELAY');

    String a = await Future<String>.delayed(Duration(seconds: 3), () => 'Hello');

    print('[${currentTime()}]         A() AFTER DELAY');

    print('[${currentTime()}]         A() end');
    
    return a + ' ' + b;
}

void main() {
    print('[${currentTime()}] main() BEFORE call A()');
    
    Future<String> r = A();
    
    print('[${currentTime()}] main() AFTER call A()');
    
    print('[${currentTime()}] main() r: ${r}');

    r.then((value) => print('[${currentTime()}] main() value: ${value}'));
}
