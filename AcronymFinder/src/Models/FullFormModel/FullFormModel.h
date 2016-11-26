// *************************************************************************************************
// # MARK: Pbulic Interface


@interface FullFormModel : NSObject


// *************************************************************************************************
// # MARK: Pbulic Properties


@property (nonatomic, strong) NSString *frequency;
@property (nonatomic, strong) NSString *fullForm;
@property (nonatomic, strong) NSString *since;
@property (nonatomic, strong) NSArray *details;


// *************************************************************************************************
// # MARK: Pbulic Interfaces


- (NSString *)getDetailDescription;
- (instancetype)initWithDictionary:(NSDictionary *)dict;


@end
