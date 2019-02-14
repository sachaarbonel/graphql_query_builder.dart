import 'package:graphql_query_builder/graphql_query_builder.dart';


abstract class GraphqlBuilder {
  String _opname;
  
  name(String opname){
    _opname=opname;
  }

  void writeTo(StringSink sink);

  @override
  String toString() {
    final StringBuffer buffer = StringBuffer();
    writeTo(buffer);
    return buffer.toString();
  }
}

class SelectionSet {
  List<Node> nodes = <Node>[];
  SelectionSet({this.nodes});
  @override
  String toString() {
    return "{${nodes?.expand((e)=>[e?.toString() ?? ""])}}";
  }

}
class Node {
  String name;
  List<Argument> arguments = <Argument>[];
  SelectionSet selectionSet;
  Node({this.name,this.arguments,this.selectionSet});

  @override
  String toString() {
    return "$name${arguments?.expand((e)=>[e?.toString() ?? ""])} ${selectionSet ?? ""}";
  }

}

class Argument extends Node {
  String argname;
  dynamic argvalue;
  
  
  Argument({this.argname,this.argvalue});

  @override
  String toString() {
    return "$argname: $argvalue";
  }
}

class GraphqlSelectionSet extends GraphqlBuilder{
  String _optype;
  GraphqlSelectionSet(String optype) {
    _optype =optype;
  }
  
  @override
  void writeTo(final StringSink sink) {
    sink.write("query $_opname {");
    sink.writeAll([Node(name: "authors", selectionSet: SelectionSet(nodes : [Node(name: "username",arguments: [Argument(argname: "name",argvalue: "test")])]), arguments: [Argument(argname: "id",argvalue: "1"),Argument(argname: "name",argvalue: "sacha")])]);
    sink.write(" }");
  }

}


abstract class Gql {

  static GraphqlSelectionSet query() {
    return GraphqlSelectionSet("query");
  }

  
}
main() {
  print(Gql
  .query()
  ..name("PostsForAuthor")
  //..field(name:)
  .toString());
}
