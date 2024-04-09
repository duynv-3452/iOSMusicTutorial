//
//  SongTableViewCell.swift
//  Music
//
//  Created by nguyen.van.duyb on 4/9/24.
//

import UIKit

class SongTableViewCell: UITableViewCell {
    @IBOutlet weak var songImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var performerLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configView()
    }
    
    private func configView() {
        selectionStyle = .none
    }
    
    func configCell(song: Song) {
        songImageView.image = UIImage(named: song.thumbnail)
        titleLabel.text = song.name
        performerLabel.text = song.performer
    }
}
