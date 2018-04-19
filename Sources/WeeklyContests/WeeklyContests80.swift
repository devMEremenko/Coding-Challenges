//
//  WeeklyContests80.swift
//  LeetCode
//
//  Created by Maxim Eremenko on 4/16/18.
//  Copyright © 2018 Eremenko Maxim. All rights reserved.
//

import XCTest

class WeeklyContests80: XCTestCase {
    
    /*
     
     Contest: https://leetcode.com/contest/weekly-contest-80
     Task: https://leetcode.com/contest/weekly-contest-80/problems/most-common-word/
     
     ------Description------
     Given a paragraph and a list of banned words, return the most frequent word that is not in the list of banned words.  It is guaranteed there is at least one word that isn't banned, and that the answer is unique.
     
     Words in the list of banned words are given in lowercase, and free of punctuation.  Words in the paragraph are not case sensitive.  The answer is in lowercase.
     
     
     ------Example------
     Input:
     paragraph = "Bob hit a ball, the hit BALL flew far after it was hit."
     banned = ["hit"]
     Output: "ball"
     Explanation:
     "hit" occurs 3 times, but it is a banned word.
     "ball" occurs twice (and no other word does), so it is the most frequent non-banned word in the paragraph.
     Note that words in the paragraph are not case sensitive,
     that punctuation is ignored (even if adjacent to words, such as "ball,"),
     and that "hit" isn't the answer even though it occurs more because it is banned.
     
     ------Note------
     1 <= paragraph.length <= 1000.
     1 <= banned.length <= 100.
     1 <= banned[i].length <= 10.
     The answer is unique, and written in lowercase (even if its occurrences in paragraph may have uppercase symbols, and even if it is a proper noun.)
     paragraph only consists of letters, spaces, or the punctuation symbols !?',;.
     Different words in paragraph are always separated by a space.
     There are no hyphens or hyphenated words.
     Words only consist of letters, never apostrophes or other punctuation symbols.
     */
    
    func testMostCommonWord() {
        
        let p1 = "Bob hit a ball, the hit BALL flew far after it was hit."
        let p2 = "Bob hit a ball, a a a the hit BALL flew far after it was hit."
        let p4 = "Bob hit Bob Bob a ball, a a a the hit BALL flew far after it was hit."
        
        XCTAssert(mostCommonWord(p1, ["hit"]) == "ball")
        XCTAssert(mostCommonWord(p2, ["bob", "a"]) == "hit")
        XCTAssert(mostCommonWord(p4, ["bob", "hit"]) == "a")
        
        let p5 = "L, P! X! C; u! P? w! P. G, S? l? X? D. w? m? f? v, x? i. z; x' m! U' M! j? V; l. S! j? r, K. O? k? p? p, H! t! z' X! v. u; F, h; s? X? K. y, Y! L; q! y? j, o? D' y? F' Z; E? W; W' W! n! p' U. N; w? V' y! Q; J, o! T? g? o! N' M? X? w! V. w? o' k. W. y, k; o' m! r; i, n. k, w; U? S? t; O' g' z. V. N? z, W? j! m? W! h; t! V' T! Z? R' w, w? y? y; O' w; r? q. G, V. x? n, Y; Q. s? S. G. f, s! U? l. o! i. L; Z' X! u. y, Q. q; Q, D; V. m. q. s? Y, U; p? u! q? h? O. W' y? Z! x! r. E, R, r' X' V, b. z, x! Q; y, g' j; j. q; W; v' X! J' H? i' o? n, Y. X! x? h? u; T? l! o? z. K' z' s; L? p? V' r. L? Y; V! V' S. t? Z' T' Y. s? i? Y! G? r; Y; T! h! K; M. k. U; A! V? R? C' x! X. M; z' V! w. N. T? Y' w? n, Z, Z? Y' R; V' f; V' I; t? X? Z; l? R, Q! Z. R. R, O. S! w; p' T. u? U! n, V, M. p? Q, O? q' t. B, k. u. H' T; T? S; Y! S! i? q! K' z' S! v; L. x; q; W? m? y, Z! x. y. j? N' R' I? r? V! Z; s, O? s; V, I, e? U' w! T? T! u; U! e? w? z; t! C! z? U, p' p! r. x; U! Z; u! j; T! X! N' F? n! P' t, X. s; q'"
        
        let b5 = ["m", "i", "s", "w", "y", "d", "q", "l", "a", "p", "n", "t", "u", "b", "o", "e", "f", "g", "c", "x"]
        
        XCTAssert(mostCommonWord(p5, b5) == "z")
    }
    
    // Solution
    
    func mostCommonWord(_ paragraph: String, _ banned: [String]) -> String {
        
        let set = CharacterSet(charactersIn: "!?',;.")
        let words = paragraph.components(separatedBy: set).joined().components(separatedBy: " ")
        
        var map = [String: Int]()
        var maxValue = 0
        
        for item in words {
            
            let key = item.lowercased()
            if let count = map[key] {
                let next = count + 1
                map.updateValue(next, forKey: key)
                maxValue = maxValue < next ? next : maxValue
            } else {
                map.updateValue(1, forKey: key)
                maxValue = maxValue < 1 ? 1 : maxValue
            }
        }
        
        // Set is more efficient to check membership than Array
        // It requires memory allocations but safes a number of computations.
        let bannedSet = Set<String>(banned)
        
        while maxValue > 0 {
            
            for word in map.key(for: maxValue) {
                
                if !bannedSet.contains(word) {
                    return word
                }
            }
            maxValue -= 1
        }
        
        return ""
    }
}
