//
//  MusicPlayerManager.swift
//  MusicApp(final_project)
//
//  Created by yunus on 12.05.2025.
//
import SwiftUI
import AVFoundation

class MusicPlayerManager: ObservableObject {
    @Published var audioPlayer: AVPlayer?
    @Published var currentTrack: TrackItem? = nil
    @Published var isPlaying: Bool = false
    @Published var playbackProgress: Double = 0.0 // от 0.0 до 1.0
    @Published var currentTime: TimeInterval = 0.0
    @Published var duration: TimeInterval = 0.0
    let service = YandexApiServices()

    private var timeObserverToken: Any?

    func playTrack(_ track: TrackItem) async {
        stopAndClearPlayer()

        guard let url = URL(string: "https://ios-advanced-backend.onrender.com/stream/\(track.track.id)?apiKey=ios-advanced") else {
            print("Invalid URL")
            return
        }

        let playerItem = AVPlayerItem(url: url)
        DispatchQueue.main.async {
            self.audioPlayer = AVPlayer(playerItem: playerItem)

            self.duration = TimeInterval(track.track.durationMs) / 1000.0

            self.timeObserverToken = self.audioPlayer?.addPeriodicTimeObserver(forInterval: CMTime(seconds: 0.5, preferredTimescale: CMTimeScale(NSEC_PER_SEC)), queue: .main) { [weak self] time in
                guard let self = self, self.duration > 0 else { return }
                self.currentTime = time.seconds
                self.playbackProgress = time.seconds / self.duration
            }

            NotificationCenter.default.addObserver(self,
                                                   selector: #selector(self.playerDidFinishPlaying),
                                                   name: .AVPlayerItemDidPlayToEndTime,
                                                   object: playerItem)

            self.audioPlayer?.play()
            self.currentTrack = track
            self.isPlaying = true
            print("MusicPlayerManager: playTrack - SET currentTrack to \(track.track.title), isPlaying: \(self.isPlaying)")
        }
    }

    func togglePlayPause() {
        guard audioPlayer != nil else { return }
        if isPlaying {
            audioPlayer?.pause()
        } else {
            audioPlayer?.play()
        }
        isPlaying.toggle()
    }

    func seek(to progress: Double) { // progress от 0.0 до 1.0
        guard let player = audioPlayer, duration > 0 else { return }
        let targetTime = CMTime(seconds: progress * duration, preferredTimescale: CMTimeScale(NSEC_PER_SEC))
        player.seek(to: targetTime)
    }
    
    private func stopAndClearPlayer() {
        audioPlayer?.pause()
        if let token = timeObserverToken {
            audioPlayer?.removeTimeObserver(token)
            timeObserverToken = nil
        }
        NotificationCenter.default.removeObserver(self, name: .AVPlayerItemDidPlayToEndTime, object: audioPlayer?.currentItem)
        audioPlayer = nil
        isPlaying = false
        playbackProgress = 0.0
        currentTime = 0.0
        duration = 0.0
        // currentTrack не сбрасываем здесь, чтобы MiniPlayer оставался видимым с последним треком
    }
    
    @objc private func playerDidFinishPlaying(note: NSNotification) {
        DispatchQueue.main.async {
            self.isPlaying = false
            self.playbackProgress = 1.0 // или 0.0, если нужно сбросить
            // Здесь можно добавить логику для авто-переключения на следующий трек
        }
    }

    // Очистка при деинициализации
    deinit {
        stopAndClearPlayer()
    }
}
