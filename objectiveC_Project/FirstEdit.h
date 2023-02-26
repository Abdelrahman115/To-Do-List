//
//  FirstEdit.h
//  objectiveC_Project
//
//  Created by Abdelrahman on 19/01/2023.
//

#import <UIKit/UIKit.h>
#import "remData.h"

NS_ASSUME_NONNULL_BEGIN
@class FirstEdit;

 @protocol ViewControllerCDelegate <NSObject>
 - (void)addItemViewController1:(FirstEdit*)controller didFinishEnteringItem1:(remData *)item;
 @end

@interface FirstEdit : UIViewController
{
    remData * rEdit;
    NSDate * today;
    NSUserDefaults * def;

}
@property (nonatomic, weak) id <ViewControllerCDelegate> delegate;
@property NSString * nameEditprp;
@property NSString * descriptionEditprp;
@property NSString * priority2;
@property NSString * date2;
@property NSString * img2;
@property NSString * state;

@end

NS_ASSUME_NONNULL_END
