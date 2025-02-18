//
//  DataSource.swift
//  EmojiLibrary
//
//  Created by Justin on 2024/3/28.
//

import UIKit

class DataSource: NSObject, UICollectionViewDataSource {
	let emoji = Emoji.shared
	
	func numberOfSections(in collectionView: UICollectionView) -> Int {
		emoji.sections.count
	}
	
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		let category = emoji.sections[section]
		let emoji = self.emoji.data[category]
		
		return emoji?.count ?? 0
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		guard let emojiCell = collectionView.dequeueReusableCell(withReuseIdentifier: EmojiCell.reuseIdentifier, for: indexPath) as? EmojiCell else {
			fatalError("Cell cannot be created")
		}
		
		let category = emoji.sections[indexPath.section]
		let emoji = self.emoji.data[category]?[indexPath.item] ?? ""
		
		emojiCell.emojiLabel.text = emoji
		
		return emojiCell
	}
	
	func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
		guard let emojiHeaderView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: EmojiHeaderView.reuseIdentifier, for: indexPath) as? EmojiHeaderView else {
			fatalError("Cannot create EmojiHeaderView")
		}
		
		let category = emoji.sections[indexPath.section]
		emojiHeaderView.textLabel.text = category.rawValue
		
		return emojiHeaderView
	}
}

extension DataSource {
	func addEmoji(_ emoji: String, to category: Emoji.Category) {
		guard var emojiData = self.emoji.data[category] else { return }
		emojiData.append(emoji)
		self.emoji.data.updateValue(emojiData, forKey: category)
	}
	
	func deleteEmoji(at indexPath: IndexPath) {
		let category = emoji.sections[indexPath.section]
		guard var emojiData = emoji.data[category] else { return }
		emojiData.remove(at: indexPath.item)
		
		emoji.data.updateValue(emojiData, forKey: category)
	}
	
	func deleteEmoji(at indexPaths: [IndexPath]) {
		for path in indexPaths {
			deleteEmoji(at: path)
		}
	}
}
