#import "StatisticsDialogController.h"

@implementation StatisticsDialogController

#pragma mark -
#pragma mark Initialization

-(id)initWithNibName:(NSString *)nibNameOrNil logic:(Logic *)logic andDelegate:(id<StatisticsDialogControllerDelegate>)delegate
{
    self = [super initWithNibName:nibNameOrNil bundle:nil];
    
    if(self == nil) return nil;
    
    _logic = logic;
    
    _usages = [_logic getUsageList];
    _delegate = delegate;
    
    return self;
}



- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.modalInPopover = YES;
}






#pragma mark -
#pragma mark Events
-(IBAction)close:(id)sender
{
    [_delegate closeStatistics];
}






#pragma mark -
#pragma mark Public Methods

-(void)reload
{
    _usages = [_logic getUsageList];
    [_tableView reloadData];
}






#pragma mark UIPopoverControllerDelegate

-(BOOL)popoverControllerShouldDismissPopover:(UIPopoverController *)popoverController
{
    return NO;
}






#pragma mark -
#pragma mark UITableViewDataSource

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cellIdentifier = @"cell";
    
    // reusable cell
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(cell == nil)
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier] autorelease];
    
    NSString * cellValue;
    
    _currentUsage = [_usages objectAtIndex:indexPath.section];
    
    if(indexPath.row == 0) cellValue = [NSString stringWithFormat:@"Juegos Ganados: %d", _currentUsage.wins];
    else if (indexPath.row == 1) cellValue = [NSString stringWithFormat:@"Juegos Perdidos: %d", _currentUsage.loses];
    
    cell.textLabel.text = cellValue;
    
    return cell;
}



-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [_usages count];
}



-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2; // one row for wins, other for loses
}



-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    _currentUsage = [_usages objectAtIndex:section];
    
    NSDateFormatter * dateFormat = [[NSDateFormatter alloc ] init];
    [dateFormat setDateFormat:@"EEEE dd MMMM YYYY"];
    NSDate * date = _currentUsage.date;
    NSString * title = [dateFormat stringFromDate:date]; // get current time
    
    return title;
}





#pragma mark -
#pragma mark Memory

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return YES;
}

@end
