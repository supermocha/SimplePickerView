//
//  ViewController.m
//  SimplePickerView
//
//  Created by Yuchi Chen on 2017/1/13.
//  Copyright © 2017年 Yuchi Chen. All rights reserved.
//

#import "ViewController.h"
#import "SimplePickerView.h"
#import "Cell.h"

static NSString *const cellIdentifier = @"Cell";

@interface ViewController () <UITableViewDelegate, UITableViewDataSource, SimplePickerViewDelegate>
{
    SimplePickerView *pickerView;
    NSArray *pickerViewItems;
    NSMutableDictionary *selectedRowDic; //存放tableView和pickerVew的indexForSelectedRow
    NSMutableIndexSet *openingPickerViewIndexSet; //存放畫面上的pickerView的index
}
@end

@implementation ViewController

#pragma mark - Lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self initVariable];
    
    [self initLayout];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Private

- (void)initVariable
{
    selectedRowDic = [[NSMutableDictionary alloc] init];
    openingPickerViewIndexSet = [[NSMutableIndexSet alloc] init];
    pickerViewItems = @[@[@"Americano", @"Cappuccino", @"Mochacino", @"Caramel Macchiato"],
                        @[@"Brown Sugar Milk Tea", @"Classic Fruity", @"Grapefruit Green Tea", @"Toffee Black Tea", @"Litchi Black Tea"]];
}

- (void)initLayout
{
    [self setpickerView];
}

- (void)setpickerView
{
    if (pickerView == nil) {
        pickerView = [[SimplePickerView alloc] initWithBaseScrollView:self.tableView];
        pickerView.delegate = self;
        [self.view addSubview:pickerView];
    }
}

#pragma mark - pickerViewDelegate

- (void)doneButtonPressedWithSelectedRowIndex:(NSInteger)index
{
    NSLog(@"%@", [[pickerViewItems objectAtIndex:pickerView.tag] objectAtIndex:index]);
    
    [openingPickerViewIndexSet removeAllIndexes];
    
    selectedRowDic[@(pickerView.tag)] = @(index);
    // NSLog(@"%@", selectedRowDic);
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:pickerView.tag inSection:0];
    [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
}

- (void)cancelButtonPressedWithSelectedRowIndex:(NSInteger)index
{
    [openingPickerViewIndexSet removeAllIndexes];
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([openingPickerViewIndexSet containsIndex:indexPath.row]) {
        [openingPickerViewIndexSet removeAllIndexes];
        [pickerView hidePickerView];
    }
    else {
        [openingPickerViewIndexSet removeAllIndexes];
        [openingPickerViewIndexSet addIndex:indexPath.row];
        
        pickerView.tag = indexPath.row;
        [pickerView setItems:[pickerViewItems objectAtIndex:indexPath.row]];
        [pickerView showPickerViewAtIndexPath:[[selectedRowDic objectForKey:@(indexPath.row)] integerValue]];
    }
    
    NSLog(@"%lu", (unsigned long)openingPickerViewIndexSet.lastIndex);
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return pickerViewItems.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    Cell *cell = [tableView dequeueReusableCellWithId:cellIdentifier];
    
    NSString *title = [[pickerViewItems objectAtIndex:indexPath.row] objectAtIndex:pickerView.selectedRowInComponent];
    cell.titleLabel.text = title;
    
    return cell;
}

@end
