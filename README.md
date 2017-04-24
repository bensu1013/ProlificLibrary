# ProlificLibrary

An app that allows users to look at the books within the vaults of the Prolific Library.  Users may contribute to the library by adding, updating and deleting books.
User may also checkout a book with automatic timestamps so the book police with come after you if you dare to be late. Sharing with facebook and twitter is also available.
The tableviewcells can be swiped to reveal a delete button, and at the bottom of the viewcontroller is a slightly hidden button to purge all books from the library.

The first steps of the app was to create its API struct and test all its functionality.  Once I understood what information my API took in and spit out, I developed a way to store and manager the data in my BookManager class.

I choose to make it a singleton so it became a central point of information for all my view controllers. The BookManager is also the only class that interactions with the API methods.

To keep as much of the heavy lifting separate from the viewcontrollers, an AlertControllerFactory class was born.  It has methods to create all alerts needed in the app with completion handlers to give them logic at their desired destinations.
