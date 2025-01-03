//
//  SettingsModel.swift
//  Moonlight SwiftUI
//
//  Created by Michael Kenny on 25/1/2023.
//  Copyright © 2023 Moonlight Game Streaming Project. All rights reserved.
//

import SwiftUI

struct Host: Identifiable, Hashable {
    let id: String
    let name: String
}

class SettingsModel: ObservableObject {
    static var hosts: [Host?]? = {
        let dataMan = DataManager()
        if let tempHosts = dataMan.getHosts() as? [TemporaryHost] {
            let hosts = tempHosts.map { host in
                Host(id: host.uuid, name: host.name)
            }
            
            return hosts
        }
        
        
        return nil
    }()
    
    @Published var selectedHost: Host? {
        didSet {
            if selectedHost != nil {
                UserDefaults.standard.set(selectedHost?.id, forKey: "selectedSettingsProfile")
                loadSettings()
            }
        }
    }

    var resolutionChangedCallback: (() -> Void)?
    var fpsChangedCallback: (() -> Void)?

    @Published var selectedResolution: CGSize {
        didSet {
            saveSettings()
            resolutionChangedCallback?()
        }
    }
    @Published var selectedFps: Int {
        didSet {
            saveSettings()
            fpsChangedCallback?()
        }
    }
    @Published var customFps: Int {
        didSet {
            saveSettings()
        }
    }
    @Published var customResWidth: Int {
        didSet {
            saveSettings()
        }
    }
    @Published var customResHeight: Int {
        didSet {
            saveSettings()
        }
    }
    @Published var bitrateSliderValue: Float {
        didSet {
            saveSettings()
        }
    }
    @Published var selectedVideoCodec: String {
        didSet {
            saveSettings()
        }
    }
    @Published var hdr: Bool {
        didSet {
            saveSettings()
        }
    }
    @Published var selectedPacingOptions: String {
        didSet {
            saveSettings()
        }
    }
    @Published var audioOnPC: Bool {
        didSet {
            saveSettings()
        }
    }
    @Published var selectedMultiControllerMode: String {
        didSet {
            saveSettings()
        }
    }
    @Published var swapButtons: Bool {
        didSet {
            saveSettings()
        }
    }
    @Published var optimize: Bool {
        didSet {
            saveSettings()
        }
    }
    
    @Published var autoFullscreen: Bool {
        didSet {
            saveSettings()
        }
    }
    @Published var rumble: Bool {
        didSet {
            saveSettings()
        }
    }
    @Published var selectedControllerDriver: String {
        didSet {
            saveSettings()
        }
    }
    @Published var selectedMouseDriver: String {
        didSet {
            saveSettings()
        }
    }

    @Published var emulateGuide: Bool {
        didSet {
            saveSettings()
        }
    }
    @Published var appArtworkWidth: Int {
        didSet {
            saveSettings()
        }
    }
    @Published var appArtworkHeight: Int {
        didSet {
            saveSettings()
        }
    }
    @Published var dimNonHoveredArtwork: Bool {
        didSet {
            saveSettings()
        }
    }

    static var resolutions: [CGSize] = [CGSizeMake(1280, 720), CGSizeMake(1920, 1080), CGSizeMake(2560, 1440), CGSizeMake(3840, 2160), .zero]
    static var fpss: [Int] = [30, 60, 90, 120, 144, .zero]
    static var bitrateSteps: [Float] = [
        0.5,
        1,
        1.5,
        2,
        2.5,
        3,
        4,
        5,
        6,
        7,
        8,
        9,
        10,
        12,
        15,
        18,
        20,
        25,
        30,
        40,
        50,
        60,
        70,
        80,
        90,
        100,
        120,
        150,
        175,
        200,
        225,
        250,
        275,
        300
    ]
    static var videoCodecs: [String] = ["H.264", "H.265"]
    static var pacingOptions: [String] = ["Lowest Latency", "Smoothest Video"]
    static var multiControllerModes: [String] = ["Single", "Auto"]

    static var controllerDrivers: [String] = ["HID", "MFi"]
    static var mouseDrivers: [String] = ["HID", "MFi"]

