//
//  CollectionViewCell.swift
//  Diffable-Datasource-HorizontalScroll-Test
//
//  Created by SwiftMan on 2022/10/07.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
  let imageView = UIImageView()
  let titleLabel = UILabel()
  static let reuseIdentifier = "title-supplementary-reuse-identifier"
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    configure()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  var cellModel: CellModel? {
    didSet {
      imageView.image = cellModel?.image
      titleLabel.text = cellModel?.title
    }
  }
}

extension CollectionViewCell {
  func configure() {
    titleLabel.translatesAutoresizingMaskIntoConstraints = false
    contentView.addSubview(titleLabel)
    
    NSLayoutConstraint.activate([
      titleLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
      titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
    ])
    
    contentView.backgroundColor = .systemGray
    contentView.layer.borderWidth = 1
    contentView.layer.cornerRadius = 4
  }
}
