//
//  AddTaskViewController.m
//  ToDoList
//
//  Created by Manjula Jonnalagadda on 7/19/15.
//  Copyright (c) 2015 Manjula Jonnalagadda. All rights reserved.
//

#import "AddTaskViewController.h"
#import "AppDelegate.h"
#import "Task.h"

@interface AddTaskViewController (){
    
    NSDateFormatter *_dateFormatter;
    
}
@property (weak, nonatomic) IBOutlet UITextField *taskNameTextField;
@property (weak, nonatomic) IBOutlet UITextView *taskDescriptionTextField;
@property (weak, nonatomic) IBOutlet UIButton *dateButton;
@property (weak, nonatomic) IBOutlet UIToolbar *dateToolBar;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;

@end

@implementation AddTaskViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _dateFormatter=[NSDateFormatter new];
    [_dateFormatter setDateStyle:NSDateFormatterLongStyle];
    if (self.task) {
        self.taskNameTextField.text=self.task.taskName;
        self.taskDescriptionTextField.text=self.task.taskDescription;
        self.datePicker.date=self.task.deadLine;
        [self.dateButton setTitle:[_dateFormatter stringFromDate:self.task.deadLine] forState:UIControlStateNormal];
    }
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setTask:(Task *)task{
    _task=task;
    self.taskNameTextField.text=task.taskName;
    self.taskDescriptionTextField.text=task.taskDescription;
    self.datePicker.date=task.deadLine;
}

- (IBAction)dateButtonTapped:(UIButton *)sender {
    
    if ([self.taskDescriptionTextField isFirstResponder]) {
        if (self.taskDescriptionTextField.text.length==0) {
            return;
        }
        [self.taskDescriptionTextField resignFirstResponder];
    }
    if ([self.taskDescriptionTextField isFirstResponder]) {
        [self.taskDescriptionTextField resignFirstResponder];
    }
    self.datePicker.hidden=NO;
    self.dateToolBar.hidden=NO;

}
- (IBAction)save:(UIButton *)sender {
    
    if ([self.taskDescriptionTextField isFirstResponder]) {
        if (self.taskDescriptionTextField.text.length==0) {
            return;
        }
        [self.taskDescriptionTextField resignFirstResponder];
    }
    if ([self.taskDescriptionTextField isFirstResponder]) {
        [self.taskDescriptionTextField resignFirstResponder];
    }
    
    AppDelegate *appDelegate=[UIApplication sharedApplication].delegate;
    NSManagedObjectContext *context=appDelegate.managedObjectContext;
    if (self.task) {
        self.task.taskName=self.taskNameTextField.text;
        //   Task *task=[[Task alloc]initWithTaskName:self.taskNameTextField.text];
        //   Task *task=[[Task alloc]init];
        //   task.taskName=self.taskNameTextField.text;
        self.task.taskDescription=self.taskDescriptionTextField.text;
        self.task.deadLine=self.datePicker.date;
    
    }else{
        Task *task=[NSEntityDescription insertNewObjectForEntityForName:@"Task" inManagedObjectContext:context];
        task.taskName=self.taskNameTextField.text;
        //   Task *task=[[Task alloc]initWithTaskName:self.taskNameTextField.text];
        //   Task *task=[[Task alloc]init];
        //   task.taskName=self.taskNameTextField.text;
        task.taskDescription=self.taskDescriptionTextField.text;
        task.deadLine=self.datePicker.date;
        
    }
    [context save:nil];
    
        if ([self.delegate respondsToSelector:@selector(reloadData)]) {
            [self.delegate reloadData];
        }
    
    [self.navigationController popViewControllerAnimated:YES];

}
- (IBAction)cancelDate:(UIBarButtonItem *)sender {
    
    self.datePicker.hidden=YES;
    self.dateToolBar.hidden=YES;
}
- (IBAction)pickDate:(UIBarButtonItem *)sender {
    
    self.datePicker.hidden=YES;
    self.dateToolBar.hidden=YES;
    NSString *dateSelected=[_dateFormatter stringFromDate:self.datePicker.date];
    [self.dateButton setTitle:dateSelected forState:UIControlStateNormal];
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