    static let defaultResolution = CGSizeMake(1280, 720)
    static let defaultCustomResWidth = 0
    static let defaultCustomResHeight = 0
    static let defaultFps = 60
    static let defaultCustomFps = 0
    static let defaultBitrateSliderValue = {
        var bitrateIndex = 0
        for i in 0..<SettingsModel.bitrateSteps.count {
            if 10000.0 <= SettingsModel.bitrateSteps[i] * 1000.0 {
                bitrateIndex = i
                break
            }
        }
        return Float(bitrateIndex)
    }()
    static let defaultVideoCodec = "H.264"
    static let defaultHdr = false
    static let defaultPacingOptions = "Smoothest Video"
    static let defaultAudioOnPC = false
    static let defaultMultiControllerMode = "Auto"
    static let defaultSwapButtons = false
    static let defaultOptimize = false
    static let defaultAutoFullscreen = true
    static let defaultRumble = true
    static let defaultControllerDriver = "HID"
    static let defaultMouseDriver = "HID"
    static let defaultEmulateGuide = false
    static let defaultAppArtworkWidth = 300
    static let defaultAppArtworkHeight = 400
    static let defaultDimNonHoveredArtwork = true
    
    init() {
        if let hosts = Self.hosts {
            if let selectedProfile = UserDefaults.standard.string(forKey: "selectedSettingsProfile") {
                for (_, host) in hosts.enumerated() {
                    if let host {
                        if host.id == selectedProfile {
                            selectedHost = host
                        }
                    }
                }
            } else {
                if let firstHost = hosts.first {
                    selectedHost = firstHost
                }
            }
        }
        
        selectedResolution = Self.defaultResolution
        customResWidth = Self.defaultCustomResWidth
        customResHeight = Self.defaultCustomResHeight
        selectedFps = Self.defaultFps
        customFps = Self.defaultCustomFps
        
        bitrateSliderValue = Self.defaultBitrateSliderValue
        
        selectedVideoCodec = Self.defaultVideoCodec
        hdr = Self.defaultHdr
        selectedPacingOptions = Self.defaultPacingOptions
        
        audioOnPC = Self.defaultAudioOnPC
        
        selectedMultiControllerMode = Self.defaultMultiControllerMode
        swapButtons = Self.defaultSwapButtons
        
        optimize = Self.defaultOptimize
        
        autoFullscreen = Self.defaultAutoFullscreen
        rumble = Self.defaultRumble
        selectedControllerDriver = Self.defaultControllerDriver
        selectedMouseDriver = Self.defaultMouseDriver
        
        emulateGuide = Self.defaultEmulateGuide
        appArtworkWidth = Self.defaultAppArtworkWidth
        appArtworkHeight = Self.defaultAppArtworkHeight
        dimNonHoveredArtwork = Self.defaultDimNonHoveredArtwork
    }
    
    func loadDefaultSettings() {
        selectedResolution = Self.defaultResolution
        customResWidth = Self.defaultCustomResWidth
        customResHeight = Self.defaultCustomResHeight
        selectedFps = Self.defaultFps
        customFps = Self.defaultCustomFps
        
        bitrateSliderValue = Self.defaultBitrateSliderValue
        
        selectedVideoCodec = Self.defaultVideoCodec
        hdr = Self.defaultHdr
        selectedPacingOptions = Self.defaultPacingOptions
        
        audioOnPC = Self.defaultAudioOnPC
        
        selectedMultiControllerMode = Self.defaultMultiControllerMode
        swapButtons = Self.defaultSwapButtons
        
        optimize = Self.defaultOptimize
        
        autoFullscreen = Self.defaultAutoFullscreen
        rumble = Self.defaultRumble
        selectedControllerDriver = Self.defaultControllerDriver
        selectedMouseDriver = Self.defaultMouseDriver
        
        emulateGuide = Self.defaultEmulateGuide
        appArtworkWidth = Self.defaultAppArtworkWidth
        appArtworkHeight = Self.defaultAppArtworkHeight
        dimNonHoveredArtwork = Self.defaultDimNonHoveredArtwork
    }
    
    func loadAndSaveDefaultSettings() {
        loadDefaultSettings()
        saveSettings()
    }
    
