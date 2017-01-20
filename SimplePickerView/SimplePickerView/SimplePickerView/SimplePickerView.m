//
//  SimplePickerView.m
//  SimplePickerView
//
//  Created by Yuchi Chen on 2017/1/13.
//  Copyright © 2017年 Yuchi Chen. All rights reserved.
//

#import "SimplePickerView.h"

CGFloat const pickerViewHeight = 180.0;
CGFloat const toolbarHeight = 35.0;

@interface SimplePickerView () <UIPickerViewDelegate, UIPickerViewDataSource>
{
    NSArray *items;
    UIScrollView *baseScrollView;
    
    UIPickerView *ycPickerView;
    UIButton *doneButton;
    UIButton *cancelButton;
    UIToolbar *toolbar;
    
    BOOL isHidden;
}
@end

@implementation SimplePickerView

#pragma mark - Init

- (instancetype)init
{
    self = [super init];
    
    if (self) {
        self.frame = CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, pickerViewHeight + toolbarHeight);
        isHidden = true;
        [self setPickerView];
    }
    
    return self;
}

#pragma mark - Private

- (void)setPickerView
{
    doneButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [doneButton addTarget:self action:@selector(doneButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    [doneButton setTitleColor:[UIColor colorWithRed:0.00 green:0.57 blue:1.00 alpha:1.00] forState:UIControlStateNormal];
    [doneButton setTitle:@"Done" forState:UIControlStateNormal];
    [doneButton sizeToFit];
    UIBarButtonItem *doneButtonItem = [[UIBarButtonItem alloc] initWithCustomView:doneButton];
    
    cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [cancelButton addTarget:self action:@selector(cancelButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    [cancelButton setTitleColor:[UIColor colorWithRed:0.00 green:0.57 blue:1.00 alpha:1.00] forState:UIControlStateNormal];
    [cancelButton setTitle:@"Cancel" forState:UIControlStateNormal];
    [cancelButton sizeToFit];
    UIBarButtonItem *cancelButtonItem = [[UIBarButtonItem alloc] initWithCustomView:cancelButton];
    
    UIBarButtonItem *flexibleSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                                                                                   target:self
                                                                                   action:nil];
    
    toolbar = [[UIToolbar alloc] init];
    toolbar.frame = CGRectMake(0, 0, CGRectGetWidth(self.frame), toolbarHeight);
    toolbar.barStyle = UIBarStyleDefault;
    toolbar.items = @[cancelButtonItem, flexibleSpace, doneButtonItem];
    toolbar.userInteractionEnabled = true;
    [self addSubview:toolbar];
    
    ycPickerView = [[UIPickerView alloc] init];
    ycPickerView.frame = CGRectMake(0, toolbarHeight, CGRectGetWidth(self.frame), pickerViewHeight);
    ycPickerView.delegate = self;
    ycPickerView.dataSource = self;
    [self addSubview:ycPickerView];
}

- (void)doneButtonPressed
{
    if ([self.delegate respondsToSelector:@selector(doneButtonPressedWithSelectedRowIndex:)]) {
        [self.delegate doneButtonPressedWithSelectedRowIndex:[ycPickerView selectedRowInComponent:0]];
    }
    
    [self hidePickerView];
}

- (void)cancelButtonPressed
{
    if ([self.delegate respondsToSelector:@selector(cancelButtonPressedWithSelectedRowIndex:)]) {
        [self.delegate cancelButtonPressedWithSelectedRowIndex:[ycPickerView selectedRowInComponent:0]];
    }
    
    [self hidePickerView];
}

#pragma mark - Public

- (void)showPickerView:(NSInteger)selectedRow
{
    [ycPickerView reloadAllComponents];
    [ycPickerView selectRow:selectedRow inComponent:0 animated:false];
    
    if (CGRectGetMinY(self.frame) < SCREEN_HEIGHT) {
        [self hidePickerView];
    }
    
    CGFloat newHeight = SCREEN_HEIGHT + CGRectGetHeight(self.frame);
    baseScrollView.contentSize = CGSizeMake(SCREEN_WIDTH, newHeight);
    
    CGRect newContainer = self.frame;
    newContainer.origin.y = CGRectGetMinY(self.frame) - CGRectGetHeight(self.frame);
    
    [UIView animateWithDuration:0.25
                          delay:0.0
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         self.frame = newContainer;
                     }
                     completion:nil];
    
    isHidden = false;
}

- (void)hidePickerView
{
    CGFloat newHeight = SCREEN_HEIGHT - CGRectGetHeight(self.frame);
    baseScrollView.contentSize = CGSizeMake(SCREEN_WIDTH, newHeight);
    
    CGRect newContainer = self.frame;
    newContainer.origin.y = CGRectGetMinY(self.frame) + CGRectGetHeight(self.frame);
    
    [UIView animateWithDuration:0.25
                          delay:0.0
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         self.frame = newContainer;
                     }
                     completion:nil];
    
    isHidden = true;
}

#pragma mark - Setter
- (void)setItems:(NSArray *)array
{
    items = array;
}

- (void)setBaseScrollView:(UIScrollView *)scrollView
{
    baseScrollView = scrollView;
}

- (void)setPickerViewBackgroungColor:(UIColor *)color
{
    ycPickerView.backgroundColor = color;
}

- (void)setToolBarBackgroungColor:(UIColor *)color
{
    toolbar.backgroundColor = color;
}

- (void)setButtonColor:(UIColor *)color
{
    [doneButton setTitleColor:color forState:UIControlStateNormal];
    [cancelButton setTitleColor:color forState:UIControlStateNormal];
}

#pragma mark - Getter

- (NSInteger)selectedRowInComponent
{
    return [ycPickerView selectedRowInComponent:0];
}

#pragma mark - UIPickerViewDelegate

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    NSString *title = [items objectAtIndex:row];
    
    return title;
}

#pragma mark - UIPickerViewDataSource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return items.count;
}

@end
