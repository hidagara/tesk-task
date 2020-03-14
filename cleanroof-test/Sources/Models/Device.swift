//
//  Device.swift
//  cleanroof-test
//
//  Created by Roman Guseynov on 12.03.2020.
//  Copyright © 2020 Roman Guseynov. All rights reserved.
//

import Foundation
import Firebase

struct Device {
  let ref: DatabaseReference?
  let uuid: String
  let name: String
  let model: String
  let os: String
  
  init(uuid: String, name: String, model: String, os: String) {
    self.ref = nil
    self.uuid = uuid
    self.name = name
    self.model = model
    self.os = os
  }
  
  init?(snapshot: DataSnapshot) {
    guard let value = snapshot.value as? [String : AnyObject],
      let name = value["name"] as? String,
      let model = value["model"] as? String,
      let os = value["os"] as? String
      else { return nil }
    self.ref = snapshot.ref
    self.name = name
    self.model = model
    self.os = os
    self.uuid = "DDD"
  }
  
  init(object: AnyObject) {
    self.ref = nil
    self.model = object["model"] as? String ?? "Unknown Model"
    self.os = object["os"] as? String ?? "Unknown os"
    self.name = object["name"] as? String ?? "Unknown name"
    self.uuid = object["uuid"] as? String ?? "Unknown key"
  }
  
  func toAnyObject() -> Any {
    return [
      "name": name,
      "model": model,
      "os": os,
      "uuid": uuid
    ]
  }
  
}
