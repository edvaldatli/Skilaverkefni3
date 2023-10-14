import 'dart:io';

typedef UserAction = dynamic Function(List<String>);

void addItemToList(List<String> list){
  print("Enter the item to add: ");
  String? item = stdin.readLineSync();
  if(item != null && item.isNotEmpty){
    list.add(item);
    print("$item has been added to the list");
  }
}

void removeItemFromList(List<String> list){
  print("Enter the item to remove: ");
  String? item = stdin.readLineSync();
  if(list.remove(item)){
    print("$item has been removed from the list.");
  } else {
    print("$item not found");
  }
}

void displayList(List<String> list){
  if(list.length == 0){
    print("Your list is empty.");
  }
  for(var i = 0; i < list.length; i++){
    print("${i+1}. ${list[i]}");
  }
}

void exitProgram([List<String>? _]){
  exit(0);
}

String? askUserForInput(){
  print("\n---------------------");
  print("Select an action to perform:");
  print("---------------------");
  options.forEach((key, value) {
    print("$key: ${value['description']}");  // Display each option
  });
  print("---------------------\n");

  return stdin.readLineSync();  // Read the user's choice
}

final Map<String, Map<String, dynamic>> options = {
  '1': {'action': addItemToList, 'description': 'Add item to list'},
  '2': {'action': removeItemFromList, 'description': 'Remove item from list'},
  '3': {'action': displayList, 'description': 'Display list'},
  'q': {'action': exitProgram, 'description': 'Quit'}
};

void executeUserRequest(String? userInput, List<String> list){
  final option = options[userInput];
  if(option != null){
    UserAction action = option['action'];
    action(list);
  } else {
    print('Invalid option');
  }
}

void main(){
  List<String> groceryList = [];

  String? userInput = "";

  do {
    userInput = askUserForInput();
    executeUserRequest(userInput, groceryList);
  } while (userInput != 'q');
}