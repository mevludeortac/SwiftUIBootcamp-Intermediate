//
//  SoundOfBootcamp.swift
//  SwiftUIBootcamp-Intermediate
//
//  Created by MEWO on 10.05.2022.
//

import SwiftUI
import AVKit
class SoundManager {
    
    enum SoundOption : String{
        case tada // case tada = "tada_sound"
        case badum //in swift dont explicity say this("tada_sound") the string version will be the exact same as this
    }
    //this is creating single instance of the manager
    //so we are initializing it once right here then every time we want to use this manager we are gonna access it through this instance
    //this way we create it once for our entire application instead of initializing a new one on every single screen
    static let instance = SoundManager()
    var player : AVAudioPlayer?
    
    func playSound(sound: SoundOption){
        guard let url = Bundle.main.url(forResource: sound.rawValue, withExtension: ".mp3") else{return}
        do{
            player = try AVAudioPlayer(contentsOf: url)
            player?.play()
        } catch{
            print("error: \(error.localizedDescription)")
        }
    }
}
struct SoundOfBootcamp: View {
    var body: some View {
        VStack(spacing: 20){
            Button("Button 1") {
                SoundManager.instance.playSound(sound: .badum)
            }
            Button("Button 2") {
                SoundManager.instance.playSound(sound: .tada)
            }
        }
    }
}

struct SoundOfBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        SoundOfBootcamp()
    }
}
