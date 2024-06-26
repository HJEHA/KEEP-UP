//
//  PhotoDetailInterface.swift
//  FeatureRecordInterface
//
//  Created by 황제하 on 4/17/24.
//

import UIKit

import ComposableArchitecture

import SharedUtil

@Reducer
public struct PhotoDetailStore {
  private let reducer: Reduce<State, Action>
  
  public init(reducer: Reduce<State, Action>) {
    self.reducer = reducer
  }
  
  public enum CancelID {
    case throttle
  }
  
  @ObservableState
  public struct State: Equatable {
    public var names: [String]
    public var index: Int
    public var currentPage: Int
    public var closeDragHeight: Double = 0
    public var isDrag: Bool = false
    public var showSaveActionSheet: Bool = false
    public var isSaving: Bool = false
    public var isSaveSuccess: Bool = false
    public var showSaveSuccessAnimaion: Bool = false
    
    @Presents public var alert: AlertState<Action.Alert>?
    
    public var maxCount: Int {
      return names.count
    }
    
    public var backgroundOpacity: Double {
      return (1 - 0.002 * abs(closeDragHeight))
    }
    
    public init(names: [String], index: Int) {
      self.names = names
      self.index = index
      self.currentPage = index + 1
    }
  }
  
  public enum Action: Equatable {
    case onAppear
    case closeButtonTapped
    case closeDraged(Double)
    case startCloseDrag(Bool)
    
    case offsetChanged(CGFloat)
    case currentPage(Int)
    
    case saveButtonTapped(Bool)
    case saveOnlyPhotoButtonTapped
    case saveTimeLapseButtonTapped
    case savePhotoResponse(TaskResult<Bool>)
    case saveCompleted(Bool)
    case showSaveCompletionAnimation(Bool)
    
    case showGoToSettingAlert
    case alert(PresentationAction<Alert>)
    public enum Alert: Equatable {
      case goSettingTapped
      case cancelTapped
    }
  }
  
  public var body: some ReducerOf<Self> {
    reducer
      .ifLet(\.$alert, action: \.alert)
  }
}
