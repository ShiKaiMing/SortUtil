//
//  SortUtil.m
//  SortUtil
//
//  Created by sky on 2017/12/26.
//  Copyright © 2017年 sky. All rights reserved.
//

#import "SortUtil.h"

@implementation SortUtil
#pragma mark --- 插入排序
/**
 插入排序
 
 @param array 需要排序的Array
 */
+ (void)inserSort:(NSMutableArray *)array
{
    //插入排序的原理：始终定义第一个元素为有序的，将元素逐个插入到有序排列之中，其特点是要不断的
    
    //移动数据，空出一个适当的位置，把待插入的元素放到里面去。
    for (int i = 0; i < array.count; i++) {
        
        NSNumber *temp = array[i];
        //temp 为待排元素 i为其位置 j为已排元素最后一个元素的位置（即取下一个元素，在已经排好序的元素序列中从后向前扫描）
        
        int j = i-1;
        
        //当j < 0 时， i 为第一个元素 该元素认为已经是排好序的 所以不进入while循环
        //  [array[j] compare:temp] == NSOrderedDescending与[array[j] intValue] > [temp intValue] 作用相同
        while (j >= 0 && [array[j] compare:temp] == NSOrderedDescending) {
            //如果已经排好序的序列中元素大于新元素，则将该元素往右移动一个位置
            [array replaceObjectAtIndex:j+1 withObject:array[j]];
            j--;
        }
        //跳出while循环时，j的元素小于或等于i的元素(待排元素)。插入新元素 i= j+1
        [array replaceObjectAtIndex:j+1 withObject:temp];
        NSLog(@"插入排序排序中:%@",array);
    }
}

#pragma mark --- 希尔排序
/**
 希尔排序
 
 @param array 需要排序的Array
 */
+(void)shellSort:(NSMutableArray *)array
{
    //希尔排序的思想: 先将整个待排序的记录序列分割成为若干子序列分别进行直接插入排序，待整个序列中的记录“基本有序”时，再对全体记录进行依次直接插入排序。
    //起始间隔值gap设置为总数的一半，
    int gap = (int)[array count] / 2;
    //当 gap==1 时 结束循环
    while (gap >= 1) {
        // 把距离为 gap 的元素编为一个组，扫描所有组
        for(int i = gap ; i < [array count]; i++){
            //取出第gap的数据
            int j = i;
            NSNumber *temp = array[i];
            // 对距离为 gap 的元素组进行排序
            while (j >= gap && [temp  integerValue] < [array[(j - gap)] integerValue]) {
                [array replaceObjectAtIndex:j withObject:array[(j - gap)]];
                j = j - gap;
                [array replaceObjectAtIndex:j withObject:temp];
            }
            
        }
        gap = gap / 2;
        NSLog(@"希尔排序结果：%@", array);
    }
}

#pragma mark --- 选择排序
/**
 选择排序
 
 @param array 需要排序的Array
 */
+ (void)selectSort:(NSMutableArray *)array
{
    
    //遍历数组
    /*
     选择排序的原理：每一次从待排序的数据元素中选出最小（或最大）的一个元素，存放在序列的起始位置，直到全部待排序的数据元素排完。
     //排序数组
     NSMutableArray *originalArray =
     [NSMutableArray arrayWithObjects:@9,@1,@2,@5,@7,@4,@8,@6,@3,@5,nil];
     */
    NSInteger min = 0;
    for (int i=0; i<array.count; i++) {
        //先设数组最小值下标为i；
        min = i;
        for (int j=i+1; j<array.count; j++) {
            //待排序数组array[j] < array[min] 其最小值的下标为j
            if (array[j]<array[min]) {
                min = j;
            }
        }
        //交换数据
        if (min != i) {
            [array exchangeObjectAtIndex:i withObjectAtIndex:min];
        }
    }
    NSLog(@"选择排序：%@",array);
}
#pragma mark --- 堆排序
/**
 堆排序
 
 @param array 需要排序的Array
 */
