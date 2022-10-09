//
//  ImageTextCollectionViewCellReactor.swift
//  Diffable-Datasource-ReactorKit-Example
//
//  Created by SwiftMan on 2022/10/09.
//

import Foundation
import ReactorKit

final class ImageTextCollectionViewCellReactor: Reactor {
  let initialState: State

  init(cellModel: CellModel) {
    initialState = State(cellModel: cellModel)
  }

  enum Action {
    case update(CellModel)
  }

  enum Mutation {
    case update(CellModel)
  }

  struct State: Hashable {
    var cellModel: CellModel
  }

  func mutate(action: Action) -> Observable<Mutation> {
    switch action {
    case .update(let cellModel):
      return .just(.update(cellModel))
    }
  }
  func reduce(state: State, mutation: Mutation) -> State {
    var state = state
    switch mutation {
    case .update(let cellModel):
      state.cellModel = cellModel
      return state
    }
  }
}

extension ImageTextCollectionViewCellReactor: Hashable {
  static func == (lhs: ImageTextCollectionViewCellReactor, rhs: ImageTextCollectionViewCellReactor) -> Bool {
    lhs.currentState == rhs.currentState
  }

  func hash(into hasher: inout Hasher) {
    hasher.combine(currentState.cellModel.id)
  }
}
