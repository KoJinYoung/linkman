//
//  CTS_TeamViewController.m
//  CrossTheStreet
//
//  Created by 고진영 on 12. 9. 23..
//  Copyright (c) 2012년 LinkMan. All rights reserved.
//

#import "CTS_TeamList.h"
#import "CTS_CommonValues.h"
#import "Reachability.h"

@interface CTS_TeamList ()

@end

@implementation CTS_TeamList
@synthesize tbl_TeamList;
@synthesize data_Team;
@synthesize SearchBar;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    // 네트워크가 활성화 되어있지 않다면 경고창을 띄움
    if ( ![self isNetworkEnable]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert"
                                                        message:@"네트워크에 접속되어있지 않습니다."
                                                       delegate:self
                                              cancelButtonTitle:@"확인"
                                              otherButtonTitles: nil];
        [alert show];
        return;
    }
    
    thread_TeamList = nil;
    [self resetDicAndArrPointers];
    
    // request 정보를 담은 딕셔너리 생성
    NSDictionary *requestDic = [[NSDictionary alloc] initWithObjectsAndKeys:
                                @"all", @"Sort",
                                @"0", @"Word",
                                @"0", @"Page",
                                @"0", @"TeamMemberNum",
                                @"0", @"TeamAgeMin",
                                @"0", @"TeamAgeMax",
                                @"0", @"TeamSex",
                                nil];
    [self readyForRequestWithDictionary:requestDic];    //검색어를 입력했을 때 실행
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Alert View Delegate
// 경고창의 버튼을 눌렀을 경우
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    // 현재 모달 뷰 종료
    if (buttonIndex == alertView.cancelButtonIndex) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

#pragma mark - Check Network Status
- (BOOL)isNetworkEnable {
    // Reachability 객체 생성
    Reachability *isConnect = [Reachability reachabilityForInternetConnection];
    
    switch ([isConnect currentReachabilityStatus]) {
        case ReachableViaWWAN:  // 3G로 접속 될 경우
        case ReachableViaWiFi:  // Wifi 접속 될 경우
            break;
        case NotReachable:  // 접속 불가시 NO 리턴
            return NO;
            break;
        default:
            break;
    }
    return YES; // NotReachable 판정이외에는 YES를 리턴
}

