//
//  MainViewReactor.swift
//  Diffable-Datasource-HorizontalScroll-Test
//
//  Created by SwiftMan on 2022/10/09.
//

import Foundation
import ReactorKit

typealias SectionReactor = SectionHeaderReusableViewReactor
typealias CellReactor = ImageTextCollectionViewCellReactor

final class MainViewReactor: Reactor {
  let initialState = State()

  enum Action {
  }

  enum Mutation {
  }
  struct State {
    var sectionReactors = SectionHeaderReusableViewReactor.allSectionReactors
  }

  func mutate(action: Action) -> Observable<Mutation> {
    return .empty()
  }

  func reduce(state: State, mutation: Mutation) -> State {
   return state
  }
}
