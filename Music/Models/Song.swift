//
//  Song.swift
//  Music
//
//  Created by nguyen.van.duyb on 4/9/24.
//

import Foundation

struct Song {
    let name: String
    let fileName: String
    let performer: String
    let thumbnail: String
    
    static func getPlaylist() -> [Song] {
        var songs: [Song] = []
        songs.append(Song(name: "Em luôn ở trong tâm trí anh", fileName: "EmLuonOTrongTamTriAnh", performer: "The Men", thumbnail: "emluonotrongtamtrianhpicture"))
        songs.append(Song(name: "Hãy để anh yêu em lần nữa", fileName: "HayDeAnhYeuEmLanNua", performer: "The Men", thumbnail: "haydeanhyeuemlannuapicture"))
        songs.append(Song(name: "Lời anh muốn nói", fileName: "LoiAnhMuonNoi", performer: "The Men", thumbnail: "loianhmuonnoipicture"))
        songs.append(Song(name: "Ngọt ngào và đắng cay", fileName: "NgotNgaoVaDangCay", performer: "The Men", thumbnail: "ngotngaovadangcaypicture"))
        songs.append(Song(name: "Người ấy", fileName: "Nguoiay", performer: "Trịnh Thăng Bình", thumbnail: "nguoiaypicture"))
        songs.append(Song(name: "Yêu lại từ đầu", fileName: "EmLuonOTrongTamTriAnh", performer: "Khắc Việt", thumbnail: "yeulaitudaupicture"))
        return songs
    }
}
