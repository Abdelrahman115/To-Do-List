//
//  Add.m
//  objectiveC_Project
//
//  Created by Abdelrahman on 19/01/2023.
//

#import "Add.h"
#import "remData.h"

@interface Add ()
@property (weak, nonatomic) IBOutlet UITextField *addName;
@property (weak, nonatomic) IBOutlet UITextView *addDescription;
@property (weak, nonatomic) IBOutlet UISegmentedControl *addPriority;

@end

@implementation Add
static NSMutableArray *todoArray;
+(void)initialize{
    todoArray = [NSMutableArray new];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)viewWillAppear:(BOOL)animated{
    
    
}

- (IBAction)ADD:(id)sender {
    UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"Add Reminder!" message:@"Do you want to add this reminder?" preferredStyle:UIAlertControllerStyleActionSheet];
    //make buttons
    UIAlertAction * yesbutton = [UIAlertAction actionWithTitle:@"Yes" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        
        
        NSDate * today = [NSDate date];
        NSDateFormatter * dateFormat = [[NSDateFormatter alloc]init];
        [dateFormat setDateFormat:@"dd/MM/yyyy"];
        NSString * datestring = [dateFormat stringFromDate:today];
        
        
        rEnter = [remData new];
        rEnter.remName = _addName.text;
        rEnter.remDescription = _addDescription.text;
        rEnter.remPriority = _priority;
        rEnter.remDate = datestring;
        rEnter.remImg = _image;
        
        NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
        NSData * d = [def objectForKey:@"todoArrNew"];
        todoArray = [NSKeyedUnarchiver unarchiveObjectWithData:d];
        
        [todoArray addObject:rEnter];
        NSData * data = [NSKeyedArchiver archivedDataWithRootObject:todoArray];
        
        
        [def setObject:data forKey:@"todoArrNew"];
        [def synchronize];
        
        
        [self.navigationController popViewControllerAnimated:YES];

    
    }];
    
    UIAlertAction * cancelbutton = [UIAlertAction actionWithTitle:@"NO" style:UIAlertActionStyleDefault handler:nil];


[alert addAction:yesbutton];
[alert addAction:cancelbutton];


[self presentViewController:alert animated:YES completion:nil];
    
    
    
    
}

- (IBAction)addSegment:(id)sender {
    switch(self.addPriority.selectedSegmentIndex){
            
        case 0:
            _priority = @"L";
            _image = @"1";
            //printf("%s",[_priority UTF8String]);
            break;
            
        case 1:
            _priority = @"M";
            _image = @"2";
            //printf("%d",_priority);
            break;
        case 2:
            _priority = @"H";
            _image = @"3";
            //printf("%s",[_priority UTF8String]);
            break;
    }
    
}



@end
