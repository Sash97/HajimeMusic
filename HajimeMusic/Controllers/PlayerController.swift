//
//  PlayerController.swift
//  HajimeMusic
//
//  Created by Aleksandr Bagdasaryan on 8/14/20.
//  Copyright © 2020 Aleksandr Bagdasaryan. All rights reserved.
//



import UIKit



class PlayerController: UIViewController {

    //MARK - Outlets -
    
    @IBOutlet private weak var underSongImageView: UIView!
    @IBOutlet private weak var songImageView: UIImageView!
     
    @IBOutlet private weak var artistNameLabel: UILabel!
    @IBOutlet private weak var songNameLabel: UILabel!
    
    @IBOutlet private weak var startTimeLabel: UILabel!
    @IBOutlet private weak var finishTimeLabel: UILabel!
    
    @IBOutlet private weak var playerSlider: UISlider!
    
    @IBOutlet private weak var backwardButton: UIButton!
    @IBOutlet private weak var playButton: UIButton!
    @IBOutlet private weak var forwardButton: UIButton!
    
    @IBOutlet private var playerButtons: [UIButton]!
    
    
    
    //MARK: - Properties -
    
    private var isPlaying: Bool = false
    private var timer: ABTimer!
    
    
    
    //MARK: - Dependencies -
    
    weak var coordinator: HomeCoordinator?
    var audioPlayer: AudioPlayer
    
    
    
    //MARK: - Init -
    
    init?(coder: NSCoder, coordinator: HomeCoordinator, audioPlayer: AudioPlayer) {
        self.coordinator = coordinator
        self.audioPlayer = audioPlayer
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    //MARK: - Lifecycle -
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureViewStyle()
        self.configureSongImageView()
        self.configurePlayerButtons()
        self.setupPlayer()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.timer.invalidate()
    }

    
    
    //MARK: - Methods -
    
    private func setupPlayer() {
        do {
             try self.audioPlayer.setupPlayer()
        } catch {
            print(error.localizedDescription)
        }
        
        self.updateViewWithNewAudio()
        self.updateSlider()
        self.configureTimer()
    }
    
    private func configureTimer() {
        self.timer = ABTimer(interval: 1, repeats: true, callback: { [weak self] in
            guard let self = self else { return }
            self.playerSlider.value = Float(self.audioPlayer.audioCurrentTime)
            self.startTimeLabel.text = String(timeInterval: self.audioPlayer.audioCurrentTime)
            if self.playerSlider.value == 0 { self.forwardHelper() }
        })
    }
    
    private func configureViewStyle() {
        let firstColor = #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1)
        let secondColor =  #colorLiteral(red: 0.2803135702, green: 0.04366438356, blue: 0.6485177654, alpha: 1)
        self.view.setGradientColor(firstColor, secondColor, frame: self.view.bounds)
    }
    
    private func configureSongImageView() {
        self.underSongImageView.layer.cornerRadius = self.view.frame.width * 0.57971 / 2
        self.songImageView.layer.cornerRadius = (self.view.frame.width - 12) * 0.57971 / 2
        self.underSongImageView.setShadow(color: #colorLiteral(red: 0.1215686277, green: 0.01176470611, blue: 0.4235294163, alpha: 1).cgColor, radius: 3, opacity: 1)
    }
    
    private func configurePlayerButtons() {
        self.playerButtons.forEach { (button) in
            button.backgroundColor = UIColor.rgb(79, 24, 187)
            button.layer.cornerRadius = 30
            button.setShadow(color: #colorLiteral(red: 0.1215686277, green: 0.01176470611, blue: 0.4235294163, alpha: 1).cgColor, radius: 3, opacity: 1)
        }
    }
    
    
    
    //MARK: - Actions -

    @IBAction private func playerSliderAction(_ sender: UISlider) {
        self.audioPlayer.pause()
        self.timer.pause()
        self.audioPlayer.audioCurrentTime = TimeInterval(sender.value)
        self.audioPlayer.prepareToPlay()
        self.timer.start()
        self.audioPlayer.play()
        if !self.isPlaying {
            self.playButton.setImage(UIImage(systemName: SFSymbols.pause), for: .normal)
            self.isPlaying = true
        }
    }
    
    
    @IBAction private func backwardAction(_ sender: UIButton) {
        self.bidirectionalActionHelper()
        self.audioPlayer.backward()
        self.updateViewWithNewAudio()
    }
    
    @IBAction private func playAction(_ sender: UIButton) {
        DispatchQueue.main.async {
            if self.isPlaying {
                self.playButton.setImage(UIImage(systemName: SFSymbols.play), for: .normal)
                self.audioPlayer.pause()
                self.isPlaying.toggle()
                self.timer.pause()
                return
            }
            self.isPlaying.toggle()
            self.isPlaying ? self.audioPlayer.play() : self.audioPlayer.pause()
            self.isPlaying ? self.playButton.setImage(UIImage(systemName: SFSymbols.pause), for: .normal) :
                             self.playButton.setImage(UIImage(systemName: SFSymbols.play), for: .normal)
            self.isPlaying ? self.timer.start() : self.timer.pause()
        }
    }
    
    @IBAction func forwardAction(_ sender: UIButton) {
        self.forwardHelper()
    }
    
    private func forwardHelper() {
        self.bidirectionalActionHelper()
        self.audioPlayer.forward()
        self.updateViewWithNewAudio()
    }
    
    private func bidirectionalActionHelper() {
        if self.isPlaying == false {
            self.playButton.setImage(UIImage(systemName: SFSymbols.pause), for: .normal)
            self.isPlaying.toggle()
            self.timer.start()
        }
        
        DispatchQueue.main.async { self.updateSlider() }
    }
    
    private func updateViewWithNewAudio() {
        self.songImageView.image  = self.audioPlayer.audio!.labelImage
        self.artistNameLabel.text = self.audioPlayer.audio?.artistName
        self.songNameLabel.text   = self.audioPlayer.audio?.songName
    }
    
    private func updateSlider() {
        self.playerSlider.value = Float(self.audioPlayer.audioCurrentTime)
        self.playerSlider.maximumValue = Float(self.audioPlayer.audioDuration)
        self.startTimeLabel.text = String(timeInterval: self.audioPlayer.audioCurrentTime)
        self.finishTimeLabel.text = String(timeInterval: self.audioPlayer.audioDuration)
    }
}



