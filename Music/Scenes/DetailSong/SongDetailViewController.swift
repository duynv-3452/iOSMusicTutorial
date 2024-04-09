//
//  SongDetailViewController.swift
//  Music
//
//  Created by nguyen.van.duyb on 4/9/24.
//

import UIKit
import AVFoundation
import MediaPlayer

final class SongDetailViewController: UIViewController {
    
    @IBOutlet private weak var songImageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var performerLabel: UILabel!
    @IBOutlet private weak var slider: UISlider!
    @IBOutlet private weak var playPauseButton: UIButton!
    private var songs = [Song]()
    private var player: AVAudioPlayer?
    private var isPlaying = true
    var currentIndex = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    override  func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.prefersLargeTitles = true
        player?.stop()
    }
    
    private func configure() {
        let url = Bundle.main.path(forResource: songs[currentIndex].fileName, ofType: "mp3")
        do {
            let session = AVAudioSession.sharedInstance()
            try session.setMode(.default)
            try session.setActive(true, options: .notifyOthersOnDeactivation)
            guard let url = url else { return }
            player = try AVAudioPlayer(contentsOf: URL(string: url) ?? URL(fileURLWithPath: ""))
            guard let player = player else { return }
            player.play()
        } catch {
            print("ERROR: \(error)")
        }
        let currentSong = songs[currentIndex]
        songImageView.image = UIImage(named: currentSong.thumbnail)
        titleLabel.text = currentSong.name
        performerLabel.text = currentSong.performer
        slider.maximumValue = Float(player?.duration ?? 0)
        
        slider.addTarget(self, action: #selector(didSlideSlider(_:)), for: .valueChanged)
        Timer.scheduledTimer(timeInterval: 0.0, target: self, selector: #selector(updateSlider), userInfo: nil, repeats: true)
    }
    
    func configSong(songs: [Song], index: Int) {
        self.songs = songs
        self.currentIndex = index
    }
    
    override func remoteControlReceived(with event: UIEvent?) {
        guard let type = event?.subtype else { return }
        switch type {
        case .remoteControlPlay:
            player?.play()
        case .remoteControlPause:
            player?.pause()
        case .remoteControlStop:
            player?.stop()
        case .remoteControlNextTrack:
            if (currentIndex < songs.count - 1) {
                currentIndex += 1
            } else {
                currentIndex = 0
            }
            configure()
        case .remoteControlPreviousTrack:
            if (currentIndex > 0) {
                currentIndex -= 1
            } else {
                currentIndex = songs.count - 1
            }
            configure()
        default:
            break
        }
    }
    
    @objc
    private func didSlideSlider(_ slider: UISlider) {
        player?.currentTime = TimeInterval(slider.value)
        player?.prepareToPlay()
    }
    
    @objc
    private func updateSlider() {
        slider.value = Float(player?.currentTime ?? 0)
    }
    
    @IBAction func tappedPlayPauseButton(_ sender: Any) {
        if let player = player {
            if isPlaying {
                player.pause()
            } else {
                player.play()
            }
        }
        isPlaying = !isPlaying
        playPauseButton.setImage(UIImage(named: isPlaying
                                         ? "pause"
                                         : "play"),
                                 for: .normal)
    }
    
    @IBAction func tappedPreviousButton(_ sender: Any) {
        if currentIndex > 0 {
            currentIndex -= 1
        } else {
            currentIndex = songs.count - 1
        }
        setImagePlayButton()
    }
    
    @IBAction func tappedNextButton(_ sender: Any) {
        if currentIndex < songs.count - 1 {
            currentIndex += 1
        } else {
            currentIndex = 0
        }
        setImagePlayButton()
    }
    
    private func setImagePlayButton() {
        isPlaying = true
        playPauseButton.setImage(UIImage(named: isPlaying
                                         ? "pause"
                                         : "play"),
                                 for: .normal)
        configure()
    }
}
