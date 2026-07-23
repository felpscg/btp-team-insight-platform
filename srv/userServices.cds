service userService {

entity return {
    key mail: String;
    data : Map
}
  action UserControll (UserEmail : String) returns return;
//   entity role {
//     key ID : UUID;
//     title  : String;
//     author : Association to group;
//   }

//   entity group {
//     key ID : UUID;
//     name   : String;
//     books  : Association to many role on group. = $self;
//   }
//   entity tile {
//     key ID : UUID;
//     name   : String;
//     books  : Association to many tile on group.author = $self;
//   }

//   action submitOrder (book : Books:ID, quantity : Integer);

}