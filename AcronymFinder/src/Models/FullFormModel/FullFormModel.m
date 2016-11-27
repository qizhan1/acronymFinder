// *************************************************************************************************
// # MARK: Imports


#import "FullFormModel.h"


// *************************************************************************************************
// # MARK: Implementation


@implementation FullFormModel


// *************************************************************************************************
// # MARK: Initialization


- (instancetype)initWithDictionary:(NSDictionary *)dict {
    @try {
        self.frequency = dict[@"freq"];
        self.fullForm = dict[@"lf"];
        self.since = dict[@"since"];
        self.details = dict[@"vars"];
    }
    @catch (NSException *exception) {
        NSLog(@"Exception = %@", exception);
    }
    @finally {
        return self;
    }
}


// *************************************************************************************************
// # MARK: Pbulic Methods


- (NSString *)getDetailDescription {
    NSString *detailString
        = [NSString stringWithFormat:@"Frequency: %@ \t Since: %@",
           self.frequency, self.since];
    
    return detailString;
}


@end
