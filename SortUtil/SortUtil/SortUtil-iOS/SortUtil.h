//
//  SortUtil.h
//  SortUtil
//
//  Created by sky on 2017/12/26.
//  Copyright © 2017年 sky. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SortUtil : NSObject
/**
 插入排序
 
 @param array 需要排序的Array
 */
+ (void)inserSort:(NSMutableArray *)array;
/**
 希尔排序
 
 @param array 需要排序的Array
 */
+(void)shellSort:(NSMutableArray *)array;
/**
 选择排序
 
 @param array 需要排序的Array
 */
+ (void)selectSort:(NSMutableArray *)array;
/**
 堆排序
 
 @param array 需要排序的Array
 */
+ (void)heapSort:(NSMutableArray *)array;
/**
 冒泡排序
 
 @param array 需要排序的Array
 */
+ (void)bubbleSort:(NSMutableArray *)array;
/**
 快速排序
 
 @param array 需要排序的Array
 @param left 初始索引
 @param right 最后一位索引
 */
+ (void)quickSort:(NSMutableArray *)array left:(int)left right:(int)right;
/**
 归并排序
 
 @param array 需要排序的Array
 */
+ (void)megerSort:(NSMutableArray *)array;
/**
 基数排序
 
 @param array 需要排序的Array
 */
+ (void)radixSort:(NSMutableArray *)array;
@end
