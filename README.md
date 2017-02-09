# SimplePickerView
`SimplePickerView` is a clean and easy-to-use native menu on iOS.

## How To Use
Just import the header file and create an instance of `SimplePickerView`.
```objective-c
#import "SimplePickerView.h"

...

SimplePickerView *pickerView = [[SimplePickerView alloc] initWithBaseScrollView:tableView];
pickerView.delegate = self;
[self.view addSubview:pickerView];
```

Showing the SimplePickerView
```objective-c
[pickerView setItems:@[@"1", @"2", @"3"]];
[pickerView showPickerViewAtIndexPath:0];
```

Hiding the SimplePickerView
```objective-c
[pickerView hidePickerView];
```

### Gesture Interaction

```objective-c
- (void)doneButtonPressedWithSelectedRowIndex:(NSInteger)index;
- (void)cancelButtonPressedWithSelectedRowIndex:(NSInteger)index;
```
