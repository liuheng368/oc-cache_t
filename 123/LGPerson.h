//
//  LGPerson.h
//  003-cache_t脱离源码环境分析
//
//  Created by cooci on 2020/9/16.
//  Copyright © 2020 cooci. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LGPerson : NSObject

@property (nonatomic, copy) NSString *lgName;
@property (nonatomic, strong) NSString *nickName;

- (void)say1;
- (void)say2;
- (void)say3;
- (void)say4;
- (void)say5;
- (void)say6;
- (void)say7;

+ (void)sayHappy;

@end

NS_ASSUME_NONNULL_END
