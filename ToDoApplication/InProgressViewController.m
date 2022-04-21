//
//  InProgressViewController.m
//  ToDoApplication
//
//  Created by Mohab El-Ziny on 05/04/2022.
//

#import "InProgressViewController.h"
#import "Task.h"
#import "InProgressCutomCell.h"
#import "MyUserDefault.h"

@interface InProgressViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end

@implementation InProgressViewController{
    NSMutableArray *inProgressArray;
    NSUserDefaults *userDefaults;
    MyUserDefault *myUserDefault;
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    userDefaults = [NSUserDefaults standardUserDefaults];
    myUserDefault = [MyUserDefault new];
    inProgressArray = [[myUserDefault getArrayWithCustomObjFromUserDefaults:userDefaults AndKey:@"inProgressTasks"] mutableCopy];
    [_tableView reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [inProgressArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    InProgressCutomCell *cell =[tableView dequeueReusableCellWithIdentifier:@"progressCell"];
    [[cell btnDone] setTag:indexPath.row];
    [[cell btnDone] addTarget:self action:@selector(doneMethod:) forControlEvents:UIControlEventTouchUpInside];
    
    
    [cell titleLabel].text = [[inProgressArray objectAtIndex:indexPath.row] taskName];
    
    [cell descriptionLabel].text = [[inProgressArray objectAtIndex:indexPath.row] taskDescription];
    
        switch ([[inProgressArray objectAtIndex:indexPath.row] taskPriority]) {
            case 0:
                cell.taskImage.image = [UIImage imageNamed:@"0"];
                break;
            case 1:
                cell.taskImage.image = [UIImage imageNamed:@"1"];
                break;
            case 2:
                cell.taskImage.image = [UIImage imageNamed:@"2"];
                break;
            default:
                break;
        }
    return cell;
}

-(void) doneMethod:(id) sender{
    NSMutableArray *arr= [[myUserDefault getArrayWithCustomObjFromUserDefaults:userDefaults AndKey:@"doneTasks"] mutableCopy];
    [arr addObject:[inProgressArray objectAtIndex:[sender tag]]];
    [myUserDefault setArrayWithCustomObjToUserDefaults:userDefaults AndKey:@"doneTasks" withArray:arr];
    [inProgressArray removeObjectAtIndex:[sender tag]];
    [myUserDefault setArrayWithCustomObjToUserDefaults:userDefaults AndKey:@"inProgressTasks" withArray:inProgressArray];
    [_tableView reloadData];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [inProgressArray removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
    [myUserDefault setArrayWithCustomObjToUserDefaults:userDefaults AndKey:@"inProgressTasks" withArray:inProgressArray];
    [tableView reloadData];
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