+ (void)heapSort:(NSMutableArray *)array
{
    /**
     设当前元素在数组中以R[i]表示，那么，
     
     (1) 它的左孩子结点是：R[2*i+1];
     
     (2) 它的右孩子结点是：R[2*i+2];
     
     (3) 它的父结点是：R[(i-1)/2];
     
     (4) R[i] <= R[2*i+1] 且 R[i] <= R[2i+2]。
     */
    //最后一个元素的索引
    NSInteger endIndex = array.count - 1;
    //构建初始堆
    array = [self heapCreate:array];
    // 进行n-1次循环，完成排序
    while (endIndex > 0) {
        //        NSLog(@"将list[0]:\%@与list[\(endIndex)]:\%@交换", ascendingArr[0], ascendingArr[endIndex]);
        // 最后一个元素和第一元素进行交换
        NSNumber *temp = array[0];
        array[0] = array[endIndex];
        array[endIndex] = temp;
        //堆调整
        array = [self heapAdjast:array withFatherIndex:0 withEndIndex:endIndex];
        // 下一次循环
        endIndex -= 1;
    }
    NSLog(@"堆排序结果：%@", array);
}
//循环建立初始堆
+ (NSMutableArray *)heapCreate:(NSMutableArray *)array
{
    NSInteger i = array.count/2;
    while (i >= 0) {
        array = [self heapAdjast:array withFatherIndex:i withEndIndex:array.count];
        i -= 1;
    }
    return array;
}
//排序
+ (NSMutableArray *)heapAdjast:(NSMutableArray *)items withFatherIndex:(NSInteger)fatherIndex withEndIndex:(NSInteger)endIndex
{
    
    //开始元素
    NSNumber *temp = items[fatherIndex];
    //先获得左子索引
    NSInteger childIndex = 2 * fatherIndex+1;
    
    while (childIndex < endIndex) {
        // 如果有右孩子结点，并且右孩子结点的值大于左孩子结点，则选取右孩子结点
        if (childIndex+1 < endIndex && [items[childIndex] floatValue] < [items[childIndex+1] floatValue]) {
            childIndex++;
        }
        // 如果父结点的值已经大于孩子结点的值，则直接结束
        if ([temp floatValue] >= [items[childIndex] floatValue]) {
            break;
        }
        // 把孩子结点的值赋给父结点
        items[fatherIndex] = items[childIndex];
        fatherIndex = childIndex;
        childIndex = 2 * fatherIndex +1;
    }
    items[fatherIndex] = temp;
    return items;
}

#pragma mark --- 冒泡排序
/**
 冒泡排序
 
 @param array 需要排序的Array
 */
+ (void)bubbleSort:(NSMutableArray *)array
{
    //遍历数组(实例为从后往前排序)
    /*
     冒泡排序的原理：每次在无序队列里从后向前依次的比较相邻两个数的大小，将小数调换到前面，逐次比较，遍历一次后，把数组中第i小的数放在第i个位置上。依此规律，直至比较结束。
     //排序数组
     NSMutableArray *originalArray =
     [NSMutableArray arrayWithObjects:@4,@3,@1,@2,@5,nil];
     
     i = 0 的时候，j的相邻两个位置都要比较排一下位置：  第1次i循环冒泡出originalArray中最小的
     
     j = 4 的时候：originalArray = 4 3 1 2 5
     j = 3 的时候：originalArray = 4 3 1 2 5
     j = 2 的时候：originalArray = 4 1 3 2 5
     j = 1 的时候：originalArray = 1 4 3 2 5
     
     i = 1;         第2次i循环冒泡出剩余最小的
     j = 4 的时候：originalArray = 1 4 3 2 5
     j = 3 的时候：originalArray = 1 4 2 3 5
     j = 2 的时候：originalArray = 1 2 4 3 5
     
     i = 2;         第3次i循环冒泡出剩余最小的
     j = 4 的时候：originalArray = 1 2 4 3 5
     j = 3 的时候：originalArray = 1 2 3 4 5
     
     
     重复i-1趟的比较,每一趟比较j-i次.
     */
    // 要遍历的次数
    for (int i = 0; i < array.count-1; i++) {
        // 从后向前依次的比较相邻两个数的大小，遍历一次后，把数组中第i小的数放在第i个位置上
        for (int j = (int)array.count-1; j > i; j--) {
            
            //根据索引的`相邻两位`进行`比较`
            if (array[j-1] > array[j]) {
                // 比较相邻的元素，如果前面的数大于后面的数，则交换（升序）
                [array exchangeObjectAtIndex:j-1 withObjectAtIndex:j];
                NSLog(@"冒泡排序：%@",array);
            }
            //            if (array[j-1] < array[j]) {
            //                // 比较相邻的元素，如果前面的数小于后面的数，则交换（降序）
            //                [array exchangeObjectAtIndex:j-1 withObjectAtIndex:j];
            //            }
            
        }
    }
    NSLog(@"冒泡排序：%@",array);
}

#pragma mark --- 快速排序
/**
 快速排序
 
 @param array 需要排序的Array
 @param left 初始索引
 @param right 最后一位索引
 */
