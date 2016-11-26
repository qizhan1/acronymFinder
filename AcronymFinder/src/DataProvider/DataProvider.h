// *************************************************************************************************
// # MARK: Typedef


typedef void (^requestData)(id response);
typedef void (^requestDataError)(id errors);


// *************************************************************************************************
// # MARK: Pbulic Interface


@interface DataProvider : NSObject


// *************************************************************************************************
// # MARK: Factory Methods


+ (id)sharedProvider;


// *************************************************************************************************
// # MARK: Public Methods


- (void)getFullFormsFor:(NSString *)acronym
                success:(requestData)success
                failure:(requestDataError)failure;


@end
