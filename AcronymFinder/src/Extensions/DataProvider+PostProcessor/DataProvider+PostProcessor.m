// *************************************************************************************************
// # MARK: Imports


#import "DataProvider+PostProcessor.h"

#import "FullFormModel.h"


// *************************************************************************************************
// # MARK: Implementation


@implementation DataProvider (PostProcessor)


- (void)processFullFormWithServerResponse:(NSArray *)response
                          completionBlock:(CompletionBlock)completion {
    NSMutableArray *results = [NSMutableArray new];
    
    if (response.count > 0) {
        NSArray *dataArray = [response[0] objectForKey:@"lfs"];
        for (NSDictionary *eachData in dataArray) {
            FullFormModel *fullForm = [[FullFormModel alloc] initWithDictionary:eachData];
            NSMutableArray *fullDetails = [NSMutableArray new];
            for (NSDictionary *eachDetail in fullForm.details) {
                FullFormModel *fullFormDetail = [[FullFormModel alloc] initWithDictionary:eachDetail];
                [fullDetails addObject:fullFormDetail];
            }
            fullForm.details = fullDetails;
            [results addObject:fullForm];
        }
    }
    
    completion(results);
}


@end
