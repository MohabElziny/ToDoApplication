//
//  DoneViewController.m
//  ToDoApplication
//
//  Created by Mohab El-Ziny on 05/04/2022.
//

#import "DoneViewController.h"
#import "MyUserDefault.h"
#import "Task.h"
@interface DoneViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end

@implementation DoneViewController{
    NSMutableArray *doneArray;
    NSUserDefaults *userDefaults;
    MyUserDefault *myUserDefault;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    userDefaults = [NSUserDefaults standardUserDefaults];
    myUserDefault = [MyUserDefault new];
    doneArray = [[myUserDefault getArrayWithCustomObjFromUserDefaults:userDefaults AndKey:@"doneTasks"] mutableCopy];
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
    return [doneArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:@"doneCell"];
    [cell textLabel].text = [[doneArray objectAtIndex:indexPath.row] taskName];
    
    [cell detailTextLabel].text = [[doneArray objectAtIndex:indexPath.row] taskDescription];
    
        switch ([[doneArray objectAtIndex:indexPath.row] taskPriority]) {
            case 0:
                cell.imageView.image = [UIImage imageNamed:@"0"];
                break;
            case 1:
                cell.imageView.image = [UIImage imageNamed:@"1"];
                break;
            case 2:
                cell.imageView.image = [UIImage imageNamed:@"2"];
                break;
            default:
                break;
        }
    return cell;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [doneArray removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
    [myUserDefault setArrayWithCustomObjToUserDefaults:userDefaults AndKey:@"doneTasks" withArray:doneArray];
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
