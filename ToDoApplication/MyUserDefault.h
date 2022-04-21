//
//  MyUserDefault.h
//  ToDoApplication
//
//  Created by Mohab El-Ziny on 05/04/2022.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MyUserDefault : NSObject
-(NSArray *)getArrayWithCustomObjFromUserDefaults:(NSUserDefaults*) userDefaults AndKey:(NSString*)keyName;
-(void)setArrayWithCustomObjToUserDefaults:(NSUserDefaults*) userDefaults AndKey:(NSString *)keyName withArray:(NSMutableArray *)myArray;
@end

NS_ASSUME_NONNULL_END
