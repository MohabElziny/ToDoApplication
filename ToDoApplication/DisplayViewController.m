//
//  DisplayViewController.m
//  ToDoApplication
//
//  Created by Mohab El-Ziny on 06/04/2022.
//

#import "DisplayViewController.h"
#import "MyUserDefault.h"
#import "Task.h"
#import "EditScreenViewController.h"
@interface DisplayViewController ()
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (weak, nonatomic) IBOutlet UILabel *priorityLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;

@end

@implementation DisplayViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [_nameLabel setText:[_task taskName]];
    [_descriptionLabel setText:[_task taskDescription]];
    [_dateLabel setText:[self getDateInString:[_task taskDate]]];
    [_priorityLabel setText:[self getPriority:[_task taskPriority]]];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    UIBarButtonItem *edit =[[UIBarButtonItem alloc] initWithTitle:@"edit" style:UIBarButtonItemStylePlain target:self action:@selector(navigateToEditScreen)];
    [self.navigationItem setRightBarButtonItem:edit];
}

-(void) navigateToEditScreen{
    EditScreenViewController *editScreen = [self.storyboard instantiateViewControllerWithIdentifier:@"EditScreenViewController"];
    [editScreen setIndex:_index];
    [self.navigationController pushViewController:editScreen animated:YES];
}

-(NSString *) getPriority:(int) index{
    switch (index) {
        case 0:
            return @"High";
            break;
        case 1:
            return @"Medium";
            break;
        case 2:
            return @"Low";
            break;
        default:
            return @"";
            break;
    }
}

-(NSString *) getDateInString:(NSDate *) date{
    return [NSDateFormatter localizedStringFromDate:date
                                                          dateStyle:NSDateFormatterShortStyle
                                                          timeStyle:NSDateFormatterFullStyle];

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
