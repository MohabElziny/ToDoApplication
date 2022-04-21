//
//  ViewController.m
//  ToDoApplication
//
//  Created by Mohab El-Ziny on 05/04/2022.
//

#import "ToDoViewController.h"
#import "Task.h"
#import "AddScreenViewController.h"
#import "MyUserDefault.h"
#import "TodoCustomCell.h"
#import "DisplayViewController.h"

@interface ToDoViewController ()
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UITableView *tableView;


@end

@implementation ToDoViewController{
    BOOL isFiltered;
    NSMutableArray *searchArray;
    NSMutableArray *todoArray;
    NSUserDefaults *userDefaults;
    MyUserDefault *myUserDefault;
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    userDefaults = [NSUserDefaults standardUserDefaults];
    myUserDefault = [MyUserDefault new];
    todoArray = [[myUserDefault getArrayWithCustomObjFromUserDefaults:userDefaults AndKey:@"todoTasks"] mutableCopy];
    [_tableView reloadData];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    isFiltered = NO;
    // Do any additional setup after loading the view.
}

- (IBAction)btnAdd:(id)sender {
    AddScreenViewController *addScreen=[self.storyboard instantiateViewControllerWithIdentifier:@"AddScreenViewController"];
    [self.navigationController pushViewController:addScreen animated:YES];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(isFiltered)
    {
        return [searchArray count];
    }else{
        return [todoArray count];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TodoCustomCell *cell =[tableView dequeueReusableCellWithIdentifier:@"todoCell"];
    
    if (!isFiltered) {
        [[cell btnDone] setTag:indexPath.row];
        [[cell btnDone] addTarget:self action:@selector(doneMethod:) forControlEvents:UIControlEventTouchUpInside];
        
        [[cell btnInProgress] setTag:indexPath.row];
        [[cell btnInProgress] addTarget:self action:@selector(inProgressMethod:) forControlEvents:UIControlEventTouchUpInside];
        
        [cell titleLabel].text = [[todoArray objectAtIndex:indexPath.row] taskName];
        
        [cell descriptionLabel].text = [[todoArray objectAtIndex:indexPath.row] taskDescription];
        
        switch ([[todoArray objectAtIndex:indexPath.row] taskPriority]) {
            case 0:
                cell.myImage.image = [UIImage imageNamed:@"0"];
                break;
            case 1:
                cell.myImage.image = [UIImage imageNamed:@"1"];
                break;
            case 2:
                cell.myImage.image = [UIImage imageNamed:@"2"];
                break;
            default:
                break;
        }
    }else{
        [[cell btnDone] setHidden:YES];
        [[cell btnInProgress] setHidden:YES];
        [cell titleLabel].text = [[searchArray objectAtIndex:indexPath.row] taskName];
        
        [cell descriptionLabel].text = [[searchArray objectAtIndex:indexPath.row] taskDescription];
        
        switch ([[searchArray objectAtIndex:indexPath.row] taskPriority]) {
            case 0:
                cell.myImage.image = [UIImage imageNamed:@"0"];
                break;
            case 1:
                cell.myImage.image = [UIImage imageNamed:@"1"];
                break;
            case 2:
                cell.myImage.image = [UIImage imageNamed:@"2"];
                break;
            default:
                break;
        }
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(!isFiltered){
        DisplayViewController *display=[self.storyboard instantiateViewControllerWithIdentifier:@"DisplayViewController"];
        [display setTask:[todoArray objectAtIndex:indexPath.row]];
        [display setIndex:indexPath.row];
        [self.navigationController pushViewController:display animated:YES];
    }
}

-(void) doneMethod:(id) sender{
    NSMutableArray *arr= [[myUserDefault getArrayWithCustomObjFromUserDefaults:userDefaults AndKey:@"doneTasks"] mutableCopy];
    [arr addObject:[todoArray objectAtIndex:[sender tag]]];
    [myUserDefault setArrayWithCustomObjToUserDefaults:userDefaults AndKey:@"doneTasks" withArray:arr];
    [todoArray removeObjectAtIndex:[sender tag]];
    [myUserDefault setArrayWithCustomObjToUserDefaults:userDefaults AndKey:@"todoTasks" withArray:todoArray];
    [_tableView reloadData];
}

-(void) inProgressMethod:(id) sender{
    NSMutableArray *arr= [[myUserDefault getArrayWithCustomObjFromUserDefaults:userDefaults AndKey:@"inProgressTasks"] mutableCopy];
    [arr addObject:[todoArray objectAtIndex:[sender tag]]];
    [myUserDefault setArrayWithCustomObjToUserDefaults:userDefaults AndKey:@"inProgressTasks" withArray:arr];
    [todoArray removeObjectAtIndex:[sender tag]];
    [myUserDefault setArrayWithCustomObjToUserDefaults:userDefaults AndKey:@"todoTasks" withArray:todoArray];
    [_tableView reloadData];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if(!isFiltered){
        if (editingStyle == UITableViewCellEditingStyleDelete) {
            [todoArray removeObjectAtIndex:indexPath.row];
            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        }
        [myUserDefault setArrayWithCustomObjToUserDefaults:userDefaults AndKey:@"todoTasks" withArray:todoArray];
        [tableView reloadData];
    }
}

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar{
    isFiltered = YES;
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    if(searchText.length==0)
    {
        isFiltered=NO;
    }else{
        isFiltered = YES;
        searchArray = [NSMutableArray new];
        for (int i=0;i<[todoArray count];i++){
            NSString * str = [[todoArray objectAtIndex:i] taskName];
            NSRange stringRange = [str rangeOfString:searchText options:NSCaseInsensitiveSearch];
            if(stringRange.location != NSNotFound)
            {
                [searchArray addObject:[todoArray objectAtIndex:i]];
            }
        }
    }
    [_tableView reloadData];
}

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    [_tableView resignFirstResponder];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    isFiltered=NO;
    [_tableView reloadData];
}
@end
