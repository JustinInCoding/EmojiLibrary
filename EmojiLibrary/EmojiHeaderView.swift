//
//  EmojiHeaderView.swift
//  EmojiLibrary
//
//  Created by Justin on 2024/3/28.
//

import UIKit

class EmojiHeaderView: UICollectionReusableView {
	@IBOutlet weak var textLabel: UILabel!
	static let reuseIdentifier = String(describing: EmojiHeaderView.self)
}
