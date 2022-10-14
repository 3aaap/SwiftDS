//
//  Queue.swift
//  leetcode_Swift
//
//  Created by 张雄飞 on 2022/10/13.
//

import Foundation

class Queue<E> {

    lazy private var _elements = [E]()
    private var _size = 0
    
    init(elements: [E]) {
        _size = elements.count
        _elements = elements
    }
    
    convenience init() {
        self.init(elements: [E]())
    }
    
    func size() -> Int { return _size }
    
    func isEmpty() -> Bool { _size == 0 }
    
    func enqueue(_ element:E) {
        _size += 1
        _elements.append(element)
    }
    
    func dequeue() -> E {
        _size -= 1
        return _elements.removeFirst()
    }
    
    func front() -> E {
        _elements[0]
    }
    
    func clear() {
        _elements.removeAll()
        _size = 0
    }
}
