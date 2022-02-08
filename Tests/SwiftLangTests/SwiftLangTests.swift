import XCTest
@testable import SwiftLang

final class SwiftLangTests: XCTestCase {
    func testExample() async throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
//        let obj = SLLocalizingService()
//        let _ = await obj.loadData()
        var locale = await SLLocalizedObject(language: "EngDict")
        print(locale.currentLanguage)
        print(locale.getWord("serviceWord1"))
        print(locale.getWord("serviceWord2"))
        await locale.changeLanguageSet(language: "RusDict")
        print(locale.currentLanguage)
        print(locale.getWord("serviceWord1"))
        print(locale.getWord("serviceWord2"))
        
        print(locale.getWord("serviceWord3"))
    }
}
