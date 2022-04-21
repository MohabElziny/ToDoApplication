//
//  MyUserDefault.m
//  ToDoApplication
//
//  Created by Mohab El-Ziny on 05/04/2022.
//

#import "MyUserDefault.h"

@implementation MyUserDefault
- (NSArray *)getArrayWithCustomObjFromUserDefaults:(NSUserDefaults *)userDefaults AndKey:(NSString *)keyName{
    NSData *data = [userDefaults objectForKey:keyName];
    NSArray *myArray = [NSMutableArray arrayWithArray:[NSKeyedUnarchiver unarchiveObjectWithData:data]];
    return myArray;
}

- (void)setArrayWithCustomObjToUserDefaults:(NSUserDefaults *)userDefaults AndKey:(NSString *)keyName withArray:(NSMutableArray *)myArray{
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:myArray];
    [userDefaults setObject:data forKey:keyName];
    [userDefaults synchronize];
}
@end
