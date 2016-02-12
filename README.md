## MSRandomIndexPath

```
+ (NSIndexPath *)randomIndexPathInArrays:(NSArray *)arrays
                     excludingIndexPaths:(NSSet *)excludedIndexPaths;
```

Returns a random index path valid for one of the arrays in `arrays`. `arrays` can't be nil and must be an array of arrays. The returned index path will not be in the set of `excludedIndexPaths`. `excludedIndexPaths` can be nil or empty.

The order of the arrays in `arrays` is important. The first array is section 0, the second array is section 1, and so on. The size of the arrays can vary but an array cannot be empty.

Returns nil if:

- `arrays` is nil
- any of the arrays in `arrays` is empty
- any of the objects in `arrays` is not an array
- the number of items in `excludedIndexPaths` is greater than or equal to the total number of elements for all the arrays in `arrays`

This method will take longer to return as the number of items in `excludedIndexPaths` grows as a percent of the total number of elements for all the arrays in `arrays`.

## Installation

MSRandomIndexPath uses arc4random_uniform which was available since iOS 4.3.


### CocoaPods

1. Add a pod entry for MSRandomIndexPath to your Podfile: `pod 'MSRandomIndexPath'`.
2. Install the pod(s) by running `pod install`.
3. Where you need it `#import "NSIndexPath+RandomAdditions.h"`.

### Source Files

Alternatively you can directly add the two `NSIndexPath+RandomAdditions.*` source files to your project.



## Tests

The example Xcode project contains a suite of tests so you can use this method with confidence.

If you copy the test file to your project you may need to configure the project so the test target will recognize the files.

1. Select your project in the Project Navigator pane.
1. Select your project in the Projects and Targets pane.
1. You must be on the Info tab.
1. In Configurations expand Debug and your project.
1. In <yourProjectName>Tests select Pods from the popup.
