{-# OPTIONS_GHC -Wall #-}
module LogAnalysis where

import Log
import Text.Read (readMaybe)
import Data.Maybe (fromMaybe)

parseType :: String -> Maybe (MessageType, [String])
parseType s = case (words s) of
                  ("I":ys)      -> Just (Info,    ys)
                  ("W":ys)      -> Just (Warning, ys)
                  ("E":n:ys)    -> do code <- readMaybe n
                                      return $ ((Error code), ys)
                  _ -> Nothing

parseTimestamp :: Maybe (MessageType, [String]) -> Maybe LogMessage
parseTimestamp (Just (mType, x:xs)) = do
    timestamp <- readMaybe x
    return $ LogMessage mType timestamp (unwords xs)

parseTimestamp Nothing  = Nothing
parseTimestamp (Just _) = Nothing

-- parseMessage parses a single log line
parseMessage :: String -> LogMessage
parseMessage s = fromMaybe (Unknown s) (parseTimestamp $ parseType s)

-- parse calls parseMessage on every line and returns the result.
parse :: String -> [LogMessage]
parse = map parseMessage . lines
