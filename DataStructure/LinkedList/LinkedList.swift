//
//  LinkedList.swift
//  SwiftOSX
//
//  Created by Samuel on 2019/9/11.
//  Copyright © 2019 Shenzhen Thirtydays Technology. All rights reserved.
//

import Foundation

private enum Exception: Error {
    case NoSuchElement
    case IndexOutOfBounds
    case IndexBeyoundTheSize
}

class Node<Element: Equatable> {
    var item: Element?
    var next: Node<Element>?
    var prev: Node<Element>?
    
    init(_ item: Element? = nil, prev: Node<Element>? = nil, next: Node<Element>? = nil) {
        self.item = item
        self.next = next
        self.prev = prev
    }
}

class LinkedList<Element: Equatable> {
    
    var first: Node<Element>?
    var last: Node<Element>?
    
    init(first: Node<Element>? = Node<Element>(), last: Node<Element>? = nil) {
        self.first = first
        self.last = last
        
        if first == nil {
            self.first = last
        } else if last == nil {
            self.last = first
        }
    }
    
    var size: Int {
        var num = 0
        var node = first
        while node != nil {
            num += 1
            node = node?.next
        }
        return num
    }
    
    func getFirst() throws -> Element? {
        guard let f = first else {
            throw Exception.NoSuchElement
        }
        return f.item
    }
    
    func getLast() throws -> Element? {
        guard let l = last else {
            throw Exception.NoSuchElement
        }
        return l.item
    }
    
    func index(of item: Element) -> Int {
        var index = 0
        var node = first
        while node != nil {
            if node?.item == item {
                return index
            }
            node = node?.next
            index += 1
        }
        return -1;
    }
    
    func lastIndex(of item: Element) -> Int {
        var index = size - 1
        var node = last
        while node != nil {
            if node?.item == item {
                return index
            }
            node = node?.prev
            index -= 1
        }
        return -1
    }
    
    /// MARK: 根据index找到指定节点，更改它的值，并且会返回原有值。
    func set(_ newElement: Element, at index: Int) throws -> Element? {
        guard index >= 0 && index < size else {
            throw Exception.IndexOutOfBounds
        }
        
        let x = node(at: index)
        let oldValue = x?.item
        x?.item = newElement
        return oldValue
    }
    
    @discardableResult
    func add(_ newElement: Element) -> Bool {
        linkLast(newElement)
        return true
    }
    
    func add(_ newElement: Element, at index: Int) throws {
        guard index >= 0 && index <= size else {
            throw Exception.IndexBeyoundTheSize
        }
        
        if index == size {
            linkLast(newElement)
        } else {
            linkBefore(newElement, succ: node(at: index))
        }
    }
    
    func addFirst(_ item: Element) {
        linkFirst(item)
    }
    
    func addLast(_ item: Element) {
        linkLast(item)
    }
    
    @discardableResult
    func addAll(_ newElements: [Element]) throws -> Bool {
        return try addAll(newElements, at: size)
    }
    
    @discardableResult
    func addAll(_ newElements: [Element], at index: Int) throws -> Bool{
        return try add(contentsOf: newElements, at: index)
    }
    
    @discardableResult
    func removeFirst() throws -> Element? {
        return try unlinkFirst()
    }
    
    @discardableResult
    func removeLast() throws -> Element? {
        return try unlinkLast()
    }
    
    func remove(at index: Int) throws -> Element? {
        guard index >= 0 && index < size else {
            throw Exception.IndexOutOfBounds
        }
        return try unlink(node(at: index))
    }
    
    func remove(_ item: Element?) throws -> Element? {
        var x = first
        while x != nil {
            if x?.item == item {
                return try unlink(x)
            }
            x = x?.next
        }
        return nil
    }
    
    func clear() {
        var x = first
        while x != nil {
            let next = x?.next
            x?.item = nil
            x?.next = nil
            x?.prev = nil
            x = next
        }
        
        first = nil
        last = nil
//        size = 0
    }
}


