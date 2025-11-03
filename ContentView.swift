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
	var fileManager = FileManager.default	
    
    var body: some View {
        VStack {
            Button("Ordner hinzufügen") {
                showImporter = true
            }
            Text("Ausgewählte URL: \(String(describing: selectedFolderURL?.absoluteString))")
            //Show URL as Text in UI.
        }
        .padding()
        .fileImporter(isPresented: $showImporter, allowedContentTypes: [.folder]) {
            result in do {
                let url = try result.get()
                selectedFolderURL = url
                listfiles()
		listfiles()
            } catch {
                print("Fehler beim Auswählen", error.localizedDescription)
            }
        }
    }
    func listfiles() {
      //URL definieren
      //Auf URL zugreifen.
        //Mit URL arbeiten
        //Zugriff schließen.
        guard let url = selectedFolderURL else {
            return
        }
        
       
        guard url.startAccessingSecurityScopedResource() else {
            return
        }
        defer {url.stopAccessingSecurityScopedResource()}
        
        do {
            let files = try FileManager.default.contentsOfDirectory(atPath: url.path)
            print("files: \(files)")
        } catch {
            
            print("Keine Dateien vorhanden.")
        }
        
    }
}

#Preview {
    ContentView()
}
