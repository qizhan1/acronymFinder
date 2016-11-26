// *************************************************************************************************
// # MARK: Imports


#import "DataProvider.h"


// *************************************************************************************************
// # MARK: Completion Block Declaration


typedef void (^CompletionBlock)(id results);


// *************************************************************************************************
// # MARK: Pbulic Properties


@interface DataProvider (PostProcessor)


- (void)processFullFormWithServerResponse:(NSArray *)response
                          completionBlock:(CompletionBlock)completion;


@end
