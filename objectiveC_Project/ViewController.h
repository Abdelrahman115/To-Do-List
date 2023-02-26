//
//  ViewController.h
//  objectiveC_Project
//
//  Created by Abdelrahman on 19/01/2023.
//

#import <UIKit/UIKit.h>
#import "remData.h"
#import "FirstEdit.h"

@interface ViewController : UIViewController <UITableViewDelegate,UITableViewDataSource>
{
    remData * r1;
    int index;
}


@end

