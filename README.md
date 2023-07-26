# flutter_tcg_calculator

Project Objective:
- Utilize "riverpod" for state management
- Apply unit tests to the project
- Save data to Firebase's Cloud Firestore
- Try to use some architectural pattern, maybe MVVM

Project Description:

I will create a TCG (Trading Card Game) calculator, it will work like this:
There will be a Home Screen with a list of Decks
The user will be able to CRUD decks
The deck is basically just a name, and some tags like name, list of cards, etc
The deck will have a details page where the user will insert cards
Each card has a name, quantity and a tag (starter, extender, etc)

There will be multiple methods associated with the deck like:
- Calculating the percentage of opening a starter card in a given deck
- Calculating the percentage of opening a given card

With these methods it will be possible to create a deck analytics in the future

The cards and decks will be stored within Firebase's Cloud Firestore.

OG Name: my_bloc_ut_flutter_project