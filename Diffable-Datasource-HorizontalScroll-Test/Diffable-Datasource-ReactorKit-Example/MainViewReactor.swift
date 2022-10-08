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
    case append(SectionHeaderReusableViewReactor, CellModel)
  }

  enum Mutation {
    case append(SectionHeaderReusableViewReactor, CellModel)
  }
  struct State {
    var sectionReactors = SectionHeaderReusableViewReactor.allSectionReactors
  }

  func mutate(action: Action) -> Observable<Mutation> {
    switch action {

    case .append(let sectionReactor, let cellModel):
      return .just(.append(sectionReactor, cellModel))
    }
  }

  func reduce(state: State, mutation: Mutation) -> State {
    var state = state
    switch mutation {

    case .append(let sectionReactor, let cellModel):
      print("sss")

      var sectionReactors = state.sectionReactors

      var findBySectionReactor = state.sectionReactors.first(where: { $0 == sectionReactor })

//      findBySectionReactor = SectionReactor(sectionModel: <#T##SectionModel#>, cellReactors: <#T##[CellReactor]#>

      state.sectionReactors.first(where: { $0 == sectionReactor })?.action.onNext(.append(cellModel))
//      state.cellReactors.append(CellReactor(cellModel: cellModel))
      return state
    }
  }
}
