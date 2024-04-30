//
//  MyPageRootView.swift
//  FeatureMyPageInterface
//
//  Created by 황제하 on 4/9/24.
//

import SwiftUI

import ComposableArchitecture

import FeatureOnboardingInterface
import DomainActivityInterface
import SharedDesignSystem

public struct MyPageRootView: View {
  @Bindable private var store: StoreOf<MyPageRootStore>
  private var viewStore: ViewStoreOf<MyPageRootStore>
  
  public init(store: StoreOf<MyPageRootStore>) {
    self.store = store
    self.viewStore = ViewStore(store, observe: { $0 })
  }
  
  public var body: some View {
    NavigationStack(
      path: $store.scope(
        state: \.path,
        action: \.path
      )
    ) {
      VStack(alignment: .leading) {
        HStack {
          title
          
          Spacer()
          
          menu
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 8)
        
        CalendarView(
          store: store.scope(
            state: \.calendar,
            action: \.calendar
          )
        )
        .padding(.vertical, 8)
        
        measurementFilter
          .padding(.horizontal, 16)
          .padding(.vertical, 8)
        
        if store.activities.count > 0 {
          activitys
          
          Spacer()
        } else {
          JaalEmptyView(
            description: "앗! 측정 기록이 없습니다."
          )
        }
      }
      .background(SharedDesignSystemAsset.gray100.swiftUIColor)
      .onAppear {
        store.send(.appear)
      }
    } destination: { store in
      ActivityDetailView(store: store)
        .toolbarRole(.editor)
    }
    .tint(SharedDesignSystemAsset.blue.swiftUIColor)
    .sheet(
      item: $store.scope(
        state: \.onboardingProfile,
        action: \.onboardingProfile
      )
    ) { store in
      OnboardingProfileView(store: store)
    }
    .sheet(
      item: $store.scope(
        state: \.onboardingAvatar,
        action: \.onboardingAvatar
      )
    ) { store in
      OnboardingAvatarView(store: store)
    }
  }
}


extension MyPageRootView {
  private var title: some View {
    Text("마이페이지")
      .modifier(GamtanFont(font: .bold, size: 24))
  }
  
  private var menu: some View {
    Menu {
      Button("프로필 변경") {
        store.send(.editProfileButtonTapped)
      }
      Button("아바타 변경") {
        store.send(.editAvatarButtonTapped)
      }
      
      Divider()
      
      Button(role: .destructive) {
      } label: {
        Label("초기화", systemImage: "trash")
      }
    } label: {
      Image(systemName: "ellipsis.circle")
        .resizable()
        .frame(width: 20, height: 20)
    }
  }
  
  private var measurementFilter: some View {
    CustomSegmentedControl(
      selection: viewStore.binding(
        get: \.filterIndex,
        send: MyPageRootStore.Action.filterSelected
      ),
      size: CGSize(width: UIScreen.main.bounds.width - 32, height: 52),
      segmentLabels: MeasurementFilter.allCases.map { $0.title }
    )
  }
  
  private var activitys: some View {
    ScrollView(.vertical) {
      VStack(spacing: 8) {
        ForEach(store.activities) { activity in
          NavigationLink(
            state: ActivityDetailStore.State(activity: activity)
          ) {
            ActivityCell(activity: activity)
          }
        }
      }
      .padding(.bottom, 40)
    }
  }
}
