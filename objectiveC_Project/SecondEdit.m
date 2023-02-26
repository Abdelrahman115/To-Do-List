//
//  SecondEdit.m
//  objectiveC_Project
//
//  Created by Abdelrahman on 19/01/2023.
//

#import "SecondEdit.h"
#import "remData.h"
#import "Inprogress.h"

@interface SecondEdit ()
{
        remData * rEnter;
        remData * rEnter1;
}
@property (weak, nonatomic) IBOutlet UITextField *edit2Name;
@property (weak, nonatomic) IBOutlet UITextView *edit2Description;
@property (weak, nonatomic) IBOutlet UISegmentedControl *edit2Priority;
@property (weak, nonatomic) IBOutlet UISegmentedControl *edit2State;

@end

@implementation SecondEdit

static NSMutableArray *inProgressArray;
static NSMutableArray *DoneArray;
static NSMutableArray *todoArray;
+(void)initialize{
    inProgressArray = [NSMutableArray new];
    DoneArray = [NSMutableArray new];
    todoArray = [NSMutableArray new];
    
   
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _edit2Name.text = _nameEditprp;
    _edit2Description.text = _descriptionEditprp;
    rEdit = [remData new];
    rEdit.remName = _nameEditprp;
    rEdit.remDescription = _descriptionEditprp;
    rEdit.remPriority = _priority2;
    rEdit.remDate = _date2;
    rEdit.remImg = _img2;
    
    
    
    if([_priority2 isEqualToString: @"L"]){
        _edit2Priority.selectedSegmentIndex = 0;
    }
    if([_priority2 isEqualToString: @"M"]){
        _edit2Priority.selectedSegmentIndex = 1;
    }
    if([_priority2 isEqualToString: @"H"]){
        _edit2Priority.selectedSegmentIndex = 2;
    }
    printf("%s",[_priority2 UTF8String]);
}

- (void)viewWillAppear:(BOOL)animated{
    
}

- (IBAction)EDIT2:(id)sender {
    UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"Edit Reminder!" message:@"Do you want to EDIT this reminder?" preferredStyle:UIAlertControllerStyleActionSheet];
    //make buttons
    UIAlertAction * yesbutton = [UIAlertAction actionWithTitle:@"Yes" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        if([_state isEqualToString:@"InProgress"]){
             Inprogress * inprogress = [self.storyboard instantiateViewControllerWithIdentifier:@"Inprogress"];
             
             today = [NSDate date];
             NSDateFormatter * dateFormat = [[NSDateFormatter alloc]init];
             [dateFormat setDateFormat:@"dd/MM/yyyy"];
             NSString * datestring = [dateFormat stringFromDate:today];
             
             rEnter = [remData new];
             rEnter.remName = _edit2Name.text;
             rEnter.remDescription = _edit2Description.text;
             rEnter.remPriority = _priority2;
             rEnter.remDate = datestring;
             rEnter.remImg = _img2;
             rEnter.remState= _state;
             
             
             
            NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
             NSData * d = [def objectForKey:@"task"];
             inProgressArray= [NSKeyedUnarchiver unarchiveObjectWithData:d];
             [inProgressArray addObject:rEnter];
             NSData * data = [NSKeyedArchiver archivedDataWithRootObject:inProgressArray];
             
             
             [def setObject:data forKey:@"task"];
             [def synchronize];
             
             
            [self.delegate addItemViewController2:self didFinishEnteringItem2:rEnter];
            
            [self.navigationController popViewControllerAnimated:YES];

             
         }
        
        if([_state isEqualToString:@"Done"]){
            today = [NSDate date];
            NSDateFormatter * dateFormat = [[NSDateFormatter alloc]init];
            [dateFormat setDateFormat:@"dd/MM/yyyy"];
            NSString * datestring = [dateFormat stringFromDate:today];
            
            rEnter1 = [remData new];
            rEnter1.remName = _edit2Name.text;
            rEnter1.remDescription = _edit2Description.text;
            rEnter1.remPriority = _priority2;
            rEnter1.remDate = datestring;
            rEnter1.remImg = _img2;
            rEnter1.remState = _state;
            
            
          
            NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
            NSData * d = [def objectForKey:@"task"];
            inProgressArray = [NSKeyedUnarchiver unarchiveObjectWithData:d];
            [inProgressArray addObject:rEnter1];
            NSData * data = [NSKeyedArchiver archivedDataWithRootObject:inProgressArray];
            
            //NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
            [def setObject:data forKey:@"task"];
            [def synchronize];
            
            NSData * d2 = [def objectForKey:@"taskDone1"];
            DoneArray = [NSKeyedUnarchiver unarchiveObjectWithData:d2];
            [DoneArray addObject:rEnter1];
            
            
            
            def = [NSUserDefaults standardUserDefaults];
            NSData * data1 = [NSKeyedArchiver archivedDataWithRootObject:DoneArray];
            [def setObject:data1 forKey:@"taskDone1"];
            [def synchronize];
            
            /*NSData * d3 = [def objectForKey:@"task"];
            inProgressArray = [NSKeyedUnarchiver unarchiveObjectWithData:d3];
            //def = [NSUserDefaults standardUserDefaults];
            [inProgressArray addObject:rEnter1];
            NSData * data3 = [NSKeyedArchiver archivedDataWithRootObject:inProgressArray];
            [def setObject:data3 forKey:@"task"];
            [def synchronize];*/
            
            [self.delegate addItemViewController2:self didFinishEnteringItem2:rEnter1];
           
           [self.navigationController popViewControllerAnimated:YES];
            
            
            
        }

    
    }];
    
    UIAlertAction * cancelbutton = [UIAlertAction actionWithTitle:@"NO" style:UIAlertActionStyleDestructive handler:nil];

//add button

[alert addAction:yesbutton];
[alert addAction:cancelbutton];
//[alert addAction:nobutton];





//show alert
[self presentViewController:alert animated:YES completion:nil];
    

}

- (IBAction)STATE2:(id)sender {
    switch(self.edit2State.selectedSegmentIndex){
    
        case 0:
            _state = @"InProgress";
            printf("%s",[_state UTF8String]);
            
            break;
        case 1:
            _state = @"Done";
            printf("%s",[_state UTF8String]);
            
            break;
    }
}

- (IBAction)PRIOTITY2:(id)sender {
    switch(self.edit2Priority.selectedSegmentIndex){
            
        case 0:
            _priority2 = @"L";
            _img2 = @"1";
            //printf("%s",[_priority UTF8String]);
            break;
            
        case 1:
            _priority2 = @"M";
            _img2 = @"2";
            //printf("%d",_priority);
            break;
        case 2:
            _priority2 = @"H";
            _img2 = @"3";
            //printf("%s",[_priority UTF8String]);
            break;
    }
}




@end
