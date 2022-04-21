//
//  AddScreenViewController.m
//  ToDoApplication
//
//  Created by Mohab El-Ziny on 05/04/2022.
//

#import "AddScreenViewController.h"
#import "Task.h"
#import "MyUserDefault.h"

@interface AddScreenViewController ()
@property (weak, nonatomic) IBOutlet UITextField *nameTF;
@property (weak, nonatomic) IBOutlet UITextField *descriptionTF;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (weak, nonatomic) IBOutlet UISegmentedControl *prioritySegmant;

@end

@implementation AddScreenViewController{
    Task *newTask ;
    NSUserDefaults *userDefaults;
    NSMutableArray *todoTasks;
    MyUserDefault *myUserDefault;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    newTask =[Task new];
    userDefaults = [NSUserDefaults standardUserDefaults];
    myUserDefault =[MyUserDefault new];
    todoTasks = [[myUserDefault getArrayWithCustomObjFromUserDefaults:userDefaults AndKey:@"todoTasks"] mutableCopy];
    
}

- (IBAction)btnAdd:(id)sender {
    if(![self checkFieldsNull]){
        [newTask setTaskName:_nameTF.text];
        [newTask setTaskDescription:_descriptionTF.text];
        [newTask setTaskPriority:_prioritySegmant.selectedSegmentIndex];
        [newTask setTaskDate:_datePicker.date];
        [todoTasks addObject:newTask];
        [myUserDefault setArrayWithCustomObjToUserDefaults:userDefaults AndKey:@"todoTasks" withArray:todoTasks];
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        [self errorAlert];
    }
}

-(BOOL) checkFieldsNull{
    return ([_nameTF.text isEqualToString:@""] && [_descriptionTF.text isEqualToString: @""]);
}

-(void) errorAlert{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Error!"
                                                                   message:@"All Fields are required"
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *firstAction = [UIAlertAction actionWithTitle:@"OK"
                                                          style:UIAlertActionStyleDefault handler:nil];
    
    [alert addAction:firstAction];
    
    [self presentViewController:alert animated:YES completion:nil];
    
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
