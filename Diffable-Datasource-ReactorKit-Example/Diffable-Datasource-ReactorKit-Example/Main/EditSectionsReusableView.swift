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

  private let lineView = UIView().then {
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.backgroundColor = UIColor(named: "Text-Dark")
  }

  private let plusButton = UIButton(type: .custom).then {
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.setImage(UIImage(systemName: "plus"), for: .normal)
    $0.setTitle("Edit", for: .normal)
    $0.setTitleColor(UIColor(named: "Text-Gray"), for: .normal)
    $0.titleLabel?.font = .systemFont(ofSize: 14)
  }

  lazy var plusButtonTap = plusButton.rx.tap

  override init(frame: CGRect) {
    super.init(frame: frame)

    backgroundColor = .systemBackground
    configureLineView()
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
  private func configureLineView() {
    addSubview(lineView)
    NSLayoutConstraint.activate([
      lineView.topAnchor.constraint(equalTo: topAnchor),
      lineView.trailingAnchor.constraint(equalTo: trailingAnchor),
      lineView.leadingAnchor.constraint(equalTo: leadingAnchor),
      lineView.heightAnchor.constraint(equalToConstant: 1)
    ])
  }

  private func configurePlusButton() {
    addSubview(plusButton)
    NSLayoutConstraint.activate([
      plusButton.centerXAnchor.constraint(equalTo: centerXAnchor),
      plusButton.topAnchor.constraint(equalTo: topAnchor, constant: 30)
    ])
  }
}
