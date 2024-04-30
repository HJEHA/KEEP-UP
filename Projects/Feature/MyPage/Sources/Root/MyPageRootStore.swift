//
//  MyPageRootStore.swift
//  FeatureMyPage
//
//  Created by 황제하 on 4/9/24.
//

import Foundation
import SwiftData

import ComposableArchitecture

import FeatureMyPageInterface
import FeatureOnboardingInterface
import DomainActivity
import DomainActivityInterface
import CoreUserDefaults
import SharedUtil

extension MyPageRootStore {
  public init(
    onboardingProfile: OnboardingProfileStore,
    onboardingAvatar: OnboardingAvatarStore
  ) {
    @Dependency(\.activityClient) var activityClient
    
    let reducer: Reduce<State, Action> = Reduce { state, action in
      switch action {
        case .appear:
          return .none
          
        case let .filterSelected(index):
          state.filterIndex = index
          
          return .send(.fetch)
          
        case let .calendar(action):
          switch action {
            case let .selectedDate(date):
              state.selectedDate = date
              return .send(.fetch)
            default:
              return .none
          }
          
        case .fetch:
          let date = DateUtil.shared.toYearMonthDay(from: state.selectedDate)
          var predicate: Predicate<Activity>
          if let mode = MeasurementFilter.toMeasurementMode(state.filterIndex) {
            predicate = {
              return #Predicate {
                $0.dateString == date
                && $0.measurementTitle == mode.title
              }
            }()
          } else {
            predicate = {
              return #Predicate {
                $0.dateString == date
              }
            }()
          }
          
          let descriptor: FetchDescriptor<Activity> = .init(
            predicate: predicate,
            sortBy: [
              .init(\.date, order: .reverse)
            ]
          )
          
          do {
            state.activities = try activityClient.fetch(descriptor)
          } catch {
            state.activities = []
          }
          
          return .none
          
        case .editProfileButtonTapped:
          state.onboardingProfile = .init(
            name: JaalUserDefaults.name,
            isEdit: true
          )
          return .none
        
        case .editAvatarButtonTapped:
          state.onboardingAvatar = .init(
            skinID: JaalUserDefaults.skinID,
            headID: JaalUserDefaults.headID,
            faceID: JaalUserDefaults.faceID,
            isEdit: true
          )
          return .none
          
        case .onboardingProfile(.presented(.doneButtonTapped)):
          JaalUserDefaults.name = state.onboardingProfile?.name ?? ""
          state.onboardingProfile = nil
          return .none
          
        case .onboardingAvatar(.presented(.doneButtonTapped)):
          JaalUserDefaults.skinID = state.onboardingAvatar?.skinID ?? 0
          JaalUserDefaults.headID = state.onboardingAvatar?.headID ?? 0
          JaalUserDefaults.faceID = state.onboardingAvatar?.faceID ?? 0
          state.onboardingAvatar = nil
          return .none
          
        default:
          return .none
      }
    }
    
    self.init(
      reducer: reducer,
      calender: CalendarStore(),
      activityDetail: ActivityDetailStore(),
      onboardingProfile: onboardingProfile,
      onboardingAvatar: onboardingAvatar
    )
  }
}
