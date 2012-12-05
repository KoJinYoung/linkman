//
//  BBSViewController.m
//  linkmanProject
//
//  Created by 승원 김 on 12. 12. 4..
//  Copyright (c) 2012년 승원 김. All rights reserved.
//

#import "BBSViewController.h"
#import "BBSListCell.h"
#import "JSONKit.h"

@interface BBSViewController ()

@end

@implementation BBSViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    BBSListArray = [[NSMutableArray alloc] init];
    
    NSString *urlString = [NSString stringWithFormat:@"http://incom.or.kr/ko28/?service=BBSList&version=0"];;
    
    NSDictionary *httpParams = [[NSDictionary alloc] initWithObjectsAndKeys:@"1", @"Token", @"all", @"Sort", @"0", @"Page", nil];
    AFHTTPClient *client = [[AFHTTPClient alloc] initWithBaseURL:[NSURL URLWithString:urlString]];
    NSMutableURLRequest *request = [client requestWithMethod:@"POST" path:nil parameters:httpParams];
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON){
        //HTTP연동이 성공하였을 경우 서버로 부터 리턴된 값이 JSON이란 id형태로 리턴됩니다.
        NSLog(@"%@", JSON);
        
        NSMutableDictionary *BBSData = [JSON objectForKey:@"Data"];
        NSArray *BBSList = [BBSData objectForKey:@"BBSList"];
//        BBSListArray = [BBSData objectForKey:@"BBSList"];
        
        for (NSDictionary *BBS in BBSList) {
//            NSLog(@"%@ %@", [BBS objectForKey:@"UserNick"], [BBS objectForKey:@"BBSTime"]);
            [BBSListArray addObject:BBS];
        }
        
    }failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON){
        
        NSLog(@"실패:%@",error);
        //실패시 처리.
        //        NSDictionary *responseData = [JSON objectForKey:@"_ResInfo"];
        
    }];
    
    [operation start];
    
    [_tableView reloadData];
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];

    [_tableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [_tableView release];
    [super dealloc];
}


#pragma mark -
#pragma mark TableView DataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSLog(@"BBSListDic count : %d", [BBSListArray count]);
    return [BBSListArray count];
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 107;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    BBSListCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"BBSListCell" owner:self options:nil];
        
        for (id oneObject in nib)
			if ([oneObject isKindOfClass:[BBSListCell class]])
                cell = (BBSListCell *)oneObject;
    }
    
    NSInteger row = [indexPath row];
    NSDictionary *rowData = [BBSListArray objectAtIndex:row];
    
    NSString *profileImagePath = [NSString stringWithString:[rowData objectForKey:@"UserPic"]];
    NSData *profileImageData = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:profileImagePath]];
    cell.profileImageView.image = [UIImage imageWithData:profileImageData];
    cell.contentTextView.delegate = self;
    cell.contentTextView.text = [rowData objectForKey:@"BBS"];
    cell.contentTextView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    cell.userNickLabel.text = [rowData objectForKey:@"UserNick"];
    cell.timeLabel.text = [rowData objectForKey:@"BBSTime"];
    cell.commentLabel.text = [rowData objectForKey:@"CmtNum"];

    return cell;
}

#pragma mark -
#pragma mark TableView Delegate

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

@end
