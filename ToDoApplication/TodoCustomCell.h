//
//  TodoCustomCell.h
//  ToDoApplication
//
//  Created by Mohab El-Ziny on 05/04/2022.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TodoCustomCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *btnDone;
@property (weak, nonatomic) IBOutlet UIButton *btnInProgress;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (weak, nonatomic) IBOutlet UIImageView *myImage;
@end

NS_ASSUME_NONNULL_END
