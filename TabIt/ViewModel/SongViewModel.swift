//
//  SongViewModel.swift
//  TabIt
//
//  Created by Zelyna Sillas on 7/11/23.
//

import AVFoundation
import SwiftUI

class SongViewModel: NSObject, ObservableObject, AVAudioRecorderDelegate {
    private var recordingSession: AVAudioSession!
    private var audioRecorder: AVAudioRecorder?

    @Published var songTitle: String?
    @Published var songArtist: String?
    @Published var hasError = false
    
    @Published var isListening = false
    @Published var isWorking = false
    @Published var isIdentified = false

    @Published var countdown: Int = 10
    @Published var contentScale: CGFloat = 1.0
    private var countdownTimer: Timer?

    private let api = AudDAPI()

    func setupAudioSession() {
        recordingSession = AVAudioSession.sharedInstance()

        do {
            try recordingSession.setCategory(.playAndRecord, mode: .default, options: [])
            try recordingSession.setActive(true)
        } catch {
            print("Failed to setup audio session: \(error)")
        }
    }

    func startRecording() {
        isListening = true

        guard let audioFileURL = getDocumentsDirectory()?.appendingPathComponent("recording.wav") else {
            print("Failed to get audio file URL")
            return
        }

        let settings = [
            AVFormatIDKey: Int(kAudioFormatLinearPCM),
            AVSampleRateKey: 44100.0,
            AVNumberOfChannelsKey: 2,
            AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
        ] as [String: Any]

        do {
            audioRecorder = try AVAudioRecorder(url: audioFileURL, settings: settings)
            audioRecorder?.delegate = self
            audioRecorder?.record(forDuration: 10)
            startCountdown()

        } catch {
            print("Failed to start audio recording: \(error)")
        }
    }

    private func startCountdown() {
        countdown = 10

        countdownTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] timer in
            guard let self = self else { return }

            self.countdown -= 1
            if self.countdown <= 0 {
                timer.invalidate() // Clean up the countdownTimer
                self.countdownTimer = nil // Clean up the countdownTimer

                // The 10-second timer has ended, stop the recording
                self.stopRecording()
            }

            withAnimation(.easeInOut(duration: 0.5)) {
                self.contentScale = 1.5
            }

            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
                guard let self = self else { return }

                withAnimation(.easeInOut(duration: 0.5)) {
                    self.contentScale = 1.0
                }
            }
        }
    }

    private func stopRecording() {
        audioRecorder?.stop() // Stop the audio recording
        audioRecorder = nil // Clean up the audioRecorder
    }
    
    func stopAudioSession() {
        do {
            try recordingSession.setActive(false)
        } catch {
            print("Failed to deactivate audio session: \(error)")
        }
    }

    private func getDocumentsDirectory() -> URL? {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths.first
    }

    private func recognizeSongFromFileURL(_ fileURL: URL) {
        do {
            let fileData = try Data(contentsOf: fileURL)
            api.recognizeSongFromFile(fileData: fileData) { [weak self] result in
                guard let self = self else { return }

                self.isWorking = false

                switch result {
                case .success(let songInfo):
                    
                    if let responseData = try? JSONEncoder().encode(songInfo) {
                        if let responseString = String(data: responseData, encoding: .utf8) {
                            print("API Response: \(responseString)")
                        }
                    }
                    
                    DispatchQueue.main.async {
                        if let title = songInfo.result?.title, let artist = songInfo.result?.artist {
                            self.songTitle = title
                            self.songArtist = artist
                            self.isIdentified = true
                            self.hasError = false
                        } else {
                            self.hasError = true
                        }
                    }
                case .failure(let error):
                    DispatchQueue.main.async {
                        self.hasError = true
                    }
                    print("Failed to recognize song: \(error)")
                }
            }
        } catch {
            DispatchQueue.main.async {
                self.hasError = true
            }
            print("Failed to read file data: \(error)")
        }
    }

    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        if flag {
            let audioFileURL = recorder.url
            recognizeSongFromFileURL(audioFileURL)
        } else {
            print("Recording did not finish successfully")
        }
        
        // Clean up the audioRecorder and remove the delegate reference
        audioRecorder?.delegate = nil
        
        isListening = false
        isWorking = true
    }

    func openUltimateGuitarTab() {
        guard let songTitle = songTitle, let songArtist = songArtist else {
            return
        }

        let urlString = "https://www.ultimate-guitar.com/search.php?search_type=title&value=\(songTitle.replacingOccurrences(of: " ", with: "+"))+\(songArtist.replacingOccurrences(of: " ", with: "+"))"

        if let url = URL(string: urlString) {
            UIApplication.shared.open(url)
        }
    }

    func reset() {
        songTitle = nil
        songArtist = nil
        hasError = false
        isIdentified = false
        isListening = false
        isWorking = false
        
    }
}
