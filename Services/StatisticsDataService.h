#import <Foundation/Foundation.h>
#import "sqlite3.h"

#import "Usage.h"

@interface StatisticsDataService : NSObject
{
    sqlite3 * _database;
}

// Public Methods
-(bool)openDatabase;
-(bool)createUsageTable;
-(bool)insertUsage:(Usage *)usage;
-(NSArray *)getUsageTable;

// Private Methods
-(NSString *) filePath;

@end
