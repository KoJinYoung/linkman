//
//  BBSViewController.m
//  linkmanProject
//
//  Created by 승원 김 on 12. 12. 4..
//  Copyright (c) 2012년 승원 김. All rights reserved.
//

#import "BBSViewController.h"
#import "BBSWriteViewController.h"
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
        self.navigationItem.rightBarButtonItem = self.editButtonItem;
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
    [_writeBBSBarButtonItem release];
    [_categoryBBSSegment release];
    [_toolbar release];
    [super dealloc];
}

- (IBAction)writeBBS:(id)sender {
    BBSWriteViewController *bBSWriteViewController = [[BBSWriteViewController alloc] initWithNibName:@"BBSWriteViewController" bundle:nil];
    [self.navigationController pushViewController:bBSWriteViewController animated:YES];
    [bBSWriteViewController release];
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
    // 커스텀셀을 xib파일로 구성한 경우 호출하는 방식
    
    NSInteger row = [indexPath row];
    NSDictionary *rowData = [BBSListArray objectAtIndex:row];
    // 해당 indexPath의 row에 해당하는 데이터를 배열에서 가져와 딕셔너리에 추가
    
    NSString *profileImagePath = [NSString stringWithString:[rowData objectForKey:@"UserPic"]];
    NSData *profileImageData = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:profileImagePath]];
    cell.profileImageView.image = [UIImage imageWithData:profileImageData];
    // 웹의 이미지 url을 가져와 셀의 프로필이미지뷰의 이미지로 추가
    
    cell.contentTextView.delegate = self;
    cell.contentTextView.text = [rowData objectForKey:@"BBS"];
    cell.contentTextView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    // 텍스트뷰의 내용을 BBS로 삽입
    
    cell.userNickLabel.text = [rowData objectForKey:@"UserNick"];   // 유저 닉네임
    cell.timeLabel.text = [rowData objectForKey:@"BBSTime"];        // 작성 시간
    cell.commentLabel.text = [rowData objectForKey:@"CmtNum"];      // 댓글 수

    return cell;
}

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the managed object for the given index path
        // Ensure that if the user is editing a name field then the change is committed before deleting a row -- this ensures that changes are made to the correct event object.
		[tableView endEditing:YES];
		
        // Delete the managed object at the given index path.
		
		// Update the array and table view.
        NSInteger row = [indexPath row];
        NSDictionary *rowData = [BBSListArray objectAtIndex:row];

        NSString *urlString = @"http://incom.or.kr/ko28/?service=BBSDelete&version=0";
        NSDictionary *httpParams = [[NSDictionary alloc] initWithObjectsAndKeys:@"1", @"Token", [rowData objectForKey:@"BBSIdx"], @"BBSIdx", nil];
        
        AFHTTPClient *client = [[AFHTTPClient alloc] initWithBaseURL:[NSURL URLWithString:urlString]];
        NSMutableURLRequest *request = [client requestWithMethod:@"POST" path:nil parameters:httpParams];
        
        AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON){
            //HTTP연동이 성공하였을 경우 서버로 부터 리턴된 값이 JSON이란 id형태로 리턴됩니다.
            NSLog(@"%@", JSON);
            
        }failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON){
            
            NSLog(@"실패:%@",error);
            //실패시 처리.
            
        }];
        [operation start];
        
        [BBSListArray removeObjectAtIndex:indexPath.row]; // 먼저 셀에서 빼줌.
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
        
	}
}

- (void)setEditing:(BOOL)editing animated:(BOOL)animated {
    [super setEditing:editing animated:animated];
    
    if(editing)
    {
        [_tableView setEditing:YES animated:YES];
        NSLog(@"editMode on");
    }
    else
    {
        [_tableView setEditing:NO animated:YES];
        NSLog(@"Done leave editmode");
    }}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

#pragma mark -
#pragma mark TableView Delegate

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger row = [indexPath row];
    NSDictionary *rowData = [BBSListArray objectAtIndex:row];
    // 선택 된 셀의 데이터를 로드하여 딕셔너리에 추가
    
    NSLog(@"%d", row);
    NSLog(@"%@", [rowData objectForKey:@"BBSIdx"]);
    NSMutableDictionary *BBSParams = [[NSMutableDictionary alloc] initWithObjectsAndKeys:@"1", @"Token", [rowData objectForKey:@"BBSIdx"], @"BBSIdx", nil];
    // POST 방식으로 넘겨줄 파라미터 Token,BBSIdx
    
    NSString *urlString = [NSString stringWithFormat:@"http://incom.or.kr/ko28/?service=BBS&version=0"];
    AFHTTPClient *client = [[AFHTTPClient alloc] initWithBaseURL:[NSURL URLWithString:urlString]];
    NSMutableURLRequest *request = [client requestWithMethod:@"POST" path:nil parameters:BBSParams];
    // POST 방식으로 요청
    
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON){
        //HTTP연동이 성공하였을 경우 서버로 부터 리턴된 값이 JSON이란 id형태로 리턴됩니다.
        NSLog(@"%@", JSON);
        
        NSMutableDictionary *CmtData = [JSON objectForKey:@"Data"];
        NSArray *CmtList = [CmtData objectForKey:@"CmtList"];
        //        BBSListArray = [BBSData objectForKey:@"BBSList"];
        
        NSMutableArray *CmtListArray = [[NSMutableArray alloc] init];
        for (NSDictionary *Cmt in CmtList) {
            NSLog(@"%@ %@", [Cmt objectForKey:@"Cmt"], [Cmt objectForKey:@"CmtTime"]);
            [CmtListArray addObject:Cmt];
        }
        
    }failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON){
        
        NSLog(@"실패:%@",error);
        //실패시 처리.
        //        NSDictionary *responseData = [JSON objectForKey:@"_ResInfo"];
        
    }];
    
    [operation start];

    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

@end
