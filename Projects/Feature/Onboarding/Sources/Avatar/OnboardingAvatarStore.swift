//
//  OnboardingAvatarStore.swift
//  FeatureOnboardingInterface
//
//  Created by 황제하 on 4/26/24.
//

import Foundation

import ComposableArchitecture

import FeatureOnboardingInterface
import CoreUserDefaults

extension OnboardingAvatarStore {
  public init() {
    
    let reducer: Reduce<State, Action> = Reduce { state, action in
      switch action {
        case .binding:
          return .none
        case .onAppear:
          return .none
        case .doneButtonTapped:
          JaalUserDefaults.skinID = state.skinID
          JaalUserDefaults.headID = state.headID
          JaalUserDefaults.faceID = state.faceID
          JaalUserDefaults.isOnboarding = false
          return .run { send in
            await send(.goToMain)
          }
        case .goToMain:
          return .none
      }
      
    }
    
    self.init(reducer: reducer)
  }
}