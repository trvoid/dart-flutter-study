import 'dart:io';

String currentTime() {
    var now = DateTime.now();

    String minute = now.minute.toString().padLeft(2, '0');
    String second = now.second.toString().padLeft(2, '0');

    return '$minute:$second';
}

/**
 * hello1() "IS NOT" an async function.
 *   - Calls 2 async statements in sequence.
 *   - Does not wait until each async statement completes.
 */
void hello1() {
    print('[${currentTime()}]         hello1 start');
    
    sleep(Duration(seconds: 2));

    print('[${currentTime()}]         hello1 call first');

    Future<int> future = Future<int>.delayed(Duration(seconds: 3), (() => 101));

    future.then((value) => print('[${currentTime()}]         hello1 value first: $value'));

    print('[${currentTime()}]         hello1 call second');

    Future<int> future2 = Future<int>.delayed(Duration(seconds: 3), (() => 102));

    future2.then((value) => print('[${currentTime()}]         hello1 value second: $value'));

    print('[${currentTime()}]         hello1 end');
}

/**
 * hello2() "IS" an async function.
 *   - Calls 2 async statements in sequence.
 *   - Waits until each async statement completes.
 */
Future<void> hello2() async {
    print('[${currentTime()}]         hello2 start');

    sleep(Duration(seconds: 2));

    print('[${currentTime()}]         hello2 call first');

    var value = await Future<int>.delayed(Duration(seconds: 3), (() => 201));

    print('[${currentTime()}]         hello2 value first: $value');

    print('[${currentTime()}]         hello2 call second');

    var value2 = await Future<int>.delayed(Duration(seconds: 3), (() => 202));

    print('[${currentTime()}]         hello2 value second: $value2');

    print('[${currentTime()}]         hello2 end');
}

/**
 *  Calls 1 sync function and 1 async function in sequence.
 */
void main() {
    print('[${currentTime()}] main start');

    // hello1
    print('[${currentTime()}] hello1 BEFORE');
    hello1();
    print('[${currentTime()}] hello1 AFTER');
    
    // hello2()
    print('[${currentTime()}] hello2 BEFORE');
    Future<void> future = hello2();
    future.then(((value) => print('[${currentTime()}] hello2 THEN')));
    print('[${currentTime()}] hello2 AFTER');

    print('[${currentTime()}] main end');
}
