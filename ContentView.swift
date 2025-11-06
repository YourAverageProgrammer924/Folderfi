//
//  ContentView.swift
//  Folderfi
//
//  Created by Alex on 31.10.25.
//

import SwiftUI
import UniformTypeIdentifiers
import AVFoundation
import Foundation

struct ContentView: View {
	@State private var showImporter = false
	@State private var selectedFolderURL: URL?
	@State private var audioPlayer: AVAudioPlayer?
    @State private var mp3files:[String] = []
	var fileManager = FileManager.default
    
    var body: some View {
        VStack {
            Button("Ordner hinzufügen") {
                showImporter = true
            }
            List{
                ForEach(mp3files, id: \.self) { file in
                    Text("File: \(file)")
            }
        }
        .padding()
        .fileImporter(isPresented: $showImporter, allowedContentTypes: [.folder]) {
            result in do {
                let url = try result.get()
                selectedFolderURL = url
                listfiles()
            } catch {
                print("Fehler beim Auswählen", error.localizedDescription)
            }
        }
    }
    func listfiles() {
                //Define URL
                //Access URL.
                //Work with URL.
                //Close access.
        guard let url = selectedFolderURL else {
            return
        }
        
       
        guard url.startAccessingSecurityScopedResource() else {
            return
        }
        defer {url.stopAccessingSecurityScopedResource()}
        
        do {
            mp3files = try FileManager.default.contentsOfDirectory(atPath: url.path)
            
        } catch {
            
            print("Keine Dateien vorhanden.")
        }
        
    }
}

#Preview {
    ContentView()
}
