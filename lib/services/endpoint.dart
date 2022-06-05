class Endpoint {
  static const getAllCharacter = "https://rickandmortyapi.com/api/character";

  static getAllByName(String name) => "$getAllCharacter/?name=$name";

  static getAllByStatusAndGenderCharacter(String status, String gender) =>
      "$getAllCharacter/?status=$status&sgender=$gender";
}
