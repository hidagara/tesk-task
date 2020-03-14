//
//  DeviceList.swift
//  cleanroof-test
//
//  Created by Roman Guseynov on 14.03.2020.
//  Copyright © 2020 Roman Guseynov. All rights reserved.
//

import Foundation
import Firebase
struct DeviceList: Collection {
  var elements: [Device]
  let ref: DatabaseReference?
  
  // MARK: Collection protocol
  typealias Index = Array<Device>.Index
  typealias Element = Device
  
  var startIndex: Index { return elements.startIndex }
  var endIndex: Index { return elements.endIndex }
  
  subscript(index: Index) -> Element {
    get { return elements[index] }
  }
  
  func index(after i: Index) -> Index {
    return elements.index(after: i)
  }
  
  
  // MARK: Init
  init(elements: [Device]) {
    self.ref = nil
    self.elements = elements
  }
  
  init?(snapshot: DataSnapshot) {
    guard let value = snapshot.value as? [String : AnyObject],
      let devices = value["devices"] as? [String : AnyObject]
      else { return nil }
    self.ref = snapshot.ref
    var resultArray = [Device]()
    
    for device in devices {
      resultArray.append(.init(object: device.value))
    }
    self.elements = resultArray
  }
}

