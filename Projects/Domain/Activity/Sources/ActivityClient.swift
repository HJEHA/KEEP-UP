//
//  ActivityClient.swift
//  DomainActivity
//
//  Created by 황제하 on 4/9/24.
//
import Foundation
import SwiftData

import ComposableArchitecture

import DomainActivityInterface

extension ActivityClient: DependencyKey {
  public static let liveValue = ActivityClient(
    context: {
      do {
        let container = try ModelContainer(for: Activity.self)
        let context = ModelContext(container)
        
        return context
      } catch {
        // TODO: 예외 처리
        fatalError()
      }
    },
    fetchAll: {
      do {
        let container = try ModelContainer(for: Activity.self)
        let context = ModelContext(container)
        let descriptor = FetchDescriptor<Activity>(sortBy: [SortDescriptor(\.date)])
        
        return try context.fetch(descriptor)
      } catch {
        return []
      }
    },
    fetch: { descriptor in
      do {
        let container = try ModelContainer(for: Activity.self)
        let context = ModelContext(container)
        
        return try context.fetch(descriptor)
      } catch {
        return []
      }
    },
    add: { model in
      do {
        let container = try ModelContainer(for: Activity.self)
        let context = ModelContext(container)
        
        context.insert(model)
      } catch {
        //TODO: - Error 처리
        return Void()
      }
    },
    delete: { model in
      do {
        let container = try ModelContainer(for: Activity.self)
        let context = ModelContext(container)
        
        context.delete(model)
      } catch {
        return Void()
      }
    },
    deleteAll: {
      do {
        let container = try ModelContainer(for: Activity.self)
        container.deleteAllData()
      } catch {
        return Void()
      }
    }
  )
}

public extension DependencyValues {
  var activityClient: ActivityClient {
    get { self[ActivityClient.self] }
    set { self[ActivityClient.self] = newValue }
  }
}
