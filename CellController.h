//
// Created by vzyw on 16/3/17.
// Copyright (c) 2016 vzyw. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface CellController : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *word;
@property (weak, nonatomic) IBOutlet UILabel *definitions;
@property (weak, nonatomic) IBOutlet UILabel *likesNumber;
@property (weak, nonatomic) IBOutlet UILabel *wordId;

@end