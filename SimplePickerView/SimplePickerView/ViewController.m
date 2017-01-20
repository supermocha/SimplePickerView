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
    [self registerNibForCellReuseIdentifier:cellIdentifier];
}

- (void)setpickerView
{
    // !pickerView 這個判斷式雖然可以成立，但感覺比較像是用在布林值的判斷上
    // 直接用 pickerView == nil 這個判斷式會比較直覺一點
    if (pickerView == nil) {
        pickerView = [[SimplePickerView alloc] init];
        [pickerView setBaseScrollView:self.tableView];
        pickerView.delegate = self;
        [self.view addSubview:pickerView];
    }
}

- (void)registerNibForCellReuseIdentifier:(NSString *)identifier
{
    UINib *cellNib = [UINib nibWithNibName:identifier bundle:nil];
    [self.tableView registerNib:cellNib forCellReuseIdentifier:identifier];
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
    // 可以加個deselect比較好看，不然cell會一直呈現反灰狀態
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if ([openingPickerViewIndexSet containsIndex:indexPath.row]) {
        [openingPickerViewIndexSet removeAllIndexes];
        [pickerView hidePickerView];
    }
    else {
        [openingPickerViewIndexSet removeAllIndexes];
        [openingPickerViewIndexSet addIndex:indexPath.row];
        
        pickerView.tag = indexPath.row;
        [pickerView setItems:[pickerViewItems objectAtIndex:indexPath.row]];
        [pickerView showPickerView:[[selectedRowDic objectForKey:@(indexPath.row)] integerValue]];
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
    Cell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[Cell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    NSString *title = [[pickerViewItems objectAtIndex:indexPath.row] objectAtIndex:pickerView.selectedRowInComponent];
    cell.titleLabel.text = title;
    
    return cell;
}

@end
