//
//  CollectionViewCell.swift
//  Diffable-Datasource-ReactorKit-Example
//
//  Created by SwiftMan on 2022/10/07.
//

import ReactorKit
import UIKit

final class ImageTextCollectionViewCell: UICollectionViewCell, View {
  var disposeBag = DisposeBag()
  private let imageView = UIImageView()
  private let titleLabel = UILabel()

  override init(frame: CGRect) {
    super.init(frame: frame)

    configure()
    configureTitleLabel()
  }

  @available(*, unavailable)
  required init?(coder: NSCoder) {
    preconditionFailure("init(coder:) has not been implemented")
  }

  func bind(reactor: ImageTextCollectionViewCellReactor) {
    reactor.state.map { $0.cellModel.image }
      .bind(to: imageView.rx.image)
      .disposed(by: disposeBag)

    reactor.state.map { $0.cellModel.title }
      .bind(to: titleLabel.rx.text)
      .disposed(by: disposeBag)
  }
}

extension ImageTextCollectionViewCell {
  private func configure() {
    contentView.backgroundColor = .systemGray
    contentView.layer.borderWidth = 1
    contentView.layer.cornerRadius = 4
  }

  private func configureTitleLabel() {
    titleLabel.translatesAutoresizingMaskIntoConstraints = false
    contentView.addSubview(titleLabel)

    NSLayoutConstraint.activate([
      titleLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
      titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
    ])
  }
}
