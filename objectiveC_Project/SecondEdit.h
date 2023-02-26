//
//  SecondEdit.h
//  objectiveC_Project
//
//  Created by Abdelrahman on 19/01/2023.
//

#import <UIKit/UIKit.h>
#import "remData.h"

NS_ASSUME_NONNULL_BEGIN
@class SecondEdit;

 @protocol ViewControllerDDelegate <NSObject>
 - (void)addItemViewController2:(SecondEdit*)controller didFinishEnteringItem2:(remData *)item;
 @end

@interface SecondEdit : UIViewController
{
    remData * rEdit;
    NSDate * today;
    NSUserDefaults * def;

}
@property (nonatomic, weak) id <ViewControllerDDelegate> delegate;
@property NSString * nameEditprp;
@property NSString * descriptionEditprp;
@property NSString * priority2;
@property NSString * date2;
@property NSString * img2;
@property NSString * state;

@end

NS_ASSUME_NONNULL_END
