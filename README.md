# Button2
## A cross-platform button control for SpriteKit

Button2 is a lightweight button control designed to work on iOS, macOS, tvOS, and watchOS.
It defines almost nothing of the button's appearance. Rather than being a comprehensive UI element class, the purpose of using Button2 is to constrain the interaction metaphor to one that works on all platforms, and to help prevent you from accidentally making a part of your SpriteKit UI platform-dependent when it really doesn't need to be.

Usage:

There are three properties of note:

* block-- the block property is a closure that will execute when the button is tapped.
* labelNode-- an SKLabelNode that serves as the title of the button. Optional.
* platterNode-- an SKShapeNode that determines both the visual appearance of the button **as well as the size of it as far as hit-testing is concerned.** Required, but a default is provided.

To use the button on iOS, tvOS and macOS, simply pass the results of every UI/NSEvent.locationInView() to Button2.consumePoint().
ConsumePoint will return true if the button was triggered and the block executed.

watchOS does not allow the converting points to SKScene space, so instead an alternate method is provided, performTap(), which automatically executes the block.

Button2 is very small in terms of lines of code. It is designed to be easy to grasp, modify, and or reimplement. Enjoy!
