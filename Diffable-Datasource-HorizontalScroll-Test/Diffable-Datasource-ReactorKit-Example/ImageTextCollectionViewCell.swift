//
//  CollectionViewCell.swift
//  Diffable-Datasource-HorizontalScroll-Test
//
//  Created by SwiftMan on 2022/10/07.
//

import UIKit
import ReactorKit

final class ImageTextCollectionViewCell: UICollectionViewCell, View {
  var disposeBag = DisposeBag()
  private let imageView = UIImageView()
  private let titleLabel = UILabel()

  override init(frame: CGRect) {
    super.init(frame: frame)

    configureTitleLabel()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
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
  private func configureTitleLabel() {
    titleLabel.translatesAutoresizingMaskIntoConstraints = false
    contentView.addSubview(titleLabel)

    NSLayoutConstraint.activate([
      titleLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
      titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
    ])

    contentView.backgroundColor = .systemGray
    contentView.layer.borderWidth = 1
    contentView.layer.cornerRadius = 4
  }
}
