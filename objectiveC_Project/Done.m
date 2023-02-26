//
//  Done.m
//  objectiveC_Project
//
//  Created by Abdelrahman on 19/01/2023.
//

#import "Done.h"
#import "FirstEdit.h"

@interface Done ()
@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property (weak, nonatomic) IBOutlet UISegmentedControl *filter;

@end

@implementation Done
static NSMutableArray * DoneArray1;


static NSMutableArray * lowPriorityArr;
static NSMutableArray * medPriorityArr;
static NSMutableArray * highPriorityArr;
+(void)initialize{
    DoneArray1 = [NSMutableArray new];
    lowPriorityArr = [NSMutableArray new];
    medPriorityArr = [NSMutableArray new];
    highPriorityArr = [NSMutableArray new];
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    if ([def objectForKey:@"taskDone"] == nil ){
        NSData * dataEmpty = [NSKeyedArchiver archivedDataWithRootObject:DoneArray1];
        [def setObject:dataEmpty forKey:@"taskDone"];
    }

}

- (void)viewDidLoad {
    [super viewDidLoad];
    /*NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
     NSData * dataEmpty = [NSKeyedArchiver archivedDataWithRootObject:DoneArray1];
     [def setObject:dataEmpty forKey:@"taskDone"];*/
}

- (void)viewWillAppear:(BOOL)animated{
    
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    def = [NSUserDefaults standardUserDefaults];
    NSData * data2 = [def objectForKey:@"taskDone"];
    DoneArray1 = [NSKeyedUnarchiver unarchiveObjectWithData:data2];

    _filter.selectedSegmentIndex = 0;
    [lowPriorityArr removeAllObjects];
    [medPriorityArr removeAllObjects];
    [highPriorityArr removeAllObjects];
    
    for(int i=0;i<[DoneArray1 count];i++){
        
        if ([[[DoneArray1 objectAtIndex:i]remPriority]isEqualToString:@"M"]){
            [medPriorityArr addObject:[DoneArray1 objectAtIndex:i]];
            [_tableview reloadData];
        }
        if([[[DoneArray1 objectAtIndex:i]remPriority]isEqualToString:@"L"]){
            [lowPriorityArr addObject:[DoneArray1 objectAtIndex:i]];
            [_tableview reloadData];
        }
        
        
        if([[[DoneArray1 objectAtIndex:i]remPriority]isEqualToString:@"H"]){
            [highPriorityArr addObject:[DoneArray1 objectAtIndex:i]];
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
            NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
            def = [NSUserDefaults standardUserDefaults];
            NSData * data2 = [def objectForKey:@"taskDone"];
            DoneArray1 = [NSKeyedUnarchiver unarchiveObjectWithData:data2];
            
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
            
            [DoneArray1 removeAllObjects];
            [DoneArray1 addObjectsFromArray:lowPriorityArr];
            [DoneArray1 addObjectsFromArray:medPriorityArr];
            [DoneArray1 addObjectsFromArray:highPriorityArr];
            
            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            
            def = [NSUserDefaults standardUserDefaults];
            NSData * data1 = [NSKeyedArchiver archivedDataWithRootObject:DoneArray1];
            [def setObject:data1 forKey:@"taskDone"];
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

- (IBAction)filter:(id)sender {
    switch(self.filter.selectedSegmentIndex){
        case 0:
            [medPriorityArr removeAllObjects];
            [highPriorityArr removeAllObjects];
            [lowPriorityArr removeAllObjects];
            for(int i=0;i<[DoneArray1  count];i++){
                if ([[[DoneArray1  objectAtIndex:i]remPriority]isEqualToString:@"M"]){
                    
                    [medPriorityArr addObject:[DoneArray1  objectAtIndex:i]];
                }
                if([[[DoneArray1  objectAtIndex:i]remPriority]isEqualToString:@"L"]){
                    
                    [lowPriorityArr addObject:[DoneArray1  objectAtIndex:i]];
                }
                
                
                if([[[DoneArray1  objectAtIndex:i]remPriority]isEqualToString:@"H"]){
                    
                    [highPriorityArr addObject:[DoneArray1  objectAtIndex:i]];
                }
            }
            [_tableview reloadData];
            break;
            
            
            
            
        case 1:
            [medPriorityArr removeAllObjects];
            [highPriorityArr removeAllObjects];
            [lowPriorityArr removeAllObjects];
            for(int i=0;i<[DoneArray1  count];i++){
                if ([[[DoneArray1  objectAtIndex:i]remPriority]isEqualToString:@"L"]){
                    [lowPriorityArr addObject:[DoneArray1  objectAtIndex:i]];
                }
            }
            [_tableview reloadData];
            break;
        case 2:
            [lowPriorityArr removeAllObjects];
            [highPriorityArr removeAllObjects];
            [medPriorityArr removeAllObjects];
            for(int i=0;i<[DoneArray1  count];i++){
                if ([[[DoneArray1  objectAtIndex:i]remPriority]isEqualToString:@"M"]){
                    [medPriorityArr addObject:[DoneArray1  objectAtIndex:i]];
                }
            }
            [_tableview reloadData];
            break;
        case 3:
            [lowPriorityArr removeAllObjects];
            [medPriorityArr removeAllObjects];
            [highPriorityArr removeAllObjects];
            for(int i=0;i<[DoneArray1  count];i++){
                if ([[[DoneArray1  objectAtIndex:i]remPriority]isEqualToString:@"H"]){
                    [highPriorityArr addObject:[DoneArray1  objectAtIndex:i]];
                }
            }
            [_tableview reloadData];
            break;
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
            edit1.descriptionEditprp = [[DoneArray1 objectAtIndex:indexPath.row]remDescription];
            
            edit1.priority2 = [[lowPriorityArr objectAtIndex:indexPath.row]remPriority];
            
            edit1.date2 = [[lowPriorityArr objectAtIndex:indexPath.row]remDate];
            
            edit1.img2 = [[lowPriorityArr objectAtIndex:indexPath.row]remImg];
            edit1.delegate =self;
            //index = indexPath.section;
            break;
        case 1:
            edit1.nameEditprp = [[medPriorityArr objectAtIndex:indexPath.row]remName];
            edit1.descriptionEditprp = [[DoneArray1 objectAtIndex:indexPath.row]remDescription];
            
            edit1.priority2 = [[medPriorityArr objectAtIndex:indexPath.row]remPriority];
            
            edit1.date2 = [[medPriorityArr objectAtIndex:indexPath.row]remDate];
            
            edit1.img2 = [[medPriorityArr objectAtIndex:indexPath.row]remImg];
            edit1.delegate =self;
            //index = indexPath.section;
            break;
        case 2:
            edit1.nameEditprp = [[highPriorityArr objectAtIndex:indexPath.row]remName];
            edit1.descriptionEditprp = [[DoneArray1 objectAtIndex:indexPath.row]remDescription];
            
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

- (void)addItemViewController1:(FirstEdit *)controller didFinishEnteringItem1:(remData *)item
 {
     NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
     NSData * d = [def objectForKey:@"taskDone"];
     DoneArray1 = [NSKeyedUnarchiver unarchiveObjectWithData:d];
     
     [lowPriorityArr removeAllObjects];
     [medPriorityArr removeAllObjects];
     [highPriorityArr removeAllObjects];
     
     for(int i=0;i<[DoneArray1 count];i++){
         
         if ([[[DoneArray1 objectAtIndex:i]remPriority]isEqualToString:@"M"]){
              [medPriorityArr addObject:[DoneArray1 objectAtIndex:i]];
             [_tableview reloadData];
          }
         if([[[DoneArray1 objectAtIndex:i]remPriority]isEqualToString:@"L"]){
             [lowPriorityArr addObject:[DoneArray1 objectAtIndex:i]];
             [_tableview reloadData];
         }
         
        
         if([[[DoneArray1 objectAtIndex:i]remPriority]isEqualToString:@"H"]){
             [highPriorityArr addObject:[DoneArray1 objectAtIndex:i]];
             [_tableview reloadData];
         }
     }
     [_tableview reloadData];
     
     switch (section) {
         case 0:
             if([item.remState isEqualToString:@"Done"]){
                [lowPriorityArr removeObjectAtIndex:row];
                 //[remindersTodoArray insertObject:item atIndex:index];
                 //[remindersTodoArray addObject:item];
                 
             
                 [_tableview reloadData];
             }
             else{
                
                 [lowPriorityArr removeObjectAtIndex:row];
                 
               
                 [_tableview reloadData];
             }
             
             break;
         case 1:
             if([item.remState isEqualToString:@"Done"]){
                [medPriorityArr removeObjectAtIndex:row];
     
                 [_tableview reloadData];
             }
             else{
                
                 [medPriorityArr removeObjectAtIndex:row];
         
                 [_tableview reloadData];
             }
             
             
             break;
         case 2:
             if([item.remState isEqualToString:@"Done"]){
                [highPriorityArr removeObjectAtIndex:row];
  
                 [_tableview reloadData];
             }
             else{
                
                 [highPriorityArr removeObjectAtIndex:row];

                 [_tableview reloadData];
             }
             
             
             break;
             
         
     }
     [DoneArray1 removeAllObjects];
     [DoneArray1 addObjectsFromArray:lowPriorityArr];
     [DoneArray1 addObjectsFromArray:medPriorityArr];
     [DoneArray1 addObjectsFromArray:highPriorityArr];
     
     

     
     //NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
     NSData * data3 = [NSKeyedArchiver archivedDataWithRootObject:DoneArray1];
     [def setObject:data3 forKey:@"taskDone"];
     [def synchronize];
 }



@end
