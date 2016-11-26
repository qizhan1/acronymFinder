// *************************************************************************************************
// # MARK: Imports


#import "ViewController.h"

#import "DataProvider.h"
#import "DataProvider+PostProcessor.h"
#import "DetailViewController.h"
#import "FullFormModel.h"
#import "MBProgressHUD+Extension.h"
#import "UIAlertController+Extension.h"


// *************************************************************************************************
// # MARK: Constants


#define cellIdentifier @"results_table_cell_identifier"
#define detailViewControllerNibName @"DetailViewController"


// *************************************************************************************************
// # MARK: Private Interface


@interface ViewController () <UISearchBarDelegate, UITableViewDataSource, UITableViewDelegate>


// *************************************************************************************************
// # MARK: IBOutlets


@property (weak, nonatomic) IBOutlet UILabel *_noReultsFoundLabel;
@property (weak, nonatomic) IBOutlet UITableView *_resultsTableView;
@property (weak, nonatomic) IBOutlet UISearchBar *_searchBar;


// *************************************************************************************************
// # MARK: Private Properties


@property (strong, nonatomic) NSMutableArray *_results;


@end


// *************************************************************************************************
// # MARK: Implementation


@implementation ViewController


// *************************************************************************************************
// # MARK: View Controller Overrides


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self._resultsTableView.dataSource = self;
    self._resultsTableView.delegate = self;
    self._searchBar.delegate = self;
    [self _resetTableView];
    [self _addGestureRecognizer];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


// *************************************************************************************************
// # MARK: Private Methods


- (void)_addGestureRecognizer {
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(_dismissKeyboard)];
    [self.view addGestureRecognizer:tap];
    [tap setCancelsTouchesInView:NO];
}


- (void)_dismissKeyboard {
    [self._searchBar resignFirstResponder];
}


- (void)_loadTableView:(id)response {
    [self._results removeAllObjects];
    [[DataProvider sharedProvider]
        processFullFormWithServerResponse:response
        completionBlock:^(id results) {
            self._results = results;
            self._noReultsFoundLabel.hidden = self._results.count > 0;
            [self._resultsTableView reloadData];
            [self._searchBar setUserInteractionEnabled:YES];
            [MBProgressHUD hideWaitIndicator:self.view];
        }];
}


- (void)_resetTableView {
    [self._results removeAllObjects];
    [self._resultsTableView reloadData];
    self._noReultsFoundLabel.hidden = YES;
}


- (void)_searchForFullForm {
    [MBProgressHUD showWaitIndicator:self.view];
    [[DataProvider sharedProvider]
        getFullFormsFor:self._searchBar.text
        success:^(id response) {
            [self _loadTableView:response];
        } failure:^(id errors) {
            NSLog(@"errors: %@", errors);
            [MBProgressHUD hideWaitIndicator:self.view];
            [self._searchBar setUserInteractionEnabled:YES];
            [self _resetTableView];
            [UIAlertController showAlertFor:self];
    }];
}


// *************************************************************************************************
// # MARK: Search Bar Delegate Methods


- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    if (searchBar == self._searchBar) {
        [searchBar resignFirstResponder];
        [self._searchBar setUserInteractionEnabled:NO];
        [self _searchForFullForm];
    }
}


- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    if([searchText isEqualToString:@""] || searchText==nil) {
        [self _resetTableView];
    }
}


// *************************************************************************************************
// # MARK: Table View Datasource Methods


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self._results.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *resultsTableCellIdentifier = cellIdentifier;
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:resultsTableCellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle
                                      reuseIdentifier:resultsTableCellIdentifier];
    }
    FullFormModel *fullForm = self._results[indexPath.row];
    cell.textLabel.text = fullForm.fullForm;
    cell.detailTextLabel.text = [fullForm getDetailDescription];
    
    return cell;
}


// *************************************************************************************************
// # MARK: Table View Delegate Methods


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    DetailViewController *viewController
        = [[DetailViewController alloc] initWithNibName:detailViewControllerNibName
                                                 bundle:nil];
    viewController.details = ((FullFormModel *)self._results[indexPath.row]).details;;
    [self.navigationController pushViewController:viewController animated:YES];
}


@end
