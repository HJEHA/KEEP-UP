//
//  OnboardingIntroView.swift
//  FeatureOnboardingInterface
//
//  Created by 황제하 on 4/25/24.
//

import SwiftUI

import ComposableArchitecture

import SharedDesignSystem

public struct OnboardingIntroView: View {
  @Bindable private var store: StoreOf<OnboardingIntroStore>
  
  public init(store: StoreOf<OnboardingIntroStore>) {
    self.store = store
  }
  
  public var body: some View {
    VStack {
      onboardingIntroView
      
      Spacer()
      
      goToProfile
        .padding([.horizontal, .bottom], 16)
    }
    .ignoresSafeArea(.all, edges: .top)
    .background(SharedDesignSystemAsset.gray100.swiftUIColor)
    .onAppear {
      store.send(.onAppear)
    }
  }
}

extension OnboardingIntroView {
  private var onboardingIntroView: some View {
    VStack(spacing : 40) {
      TabView(
        selection: $store.tabViewIndex
      ) {
        makeTabView(SharedDesignSystemAsset.intro1.swiftUIImage)
          .tag(0)
        makeTabView(SharedDesignSystemAsset.intro2.swiftUIImage)
          .tag(1)
        makeTabView(SharedDesignSystemAsset.intro3.swiftUIImage)
          .tag(2)
      }
      .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
      .frame(height: 500)
      
      VStack(spacing : 12) {
        switch store.tabViewIndex {
          case 0:
            Text("\"KEEP UP\"를 통해서")
              .modifier(GamtanFont(font: .bold, size: 16))
              .foregroundColor(
                SharedDesignSystemAsset.gray700.swiftUIColor
              )
            
            Text("바른 자세로 앉아 있는지 \n확인할 수 있어요")
              .modifier(GamtanFont(font: .bold, size: 24))
              .foregroundColor(
                SharedDesignSystemAsset.gray900.swiftUIColor
              )
              .multilineTextAlignment(.center)
              
          case 1:
            Text("바른 자세 측정 후")
              .modifier(GamtanFont(font: .bold, size: 16))
              .foregroundColor(
                SharedDesignSystemAsset.gray700.swiftUIColor
              )
              
            Text("기록을 확인해보세요")
              .modifier(GamtanFont(font: .bold, size: 24))
              .foregroundColor(
                SharedDesignSystemAsset.gray900.swiftUIColor
              )
              
          case 2:
            Text("측정 중 저장된 이미지를")
              .modifier(GamtanFont(font: .bold, size: 16))
              .foregroundColor(
                SharedDesignSystemAsset.gray700.swiftUIColor
              )
              
            Text("타입랩스로 저장해서 \n공유해보세요")
              .modifier(GamtanFont(font: .bold, size: 24))
              .foregroundColor(
                SharedDesignSystemAsset.gray900.swiftUIColor
              )
              .multilineTextAlignment(.center)
            
            HStack(spacing: 2) {
              SharedDesignSystemAsset.info.swiftUIImage
                .renderingMode(.template)
                .resizable()
                .frame(width: 14, height: 14)
              
              Text("이미지는 기기에만 저장됩니다.")
                .modifier(GamtanFont(font: .bold, size: 14))
            }
            .foregroundColor(
              SharedDesignSystemAsset.orange.swiftUIColor
            )
            .padding(.top, 4)
            
              
          default:
            EmptyView()
        }
      }
    }
  }
  
  private func makeTabView(_ image: Image) -> some View {
    VStack {
      image
      
      Spacer()
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .background(SharedDesignSystemAsset.blue.swiftUIColor)
  }
  
  private var goToProfile: some View {
    Button(action: {
      store.send(.nextButtonTapped)
    }, label: {
      RoundedRectangle(cornerRadius: 16)
        .foregroundColor(
          SharedDesignSystemAsset.beige.swiftUIColor
        )
        .frame(height: 56)
        .overlay(
          HStack {
            Image(
              uiImage: store.tabViewIndex == 2
              ? SharedDesignSystemAsset.user.image
              : SharedDesignSystemAsset.play.image
            )
            .renderingMode(.template)
            .resizable()
            .frame(width: 20, height: 20)
            .foregroundColor(
              SharedDesignSystemAsset.orange.swiftUIColor
            )
            
            Text(store.nextButtonText)
              .modifier(GamtanFont(font: .bold, size: 18))
              .foregroundColor(
                SharedDesignSystemAsset.orange.swiftUIColor
              )
          }
        )
    })
  }
}
