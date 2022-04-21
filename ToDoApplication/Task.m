//
//  Task.m
//  ToDoApplication
//
//  Created by Mohab El-Ziny on 05/04/2022.
//

#import "Task.h"

@implementation Task
- (void)encodeWithCoder:(NSCoder *)coder;
{
    [coder encodeObject:_taskName forKey:@"name"];
    [coder encodeObject:_taskDescription forKey:@"myDescription"];
    [coder encodeInt:_taskPriority forKey:@"priority"];
    [coder encodeObject:_taskDate forKey:@"myDate"];
}

- (id)initWithCoder:(NSCoder *)coder;
{
    self = [super init];
    if (self != nil)
    {
        _taskName =[coder decodeObjectForKey:@"name"];
        _taskDescription =[coder decodeObjectForKey:@"myDescription"];
        _taskPriority =[coder decodeIntForKey:@"priority"];
        _taskDate =[coder decodeObjectForKey:@"myDate"];

    }
    return self;
}
@end
