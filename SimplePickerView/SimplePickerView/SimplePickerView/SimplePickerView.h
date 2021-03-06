//
//  SimplePickerView.h
//  SimplePickerView
//
//  Created by Yuchi Chen on 2017/1/13.
//  Copyright © 2017年 Yuchi Chen. All rights reserved.
//

#import <UIKit/UIKit.h>

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

@protocol SimplePickerViewDelegate <NSObject>

@optional
- (void)doneButtonPressedWithSelectedRowIndex:(NSInteger)index;
- (void)cancelButtonPressedWithSelectedRowIndex:(NSInteger)index;

@end

@interface SimplePickerView : UIView

@property (nonatomic, weak) id<SimplePickerViewDelegate> delegate;

- (instancetype)initWithBaseScrollView:(UIScrollView *)scrollView;
- (void)setItems:(NSArray *)array;

- (void)setPickerViewBackgroungColor:(UIColor *)color;
- (void)setToolBarBackgroungColor:(UIColor *)color;
- (void)setButtonColor:(UIColor *)color;

- (void)showPickerViewAtIndexPath:(NSInteger)selectRow;
- (void)hidePickerView;

- (NSInteger)selectedRowInComponent;

@end
