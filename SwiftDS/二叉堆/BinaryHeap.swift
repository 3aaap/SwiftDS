//
//  BinaryHeap.swift
//  SwiftDS
//
//  Created by 张雄飞 on 2022/9/26.
//

import Foundation

protocol Comparable {
    associatedtype Compare
    func compare(otherElement: Compare) -> ComparisonResult
}

class BinaryHeap<E>{
    
    typealias CompareBlock = (E, E) -> ComparisonResult
    
    // MARK: 私有属性
    private var _size:Int = 0
    private var _elements: [E]?
    private var _compare: CompareBlock?
    
    // MARK: 构造方法 - 批量建堆
    convenience init(withArray elements: Array<E>, _ compare: CompareBlock?){
        self.init()
        
        _elements = elements;
        _compare = compare
        _size = elements.count
        
        self.heapify()
    }
    
    // MARK: 对外接口
    func size() -> Int{
        return _size
    }
    
    func isEmpty() -> Bool{
        return _size == 0
    }
    
    func clear(){
        _size = 0
        _elements?.removeAll()
    }
    
    func add(element: E){
        _elements?.append(element)
        _size += 1
        
        self.siftUp(idx: _size - 1)
    }
    
    func get() -> E?{
        self.emptyCheck()
        return _elements?[0]
    }
    
    func remove() -> E{
        self.emptyCheck()
        
        let ret:E = _elements![0]
        let element:E = _elements![_size - 1]
        
        _elements?.removeLast()
        _size -= 1
        if (_size > 0){
            _elements?[0] = element
            self.siftDown(idx: 0)
        }
        
        return ret
    }
    
    func replace(element: E) -> E?{
        self.emptyCheck()
        
        let ret: E = _elements![0]
        _elements![0] = element
        
        self.siftDown(idx: 0)
        
        return ret
    }
    
    // MARK: 内部私有方法
    // 上滤
    private func siftUp(idx: Int){
        var index: Int = idx;
        let element = _elements![index]
        while(index > 0){
            let pIndex:Int = (index - 1) >> 1
            let pElement:E = _elements![pIndex]
            
            if (self.compare2Objects(o1: element, o2: pElement) == ComparisonResult.orderedDescending){
                break
            }
                
            // 1,将父元素存储在子节点位置
            _elements![index] = pElement;
            
            // 2,记录父节点元素为子元素，不覆盖
            index = pIndex;
        }
        // 3,直到退出循环再交换
        _elements![index] = element
    }
    
    // 下滤
    private func siftDown(idx: Int){
        var index: Int = idx;
        let element: E = _elements![index]
        
        // 有子节点，且比子节点中最大者小
        while (_size > (index << 1) + 1){
            var childIdx:Int = (index << 1) + 1
            var childEle:E = _elements![childIdx]
            
            let rightIdx:Int = childIdx + 1
            if (_size > rightIdx && self.compare2Objects(o1: childEle, o2: _elements![rightIdx]) == ComparisonResult.orderedDescending){
                // 右子节点存在， 且右子节点 > 左子节点
                childIdx = rightIdx
                childEle = _elements![childIdx]
            }
            
            if (self.compare2Objects(o1: element, o2: childEle) == ComparisonResult.orderedAscending){
                break
            }
            
            _elements![index] = childEle
            index = childIdx
        }
        _elements![index] = element
    }
    
    // 批量建堆
    private func heapify(){
        var i: Int = (_size >> 1) - 1;
        while i>=0 {
            self.siftDown(idx: i)
            i -= 1
        }
    }
    
    // 空检查
    private func emptyCheck(){
        assert(_size != 0, "Heap can not be empty")
    }
    
    // 比较元素
    private func compare2Objects(o1: E, o2: E) -> ComparisonResult{
        if ((_compare) != nil){
            return _compare!(o1, o2)
        }
        
        return ComparisonResult.orderedSame
    }
}

