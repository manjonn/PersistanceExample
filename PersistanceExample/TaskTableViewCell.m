//
//  TaskTableViewCell.m
//  ToDoList
//
//  Created by Manjula Jonnalagadda on 7/20/15.
//  Copyright (c) 2015 Manjula Jonnalagadda. All rights reserved.
//

#import "TaskTableViewCell.h"

@implementation TaskTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)prepareForReuse{
    [super prepareForReuse];
    self.taskNameLabel.text=@"";
    self.taskDescriptionLabel.text=@"";
    self.deadLineLabel.text=@"";
}

@end
