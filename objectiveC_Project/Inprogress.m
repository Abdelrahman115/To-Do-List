//
//  Inprogress.m
//  objectiveC_Project
//
//  Created by Abdelrahman on 19/01/2023.
//

#import "Inprogress.h"
#import "SecondEdit.h"

@interface Inprogress ()
@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property (weak, nonatomic) IBOutlet UISegmentedControl *filter;

@end

@implementation Inprogress
static NSMutableArray * InProgArray;
static NSMutableArray * lowPriorityArr;
static NSMutableArray * medPriorityArr;
static NSMutableArray * highPriorityArr;
+(void)initialize{
    InProgArray = [NSMutableArray new];
    lowPriorityArr = [NSMutableArray new];
    medPriorityArr = [NSMutableArray new];
    highPriorityArr = [NSMutableArray new];
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    if ([def objectForKey:@"task"] == nil ){
        NSData * dataEmpty = [NSKeyedArchiver archivedDataWithRootObject:InProgArray];
        [def setObject:dataEmpty forKey:@"task"];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    /*NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
     NSData * dataEmpty = [NSKeyedArchiver archivedDataWithRootObject:InProgArray];
     [def setObject:dataEmpty forKey:@"task"];*/
}

- (void)viewWillAppear:(BOOL)animated{
    def = [NSUserDefaults standardUserDefaults];
    NSData * data2 = [def objectForKey:@"task"];
    InProgArray = [NSKeyedUnarchiver unarchiveObjectWithData:data2];
    _filter.selectedSegmentIndex = 0;
    [lowPriorityArr removeAllObjects];
    [medPriorityArr removeAllObjects];
    [highPriorityArr removeAllObjects];
    
    for(int i=0;i<[InProgArray count];i++){
        
        if ([[[InProgArray objectAtIndex:i]remPriority]isEqualToString:@"M"]){
             [medPriorityArr addObject:[InProgArray objectAtIndex:i]];
            [_tableview reloadData];
         }
        if([[[InProgArray objectAtIndex:i]remPriority]isEqualToString:@"L"]){
            [lowPriorityArr addObject:[InProgArray objectAtIndex:i]];
            [_tableview reloadData];
        }
        
       
        if([[[InProgArray objectAtIndex:i]remPriority]isEqualToString:@"H"]){
            [highPriorityArr addObject:[InProgArray objectAtIndex:i]];
            [_tableview reloadData];
        }
    }
    [_tableview reloadData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSInteger numberOfRows = 0;
    switch(section){
        case 0:
            numberOfRows = [lowPriorityArr count];
            break;
        case 1:
            numberOfRows = [medPriorityArr count];
            break;
        case 2:
            numberOfRows = [highPriorityArr count];
            break;
            
    }
    return numberOfRows;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    
    NSString *str;
    switch(section){
        case 0:
            str = @"Low Priority";
            break;
        case 1:
            str = @"Medium Priority";
            break;
        case 2:
            str = @"High Priority";
            break;
            
    }
    return str;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    switch (indexPath.section) {
        case 0:
            cell.textLabel.text = [[lowPriorityArr objectAtIndex:indexPath.row]remName];
            
            
            cell.imageView.image = [UIImage imageNamed:[[lowPriorityArr objectAtIndex:indexPath.row]remImg]];
            
            cell.detailTextLabel.text = [[lowPriorityArr objectAtIndex:indexPath.row]remDate];
            break;
            
        case 1:
           cell.textLabel.text = [[medPriorityArr objectAtIndex:indexPath.row]remName];
            
            
            cell.imageView.image = [UIImage imageNamed:[[medPriorityArr objectAtIndex:indexPath.row]remImg]];
            
            cell.detailTextLabel.text = [[medPriorityArr objectAtIndex:indexPath.row]remDate];
            
            break;
            
        case 2:
           cell.textLabel.text = [[highPriorityArr objectAtIndex:indexPath.row]remName];
            
            
            cell.imageView.image = [UIImage imageNamed:[[highPriorityArr objectAtIndex:indexPath.row]remImg]];
            
            cell.detailTextLabel.text = [[highPriorityArr objectAtIndex:indexPath.row]remDate];
            
            break;
    }
    return cell;
}


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"Delete Reminder!" message:@"Do you want to DELETE this reminder?" preferredStyle:UIAlertControllerStyleActionSheet];
        //make buttons
        UIAlertAction * yesbutton = [UIAlertAction actionWithTitle:@"Yes" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            def = [NSUserDefaults standardUserDefaults];
            NSData * data2 = [def objectForKey:@"task"];
            InProgArray = [NSKeyedUnarchiver unarchiveObjectWithData:data2];
  
                switch(indexPath.section){
                case 0:
                    [lowPriorityArr removeObjectAtIndex:indexPath.row];
                    
                    break;
                case 1:
            
                    [medPriorityArr removeObjectAtIndex:indexPath.row];
                    break;
                case 2:
                    [highPriorityArr removeObjectAtIndex:indexPath.row];
                    break;
            }
            
            [InProgArray removeAllObjects];
            [InProgArray addObjectsFromArray:lowPriorityArr];
            [InProgArray addObjectsFromArray:medPriorityArr];
            [InProgArray addObjectsFromArray:highPriorityArr];
            
            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            
            def = [NSUserDefaults standardUserDefaults];
            NSData * data1 = [NSKeyedArchiver archivedDataWithRootObject:InProgArray];
            [def setObject:data1 forKey:@"task"];
            [def synchronize];
  
        }];
        
        UIAlertAction * cancelbutton = [UIAlertAction actionWithTitle:@"NO" style:UIAlertActionStyleDestructive handler:nil];

    //add button

    [alert addAction:yesbutton];
    [alert addAction:cancelbutton];
   
    [self presentViewController:alert animated:YES completion:nil];
        
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    FirstEdit * edit1 = [self.storyboard instantiateViewControllerWithIdentifier:@"FirstEdit"];
    
   section = indexPath.section;
    row = indexPath.row;
    printf("%d",section);
    switch (indexPath.section) {
        case 0:
            edit1.nameEditprp = [[lowPriorityArr objectAtIndex:indexPath.row]remName];
            edit1.descriptionEditprp = [[InProgArray objectAtIndex:indexPath.row]remDescription];
            
            edit1.priority2 = [[lowPriorityArr objectAtIndex:indexPath.row]remPriority];
            
            edit1.date2 = [[lowPriorityArr objectAtIndex:indexPath.row]remDate];
            
            edit1.img2 = [[lowPriorityArr objectAtIndex:indexPath.row]remImg];
            edit1.delegate =self;
            //index = indexPath.section;
            break;
        case 1:
            edit1.nameEditprp = [[medPriorityArr objectAtIndex:indexPath.row]remName];
            edit1.descriptionEditprp = [[InProgArray objectAtIndex:indexPath.row]remDescription];
            
            edit1.priority2 = [[medPriorityArr objectAtIndex:indexPath.row]remPriority];
            
            edit1.date2 = [[medPriorityArr objectAtIndex:indexPath.row]remDate];
            
            edit1.img2 = [[medPriorityArr objectAtIndex:indexPath.row]remImg];
            edit1.delegate =self;
            //index = indexPath.section;
            break;
        case 2:
            edit1.nameEditprp = [[highPriorityArr objectAtIndex:indexPath.row]remName];
            edit1.descriptionEditprp = [[InProgArray objectAtIndex:indexPath.row]remDescription];
            
            edit1.priority2 = [[highPriorityArr objectAtIndex:indexPath.row]remPriority];
            
            edit1.date2 = [[highPriorityArr objectAtIndex:indexPath.row]remDate];
            
            edit1.img2 = [[highPriorityArr objectAtIndex:indexPath.row]remImg];
            edit1.delegate =self;
            //index = indexPath.section;
            break;
    }
    
    
    
    
    
    [_tableview reloadData];
    [self.navigationController pushViewController:edit1 animated:YES];
    
    
}
- (IBAction)filterAction:(id)sender {
    switch(self.filter.selectedSegmentIndex){
        case 0:
            [medPriorityArr removeAllObjects];
            [highPriorityArr removeAllObjects];
            [lowPriorityArr removeAllObjects];
            for(int i=0;i<[InProgArray count];i++){
                if ([[[InProgArray objectAtIndex:i]remPriority]isEqualToString:@"M"]){
                    
                     [medPriorityArr addObject:[InProgArray objectAtIndex:i]];
                 }
                if([[[InProgArray objectAtIndex:i]remPriority]isEqualToString:@"L"]){
                    
                    [lowPriorityArr addObject:[InProgArray objectAtIndex:i]];
                }
                
               
                if([[[InProgArray objectAtIndex:i]remPriority]isEqualToString:@"H"]){
            
                    [highPriorityArr addObject:[InProgArray objectAtIndex:i]];
                }
            }
            [_tableview reloadData];
            break;
        
        
        
        
        case 1:
            [medPriorityArr removeAllObjects];
            [highPriorityArr removeAllObjects];
            [lowPriorityArr removeAllObjects];
            for(int i=0;i<[InProgArray count];i++){
                if ([[[InProgArray objectAtIndex:i]remPriority]isEqualToString:@"L"]){
                     [lowPriorityArr addObject:[InProgArray objectAtIndex:i]];
                 }
            }
            
            [_tableview reloadData];
            break;
        case 2:
            [lowPriorityArr removeAllObjects];
            [highPriorityArr removeAllObjects];
            [medPriorityArr removeAllObjects];
            for(int i=0;i<[InProgArray count];i++){
                if ([[[InProgArray objectAtIndex:i]remPriority]isEqualToString:@"M"]){
                     [medPriorityArr addObject:[InProgArray objectAtIndex:i]];
                 }
            }
            [_tableview reloadData];
            break;
        case 3:
            [lowPriorityArr removeAllObjects];
            [medPriorityArr removeAllObjects];
            [highPriorityArr removeAllObjects];
            for(int i=0;i<[InProgArray count];i++){
                if ([[[InProgArray objectAtIndex:i]remPriority]isEqualToString:@"H"]){
                     [highPriorityArr addObject:[InProgArray objectAtIndex:i]];
                 }
            }
            [_tableview reloadData];
            break;
    }
}

