//
//  Cell.m
//  YCPickerView
//
//  Created by Yu Chi Chen on 2016/7/11.
//  Copyright © 2016年 Yu Chi Chen. All rights reserved.
//

#import "Cell.h"

@implementation Cell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

@implementation UITableView (Cell)

- (Cell *)dequeueReusableCellWithId:(NSString *)cellId
{
    Cell *cell = [self dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[NSBundle mainBundle] loadNibNamed:cellId owner:nil options:nil].firstObject;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    return cell;
}

@end
