//
//  Task.h
//  ToDoApplication
//
//  Created by Mohab El-Ziny on 05/04/2022.
//

#import <Foundation/Foundation.h>

@interface Task : NSObject
@property NSString *taskName;
@property int taskPriority;
@property NSString *taskDescription;
@property NSDate *taskDate;
- (void) encodeWithCoder : (NSCoder *)encode ;
- (id) initWithCoder : (NSCoder *)decode;
@end

