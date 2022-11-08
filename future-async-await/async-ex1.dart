String currentTime() {
    var now = DateTime.now();

    String minute = now.minute.toString().padLeft(2, '0');
    String second = now.second.toString().padLeft(2, '0');

    return '$minute:$second';
}

Future<String> B() async {
    print('[${currentTime()}]         TASK begin');
    
    String a = await Future<String>.delayed(Duration(seconds: 3), () => 'Hello');
    
    print('[${currentTime()}]         TASK end');
    
    return a;
}

void main() {
    print('[${currentTime()}] BEFORE call');
    
    Future<String> r = B();
    
    print('[${currentTime()}] AFTER call');
    
    print('[${currentTime()}] r: ${r}');

    r.then((value) => print('[${currentTime()}] value: ${value}'));
}
