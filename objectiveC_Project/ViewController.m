//
//  ViewController.m
//  objectiveC_Project
//
//  Created by Abdelrahman on 19/01/2023.
//

#import "ViewController.h"
#import "Add.h"
#import "FirstEdit.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableview;

@end

@implementation ViewController 
static NSMutableArray *remindersTodoArray;
+(void)initialize{
    remindersTodoArray = [NSMutableArray new];
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    if ([def objectForKey:@"todoArrNew"] == nil ){
        NSData * dataEmpty = [NSKeyedArchiver archivedDataWithRootObject:remindersTodoArray];
        [def setObject:dataEmpty forKey:@"todoArrNew"];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
   /* NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    NSData * dataEmpty = [NSKeyedArchiver archivedDataWithRootObject:remindersTodoArray];
    [def setObject:dataEmpty forKey:@"todoArrNew"];*/
}

- (void)viewWillAppear:(BOOL)animated{
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    NSData * d = [def objectForKey:@"todoArrNew"];
    remindersTodoArray = [NSKeyedUnarchiver unarchiveObjectWithData:d];
    [self.tableview reloadData];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return [remindersTodoArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    cell.textLabel.text = [[remindersTodoArray objectAtIndex:indexPath.row]remName];
    
    cell.imageView.image = [UIImage imageNamed:[[remindersTodoArray objectAtIndex:indexPath.row]remImg]];
    
    cell.detailTextLabel.text = [[remindersTodoArray objectAtIndex:indexPath.row]remDate];
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    FirstEdit * edit1 = [self.storyboard instantiateViewControllerWithIdentifier:@"FirstEdit"];
    
    index = indexPath.row;
    
    
    
    edit1.nameEditprp = [[remindersTodoArray objectAtIndex:indexPath.row]remName];
    edit1.descriptionEditprp = [[remindersTodoArray objectAtIndex:indexPath.row]remDescription];
    
    edit1.priority2 = [[remindersTodoArray objectAtIndex:indexPath.row]remPriority];
    
    edit1.date2 = [[remindersTodoArray objectAtIndex:indexPath.row]remDate];
    
    edit1.img2 = [[remindersTodoArray objectAtIndex:indexPath.row]remImg];
    
    edit1.delegate =self;
    [self.navigationController pushViewController:edit1 animated:YES];
    
    
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"Delete Reminder!" message:@"Do you want to DELETE this reminder?" preferredStyle:UIAlertControllerStyleActionSheet];
        //make buttons
        UIAlertAction * yesbutton = [UIAlertAction actionWithTitle:@"Yes" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
            NSData * d = [def objectForKey:@"todoArrNew"];
            remindersTodoArray = [NSKeyedUnarchiver unarchiveObjectWithData:d];
            [remindersTodoArray removeObjectAtIndex:indexPath.row];
            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            NSData * data3 = [NSKeyedArchiver archivedDataWithRootObject:remindersTodoArray];
            [def setObject:data3 forKey:@"todoArrNew"];
            [def synchronize];
        }];
        
        UIAlertAction * cancelbutton = [UIAlertAction actionWithTitle:@"NO" style:UIAlertActionStyleDestructive handler:nil];

    //add button

    [alert addAction:yesbutton];
    [alert addAction:cancelbutton];
    //[alert addAction:nobutton];





    //show alert
    [self presentViewController:alert animated:YES completion:nil];
        
        
        
        
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }
}

- (IBAction)ADD:(id)sender {
    Add * addrem = [self.storyboard instantiateViewControllerWithIdentifier:@"Add"];
    //addrem.delegate=self;
    
    [self.navigationController pushViewController:addrem animated:YES];
    
}

- (void)addItemViewController1:(FirstEdit *)controller didFinishEnteringItem1:(remData *)item
 {
     NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
     NSData * d = [def objectForKey:@"todoArrNew"];
     remindersTodoArray = [NSKeyedUnarchiver unarchiveObjectWithData:d];
     if([item.remState isEqualToString:@"ToDo"]){
        [remindersTodoArray removeObjectAtIndex:index];
         //[remindersTodoArray insertObject:item atIndex:index];
         //[remindersTodoArray addObject:item];
         
     
         [_tableview reloadData];
     }
     
    else{
        
         [remindersTodoArray removeObjectAtIndex:index];
         //[remindersTodoArray removeLastObject];
         
       
         [_tableview reloadData];
     }
     //NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
     NSData * data3 = [NSKeyedArchiver archivedDataWithRootObject:remindersTodoArray];
     [def setObject:data3 forKey:@"todoArrNew"];
     [def synchronize];
 }






@end
