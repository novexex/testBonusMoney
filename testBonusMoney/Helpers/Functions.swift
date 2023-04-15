//
//  Functions.swift
//  testBonusMoney
//
//  Created by Artour Ilyasov on 15.04.2023.
//

import Foundation

func decodeUnicodeString(_ unicodeString: String) -> String {
    unicodeString.decomposedStringWithCanonicalMapping
}

func getUrl(string: String) -> URL? {
    guard let url = URL(string: string) else { return nil }
    return url
}
