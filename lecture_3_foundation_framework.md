# Optional
* Optional is simply an enum, so it's generic. so Optional<T> kinda like generics in Java Arraylist<T>
* two cases: either None or Some (nil or something)
* use ! to unwrap, basically saying make this some and then set the variable to it
* can chain so optional?text?something, ? says try to unwrap this, if it doesn't work just set this to nil

# Range
* two end points, generic.
* array's range is Ints (index arrays by ints)
* ... (inclusive) ..< (open-ended)

# Data Structures in Swift
* classes, structures and enums are the building blocks for data structures
* similarities:
	* declaration syntax
	* properties and functions
	* initializers
* differences:
	* only classes have inheritance
	* value type (enum, struct) vs reference type (class)

# Value vs Reference
* value is copied when passed as arg to function, and assigned to a diff variable
* any func that will change a struct or enum, must use keyword mutating
* references are stored in heap, and use reference counting

# Methods
* all parameters to all functions have an *internal* and an *external* name.
* *internal* - is the name of the local variable that you're going to be using.
* *external* - name the caller uses when they call the method.
* can put _ if you dont' want callers to use external name.
* you can override methods or properties, by using keywords *override* 
* can mark something final by using the *final* keyword

# Properties
* you can observe changes to a property using willSet and didSet
* if a mutation happens, these methods will be called.
* can do *lazy* property doesn't get initialized until someone tries accessing it.
* "cheat code" because you won't need to write an initializer.

# String
* String.CharacterView will give you a Character array, makes it much more easier for us to index through
* Character is a human understandable version of Character
* Strings are weird because Swift is full unicode and you have emojis

# Initialization
* not so common because you can set defaults, or use lazy.
* if all properties have defaults than you get a free init.
* if it has no initializers it will get a default one, with all properties as args.
* try to avoid writing your own inits, lots of rules and stuff.

# Property List
* AnyObject which is known to be a collection of objects ONLY of String, Array, Dictionary, 
* NSUserDefaults is a very tiny database, usually used for user settings and stuff

