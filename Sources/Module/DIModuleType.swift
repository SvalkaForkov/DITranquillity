//
//  DIModuleType.swift
//  DITranquillity
//
//  Created by Alexander Ivlev on 26/02/2017.
//  Copyright © 2017 Alexander Ivlev. All rights reserved.
//

#if ENABLE_DI_MODULE

class DIModuleType: Hashable {
  let name: String
  
  init(_ module: DIModule) {
    self.name = String(describing: type(of: module))
  }
  
  var hashValue: Int {
    return name.hashValue
  }
  
  static func ==(lhs: DIModuleType, rhs: DIModuleType) -> Bool {
    return lhs.name == rhs.name
  }
}

#endif