private extension LinkedList {
    
    @discardableResult
    func unlink(_ node: Node<Element>?) throws -> Element? {
        guard let x = node else {
            throw Exception.NoSuchElement
        }
        
        let item = x.item
        let prev = x.prev
        let next = x.next
        
        if prev == nil {
            first = next
        } else {
            prev?.next = next
            x.prev = nil
        }
        
        if next == nil {
            last = prev
        } else {
            next?.prev = prev
            x.next = nil
        }
        
        x.item = nil
//        size -= 1
        return item
    }
    
    @discardableResult
    func unlinkLast() throws -> Element? {
        guard let l = last else {
            throw Exception.NoSuchElement
        }
        
        let item = l.item
        let prev = l.prev
        
        l.item = nil
        l.prev = nil
        
        last = prev
        if prev == nil {
            first = nil
        } else {
            prev?.next = nil
        }
//        size -= 1
        return item
    }
    
    @discardableResult
    func unlinkFirst() throws -> Element? {
        guard let f = first else {
            throw Exception.NoSuchElement
        }
        
        let item = f.item
        let next = f.next
        
        f.item = nil
        f.next = nil
        
        first = next
        if next == nil {
            last = nil
        } else {
            next?.prev = nil
        }
        
//        size -= 1
        return item
    }
    
    @discardableResult
    func add(contentsOf newElements: [Element], at index: Int) throws -> Bool {
        guard index >= 0 && index <= size else {
            throw Exception.IndexBeyoundTheSize
        }
        
        let count = newElements.count
        guard count > 0 else { return false }
        
        var pred: Node<Element>?, succ: Node<Element>?
        if index == size {
            succ = nil
            pred = last
        } else {
            succ = node(at: index)
            pred = succ?.prev
        }
        
        for item in newElements {
            let newNode = Node(item, prev: pred)
            if pred == nil {
                first = newNode
            } else {
                pred?.next = newNode
            }
            pred = newNode
        }
        
        if succ == nil {
            succ = pred
        } else {
            pred?.next = succ
            succ?.prev = pred
        }
        
//        size += count
        return true
    }
    
    func linkBefore(_ item: Element, succ: Node<Element>?) {
        let pred = succ?.prev
        let newNode = Node(item, prev: pred, next: succ)
        succ?.prev = newNode
        if pred == nil {
            first = newNode
        } else {
            pred?.next = newNode
        }
//        size += 1
    }
    
    func linkFirst(_ item: Element) {
        let f = first
        let newNode = Node(item, next: f)
        first = newNode
        if f == nil {
            last = newNode
        } else {
            f?.prev = newNode
        }
//        size += 1
    }
    
    func linkLast(_ item: Element) {
        let l = last
        let newNode = Node(item, prev: l)
        last = newNode
        if l == nil {
            first = newNode
        } else {
            l?.next = newNode
        }
//        size += 1
    }
    
    func node(at index: Int) -> Node<Element>? {
        // 判断 index 是在链表偏左侧还是偏右侧
        if index < (size >> 1) {
            var node = first
            var i: Int = 0
            while node != nil {
                if i == index {
                    return node
                }
                // 从左边往右 next
                node = node?.next
                i += 1
            }
            return nil
        } else {
            var node = last
            var i: Int = size - 1
            while node != nil {
                if i == index {
                    return node
                }
                // 从右往左 prev
                node = node?.prev
                i -= 1
            }
            return nil
        }
    }
}

struct LinkedListIterator<E: Equatable>: IteratorProtocol {
    typealias Element = E
    private var node: Node<Element>?
    
    init(node: Node<Element>?) {
        self.node = node
    }
    
    mutating func next() -> Element? {
        defer { node = node?.next }
        return node?.item
    }
}

extension LinkedList: Sequence {

    func makeIterator() -> LinkedListIterator<Element> {
        return LinkedListIterator(node: self.first)
    }
}
