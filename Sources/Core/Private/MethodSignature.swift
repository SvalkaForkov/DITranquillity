//
//  MethodSignature.swift
//  DITranquillity
//
//  Created by Alexander Ivlev on 10/06/2017.
//  Copyright © 2017 Alexander Ivlev. All rights reserved.
//

class MethodSignature: Hashable {
  typealias Parameter = (type: Any.Type, style: DIResolveStyle)
  let parameters: [Parameter]
  let unique: String
  
  init(styles: [DIResolveStyle], types: [Any.Type]) {
    assert(styles.count == types.count || 0 == styles.count)
    var parameters: [Parameter] = []
    for i in 0..<types.count {
      let style = i < styles.count ? styles[i] : DIResolveStyle.default
      parameters.append((types[i], style))
    }
    self.parameters = parameters
    
    self.unique = parameters
      .filter{ $0.style == .arg }
      .map{ TypeKey($0.type).unique }
      .joined()
  }
  
  var hashValue: Int { return unique.hashValue }
  static func ==(lhs: MethodSignature, rhs: MethodSignature) -> Bool {
    return lhs.unique == rhs.unique
  }
}