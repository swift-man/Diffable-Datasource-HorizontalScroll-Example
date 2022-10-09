//
//  SectionHeaderReusableViewReactor.swift
//  Diffable-Datasource-ReactorKit-Example
//
//  Created by SwiftMan on 2022/10/09.
//

import Foundation
import ReactorKit

final class SectionHeaderReusableViewReactor: Reactor {
  let initialState: State

  init(sectionModel: SectionModel, cellReactors: [CellReactor]) {
    initialState = State(sectionModel: sectionModel, cellReactors: cellReactors)
  }

  enum Action {
    case append(CellModel)
    case edit(CellReactor, CellModel)
    case remove(CellReactor)
  }

  enum Mutation {
    case append(CellModel)
    case edit(CellReactor, CellModel)
    case remove(CellReactor)
  }

  struct State: Hashable {
    let sectionModel: SectionModel
    var cellReactors: [CellReactor]

    var subtitle: String {
      "\(cellReactors.count)"
    }
  }

  func mutate(action: Action) -> Observable<Mutation> {
    switch action {
    case .append(let cellModel):
      return .just(.append(cellModel))
    case let .edit(cellReactor, cellModel):
      return .just(.edit(cellReactor, cellModel))
    case .remove(let cellReactor):
      return .just(.remove(cellReactor))
    }
  }

  func reduce(state: State, mutation: Mutation) -> State {
    var state = state
    switch mutation {
    case .append(let cellModel):
      state.cellReactors.append(CellReactor(cellModel: cellModel))
      return state
    case let .edit(cellReactor, cellModel):
      let findByCellReactor = state.cellReactors.first(where: { $0 == cellReactor })
      findByCellReactor?.action.onNext(.update(cellModel))

      return state
    case .remove(let cellReactor):
      state.cellReactors.removeAll(where: { $0 == cellReactor })
      return state
    }
  }
}

extension SectionHeaderReusableViewReactor: Hashable {
  static func == (lhs: SectionHeaderReusableViewReactor, rhs: SectionHeaderReusableViewReactor) -> Bool {
    lhs.currentState == rhs.currentState
  }

  func hash(into hasher: inout Hasher) {
    hasher.combine(currentState.sectionModel.id)
  }
}
