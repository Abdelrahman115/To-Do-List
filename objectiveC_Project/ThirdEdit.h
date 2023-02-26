//
//  ThirdEdit.h
//  objectiveC_Project
//
//  Created by Abdelrahman on 19/01/2023.
//

#import <UIKit/UIKit.h>
#import "remData.h"

NS_ASSUME_NONNULL_BEGIN

@class ThirdEdit;

 @protocol ViewControllerEDelegate <NSObject>
 - (void)addItemViewController3:(ThirdEdit*)controller didFinishEnteringItem3:(remData *)item;
 @end

@interface ThirdEdit : UIViewController
{
    remData * rEdit;
    NSDate * today;
    NSUserDefaults * def;

}
@property (nonatomic, weak) id <ViewControllerEDelegate> delegate;
@property NSString * nameEditprp;
@property NSString * descriptionEditprp;
@property NSString * priority3;
@property NSString * date2;
@property NSString * img2;
@property NSString * state;

@end

NS_ASSUME_NONNULL_END
