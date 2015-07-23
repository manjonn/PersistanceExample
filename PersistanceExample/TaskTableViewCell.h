//
//  TaskTableViewCell.h
//  ToDoList
//
//  Created by Manjula Jonnalagadda on 7/20/15.
//  Copyright (c) 2015 Manjula Jonnalagadda. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TaskTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *taskNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *taskDescriptionLabel;
@property (weak, nonatomic) IBOutlet UILabel *deadLineLabel;

@end
