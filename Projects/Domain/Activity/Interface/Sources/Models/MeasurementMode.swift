//
//  MeasurementMode.swift
//  DomainActivityInterface
//
//  Created by 황제하 on 4/9/24.
//

import Foundation

public enum MeasurementMode: Codable {
  case normal
  case focus
  
  public var title: String {
    switch self {
      case .normal:
        return "일반 모드"
      case .focus:
        return "집중 모드"
    }
  }
}
