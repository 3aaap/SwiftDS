//
//  LinearList.swift
//  SwiftDS
//
//  Created by songdezhong on 2022/9/23.
//

import Foundation

class ListNode<T> {
    var next: ListNode?
    var val: T
    init(_ x: T) {
        val = x
    }
    convenience init(_ x: T, _ node: ListNode) {
        self.init(x)
        next = node
    }
}
