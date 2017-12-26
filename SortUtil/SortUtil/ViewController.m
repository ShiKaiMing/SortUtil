//
//  ViewController.m
//  SortUtil
//
//  Created by fangd@silviscene.com on 2017/12/26.
//  Copyright © 2017年 sky. All rights reserved.
//

#import "ViewController.h"
#import "SortUtil.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark --- 插入排序
- (IBAction)inserSort:(id)sender {
    NSMutableArray *sortArray = [NSMutableArray array];
    [sortArray addObjectsFromArray:@[@4,@1,@2,@5]];
    [SortUtil inserSort:sortArray];
}
#pragma mark --- 希尔排序
- (IBAction)shellSort:(id)sender {
    NSMutableArray *sortArray = [NSMutableArray array];
    [sortArray addObjectsFromArray:@[@9,@1,@2,@5,@7,@4,@8,@6,@3,@5]];
    [SortUtil shellSort:sortArray];
}
#pragma mark --- 选择排序
- (IBAction)selectSort:(id)sender {
    NSMutableArray *sortArray = [NSMutableArray array];
    [sortArray addObjectsFromArray:@[@9,@1,@2,@5,@7,@4,@8,@6,@3,@5]];
    [SortUtil selectSort:sortArray];
}
#pragma mark --- 堆排序
- (IBAction)heapSort:(id)sender {
    NSMutableArray *sortArray = [NSMutableArray array];
    [sortArray addObjectsFromArray:@[@1,@3,@4,@5,@2,@6,@9,@7,@8,@0]];
    [SortUtil heapSort:sortArray];
}
#pragma mark --- 冒泡排序
- (IBAction)bubbleSort:(id)sender {
    NSMutableArray *sortArray = [NSMutableArray array];
    [sortArray addObjectsFromArray:@[@4,@3,@1,@2,@5]];
    [SortUtil bubbleSort:sortArray];
    
}
#pragma mark --- 快速排序
- (IBAction)quickSort:(id)sender {
    NSMutableArray *sortArray = [NSMutableArray array];
    [sortArray addObjectsFromArray:@[@2,@4,@5,@1,@3]];
    [SortUtil quickSort:sortArray left:0 right:(int)sortArray.count-1];
}
#pragma mark --- 归并排序
- (IBAction)megerSort:(id)sender {
    NSMutableArray *sortArray = [NSMutableArray array];
    [sortArray addObjectsFromArray:@[@8,@4,@7,@7,@1,@3,@6,@2]];
    [SortUtil megerSort:sortArray];
}
#pragma mark --- 基数排序
- (IBAction)radixSort:(id)sender {
    NSMutableArray *sortArray = [NSMutableArray array];
    [sortArray addObjectsFromArray:@[@73,@22,@93,@43,@55,@14,@28,@65,@39,@81]];
    [SortUtil radixSort:sortArray];
}

































@end
