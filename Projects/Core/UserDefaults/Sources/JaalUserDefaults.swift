//
//  JaalUserDefaults.swift
//  CoreUserDefaults
//
//  Created by 황제하 on 4/24/24.
//

import Foundation

@propertyWrapper
public struct UserDefault<T> {
  let key: String
  let defaultValue: T
  let storage: UserDefaults
  
  public var wrappedValue: T {
    get {
      guard let value = storage.object(forKey: key) else {
        return defaultValue
      }
      
      return value as? T ?? defaultValue
    }
    set {
      if let value = newValue as? OptionalProtocol, value.isNil() {
        storage.removeObject(forKey: key)
      } else {
        storage.set(newValue, forKey: key)
      }
    }
  }
  
  init(
    key: String,
    defaultValue: T,
    storage: UserDefaults = .standard
  ) {
    self.key = key
    self.defaultValue = defaultValue
    self.storage = storage
  }
}

fileprivate protocol OptionalProtocol {
  func isNil() -> Bool
}

extension Optional : OptionalProtocol {
  func isNil() -> Bool {
    return self == nil
  }
}

public struct JaalUserDefaults {
  @UserDefault(key: "isOnboarding", defaultValue: false)
  public static var isOnboarding: Bool
  
  @UserDefault(key: "headID", defaultValue: 0)
  public static var headID: Int
  
  @UserDefault(key: "faceID", defaultValue: 0)
  public static var face: Int
}