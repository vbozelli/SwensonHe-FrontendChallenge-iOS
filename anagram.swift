//Note: it is faster to use NSString instead of String because NSString stores characters as UInt16 instead of String that stores characters as Character struct which is a wrapper around Unicode values which are also structs and wrappers and it is memory and CPU costly. So when dealing whith characters processing NSString is faster and memory optimized then String.

import Foundation

func anagram(word1: String, word2: String) -> Bool {
    let word1String = word1.trimmingCharacters(in: .whitespacesAndNewlines) as NSString
    let word2String = word2.trimmingCharacters(in: .whitespacesAndNewlines) as NSString
    let length1 = word1String.length
    let length2 = word2String.length
    if length1 != length2 {
        return false
    }
    var i = 0
    var charactersDict1 = [unichar:UInt]()
    while i < length1 {
        let character = word1String.character(at: i)
        if charactersDict1[character] == nil {
            charactersDict1[character] = .zero
        }
        charactersDict1[character]! += 1
        i += 1
    }
    i = 0
    var charactersDict2 = [unichar:UInt]()
    while i < length2 {
        let character = word2String.character(at: i)
        if charactersDict2[character] == nil {
            charactersDict2[character] = .zero
        }
        charactersDict2[character]! += 1
        i += 1
    }
    if charactersDict1.count != charactersDict2.count {
        return false
    }
    return charactersDict1 == charactersDict2
}
