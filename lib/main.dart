import 'dart:io';

/// A type representing actions that a user can perform.
typedef UserAction = dynamic Function(List<String>);

/// Adds an item to the provided list.
///
/// Prompts the user for input and adds the entered item to the list
/// if it's not empty.
void addItemToList(List<String> list) {
  print("Enter the item to add: ");
  String? item = stdin.readLineSync();
  if (item != null && item.isNotEmpty) {
    list.add(item);
    print("$item has been added to the list");
  }
}

/// Removes an item from the provided list.
///
/// Prompts the user for the item they wish to remove. If the item exists
/// in the list, it gets removed. Otherwise, a not found message is displayed.
void removeItemFromList(List<String> list) {
  print("Enter the item to remove: ");
  String? item = stdin.readLineSync();
  if (list.remove(item)) {
    print("$item has been removed from the list.");
  } else {
    print("$item not found");
  }
}

/// Displays all items in the provided list.
///
/// If the list is empty, an appropriate message is shown.
void displayList(List<String> list) {
  if (list.isEmpty) {
    print("Your list is empty.");
    return;
  }
  for (var i = 0; i < list.length; i++) {
    print("${i + 1}. ${list[i]}");
  }
}

/// Exits the program.
void exitProgram([List<String>? _]) {
  exit(0);
}

/// Displays a menu of available options and reads the user's input.
///
/// Returns the input option selected by the user.
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

/// Maps option keys to their corresponding actions and descriptions.
final Map<String, Map<String, dynamic>> options = {
  '1': {'action': addItemToList, 'description': 'Add item to list'},
  '2': {'action': removeItemFromList, 'description': 'Remove item from list'},
  '3': {'action': displayList, 'description': 'Display list'},
  'q': {'action': exitProgram, 'description': 'Quit'}
};

/// Executes the action selected by the user based on their input.
///
/// If an invalid option is chosen, an appropriate error message is displayed.
void executeUserRequest(String? userInput, List<String> list) {
  final option = options[userInput];
  if (option != null) {
    UserAction action = option['action'];
    action(list);
  } else {
    print('Invalid option');
  }
}

/// The main entry point of the program.  
///
/// Initializes an empty grocery list and continually prompts the user
/// to select and execute actions on it until they choose to exit.
void main() {
  List<String> groceryList = []; // Initialize an empty grocery list

  String? userInput;

  // Keep asking the user for input and executing their request until they choose to quit
  do {
    userInput = askUserForInput();
    executeUserRequest(userInput, groceryList);
  } while (userInput != 'q');
}

