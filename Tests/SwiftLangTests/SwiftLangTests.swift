import XCTest
@testable import SwiftLang

struct LangDictionaries: Codable{
    typealias LangDictionary = Dictionary<String, String>
    var testDict1: LangDictionary
    var testDict2: LangDictionary
}

final class SwiftLangTests: XCTestCase {
    func testSwiftLangModule() async throws {
        
        //Define tests dictionary:
        let testDictionaries = LangDictionaries(
            testDict1: [
                "serviceWord1":"translatedWord1(testDict1)",
                "serviceWord2":"translatedWord2(testDict1)"
            ],
            testDict2: [
                "serviceWord1":"translatedWord1(testDict2)",
                "serviceWord2":"translatedWord2(testDict2)"
            ])
        
        //Copy the URL of the Dictionaries.json file:
        guard let pathAsURL = Bundle.module.url(forResource: "Dictionaries", withExtension: "json") else {fatalError()}

        //Saving current Dictionaries.json to string (DEPRECATED):
        //let _ = try String(contentsOf: pathAsURL)
        
        //Writing test dictionaries on JSON file:
        if let jsonData = try? JSONEncoder().encode(testDictionaries) {
           
            do {
                print(String(decoding: jsonData, as: UTF8.self))
                try jsonData.write(to: pathAsURL)
            }
            catch {
                print("Failed to write JSON data: \(error.localizedDescription)")
            }
        }
        
        //Testing:
        var locale = await SLLocalizedObject(language: "testDict1")
        XCTAssertEqual("testDict1", locale.currentLanguage)
        XCTAssertEqual("translatedWord1(testDict1)", locale.getWord("serviceWord1"))
        XCTAssertEqual("translatedWord2(testDict1)", locale.getWord("serviceWord2"))

        await locale.changeLanguageSet(language: "testDict2")
        XCTAssertEqual("testDict2", locale.currentLanguage)
        XCTAssertEqual("translatedWord1(testDict2)", locale.getWord("serviceWord1"))
        XCTAssertEqual("translatedWord2(testDict2)", locale.getWord("serviceWord2"))
        
        //Testing error handling:
        XCTAssertEqual("LOCALE_ERROR", locale.getWord("serviceWord3"))
    }
}
