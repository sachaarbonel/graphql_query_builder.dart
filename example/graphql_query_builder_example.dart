import 'package:graphql_query_builder/graphql_query_builder.dart';

main() {
  print(Gql
  .query()
  ..name("PostsForAuthor")
  //..field(name:)
  .toString());
}
