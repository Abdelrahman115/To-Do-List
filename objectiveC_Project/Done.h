//
//  Done.h
//  objectiveC_Project
//
//  Created by Abdelrahman on 19/01/2023.
//

#import <UIKit/UIKit.h>
#import "remData.h"
#import "FirstEdit.h"

NS_ASSUME_NONNULL_BEGIN

@interface Done : UIViewController <UITableViewDelegate,UITableViewDataSource>
{
    NSUserDefaults * def;
    int index;
    NSInteger  section ;
    NSInteger  row ;
}

@end

NS_ASSUME_NONNULL_END
