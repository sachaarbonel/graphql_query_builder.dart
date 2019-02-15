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
    return "query $_opname {${buffer.toString()}}";
  }
}

class SelectionSet {
  List<Field> nodes = <Field>[];
  SelectionSet({this.nodes});
  @override
  String toString() {
    return "{${nodes?.expand((e)=>[e?.toString() ?? ""])}}";
  }

}
class Field {
  String name;
  List<Argument> arguments = <Argument>[];
  SelectionSet selectionSet;
  Field({this.name,this.arguments,this.selectionSet});

  @override
  String toString() {
    return " ${name}${arguments?.expand((e)=>[e?.toString() ?? ""]) ?? ""}${selectionSet ?? ""}";
  }

}

class Argument extends Field {
  String argname;
  dynamic argvalue;
  
  
  Argument({this.argname,this.argvalue});

  @override
  String toString() {
    return "$argname: $argvalue";
  }
}

class GraphqlSelectionSet extends GraphqlBuilder{
  
  List<Field> tree = <Field>[];

  @override
  void writeTo(final StringSink sink) {
    //sink.write("query $_opname {");
    sink.writeAll(tree);
  }

  GraphqlSelectionSet field(Field node){
    tree.add(node);
    return GraphqlSelectionSet();
  }

}

abstract class Gql {

  static GraphqlSelectionSet query() {
    return GraphqlSelectionSet();
  }

}