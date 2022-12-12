import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    super.key,
  });

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sendgrid Demo App'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 36),
              child: TextFormField(
                controller: _controller,
                decoration: const InputDecoration(
                  hintText: 'xxxxx@gmail.com',
                ),
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
                onPressed: () async {
                  try {
                    await FirebaseFirestore.instance.collection('emails').add({
                      'to': _controller.text,
                      'message': {
                        'subject': 'Hello from Flutter!',
                        'html':
                        'このメールは${_controller.text}宛てにSendGridDemoAppから送信されました。'
                            '<br>'
                            'html形式で文章を作成することが出来ます。'
                      }
                    });
                    // ドキュメント追加後にテキストフォームを空にする
                    setState(() {
                      _controller.clear();
                    });
                  } on Exception catch (e) {
                    debugPrint(e.toString());
                  }
                },
                child: const Text('送信')),
          ],
        ),
      ),
    );
  }
}
