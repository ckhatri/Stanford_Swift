# View
* represents a rectangular area, defines a coordinate space.
* views are stackable/hierarchical
* views can extend outside of their parents views

# Initializing a UIView
* try to avoid an init if possible
* UIView initializer is different if it comes out of storyboard.

# View Coordinate System
* origin is upper left
* units are points, not pixels.
	* can have multiple pixels in one point
* use frame and/or center to position a view, not bounds.
* views can be rotated and scaled

# Custom View
* why?
	* custom drawing
	* handle touch events in specific ways
* to draw
	* create a UiView subclass, and override drawRect
* NEVER CALL DRAWRECT
	* do setNeedsDisplay()
	* setNeedsDisplayInRect()
* UIBezierPath is good for drawing
  