- (void)addItemViewController1:(FirstEdit *)controller didFinishEnteringItem1:(remData *)item
 {
     NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
     NSData * d = [def objectForKey:@"task"];
     InProgArray = [NSKeyedUnarchiver unarchiveObjectWithData:d];
     
     [lowPriorityArr removeAllObjects];
     [medPriorityArr removeAllObjects];
     [highPriorityArr removeAllObjects];
     
     for(int i=0;i<[InProgArray count];i++){
         
         if ([[[InProgArray objectAtIndex:i]remPriority]isEqualToString:@"M"]){
              [medPriorityArr addObject:[InProgArray objectAtIndex:i]];
             [_tableview reloadData];
          }
         if([[[InProgArray objectAtIndex:i]remPriority]isEqualToString:@"L"]){
             [lowPriorityArr addObject:[InProgArray objectAtIndex:i]];
             [_tableview reloadData];
         }
         
        
         if([[[InProgArray objectAtIndex:i]remPriority]isEqualToString:@"H"]){
             [highPriorityArr addObject:[InProgArray objectAtIndex:i]];
             [_tableview reloadData];
         }
     }
     [_tableview reloadData];
     
     switch (section) {
         case 0:
             if([item.remState isEqualToString:@"InProgress"]){
                [lowPriorityArr removeObjectAtIndex:row];

                 [_tableview reloadData];
             }
             
             else{
                
                 [lowPriorityArr removeObjectAtIndex:row];
                 [_tableview reloadData];
             }
             break;
         case 1:
             if([item.remState isEqualToString:@"InProgress"]){
                [medPriorityArr removeObjectAtIndex:row];
                 [_tableview reloadData];
             }
             
             else{
                
                 [medPriorityArr removeObjectAtIndex:row];
   
                 [_tableview reloadData];
             }
             break;
         case 2:
             if([item.remState isEqualToString:@"InProgress"]){
                [highPriorityArr removeObjectAtIndex:row];
        
                 [_tableview reloadData];
             }
             
             else{
                
                 [highPriorityArr removeObjectAtIndex:row];
                 [_tableview reloadData];
             }
             break;
             
         
     }
     [InProgArray removeAllObjects];
     [InProgArray addObjectsFromArray:lowPriorityArr];
     [InProgArray addObjectsFromArray:medPriorityArr];
     [InProgArray addObjectsFromArray:highPriorityArr];
     
     

     
     //NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
     NSData * data3 = [NSKeyedArchiver archivedDataWithRootObject:InProgArray];
     [def setObject:data3 forKey:@"task"];
     [def synchronize];
 }




@end
