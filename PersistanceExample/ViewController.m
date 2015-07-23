//
//  ViewController.m
//  PersistanceExample
//
//  Created by Manjula Jonnalagadda on 7/22/15.
//  Copyright (c) 2015 Manjula Jonnalagadda. All rights reserved.
//

#import "ViewController.h"
#import "TaskTableViewCell.h"
#import "AddTaskViewController.h"
#import "AppDelegate.h"
#import "Task.h"

@interface ViewController ()<UITableViewDataSource,UITextFieldDelegate,UITableViewDelegate,AddTaskViewControllerDelegate>{
    
    NSDateFormatter *_dateFormatter;
    
}


///NSArray is static array NSMutableArray Objects can be added and removed.
@property(nonatomic,copy)NSArray *tasks;
@property (weak, nonatomic) IBOutlet UITableView *taskTableView;
@property(nonatomic,assign)NSInteger editingIndex;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _dateFormatter=[NSDateFormatter new];
    [_dateFormatter setDateStyle:NSDateFormatterLongStyle];
    self.editingIndex=-1;
    [self fetchTasks];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    if ([segue.destinationViewController isKindOfClass:[AddTaskViewController class]]) {
        AddTaskViewController *addTaskViewController=segue.destinationViewController;
        addTaskViewController.delegate=self;
    }
    
}



-(CGFloat)estimatedHeightForRow:(NSInteger)row{
    
    CGFloat ht=50;
    Task *task=self.tasks[row];
    if (task.taskDescription.length>0) {
        CGRect rect=[task.taskDescription boundingRectWithSize:CGSizeMake(self.view.frame.size.width-30, INFINITY) options:NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17.0]} context:nil];
        ht+=rect.size.height+10;
    }
    return ht;
}

-(void)fetchTasks{
    AppDelegate *appDelegate=[UIApplication sharedApplication].delegate;
    NSManagedObjectContext *context=appDelegate.managedObjectContext;
    
    NSFetchRequest *fetchRequest=[NSFetchRequest fetchRequestWithEntityName:@"Task"];
    NSSortDescriptor *sortDescriptor=[NSSortDescriptor sortDescriptorWithKey:@"deadLine" ascending:YES];
    fetchRequest.sortDescriptors=@[sortDescriptor];
    
    self.tasks=[context executeFetchRequest:fetchRequest error:nil];
    [self.taskTableView reloadData];
}

-(void)removeTask:(Task *)task{
    
    AppDelegate *appDelegate=[UIApplication sharedApplication].delegate;
    NSManagedObjectContext *context=appDelegate.managedObjectContext;
    
    [context deleteObject:task];
    [context save:nil];
    [self fetchTasks];
    
}


#pragma mark - UITableViewDataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.tasks.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    TaskTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"taskCell" forIndexPath:indexPath];
    Task *task=self.tasks[indexPath.row];
    cell.taskNameLabel.text=task.taskName;
    cell.taskDescriptionLabel.text=task.taskDescription;
    cell.deadLineLabel.text=[_dateFormatter stringFromDate:task.deadLine];
    return cell;
}

#pragma mark - UITableViewDelegate
/*
 //Use for pre-iOS 8 versions
 
 -(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
 return YES;
 }
 */

/*
 
 
 
 */

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    /*
     //Use for pre-iOS 8 versions
     
     if (UITableViewCellEditingStyleDelete) {
     [self.tasks removeObjectAtIndex:indexPath.row];
     [self.taskTableView reloadData];
     }
     */
}

-(NSArray *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    __weak typeof(self) weakself=self;
    
    UITableViewRowAction *deleteAction=[UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@"Delete" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
        Task *task=self.tasks[indexPath.row];
        [weakself removeTask:task];
        
    }];
    
    UITableViewRowAction *editAction=[UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:@"Edit" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
        
        AddTaskViewController *taskViewController=[[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"AddTaskViewController"];
        [self.navigationController pushViewController:taskViewController animated:YES];
        taskViewController.delegate=self;
        taskViewController.task=self.tasks[indexPath.row];
        [weakself.taskTableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
        
        
    }];
    
    return @[deleteAction,editAction];
    
}

-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [self estimatedHeightForRow:indexPath.row];
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return [self estimatedHeightForRow:indexPath.row];
    
}

-(void)reloadData{
    [self fetchTasks];
}


@end
