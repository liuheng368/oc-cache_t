//
//  ViewController.m
//  123
//
//  Created by Henry on 2020/11/12.
//  真机

#import "ViewController.h"
#import "LGPerson.h"
#import <objc/runtime.h>

typedef uint32_t mask_t;  // x86_64 & arm64 asm are less efficient with 16-bits
typedef unsigned long uintptr_t;

struct hr_bucket_t {
    IMP _imp;
    SEL _sel;
};

struct hr_cache_t {
    uintptr_t _maskAndBuckets;
    mask_t _mask_unused;
    uint16_t _flags;
    uint16_t _occupied;
};

struct hr_class_data_bits_t {
    uintptr_t bits;
};

struct hr_objc_class {
    Class ISA;
    Class superclass;
    struct hr_cache_t cache;             // formerly cache pointer and vtable
    struct hr_class_data_bits_t bits;    // class_rw_t * plus custom rr/alloc flags
};

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    LGPerson *p  = [LGPerson alloc];
    Class pClass = [LGPerson class];  // objc_clas
    [p say1];
    [p say2];
    [p say3];
//    [p say4];
//    [p say5];
//    [p say6];
//    [p say7];

    struct hr_objc_class *hr_pClass = (__bridge struct hr_objc_class *)(pClass);
    uintptr_t mask = hr_pClass->cache._maskAndBuckets >> 48;
    struct hr_bucket_t *bucket = hr_pClass->cache._maskAndBuckets << 16 >> 16;
    NSLog(@"%hu - %lu",hr_pClass->cache._occupied,mask);
    for (mask_t i = 0; i<mask+1; i++) {
        // 打印获取的 bucket
        struct hr_bucket_t *buckets = (bucket + 0x000000000000001*i);
        NSLog(@"%@ - %p",NSStringFromSelector(buckets->_sel),buckets->_imp);
    }
}


@end
