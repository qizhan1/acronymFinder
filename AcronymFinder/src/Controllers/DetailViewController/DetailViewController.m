// *************************************************************************************************
// # MARK: Imports


#import "DetailViewController.h"

#import "FullFormModel.h"


// *************************************************************************************************
// # MARK: Pbulic Interface


@interface DetailViewController ()
@end


// *************************************************************************************************
// # MARK: Implementation


@implementation DetailViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


// *************************************************************************************************
// # MARK: Table View Datasource Methods


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.details.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"details_table_view_cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle
                                      reuseIdentifier:cellIdentifier];
    }
    FullFormModel *fullForm = self.details[indexPath.row];
    cell.textLabel.text = fullForm.fullForm;
    cell.detailTextLabel.text = [fullForm getDetailDescription];
    
    return cell;
}


@end
