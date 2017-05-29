//
//  TableViewModel.swift
//  Debugging
//

import Foundation

public final class TableViewModel<T> {
  var items: [T] = []
  var queue: DispatchQueue

  public init() {
    queue = DispatchQueue(label: "xyz.swiftaveiro.queue",
                          qos: .userInteractive,
                          attributes: [],
                          autoreleaseFrequency: .inherit,
                          target: nil)
  }

  public var count: Int {
    return items.count
  }

  public func add(_ item: T) {
    queue.async {
      let oldCount = self.items.count
      self.items.insert(item, at: 0)
      assert(self.items.count > oldCount)
    }
  }

  public func remove(at index: Int) {
    queue.async {
      self.items.remove(at: index)
    }
  }

  public func item(at index: Int) -> T? {
    var item: T?
    queue.sync {
      if index < self.items.count {
        item = self.items[index]
      }
    }
    return item
  }

  public func reverse() {
    queue.async {
      self.items = self.items.reversed()
    }
  }
}
