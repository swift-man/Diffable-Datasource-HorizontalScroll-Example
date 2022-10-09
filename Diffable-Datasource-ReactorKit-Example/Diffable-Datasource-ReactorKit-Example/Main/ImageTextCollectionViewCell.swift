//
//  CollectionViewCell.swift
//  Diffable-Datasource-ReactorKit-Example
//
//  Created by SwiftMan on 2022/10/07.
//

import ReactorKit
import Then
import UIKit

final class ImageTextCollectionViewCell: UICollectionViewCell, View {
  var disposeBag = DisposeBag()
  private let imageView = UIImageView().then {
    $0.translatesAutoresizingMaskIntoConstraints = false
  }
  private var imageViewCenterYLayoutConstraint: NSLayoutConstraint?
  private var imageViewBottomLayoutConstraint: NSLayoutConstraint?

  private let titleLabel = UILabel().then {
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.font = .systemFont(ofSize: 14)
    $0.textColor = UIColor(named: "Text-Dark")
    $0.textAlignment = .center
  }
  override init(frame: CGRect) {
    super.init(frame: frame)

    configure()
    configureTitleLabel()
    configureImageView()
  }

  @available(*, unavailable)
  required init?(coder: NSCoder) {
    preconditionFailure("init(coder:) has not been implemented")
  }

  func bind(reactor: ImageTextCollectionViewCellReactor) {
    reactor.state.map { $0.cellModel.image }
      .distinctUntilChanged()
      .bind(to: imageView.rx.image)
      .disposed(by: disposeBag)

    reactor.state.map { $0.cellModel.title }
      .distinctUntilChanged()
      .bind(to: titleLabel.rx.text)
      .disposed(by: disposeBag)

    reactor.state.map { $0.cellModel.title }
      .map({ title -> Bool in
        if let title {
          return title.isEmpty
        }
        return true
      })
      .distinctUntilChanged()
      .observe(on: MainScheduler.instance)
      .subscribe(onNext: { [weak self] isHidden in
        guard let self else { return }
        self.titleLabel.isHidden = isHidden
        self.imageViewCenterYLayoutConstraint?.isActive = isHidden
        self.imageViewBottomLayoutConstraint?.isActive = !isHidden
      })
      .disposed(by: disposeBag)
  }
}

extension ImageTextCollectionViewCell {
  private func configure() {
    contentView.backgroundColor = UIColor(named: "CellBackground")
    contentView.layer.cornerRadius = 10
  }

  private func configureTitleLabel() {
    contentView.addSubview(titleLabel)

    NSLayoutConstraint.activate([
      titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
      titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
      titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
      titleLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
    ])
  }

  private func configureImageView() {
    contentView.addSubview(imageView)

    NSLayoutConstraint.activate([
      imageView.widthAnchor.constraint(equalToConstant: 18),
      imageView.heightAnchor.constraint(equalToConstant: 18),
      imageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
    ])

    imageViewCenterYLayoutConstraint = imageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
    imageViewBottomLayoutConstraint = imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16)
  }
}
