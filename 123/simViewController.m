//
//  simViewController.m
//  123
//
//  Created by Henry on 2020/11/12.
//  模拟器

#import "simViewController.h"
#import "LGPerson.h"
typedef uint32_t mask_t;  // x86_64 & arm64 asm are less efficient with 16-bits

struct lg_bucket_t {
    SEL _sel;
    IMP _imp;
};

struct lg_cache_t {
    struct lg_bucket_t * _buckets;
    mask_t _mask;
    uint16_t _flags;
    uint16_t _occupied;
};

struct lg_class_data_bits_t {
    uintptr_t bits;
};

struct lg_objc_class {
    Class ISA;
    Class superclass;
    struct lg_cache_t cache;             // formerly cache pointer and vtable
    struct lg_class_data_bits_t bits;    // class_rw_t * plus custom rr/alloc flags
};


@interface simViewController ()

@end

@implementation simViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    LGPerson *p  = [LGPerson alloc];
    Class pClass = [LGPerson class];
    
    
    struct lg_objc_class *lg_pClass = (__bridge struct lg_objc_class *)(pClass);
    NSLog(@"%hu - %u",lg_pClass->cache._occupied,lg_pClass->cache._mask);
    for (mask_t i = 0; i<lg_pClass->cache._mask; i++) {
        // 打印获取的 bucket
        struct lg_bucket_t bucket = lg_pClass->cache._buckets[i];
        NSLog(@"%@ - %p",NSStringFromSelector(bucket._sel),bucket._imp);
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
