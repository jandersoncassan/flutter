class UsuarioBkp {
  String login;
  String nome;
  String email;
  String urlFoto;
  String token;
  List<String> roles;

  //Usuario(this.nome, this.email);

  // Usuario(Map<String, dynamic> maps){
  //   this.login = maps['login'];
  //   this.nome  = maps['nome'];
  //   this.email  = maps['email'];
  //   this.urlFoto = maps ['urlFoto'];
  //   this.token = maps['token'];
  // }

  //É muito comum nesses casos utilizarmos named constructor, Usuario.fromJson, com lista de inicialização, dessa forma ó
  UsuarioBkp.fromJson(Map<String, dynamic> maps)
      : this.login = maps['login'],
        this.nome = maps['nome'],
        this.email = maps['email'],
        this.urlFoto = maps['urlFoto'],
        this.token = maps['token'],
       // this.roles = getRoles2(maps),
        this.roles = maps['roles'] != null
            ? maps['roles'].map<String>((role) => role.toString()).toList()
            : null; //TRATAMOS PQ PODE SER NULL, PARA NAO ROLAR NULLPOINTER

  @override
  String toString() {
    return 'UsuarioBkp:{login: $login, nome: $nome, email: $email, urlFoto: $urlFoto, token: $token, roles: $roles,}';
  }

  //Essa é uma das formas, mas é bem RUDIMENTAR
  static List<String> getRoles(Map<String, dynamic> maps) {
    List list = maps['roles'];
    List<String> roles = [];
    for (String role in list) {
      roles.add(role);
    }
    return roles;
  }

  //Essa é outra forma + bonita, utilizamos map para converter a lista,
  //podemos usar isso direto como fizemos la no construtor
  static List<String> getRoles2(Map<String, dynamic> maps) {
    List list = maps['roles'];
    List<String> roles = list.map<String>((role) => role.toString()).toList();
    return roles;
  }
}