+ (void)quickSort:(NSMutableArray *)array left:(int)left right:(int)right
{
    
    if(array == nil || array.count == 0 || left >= right){
        NSLog(@"注意快速排序条件");
        return;
    }
    
    // 以最左边的数(left)为基准
    int base = left;
    NSNumber *prmt = array[base];
    //    //取中值
    //    int middle = left + (right - left)/2;
    //    NSNumber *prmt = array[middle];
    int i = left;
    int j = right;
    
    /**
     while是循环流程控制，使用的标准格式为
     while(表达式)
     {
     循环语句体；
     }
     说明：①while循环的表达式是循环进行的条件，用作循环条件的表达式中一般至少包括一个能够改变表达式的变量，这个变量称为循环变量
     ②当表达式的值为真（非零）时，执行循环体；为假（0）时，则循环结束
     ③当循环体不需要实现任何功能时，可以用空语句作为循环体
     ④对于循环变量的初始化应在while语句之前进行，可以通过适当方式给循环变量赋初值
     */
    //开始排序，使得left<prmt 同时right>prmt
    while (i < j) {
        //        while ([array[j] intValue] > [prmt intValue]) {
        //该行与下一行作用相同
        // j 从右至左移动(j--) 直到找到一个小于[prmt intValue]的数停下来
        while ([array[j] compare:prmt] == NSOrderedDescending) {
            j--;
        }
        //        while ([array[i] intValue] < [prmt intValue]) {
        //该行与下一行作用相同
        /**
         i 从左至右移动(i++) 直到找到一个大于[prmt intValue]的数停下来
         */
        while ([array[i] compare:prmt] == NSOrderedAscending) {
            i++;
        }
        
        //如果i与j未相遇 交换其数据
        if(i < j){
            [array exchangeObjectAtIndex:i withObjectAtIndex:j];
            //i 与j 各移动一位 进入下一循环
            i++;
            j--;
        }
        NSLog(@"快速排序排序中:%@",array);
    }
    
    //第一轮排序完成 将数组拆成 A[p ..q-1] <= A[q] <= A[q+1 ..r] 模式的两个数组 递归
    /**
     程序调用自身的编程技巧称为递归（ recursion）。递归做为一种算法在程序设计语言中广泛应用。递归有直接递归和间接递归
     •直接递归：函数在执行过程中调用本身。
     •间接递归：函数在执行过程中调用其它函数再经过这些函数调用本身。
     •递归算法有四个特性：
     （1）必须有可最终达到的终止条件，否则程序将陷入无穷循环；
     （2）子问题在规模上比原问题小，或更接近终止条件；
     （3）子问题可通过再次递归调用求解或因满足终止条件而直接求解；
     （4）子问题的解应能组合为整个问题的解。
     */
    
    // 对“基准标号“左侧的一组数值进行递归的切割，以至于将这些数值完整的排序
    if (left < j) {
        [self quickSort:array left:left right:j];
    }
    // 对“基准标号“右侧的一组数值进行递归的切割，以至于将这些数值完整的排序
    if (right > i) {
        [self quickSort:array left:i right:right];
    }
}
#pragma mark --- 归并排序
/**
 归并排序
 
 @param array 需要排序的Array
 */
+ (void)megerSort:(NSMutableArray *)array
{
    /**
     归并排序其实要做两件事：
     
     （1）“分解”——将序列每次折半划分。
     
     （2）“合并”——将划分后的序列段两两合并后排序。
     */
    //排序数组
    NSMutableArray *tempArray = [NSMutableArray arrayWithCapacity:1];
    //第一趟排序是的子数组个数为ascendingArr.count
    for (NSNumber *num in array) {
        NSMutableArray *subArray = [NSMutableArray array];
        [subArray addObject:num];
        [tempArray addObject:subArray];
    }
    /**
     分解操作 每一次归并操作 tempArray的个数为（当数组个数为偶数时tempArray.count/2;当数组个数为奇数时tempArray.count/2+1）;当tempArray.count == 1时，归并排序完成
     */
    while (tempArray.count != 1) {
        NSInteger i = 0;
        
        //当数组个数为偶数时 进行合并操作， 当数组个数为奇数时，最后一位轮空
        while (i < tempArray.count - 1) {
            
            //将i 与i+1 进行合并操作 将合并结果放入i位置上 将i+1位置上的元素删除
            tempArray[i] = [self mergeArrayFirstList:tempArray[i] secondList:tempArray[i + 1]];
            [tempArray removeObjectAtIndex:i + 1];
            
            //i++ 继续下一循环的合并操作
            i++;
        }
    }
    NSLog(@"归并排序结果：%@", tempArray);
}
//合并
+ (NSArray *)mergeArrayFirstList:(NSArray *)array1 secondList:(NSArray *)array2 {
    
    // 合并序列数组
    NSMutableArray *resultArray = [NSMutableArray array];
    
    // firstIndex是第一段序列的下标 secondIndex是第二段序列的下标
    NSInteger firstIndex = 0, secondIndex = 0;
    
    // 扫描第一段和第二段序列，直到有一个扫描结束
    while (firstIndex < array1.count && secondIndex < array2.count) {
        // 判断第一段和第二段取出的数哪个更小，将其存入合并序列，并继续向下扫描
        if ([array1[firstIndex] floatValue] < [array2[secondIndex] floatValue]) {
            [resultArray addObject:array1[firstIndex]];
            firstIndex++;
        } else {
            [resultArray addObject:array2[secondIndex]];
            secondIndex++;
        }
    }
    // 若第一段序列还没扫描完，将其全部复制到合并序列
    while (firstIndex < array1.count) {
        [resultArray addObject:array1[firstIndex]];
        firstIndex++;
    }
    // 若第二段序列还没扫描完，将其全部复制到合并序列
    while (secondIndex < array2.count) {
        [resultArray addObject:array2[secondIndex]];
        secondIndex++;
    }
    // 返回合并序列数组
    return resultArray.copy;
}
#pragma mark --- 基数排序
/**
 基数排序
 
 @param array 需要排序的Array
 */
