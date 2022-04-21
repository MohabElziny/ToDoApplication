//
//  DisplayViewController.h
//  ToDoApplication
//
//  Created by Mohab El-Ziny on 06/04/2022.
//

#import <UIKit/UIKit.h>
#import "Task.h"

NS_ASSUME_NONNULL_BEGIN

@interface DisplayViewController : UIViewController
@property int index;
@property Task *task;
@end

NS_ASSUME_NONNULL_END
