//
//  SectionHeaderReusableViewReactor.swift
//  Diffable-Datasource-HorizontalScroll-Test
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
  }

  enum Mutation {
    case append(CellModel)
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
    }
  }

  func reduce(state: State, mutation: Mutation) -> State {
    var state = state
    switch mutation {
    case .append(let cellModel):
      state.cellReactors.append(CellReactor(cellModel: cellModel))
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

extension SectionHeaderReusableViewReactor {
  static var allSectionReactors: [SectionHeaderReusableViewReactor] = [
    SectionHeaderReusableViewReactor(sectionModel: SectionModel(title: "SwiftUI"), cellReactors: [
      CellReactor(cellModel: CellModel(title: "SwiftUI")),
      CellReactor(cellModel: CellModel(title: "SwiftUI1")),
      CellReactor(cellModel: CellModel(title: "SwiftUI2")),
      CellReactor(cellModel: CellModel(title: "SwiftUI3")),
      CellReactor(cellModel: CellModel(title: "SwiftUI4")),
      CellReactor(cellModel: CellModel(title: "SwiftUI5")),
      CellReactor(cellModel: CellModel(title: "SwiftUI6")),
      CellReactor(cellModel: CellModel(title: "SwiftUI7")),
      CellReactor(cellModel: CellModel(title: "SwiftUI8")),
      CellReactor(cellModel: CellModel(title: "SwiftUI9")),
      CellReactor(cellModel: CellModel(title: "SwiftUI10"))
    ]),
    SectionHeaderReusableViewReactor(sectionModel: SectionModel(title: "UIKit"), cellReactors: [
      CellReactor(cellModel: CellModel(title: "Demystifying", count: 26)),
      CellReactor(cellModel: CellModel(title: "Controls", count: 31))
    ]),
    SectionHeaderReusableViewReactor(sectionModel: SectionModel(title: "Frameworks"), cellReactors: [
      CellReactor(cellModel: CellModel(title: "iOS", count: 44)),
      CellReactor(cellModel: CellModel(title: "Beginning", count: 3))
    ]),
    SectionHeaderReusableViewReactor(sectionModel: SectionModel(title: "EmptySection"), cellReactors: []),
    SectionHeaderReusableViewReactor(sectionModel: SectionModel(title: "Miscellaneous"), cellReactors: [
      CellReactor(cellModel: CellModel(title: "Structures", count: 2)),
      CellReactor(cellModel: CellModel(title: "Beginning", count: 4)),
      CellReactor(cellModel: CellModel(title: "Machine", count: 1)),
      CellReactor(cellModel: CellModel(title: "Push", count: 3))
    ]),
    SectionHeaderReusableViewReactor(sectionModel: SectionModel(title: "SwiftUI"), cellReactors: [
      CellReactor(cellModel: CellModel(title: "SwiftUI")),
      CellReactor(cellModel: CellModel(title: "SwiftUI1")),
      CellReactor(cellModel: CellModel(title: "SwiftUI2")),
      CellReactor(cellModel: CellModel(title: "SwiftUI3")),
      CellReactor(cellModel: CellModel(title: "SwiftUI4")),
      CellReactor(cellModel: CellModel(title: "SwiftUI5")),
      CellReactor(cellModel: CellModel(title: "SwiftUI6")),
      CellReactor(cellModel: CellModel(title: "SwiftUI7")),
      CellReactor(cellModel: CellModel(title: "SwiftUI8")),
      CellReactor(cellModel: CellModel(title: "SwiftUI9")),
      CellReactor(cellModel: CellModel(title: "SwiftUI10"))
    ]),
    SectionHeaderReusableViewReactor(sectionModel: SectionModel(title: "UIKit"), cellReactors: [
      CellReactor(cellModel: CellModel(title: "Views", count: 26)),
      CellReactor(cellModel: CellModel(title: "Popular", count: 31))
    ]),
    SectionHeaderReusableViewReactor(sectionModel: SectionModel(title: "Frameworks"), cellReactors: [
      CellReactor(cellModel: CellModel(title: "for", count: 44)),
      CellReactor(cellModel: CellModel(title: "RxSwift", count: 3))
    ]),
    SectionHeaderReusableViewReactor(sectionModel: SectionModel(title: "EmptySection"), cellReactors: []),
    SectionHeaderReusableViewReactor(sectionModel: SectionModel(title: "Miscellaneous"), cellReactors: [
      CellReactor(cellModel: CellModel(title: "Data", count: 2)),
      CellReactor(cellModel: CellModel(title: "ARKit", count: 4)),
      CellReactor(cellModel: CellModel(title: "Learning", count: 1)),
      CellReactor(cellModel: CellModel(title: "Push", count: 3))
    ])
  ]
}
