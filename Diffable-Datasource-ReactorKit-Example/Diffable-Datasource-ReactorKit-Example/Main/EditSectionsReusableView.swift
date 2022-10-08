//
//  EditSectionsReusableView.swift
//  Diffable-Datasource-ReactorKit-Example
//
//  Created by SwiftMan on 2022/10/09.
//

import RxCocoa
import RxSwift
import UIKit

final class EditSectionsReusableView: UICollectionReusableView {
  static let elementKind = "EditSectionsReusableView"

  var disposeBag = DisposeBag()

  private let plusButton = UIButton(type: .custom).then {
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.setImage(UIImage(systemName: "plus"), for: .normal)
  }

  lazy var plusButtonTap = plusButton.rx.tap

  override init(frame: CGRect) {
    super.init(frame: frame)

    backgroundColor = .systemBackground
    configurePlusButton()
  }

  @available(*, unavailable)
  required init?(coder: NSCoder) {
    preconditionFailure("init(coder:) has not been implemented")
  }

  override func prepareForReuse() {
    super.prepareForReuse()

    disposeBag = DisposeBag()
  }
}

extension EditSectionsReusableView {
  private func configurePlusButton() {
    addSubview(plusButton)
    NSLayoutConstraint.activate([
      plusButton.centerXAnchor.constraint(equalTo: centerXAnchor),
      plusButton.centerYAnchor.constraint(equalTo: centerYAnchor),
      plusButton.widthAnchor.constraint(equalToConstant: 23),
      plusButton.heightAnchor.constraint(equalToConstant: 23)
    ])
  }
}
