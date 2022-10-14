//
//  Stack.swift
//  leetcode_Swift
//
//  Created by 张雄飞 on 2022/10/12.
//

import Foundation

class Stack <E> {
    
    lazy private var _elements = [E]()
    private var _size = 0
    
    init(elements: [E]) {
        _size = elements.count
        _elements = elements
    }
    
    convenience init() {
        self.init(elements: [E]())
    }
    
    func size() -> Int { _size }
    func isEmpty() -> Bool { size() == 0 }
    
    func push(_ element: E) {
        _size += 1
        _elements.append(element)
    }
    
    func pop() -> E{
        _size -= 1
        return _elements.removeLast()
    }
    
    func top() -> E { _elements[_size - 1] }
    
    func clear() {
        _size = 0
        _elements.removeAll()
    }
    
}
