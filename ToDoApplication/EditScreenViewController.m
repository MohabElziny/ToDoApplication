//
//  EditScreenViewController.m
//  ToDoApplication
//
//  Created by Mohab El-Ziny on 06/04/2022.
//

#import "EditScreenViewController.h"
#import "MyUserDefault.h"
#import "Task.h"
@interface EditScreenViewController ()
@property (weak, nonatomic) IBOutlet UITextField *nameTF;
@property (weak, nonatomic) IBOutlet UITextField *descriptionTF;
@property (weak, nonatomic) IBOutlet UISegmentedControl *prioritySegment;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;

@end

@implementation EditScreenViewController{
    NSMutableArray *allData;
    NSUserDefaults *userDefaults;
    MyUserDefault *myUserDefaults;
    Task *task;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    allData = [[myUserDefaults getArrayWithCustomObjFromUserDefaults:userDefaults AndKey:@"todoTasks"] mutableCopy];
    task = [allData objectAtIndex:_index];
    [self showData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    userDefaults = [NSUserDefaults standardUserDefaults];
    myUserDefaults = [MyUserDefault new];
    // Do any additional setup after loading the view.
}

-(void) showData{
    [_nameTF setText:[task taskName]];
    [_descriptionTF setText:[task taskDescription]];
    [_prioritySegment setSelectedSegmentIndex:[task taskPriority]];
    [_datePicker setDate:[task taskDate]];
}

- (IBAction)btnDone:(id)sender {
    if(![self checkFieldsNull]){
        [self ensureEdit];
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

-(void) ensureEdit{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Edit Task"
                                                                   message:@"Are you sure you want to edit this task"
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *yes = [UIAlertAction actionWithTitle:@"YES"
                                                          style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self->task setTaskName:self->_nameTF.text];
        [self->task setTaskDescription:self->_descriptionTF.text];
        [self->task setTaskPriority:self->_prioritySegment.selectedSegmentIndex];
        [self->task setTaskDate:self->_datePicker.date];
        [self->allData replaceObjectAtIndex:self->_index withObject:self->task];
        [self->myUserDefaults setArrayWithCustomObjToUserDefaults:self->userDefaults AndKey:@"todoTasks" withArray:self->allData];
        [self.navigationController popToRootViewControllerAnimated:YES];
    }];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"NO"
                                                          style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:yes];
    [alert addAction:cancel];
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