    func loadSettings() {
        if let selectedHost {
            if let settings = Settings.getSettings(for: selectedHost.id) {
                selectedResolution = settings.resolution
                customResWidth = Int(settings.customResolution.width)
                customResHeight = Int(settings.customResolution.height)
                selectedFps = settings.fps
                customFps = settings.customFps
                
                var bitrateIndex = 0
                for i in 0..<Self.bitrateSteps.count {
                    if Float(settings.bitrate) <= Self.bitrateSteps[i] * 1000.0 {
                        bitrateIndex = i
                        break
                    }
                }
                bitrateSliderValue = Float(bitrateIndex)
                
                selectedVideoCodec = Self.getString(from: settings.codec, in: Self.videoCodecs)
                hdr = settings.hdr
                selectedPacingOptions = Self.getString(from: settings.framePacing, in: Self.pacingOptions)
                
                audioOnPC = settings.audioOnPC
                
                selectedMultiControllerMode = Self.getString(from: settings.multiController, in: Self.multiControllerModes)
                swapButtons = settings.swapABXYButtons
                
                optimize = settings.optimize
                
                autoFullscreen = settings.autoFullscreen
                rumble = settings.rumble
                selectedControllerDriver = Self.getString(from: settings.controllerDriver, in: Self.controllerDrivers)
                selectedMouseDriver = Self.getString(from: settings.mouseDriver, in: Self.mouseDrivers)
                
                emulateGuide = settings.emulateGuide
                appArtworkWidth = Int(settings.appArtworkDimensions.width)
                appArtworkHeight = Int(settings.appArtworkDimensions.height)
                dimNonHoveredArtwork = settings.dimNonHoveredArtwork
            } else {
                loadAndSaveDefaultSettings()
            }
        } else {
            loadAndSaveDefaultSettings()
        }
    }
    
    func saveSettings() {
        let customResolution = CGSizeMake(CGFloat(customResWidth), CGFloat(customResHeight))
        let bitrate = Int(Self.bitrateSteps[Int(bitrateSliderValue)] * 1000)
        let codec = Self.getInt(from: selectedVideoCodec, in: Self.videoCodecs)
        let framePacing = Self.getInt(from: selectedPacingOptions, in: Self.pacingOptions)
        let multiController = Self.getBool(from: selectedMultiControllerMode, in: Self.multiControllerModes)
        let controllerDriver = Self.getInt(from: selectedControllerDriver, in: Self.controllerDrivers)
        let mouseDriver = Self.getInt(from: selectedMouseDriver, in: Self.mouseDrivers)
        let appArtworkDimensions = CGSizeMake(CGFloat(appArtworkWidth), CGFloat(appArtworkHeight))

        let settings = Settings(
            resolution: selectedResolution,
            customResolution: customResolution,
            fps: selectedFps,
            customFps: customFps,
            bitrate: bitrate,
            codec: codec,
            hdr: hdr,
            framePacing: framePacing,
            audioOnPC: audioOnPC,
            multiController: multiController,
            swapABXYButtons: swapButtons,
            optimize: optimize,
            autoFullscreen: autoFullscreen,
            rumble: rumble,
            controllerDriver: controllerDriver,
            mouseDriver: mouseDriver,
            emulateGuide: emulateGuide,
            appArtworkDimensions: appArtworkDimensions,
            dimNonHoveredArtwork: dimNonHoveredArtwork
        )
        
        if let data = try? PropertyListEncoder().encode(settings) {
            if let selectedHost {
                UserDefaults.standard.set(data, forKey: SettingsClass.profileKey(for: selectedHost.id))
            }
        }
    }
    
    static func getInt(from selectedSetting: String, in settingsArray: [String]) -> Int {
        for (index, setting) in settingsArray.enumerated() {
            if setting == selectedSetting {
                return index
            }
        }
        
        return 0
    }

    static func getString(from settingInt: Int, in settingsArray: [String]) -> String {
        var settingString = settingsArray.first!
        for (index, setting) in settingsArray.enumerated() {
            if index == settingInt {
                settingString = setting
            }
        }
        
        return settingString
    }

    static func getBool(from settingInt: Int, in settingsArray: [String]) -> Bool {
        guard settingsArray.count == 2 || settingInt <= 1 else {
            return false
        }
        
        var settingBool = false
        for (index, _) in settingsArray.enumerated() {
            if index == settingInt {
                settingBool = index == 1
            }
        }
        
        return settingBool
    }

    static func getBool(from selectedSetting: String, in settingsArray: [String]) -> Bool {
        selectedSetting == settingsArray.last
    }
    
    static func getString(from settingBool: Bool, in settingsArray: [String]) -> String {
        var settingString = settingsArray.first!
        for (index, setting) in settingsArray.enumerated() {
            let indexBool = index == 1
            if indexBool == settingBool {
                settingString = setting
            }
        }
        
        return settingString
    }
}
