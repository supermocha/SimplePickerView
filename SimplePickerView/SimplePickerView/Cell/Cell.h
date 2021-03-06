//
//  Cell.h
//  YCPickerView
//
//  Created by Yu Chi Chen on 2016/7/11.
//  Copyright © 2016年 Yu Chi Chen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Cell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *titleLabel;

@end

@interface UITableView (Cell)

// return the cell with the specified ID. It takes care of the dequeue if necessary
- (Cell *)dequeueReusableCellWithId:(NSString *)cellId;

@end
