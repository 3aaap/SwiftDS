//
//  UnionFind_QU_R_F.swift
//  leetcode_Swift
//
//  Created by 张雄飞 on 2022/10/17.
//

import Foundation

/**
 并查集
 快速查找 QuickUnion
 基于 Rank , 路径分裂 优化
 */
class UnionFind {
    var size: Int
    var parents = [Int]()
    var ranks: Array<Int>
    
    init(_ capacity: Int) {
        assert(capacity > 0, "容量 >= 1")
        for i in 0..<capacity {
            parents.append(i)
        }
        self.ranks = Array(repeating: 1, count: capacity)
        self.size = capacity
    }
    
    convenience init() {
        self.init(10)
    }
    
    /// 查找
    func find(v: Int) -> Int {
        var _v = v
        while (_v != parents[_v]){
            let parent = parents[_v]
            parents[_v] = parents[parent]
            _v = parent
        }
        return parents[_v]
    }
    
    /// 合并 -> 基于树高 rank 优化合并过程
    ///
    func union(v1: Int, v2: Int) {
        let p1 = find(v: v1)
        let p2 = find(v: v2)
        guard p1 != p2 else { return }
        
        if (ranks[p1] < ranks[p2]){
            // p1 比 p2 矮
            parents[p1] = p2
        }else if (ranks[p2] > ranks[p1]){
            // p1 比 p2 高
            parents[p2] = p1
        }else {
            // 两棵树高度相等
            parents[p1] = p2
            ranks[p2] += 1
        }
        self.size -= 1
    }

    /// 是否在同一集
    func isSame(v1: Int, v2: Int) -> Bool {
        find(v: v1) == find(v: v2)
    }
}
