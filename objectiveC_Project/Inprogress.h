//
//  Inprogress.h
//  objectiveC_Project
//
//  Created by Abdelrahman on 19/01/2023.
//

#import <UIKit/UIKit.h>
#import "remData.h"
#import "FirstEdit.h"
#import "SecondEdit.h"

NS_ASSUME_NONNULL_BEGIN

@interface Inprogress : UIViewController <UITableViewDelegate,UITableViewDataSource>
{
    NSUserDefaults * def;
    int index;
    NSInteger  section ;
    NSInteger  row ;
}
@property NSString * data;
@property remData * inprogREM;


@end

NS_ASSUME_NONNULL_END
