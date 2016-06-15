# MVC

* Model is what your application is, but now how it's displayed
* Controller is how your model is displayed on screen.
* View is your Controller's Minions, what your Controller will do to put things on screen
	* ex. buttons and labels

## Communication
* Controller can always directly talk to Model, is in complete control of the model. Controller -> Model 
* Controller can always directly talk to View, through outlets. Controller -> View
* Model and the View don't ever speak to each other.  Model !=> View
* View can talk to controller, but is blind. They do not know what classes they are talking.
	* view must talk to controller in a structured way, with a set of rules.
	* view simply calls that method/function that is created by the controller's target.
	* minions ask questions to Controller through **delegate** 
		* ex. "Can I scroll up? Or do vertical scroll"
	* views do not own data they display, they ask for it from Controller
* Controller interprets Model info for the View
* Model cannot talk directly to Controller.
	* If Model has information to update, we use a **radio station** model which broadcasts whenever something interesting happens
	* controller tunes into that radio station
	* remember has nothing to do with UI

## Filler Header
* Big application is simply multiple MVC's working together.
* MVC can only be the view of another MVC.

## Code Stuff
* computer property values calculate the value in real time.
* done through get and set functions
* we don't store this variable, we simple calculate it.

