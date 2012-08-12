#import <UIKit/UIKit.h>

#import "Logic.h"
#import "Usage.h"

@protocol StatisticsDialogControllerDelegate;

@interface StatisticsDialogController : UIViewController <UITableViewDataSource, UIPopoverControllerDelegate>
{
    IBOutlet UITableView * _tableView;
    
    id<StatisticsDialogControllerDelegate> _delegate;
    
    Logic * _logic;
    NSArray * _usages;

    Usage * _currentUsage;
}

// Initialization
-(id)initWithNibName:(NSString *)nibNameOrNil logic:(Logic *)logic andDelegate:(id<StatisticsDialogControllerDelegate>)delegate;
// Events
-(IBAction)close:(id)sender;
// Public Methods
-(void)reload;

@end



@protocol StatisticsDialogControllerDelegate

-(void)closeStatistics;

@end