+ (void)radixSort:(NSMutableArray *)array
{
    /**
     基于LSD方法的链式基数排序的基本思想
     　　“多关键字排序”的思想实现“单关键字排序”。对数字型或字符型的单关键字，可以看作由多个数位或多个字符构成的多关键字，此时可以采用“分配-收集”的方法进行排序，这一过程称作基数排序法，其中每个数字或字符可能的取值个数称为基数。比如，扑克牌的花色基数为4，面值基数为13。在整理扑克牌时，既可以先按花色整理，也可以先按面值整理。按花色整理时，先按红、黑、方、花的顺序分成4摞（分配），再按此顺序再叠放在一起（收集），然后按面值的顺序分成13摞（分配），再按此顺序叠放在一起（收集），如此进行二次分配和收集即可将扑克牌排列有序。
     基数排序:
     是按照低位先排序，然后收集；再按照高位排序，然后再收集；依次类推，直到最高位。有时候有些属性是有优先级顺序的，先按低优先级排序，再按高优先级排序。最后的次序就是高优先级高的在前，高优先级相同的低优先级高的在前。基数排序基于分别排序，分别收集，所以是稳定的。
     */
    //创建空桶
    NSMutableArray *buckt = [self createBucket];
    //待排数组的最大数值
    NSNumber *maxnumber = [self listMaxItem:array];
    //最大数值的数字位数
    NSInteger maxLength = numberLength(maxnumber);
    // 按照从低位到高位的顺序执行排序过程
    for (int digit = 1; digit <= maxLength; digit++) {
        // 入桶
        for (NSNumber *item in array) {
            //确定item 归属哪个桶 以digit位数为基数
            NSInteger baseNumber = [self fetchBaseNumber:item digit:digit];
            NSMutableArray *mutArray = buckt[baseNumber];
            //将数据放入空桶上
            [mutArray addObject:item];
        }
        NSInteger index = 0;
        //出桶
        for (int i = 0; i < buckt.count; i++) {
            NSMutableArray *array = buckt[i];
            //将桶的数据放回待排数组中
            while (array.count != 0) {
                
                NSNumber *number = [array objectAtIndex:0];
                array[index] = number;
                [array removeObjectAtIndex:0];
                index++;
            }
        }
    }
    NSLog(@"基数升序排序结果：%@", array);
}
//创建空桶
+ (NSMutableArray *)createBucket {
    NSMutableArray *bucket = [NSMutableArray array];
    for (int index = 0; index < 10; index++) {
        NSMutableArray *array = [NSMutableArray array];
        [bucket addObject:array];
    }
    return bucket;
}
//数据最大值
+ (NSNumber *)listMaxItem:(NSArray *)list {
    NSNumber *maxNumber = list[0];
    for (NSNumber *number in list) {
        if ([maxNumber integerValue] < [number integerValue]) {
            maxNumber = number;
        }
    }
    return maxNumber;
}
//数字的位数
NSInteger numberLength(NSNumber *number) {
    NSString *string = [NSString stringWithFormat:@"%ld", (long)[number integerValue]];
    return string.length;
}
+ (NSInteger)fetchBaseNumber:(NSNumber *)number digit:(NSInteger)digit {
    //digit为基数位数
    if (digit > 0 && digit <= numberLength(number)) {
        NSMutableArray *numbersArray = [NSMutableArray array];
        //        number的位数确定
        NSString *string = [NSString stringWithFormat:@"%ld", [number integerValue]];
        for (int index = 0; index < numberLength(number); index++) {
            [numbersArray addObject:[string substringWithRange:NSMakeRange(index, 1)]];
        }
        //        number的位数 是几位数的
        NSString *str = numbersArray[numbersArray.count - digit];
        return [str integerValue];
    }
    return 0;
}


@end
