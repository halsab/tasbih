//
//  DuaModel.swift
//  DuaKit
//
//  Created by Khalil Sabirov on 03.11.2024.
//

import Foundation

struct DuaModel: Identifiable, Hashable {
    let id = UUID()
    let name: Name
    let number: Int?
    let isFull: Bool
    let sentences: [Sentence]
    
    var sentencesRange: String {
        if let firstNumber = sentences.first?.number,
           let lastNumber = sentences.last?.number {
            return "\(firstNumber)-\(lastNumber)"
        } else {
            return ""
        }
    }
    
    init(
        name: Name,
        number: Int? = nil,
        isFull: Bool = false,
        sentences: [Sentence]
    ) {
        self.name = name
        self.number = number
        self.isFull = isFull
        self.sentences = sentences
    }
}

// MARK: - Name

extension DuaModel {
    struct Name: Hashable {
        let arabic: String?
        let translation: String
        let alternative: String?
        let meaning: String?
        let honor: String?
        
        init(
            arabic: String? = nil,
            translation: String,
            alternative: String? = nil,
            meaning: String? = nil,
            honor: String? = nil
        ) {
            self.arabic = arabic
            self.translation = translation
            self.alternative = alternative
            self.meaning = meaning
            self.honor = honor
        }
    }
}

// MARK: - Sentence

extension DuaModel {
    struct Sentence: Identifiable, Hashable {
        let id = UUID()
        let number: Int?
        let arabic: String
        let translation: String
        let transcription: String
        let tafsir: Tafsir?
        
        init(
            number: Int? = nil,
            arabic: String,
            translation: String,
            transcription: String,
            tafsir: Tafsir? = nil
        ) {
            self.number = number
            self.arabic = arabic
            self.translation = translation
            self.transcription = transcription
            self.tafsir = tafsir
        }
    }
}

// MARK: - SentenceTafsir

extension DuaModel.Sentence {
    struct Tafsir: Identifiable, Hashable {
        let id = UUID()
        let author: String
        let text: String
        
        init(
            author: String,
            text: String
        ) {
            self.author = author
            self.text = text
        }
    }
}
