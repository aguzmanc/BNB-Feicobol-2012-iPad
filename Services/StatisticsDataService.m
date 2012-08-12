#import "StatisticsDataService.h"

@implementation StatisticsDataService

#pragma mark -
#pragma mark Public Methods


-(bool)openDatabase
{
    // Create Database
    if(sqlite3_open([[self filePath] UTF8String], &_database) != SQLITE_OK)
    {
        NSAssert(0, @"Database failed to open.");
        return false;
    }
    
    return true;
}



-(bool)createUsageTable
{
    char * err;
    NSString * cmd = @"CREATE TABLE IF NOT EXISTS 'Usage' ('date' TEXT PRIMARY KEY, 'win_count' INT, 'loses_count' INT)";
    
    if (sqlite3_exec(_database, [cmd UTF8String], NULL, NULL, &err) != SQLITE_OK) 
    {
        NSAssert(0, @"Failed to create table Usage");
        
        return false;
    }
    
    return true;
}



-(bool)insertUsage:(Usage *)usage
{
    NSString * cmd = @"INSERT OR REPLACE INTO 'Usage' ('date', 'win_count', 'loses_count') VALUES (?,?,?)";
    
    NSDateFormatter * dateFormat = [[NSDateFormatter alloc ] init];
    [dateFormat setDateFormat:@"YYYYMMdd"];
    NSString * dateStr = [dateFormat stringFromDate:usage.date]; // get current time
    
    sqlite3_stmt * statement;
    
    if(sqlite3_prepare_v2(_database, [cmd UTF8String], -1, &statement, nil) == SQLITE_OK)
    {
        sqlite3_bind_text(statement, 1, [dateStr UTF8String], -1, NULL);
        sqlite3_bind_text(statement, 2, [[NSString stringWithFormat:@"%d",usage.wins] UTF8String], -1, NULL);
        sqlite3_bind_text(statement, 3, [[NSString stringWithFormat:@"%d",usage.loses] UTF8String], -1, NULL);
    }
    
     
    if(sqlite3_step(statement) != SQLITE_DONE)
    {
        NSAssert(0, @"Error updating table Usage.");
        return false;
    }
    
    
    return true;
}



-(NSArray *)getUsageTable
{
    NSMutableArray * usages = [[NSMutableArray alloc] init];
    
    NSString * query = @"SELECT date, win_count, loses_count FROM Usage ORDER BY date";
    
    sqlite3_stmt * statement;
    if(sqlite3_prepare_v2(_database, [query UTF8String], -1, &statement, nil) == SQLITE_OK)
    {
        while (sqlite3_step(statement) == SQLITE_ROW) 
        {
            // Obtain date
            NSString * dateStr = [[NSString alloc] initWithUTF8String:((char*)sqlite3_column_text(statement, 0))];
            
            int year = [[dateStr substringToIndex:4] intValue];
            int month = [[[dateStr substringFromIndex:4] substringToIndex:2] intValue];
            int day = [[[dateStr substringFromIndex:6]substringToIndex:2] intValue];
            
            NSDateComponents * comps = [[[NSDateComponents alloc] init] autorelease];
            [comps setDay:day];
            [comps setMonth:month];
            [comps setYear:year];
            
            // obtain win number
            int wins = sqlite3_column_int(statement, 1);
            int loses = sqlite3_column_int(statement, 2);
            
            NSLog(@"date: %@, wins: %d, loses: %d", dateStr, wins, loses);
            
            Usage * usage = [[Usage alloc] initWithDate:[[NSCalendar currentCalendar]dateFromComponents:comps]
                                                   wins:wins
                                               andLoses:loses];
            
            [usages addObject:usage];
        }
        
        sqlite3_finalize(statement);
    
    }
    
    return [[NSArray alloc] initWithArray:usages];
    
}









#pragma mark -
#pragma mark Private Methods

-(NSString *) filePath
{
    NSArray * paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString * documentsDir = [paths objectAtIndex:0];
    return [documentsDir stringByAppendingFormat:@"/Statistics.sql"];
}

@end
