import 'package:graphql_query_builder/graphql_query_builder.dart';

main() {
  print(Gql
  .query()
  ..name("PostsForAuthor")
  ..field(Field(name: "authors"))
  ..field(Field(name : "users", arguments: [Argument(argname: "id",argvalue:"1")]))
  ..field(Field(name:"posts",selectionSet: SelectionSet(nodes : [Field(name : "likes")])))
  .toString());
}