#pragma mark - request API
- (void)getData_From_Server:(NSDictionary *)requestDic
{
    // 상태바의 네트워크 인디케이터 켜줌
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    
    NSString *Sort = [requestDic objectForKey:@"Sort"];    // all, search, searchdetail
    NSString *Word = [requestDic objectForKey:@"Word"];
    NSString *Page = [requestDic objectForKey:@"Page"];
    NSString *TeamMemberNum = [requestDic objectForKey:@"TeamMemberNum"];
    NSString *TeamAgeMin = [requestDic objectForKey:@"TeamAgeMin"];
    NSString *TeamAgeMax = [requestDic objectForKey:@"TeamAgeMax"];
    NSString *TeamSex = [requestDic objectForKey:@"TeamSex"];
    
    NSString *paramDataString = [NSString stringWithFormat:@"Sort=%@&Word=%@&Page=%@&TeamMemberNum=%@&TeamAgeMin=%@&TeamAgeMax=%@&TeamSex=%@",
                                 Sort,
                                 Word,
                                 Page,
                                 TeamMemberNum,
                                 TeamAgeMin,
                                 TeamAgeMax,
                                 TeamSex];
    
    // 전달 인자로 보낼 데이터 생성
    NSData* paramData = [paramDataString dataUsingEncoding:NSUTF8StringEncoding];
    
    // URL 생성
    NSString *url_str = [NSString stringWithFormat:@"%@%@",URL_SERVER_HOST,@"?service=TeamList&version=0"];
    NSURL *url = [NSURL URLWithString:url_str];
    
    // request 생성 및 옵션 설정. 전달인자 붙이기
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    [request setCachePolicy:NSURLRequestUseProtocolCachePolicy];
    [request setHTTPBody:paramData];
    [request setHTTPMethod:@"POST"];
    
    //결과 값 받기
    NSData *response = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSError *error;
    
    NSLog(@"response:%@", [[NSString alloc] initWithData:response encoding:NSUTF8StringEncoding]);
    
    //결과로 받은 JSON 결과값을 JSONSerialization 을 이용하여 딕셔너리에 저장
    NSDictionary *resultDic = [NSJSONSerialization JSONObjectWithData:response options:NSJSONReadingMutableContainers error:&error];
    
    //결과 확인
    NSLog(@"result:%@", resultDic);
    NSLog(@"error:%@", error);
    
    // 상태바의 네트워크 인디케이터 꺼줌
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    
    // 현재 메소드를 관장하는 스레드가 취소되었다면 더이상 진행하지 않는다. (테이블에 자료를 뿌려주지 않는다.)
    if ([[NSThread currentThread] isCancelled]) {
        return;
    }
    
    //잘못된 사용을 방지하기 위하여 nil 처리
    thread_TeamList = nil;
    TeamDic = resultDic;
    
    if(TeamListArr == nil) {
        TeamListArr = [[NSMutableArray alloc] init];
    }
    
    NSLog(@"header:%@",[[TeamDic objectForKey:@"Header"] objectForKey:@"code"]);
    
    [TeamListArr addObjectsFromArray:[[TeamDic objectForKey:@"Data"] objectForKey:@"TeamList"]];
    
    // 결과 테이블 뷰
    //UITableView *resultTable = [searchDisplayController searchResultsTableView];
    
    // 텍스트 데이터를 가져온 후 테이블뷰 새로고침
    // 화면의 변화는 무조건 메인 스레드 위에서 이루어 져야 한다.
    [tbl_TeamList performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:NO];
    
    NSString *imageUrlString = nil;
    NSURL *imageUrl = nil;
    NSData *imageData = nil;
    UIImage *image = nil;
    
    // 이미지를 웹에서 가져오기
    for (int i=0; i<[TeamListArr count]; i++) {
        // 만약 스레드가 중지되었다면 실행 중지
        if ([[NSThread currentThread] isCancelled]) {
            return;
        }
        // 이미지 URL을 이용하여 데이터를 로드해와 이미지를 만든다.
        for (int j=0; j<[[[TeamListArr objectAtIndex:i] objectForKey:@"UserPicList"] count]; j++) {
            imageUrlString = [[[TeamListArr objectAtIndex:i] objectForKey:@"UserPicList"] objectAtIndex:j];
            imageUrl = [NSURL URLWithString:imageUrlString];
            
            [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
            
            imageData = [NSData dataWithContentsOfURL:imageUrl];
            
            [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
            
            image = [UIImage imageWithData:imageData];
            
            // 딕셔너리에 nil 데이터를 넣을 수 없으므로, 데이터가 정상적으로 받아져왔는지 확인하고 딕셔너리에 넣는다.
            if (image != nil) {
                // 아이템 딕셔너리에 객체를 넣어준다.
                [[[TeamListArr objectAtIndex:i] objectForKey:@"UserPicList"] setObject:image atIndex:j];
                
                // 이미지 데이터를 가져온 후 테이블뷰 새로고침
                // 화면의 변화는 무조건 메인 스레드 위에서 이루어 져야 한다.
                [tbl_TeamList performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:NO];
            }
        }
    }
}


#pragma mark - readyForRequest
- (void)readyForRequestWithDictionary:(NSDictionary *) requestDic
{
    thread_TeamList = [[NSThread alloc] initWithTarget:self selector:@selector(getData_From_Server:) object:requestDic];
    [thread_TeamList start];
}


#pragma mark - Reset Method
- (void)resetDicAndArrPointers{
    TeamDic = nil;
    TeamListArr = nil;
}


#pragma mark - 검색

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    
    if(textField == SearchBar){
        
        //새로운 내용을 불러와야 하므로 포인터 초기화
        [self resetDicAndArrPointers];
        
        //키보드 내리기
        [textField resignFirstResponder];
        
        [thread_TeamList cancel];
        thread_TeamList = nil;
        // request 정보를 담은 딕셔너리 생성
        NSDictionary *requestDic = [[NSDictionary alloc] initWithObjectsAndKeys:
                                    @"search", @"Sort",
                                    [textField text], @"Word",
                                    @" ", @"Page",
                                    @" ", @"TeamMemberNum",
                                    @" ", @"TeamAgeMin",
                                    @" ", @"TeamAgeMax",
                                    @" ", @"TeamSex",
                                    nil];
        [self readyForRequestWithDictionary:requestDic];    //검색어를 입력했을 때 실행
        return YES;
    }
    return NO;
}


#pragma mark - 새로고침

- (void)refreshTeamList{
    //새로운 내용을 불러와야 하므로 포인터 초기화
    [self resetDicAndArrPointers];
    
    [thread_TeamList cancel];
    thread_TeamList = nil;
    // request 정보를 담은 딕셔너리 생성
    NSDictionary *requestDic = [[NSDictionary alloc] initWithObjectsAndKeys:
                                @"all", @"Sort",
                                @" ", @"Word",
                                @" ", @"Page",
                                @" ", @"TeamMemberNum",
                                @" ", @"TeamAgeMin",
                                @" ", @"TeamAgeMax",
                                @" ", @"TeamSex",
                                nil];
    [self readyForRequestWithDictionary:requestDic];    //검색어를 입력했을 때 실행

}


#pragma mark - 상세 검색


#pragma mark - table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [TeamListArr count];
    //return 1;
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CTS_CellTeamList *cell = [tableView dequeueReusableCellWithIdentifier:@"cell_Team"];
    if (cell == nil) {
        cell = [[CTS_CellTeamList alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell_Team"] ;
    }
    
    // Data 배열과 각각의 Data를 가리킬 포인터 변수
    static NSArray *itemArr = nil;
    static NSDictionary *item = nil;
    
    itemArr = TeamListArr;
    
    // 각각의 아이템은 배열의 하나의 인덱스 요소
    item = [itemArr objectAtIndex:indexPath.row];

    // 값 입력
    cell.team_idx = [item objectForKey:@"TeamIdx"];
    [[cell cell_title_lable] setText:[item objectForKey:@"TeamTitle"]];
    [[cell cell_age_lable] setText:[NSString stringWithFormat:@"%@-%@",[item objectForKey:@"TeamAgeMin"],[item objectForKey:@"TeamAgeMax"]]];
    [[cell cell_num_lable] setText:[item objectForKey:@"TeamMemberNum"]];
    
    for (int i=0; i<[[item objectForKey:@"UserPicList"] count] && i < 5; i++) {
        switch (i) {
            case 0:
                [[cell cell_userpic1_image] setImage:[[item objectForKey:@"UserPicList"] objectAtIndex:0]];
                break;
            case 1:
                [[cell cell_userpic2_image] setImage:[[item objectForKey:@"UserPicList"] objectAtIndex:1]];
                break;
            case 2:
                [[cell cell_userpic3_image] setImage:[[item objectForKey:@"UserPicList"] objectAtIndex:2]];
                break;
            case 3:
                [[cell cell_userpic4_image] setImage:[[item objectForKey:@"UserPicList"] objectAtIndex:3]];
                break;
            case 4:
                [[cell cell_userpic5_image] setImage:[[item objectForKey:@"UserPicList"] objectAtIndex:4]];
                break;
            default:
                break;
        }
    }
    
    itemArr = nil;
    
    return cell;
}

#pragma mark - end

@end
