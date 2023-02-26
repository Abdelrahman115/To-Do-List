//
//  FirstEdit.m
//  objectiveC_Project
//
//  Created by Abdelrahman on 19/01/2023.
//

#import "FirstEdit.h"
#import "ViewController.h"
#import "remData.h"
#import "Inprogress.h"
#import "Done.h"

@interface FirstEdit ()
{
        remData * rEnter;
        remData * rEnter1;
}
@property (weak, nonatomic) IBOutlet UITextField *edit1Name;
@property (weak, nonatomic) IBOutlet UITextView *edit1Description;
@property (weak, nonatomic) IBOutlet UISegmentedControl *edit1Priority;
@property (weak, nonatomic) IBOutlet UISegmentedControl *edit1State;


@end

@implementation FirstEdit
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
    _edit1Name.text = _nameEditprp;
    _edit1Description.text = _descriptionEditprp;
    rEdit = [remData new];
    rEdit.remName = _nameEditprp;
    rEdit.remDescription = _descriptionEditprp;
    rEdit.remPriority = _priority2;
    rEdit.remDate = _date2;
    rEdit.remImg = _img2;
    
    
    
    if([_priority2 isEqualToString: @"L"]){
        _edit1Priority.selectedSegmentIndex = 0;
    }
    if([_priority2 isEqualToString: @"M"]){
        _edit1Priority.selectedSegmentIndex = 1;
    }
    if([_priority2 isEqualToString: @"H"]){
        _edit1Priority.selectedSegmentIndex = 2;
    }
    
}
- (IBAction)EDIT1:(id)sender {
    UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"Edit Reminder!" message:@"Do you want to EDIT this reminder?" preferredStyle:UIAlertControllerStyleActionSheet];
    //make buttons
    UIAlertAction * yesbutton = [UIAlertAction actionWithTitle:@"Yes" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if([_state isEqualToString:@"ToDo"]){
             ViewController * todo = [self.storyboard instantiateViewControllerWithIdentifier:@"ViewController"];
             
             today = [NSDate date];
             NSDateFormatter * dateFormat = [[NSDateFormatter alloc]init];
             [dateFormat setDateFormat:@"dd/MM/yyyy"];
             NSString * datestring = [dateFormat stringFromDate:today];
             
             rEnter = [remData new];
             rEnter.remName = _edit1Name.text;
             rEnter.remDescription = _edit1Description.text;
             rEnter.remPriority = _priority2;
             rEnter.remDate = datestring;
             rEnter.remImg = _img2;
            rEnter.remState = _state;
            
            NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
            NSData * d = [def objectForKey:@"todoArrNew"];
            todoArray = [NSKeyedUnarchiver unarchiveObjectWithData:d];
            [todoArray addObject:rEnter];
            NSData * data = [NSKeyedArchiver archivedDataWithRootObject:todoArray];
            [def setObject:data forKey:@"todoArrNew"];
            [def synchronize];
             
             [self.delegate addItemViewController1:self didFinishEnteringItem1:rEnter];
            
            [self.navigationController popViewControllerAnimated:YES];
             
         }
         
         if([_state isEqualToString:@"InProgress"]){
             Inprogress * inprogress = [self.storyboard instantiateViewControllerWithIdentifier:@"Inprogress"];
             
             today = [NSDate date];
             NSDateFormatter * dateFormat = [[NSDateFormatter alloc]init];
             [dateFormat setDateFormat:@"dd/MM/yyyy"];
             NSString * datestring = [dateFormat stringFromDate:today];
             
             rEnter = [remData new];
             rEnter.remName = _edit1Name.text;
             rEnter.remDescription = _edit1Description.text;
             rEnter.remPriority = _priority2;
             rEnter.remDate = datestring;
             rEnter.remImg = _img2;
             rEnter.remState= _state;
             
             
           
             NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
             NSData * d2 = [def objectForKey:@"task"];
             inProgressArray = [NSKeyedUnarchiver unarchiveObjectWithData:d2];
             def = [NSUserDefaults standardUserDefaults];
             [inProgressArray addObject:rEnter];
             NSData * data1 = [NSKeyedArchiver archivedDataWithRootObject:inProgressArray];
             [def setObject:data1 forKey:@"task"];
             [def synchronize];
             
             
             [self.delegate addItemViewController1:self didFinishEnteringItem1:rEnter];
            
            [self.navigationController popViewControllerAnimated:YES];
         }
        
        if([_state isEqualToString:@"Done"]){
            today = [NSDate date];
            NSDateFormatter * dateFormat = [[NSDateFormatter alloc]init];
            [dateFormat setDateFormat:@"dd/MM/yyyy"];
            NSString * datestring = [dateFormat stringFromDate:today];
            
            rEnter1 = [remData new];
            rEnter1.remName = _edit1Name.text;
            rEnter1.remDescription = _edit1Description.text;
            rEnter1.remPriority = _priority2;
            rEnter1.remDate = datestring;
            rEnter1.remImg = _img2;
            rEnter1.remState = _state;
            
            
            NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
            NSData * d2 = [def objectForKey:@"taskDone"];
            DoneArray = [NSKeyedUnarchiver unarchiveObjectWithData:d2];
            [DoneArray addObject:rEnter1];
            def = [NSUserDefaults standardUserDefaults];
            NSData * data1 = [NSKeyedArchiver archivedDataWithRootObject:DoneArray];
            [def setObject:data1 forKey:@"taskDone"];
            [def synchronize];
            
            
            [self.delegate addItemViewController1:self didFinishEnteringItem1:rEnter1];
            
            [self.navigationController popViewControllerAnimated:YES];
        }
    }];
    
    UIAlertAction * cancelbutton = [UIAlertAction actionWithTitle:@"NO" style:UIAlertActionStyleDestructive handler:nil];

//add button

[alert addAction:yesbutton];
[alert addAction:cancelbutton];

//show alert
[self presentViewController:alert animated:YES completion:nil];
    
}

- (IBAction)STATE1:(id)sender {
    switch(self.edit1State.selectedSegmentIndex){
        case 0:
            _state = @"ToDo";
            printf("%s",[_state UTF8String]);
            break;
        case 1:
            _state = @"InProgress";
            
            break;
        case 2:
            _state = @"Done";
            
            
            break;
    }
}

- (IBAction)priority1:(id)sender {
    switch(self.edit1Priority.selectedSegmentIndex){
            
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
