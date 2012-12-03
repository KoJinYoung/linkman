//
//  CTS_SingletoneObject.h
//  CrossTheStreet
//
//  Created by 고진영 on 12. 12. 3..
//  Copyright (c) 2012년 LinkMan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CTS_SingletonObject : NSObject {
    
    NSString *Token;
}

// 싱글톤 객체를 반환
+ (CTS_SingletonObject *)getSingletonObject;

// 문자열(Token)을 파일에 저장.
- (BOOL)saveStringToFile;

// 파일에서 문자열을 불러옴(currentString으로 세팅).
- (BOOL)loadStringFromFile;

// 현재 싱글톤 객체가 가지고 있는 문자열을 property로 설정.
@property (nonatomic, strong) NSString *Token;

@end
