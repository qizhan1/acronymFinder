// *************************************************************************************************
// # MARK: Imports


#import "DataProvider.h"

#import "FullFormModel.h"


// *************************************************************************************************
// # MARK: Constants


#define urlString @"http://www.nactem.ac.uk/software/acromine/dictionary.py"


// *************************************************************************************************
// # MARK: Private Interfaces


@interface DataProvider ()


// *************************************************************************************************
// # MARK: Private Properties


//@property (strong, nonatomic) NSMutableArray *_results;


@end


// *************************************************************************************************
// # MARK: Implementation


@implementation DataProvider


// *************************************************************************************************
// # MARK: Factory Methods


+ (id)sharedProvider {
    static DataProvider *sharedProvider = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedProvider = [[self alloc] init];
    });
    
    return sharedProvider;
}


// *************************************************************************************************
// # MARK: Public Methods


- (void)getFullFormsFor:(NSString *)acronym
                success:(requestData)success
                failure:(requestDataError)failure {
    NSDictionary *params = @{@"sf":acronym};
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer new];
    [manager GET:urlString
      parameters:params
        progress:nil
         success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
             id data = [NSJSONSerialization JSONObjectWithData:responseObject
                                                       options:kNilOptions
                                                         error:nil];
             success(data);
         } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
             NSData *errorData = error.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey];
             id errorJson = nil;
             if (errorData) {
                 errorJson = [NSJSONSerialization JSONObjectWithData:errorData
                                                             options:kNilOptions
                                                               error:nil];
             }
             failure(errorJson);
         }];
}


@end
