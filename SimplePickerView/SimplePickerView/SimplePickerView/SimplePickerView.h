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

// 這兩個變數其實可以在.c檔裡宣告，需要設定時再呼叫set的funtcion就好
// 在.h檔裡宣告當然也是可以，只是因為是property的宣告
// 所以其實這兩個變數都可以get的到，在這裡似乎沒這個必要
@property (nonatomic, strong) NSArray *items;
@property (nonatomic, strong) UIScrollView *baseScrollView;

// 別人用不到的變數不要宣告在header檔裡，很危險
@property (nonatomic, assign) BOOL isHidden;
@property (nonatomic, weak) id<SimplePickerViewDelegate> delegate;

- (NSInteger)selectedRowInComponent;

- (void)setPickerViewBackgroungColor:(UIColor *)color;
- (void)setToolBarBackgroungColor:(UIColor *)color;
- (void)setButtonColor:(UIColor *)color;

- (void)showPickerView:(NSInteger)selectRow;
- (void)hidePickerView;

@end
