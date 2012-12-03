//
//  CTS_SingletonObject.m
//  CrossTheStreet
//
//  Created by 고진영 on 12. 12. 3..
//  Copyright (c) 2012년 LinkMan. All rights reserved.
//

#import "CTS_SingletonObject.h"

@implementation CTS_SingletonObject

@synthesize Token;

// 싱글톤 객체를 반환
+ (CTS_SingletonObject *)getSingletonObject {
    
    static CTS_SingletonObject *sharedInstance = nil;
    
    if (sharedInstance == nil) {
        
        @synchronized(self) {
            
            if (sharedInstance == nil) {
                
                // 처음 호출 되었을 때
                sharedInstance = [[CTS_SingletonObject alloc] init];
            }
            
        }
        
    }
    
    return sharedInstance;
}

// 문자열(Token)을 파일에 저장.
- (BOOL)saveStringToFile {
    
    //NSArray, NSMutableDictionary, NSMutableArray도 가능
    NSDictionary *stringDic = [[NSDictionary alloc] initWithObjectsAndKeys:Token,   //value
                               @"Token",    //key
                               nil];
    
    // Document 폴더의 경로 찾기
    NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    // Document 폴더 경로
    NSString *documentRootPath = [documentPaths objectAtIndex:0];
    
    // 내가 만들 plist파일 경로
    NSString *stringFilePath = [documentRootPath stringByAppendingFormat:@"/Token.plist"];
    
    // 파일이 쓰여졌는지 확인 할 필요가 있다.
    BOOL isWritten = NO;
    
    // 정상적으로 저장이 되었는지 BOOL 값을 반환받을 수 있다.
    isWritten = [stringDic writeToFile:stringFilePath atomically:YES];
    
    UIAlertView *alert = nil;
    
    // 정상적으로 쓰였다면
    if (isWritten) {
        alert = [[UIAlertView alloc] initWithTitle:@"알림"
                                           message:@"정상적으로 저장되었습니다."
                                          delegate:nil
                                 cancelButtonTitle:@"확인"
                                 otherButtonTitles:nil];
    }
    else {
        alert = [[UIAlertView alloc] initWithTitle:@"알림"
                                           message:@"정상적으로 실패하였습니다."
                                          delegate:nil
                                 cancelButtonTitle:@"확인"
                                 otherButtonTitles:nil];
    }
    
    [alert show];
    
    return isWritten;
}

// 파일에서 문자열을 불러옴(currentString으로 세팅).
- (BOOL)loadStringFromFile {
    
    // Document 폴더의 경로 찾기
    NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    // Document 폴더 경로
    NSString *documentRootPath = [documentPaths objectAtIndex:0];
    
    // 내가 만들 plist파일 경로
    NSString *stringFilePath = [documentRootPath stringByAppendingFormat:@"/Token.plist"];
    
    NSDictionary *stringDic = [[NSDictionary alloc] initWithContentsOfFile:stringFilePath];
    
    NSString *loadedString = nil;
    
    // 정상적으로 파일을 읽었으면 stringDic이 nil이 아니다. 파일 로드에 실패하면 nil값을 반환
    if (stringDic) {
        
        // 파일에서 읽어온 Dictionary에서 Token이라는 키값의 NSString Object를 가져옴.
        loadedString = [stringDic objectForKey:@"Token"];
        
        // Token에 텍스트 세팅
        Token = [NSString stringWithString:loadedString];
    }
    else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"알림"
                                           message:@"파일 로드에 실패하였습니다."
                                          delegate:nil
                                 cancelButtonTitle:@"확인"
                                 otherButtonTitles:nil];
        [alert show];
    }
    
    // Token이 불러온 문자열과 동일하다면 정상적으로 세팅 된 것이다.
    if ([Token isEqualToString:loadedString]) {
        return YES;
    }
    else {
        return NO;
    }
}

@end
