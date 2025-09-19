import Foundation

struct CodeBlock {
    let language: String?
    let code: String
}

class MarkdownReader {
    
    /// Extract code dari pattern ```...```
    /// Input: "```swift\nvar a = 5\n```"
    /// Output: CodeBlock(language: "swift", code: "var a = 5")
    static func extractCode(from input: String) -> CodeBlock? {
        let trimmed = input.trimmingCharacters(in: .whitespacesAndNewlines)
        
        // Check pattern ```...```
        guard trimmed.hasPrefix("```") && trimmed.hasSuffix("```") else {
            return nil
        }
        
        // Remove ``` dari awal dan akhir
        let content = String(trimmed.dropFirst(3).dropLast(3))
        
        // Split by first newline untuk ambil language
        let lines = content.components(separatedBy: .newlines)
        
        if lines.isEmpty {
            return CodeBlock(language: nil, code: "")
        }
        
        let firstLine = lines[0].trimmingCharacters(in: .whitespaces)
        
        // Jika first line kosong atau ada code langsung
        if firstLine.isEmpty {
            let code = lines.dropFirst().joined(separator: "\n")
            return CodeBlock(language: nil, code: code)
        }
        
        // Check apakah first line adalah language identifier
        if firstLine.allSatisfy({ $0.isLetter }) {
            // First line adalah language
            let language = firstLine
            let code = lines.dropFirst().joined(separator: "\n")
            return CodeBlock(language: language, code: code)
        } else {
            // First line adalah bagian dari code
            let code = lines.joined(separator: "\n")
            return CodeBlock(language: nil, code: code)
        }
    }
    
    /// Extract code string saja (tanpa language info)
    /// Input: "```swift\nvar a = 5\n```"
    /// Output: "var a = 5"
    static func extractCodeString(from input: String) -> String? {
        return extractCode(from: input)?.code
    }
    
    /// Extract language saja
    /// Input: "```swift\nvar a = 5\n```"
    /// Output: "swift"
    static func extractLanguage(from input: String) -> String? {
        return extractCode(from: input)?.language
    }
    
    /// Create code block dari string
    /// Input: code: "var a = 5", language: "swift"
    /// Output: "```swift\nvar a = 5\n```"
    static func createCodeBlock(code: String, language: String? = nil) -> String {
        if let lang = language {
            return "```\(lang)\n\(code)\n```"
        } else {
            return "```\n\(code)\n```"
        }
    }
    
    /// Validate apakah string adalah valid code block
    static func isValidCodeBlock(_ input: String) -> Bool {
        let trimmed = input.trimmingCharacters(in: .whitespacesAndNewlines)
        return trimmed.hasPrefix("```") && trimmed.hasSuffix("```")
    }
}

// MARK: - String Extension untuk convenience
extension String {
    var extractedCode: String? {
        MarkdownReader.extractCodeString(from: self)
    }
    
    var extractedLanguage: String? {
        MarkdownReader.extractLanguage(from: self)
    }
    
    var isCodeBlock: Bool {
        MarkdownReader.isValidCodeBlock(self)
    }
    
    func toCodeBlock(language: String? = nil) -> String {
        MarkdownReader.createCodeBlock(code: self, language: language)
    }
}
