module Main where

import Test.Hspec
import Test.QuickCheck

import Log
import LogAnalysis

main :: IO ()
main = hspec $ do
  it "parses the message type" $ do
    parseType "I 29 la la la" `shouldBe` Just ((Info), (words "29 la la la"))
    parseType "E 2 562 the sky is falling!" `shouldBe`
        Just (((Error 2)), (words "562 the sky is falling!"))
    parseType "blah blah blah" `shouldBe` Nothing
    parseType "W 5 Flange is due for a check-up" `shouldBe`
       Just ((Warning), (words "5 Flange is due for a check-up"))

    -- invalid inputs
    parseType "E NaN NaN duh" `shouldBe` Nothing
    parseType "poopsie"       `shouldBe` Nothing
    parseType ""              `shouldBe` Nothing

  it "parses unknown messages" $ do
    parseMessage "blah blah blah" `shouldBe` (Unknown "blah blah blah")

  it "parses info messages" $ do
    parseMessage "I 29 la la la" `shouldBe` LogMessage Info 29 "la la la"

  it "parses warning messages" $ do
    parseMessage "W 5 Flange is due for a check-up" `shouldBe`
        LogMessage Warning 5 "Flange is due for a check-up"

  it "parses error messages" $ do
    parseMessage "E 2 562 the sky is falling!" `shouldBe`
      LogMessage (Error 2) 562 "the sky is falling!"
