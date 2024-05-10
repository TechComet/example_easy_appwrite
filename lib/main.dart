import 'package:appwrite/appwrite.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'database.dart';
import 'models.dart';

part 'main.g.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

@riverpod
Future<BaseModel<TopicModel>> fetchData1(FetchData1Ref ref) async {
  final response = await database.topic.list();

  final allDocuments =
      response.documents.map((e) => TopicModel.fromJson(e.data)).toList();

  return BaseModel(documents: allDocuments, total: response.total);
}

@riverpod
Future<BaseModel<TopicModel>> fetchData2(FetchData2Ref ref) async {
  final response = await database.using('two').topic.list();

  final allDocuments =
      response.documents.map((e) => TopicModel.fromJson(e.data)).toList();

  return BaseModel(documents: allDocuments, total: response.total);
}

class MyHomePage extends ConsumerStatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  ConsumerState<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends ConsumerState<MyHomePage> {
  void _refreshData() {
    ref.invalidate(fetchData1Provider);
    ref.invalidate(fetchData2Provider);
  }

  @override
  Widget build(BuildContext context) {
    final data1 = ref.watch(fetchData1Provider);
    final data2 = ref.watch(fetchData2Provider);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              color: Colors.green,
              child: data1.when(
                data: (data) => ListView.builder(
                  itemBuilder: (context, index) {
                    final item = data.documents.elementAt(index);
                    return Text(item.title);
                  },
                  itemCount: data.total,
                ),
                error: (error, stackTrace) =>
                    Text('Error: ${error.toString()}'),
                loading: () => const CircularProgressIndicator(),
              ),
            ),
          ),
          Expanded(
            child: Container(
              color: Colors.amber,
              child: data2.when(
                data: (data) => ListView.builder(
                  itemBuilder: (context, index) {
                    final item = data.documents.elementAt(index);
                    return Text(item.title);
                  },
                  itemCount: data.total,
                ),
                error: (error, stackTrace) =>
                    Text('Error: ${error.toString()}'),
                loading: () => const CircularProgressIndicator(),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _refreshData,
        tooltip: 'Refresh',
        child: const Icon(Icons.refresh),
      ),
    );
  }
}
