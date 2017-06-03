# Swift Aveiro 2017: Debugging Workshop

## Part 1: Symbolic Debugging

We looked at using *symbolic breakpoints* to inspect how an app works.

![Symbolic breakpoints](assets/symbolic-breakpoint.png)

For example, how does the navigation in an app work? We can try adding breakpoints at some common navigation locations:

* `-[UINavigationController pushViewController:animated:]`
* `-[UIViewController presentViewController:animated:completion:]`
* `-[UIViewController addChildViewController:]`

We can combine our knowledge of UIKit with lldb to find good places for symbolic breakpoints.

### LLDB Tips

**Remember to import UIKit!** You might need to import it in both "Swift mode" and "Objective-C" mode.

```
expr -l swift -- import UIKit
expr @import UIKit
```

**Swift variables in lldb**: get typed variables in LLDB Swift mode:

```
expr -l Swift -- let $view = unsafeBitCast(0x7df67c50, to: UIView.self)
expr -l Swift -- print($view.frame)
```

**Swift in LLDB**: If you like Swift, you can add a command alias to your `~/.lldbinit` file:

```
command alias sc expression -l swift --
```

Then in lldb, you can use `sc import UIKit` rather than `expr -l swift -- import UIKit`. Hat tip to [Jorge Ortiz](https://github.com/jdortiz) for the alias!


## Part 2: Chisel

We looked at [Chisel](https://github.com/facebook/chisel), an open-source project from Facebook that adds extra debugging commands to lldb.

Remember, you can replace `<obj>` below with an instance or a hex address.

Some favorites:

|Command           |Notes           |
|------------------|----------------|
|pviews|Print the `recursiveDescription` of the key window|
|pvc|Print the recursive view controller hierarchy of the key window|
|pinternals <obj>  |Print the internals (instance variables, etc.) of the object|
|pclass <obj>      |Print the class hierarchy of an object|
|mask/unmask <obj> |Put a transparent color view on top of the view|
|border/unborder <obj>|Draw a border around the view|
|visualize <obj>   |Render the target to a PNG and open it in Preview.app|
|pdocspath         |Print out the Documents directory path|
|pbundlepath       |Print out the app bundle directory path|

## Part 2.5: View Debugging

We took a quick sidebar to talk about [FLEX](https://github.com/Flipboard/FLEX) and [UIDebuggingInformationOverlay](http://ryanipete.com/blog/ios/swift/objective-c/uidebugginginformationoverlay/) for visual debugging.

FLEX is an amazing debugging tool (not just for view debugging) and it's very easy to integrate into your own apps.

## Part 3: New Debugging Features in Xcode

We looked at the memory graph debugger in Xcode to inspect memory usage and detect retain cycles. Note that you can't activate the memory graph debugger if you have the thread sanitizer option turned on.

![Memory graph debugger button](assets/memory-graph.png)

Next, we looked at the thread sanitizer to help find race conditions and threading issues.

The thread sanitizer only works in the simulator and slows down the app. You can activate it in the scheme editor.

![Thread sanitizer](assets/tsan.png)

Here's the lovely retain cycle I made special for this session:

![Retain cycle](assets/cycle.png)

😜
