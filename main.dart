import 'dart:io';

// Define a type for actions that the user can perform
typedef UserAction = dynamic Function(List<String>);

// Method to add an item to the provided list while user doesnt type in 'quit'
void addItemToList(List<String> list) {
  print("Type 'quit' to stop adding items.");
  String? item;
  while (item != 'quit') {
    print("Enter the item to add.");
    item = stdin.readLineSync();
    if (item != null && item.isNotEmpty && item != 'quit') {
      list.add(item);
      print("$item has been added to the list");
    }
  }
}

// Method to remove an item from the provided list
void removeItemFromList(List<String> list) {
  print("Enter the item to remove: ");
  String? item = stdin.readLineSync();
  if (list.remove(item)) {
    print("$item has been removed from the list.");
  } else {
    print("$item not found");
  }
}

// Method to display all items in the provided list
void displayList(List<String> list) {
  if (list.isEmpty) {
    print("Your list is empty.");
    return;
  }
  print("----- Your grocery list -----");
  for (var i = 0; i < list.length; i++) {
    print("${i + 1}. ${list[i]}");
  }
}

// Method to exit the program
void exitProgram([List<String>? _]) {
  exit(0);
}

// Method to display available options and get user input
String? askUserForInput() {
  print("\n---------------------");
  print("Select an action to perform:");
  print("---------------------");
  options.forEach((key, value) {
    print("$key: ${value['description']}"); // Display each option
  });
  print("---------------------\n");

  return stdin.readLineSync(); // Read the user's choice
}

// A map that associates option keys with their corresponding actions and descriptions
final Map<String, Map<String, dynamic>> options = {
  '1': {'action': addItemToList, 'description': 'Add item to list'},
  '2': {'action': removeItemFromList, 'description': 'Remove item from list'},
  '3': {'action': displayList, 'description': 'Display list'},
  'q': {'action': exitProgram, 'description': 'Quit'}
};

// Method to execute the user's selected action
void executeUserRequest(String? userInput, List<String> list) {
  final option = options[userInput];
  if (option != null) {
    UserAction action = option['action'];
    action(list);
  } else {
    print('Invalid option');
  }
}

// The main function, where the program starts
void main() {
  List<String> groceryList = []; // Initialize an empty grocery list

  String? userInput;

  // Keep asking the user for input and executing their request until they choose to quit
  do {
    userInput = askUserForInput();
    executeUserRequest(userInput, groceryList);
  } while (userInput != 'q');
}
