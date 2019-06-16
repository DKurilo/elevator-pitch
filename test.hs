{-# LANGUAGE LambdaCase #-}
module Main where

import System.IO
import Control.Monad.Fix

newtype Offer = Offer String
    deriving (Show)

myPitch :: IO Offer -> IO Offer
myPitch rec =(putStrLn speach >>
              (\c -> if c=='y'then Just (Offer "Great offer!") else Nothing) <$> getChar) >>=
              (\case {Just offer -> return offer; _ -> rec})
    where speach = "Hi, my name is Dima and I never had elevator pitch, but everyone is talking about it. It's important to have one if you want to find new opportunities. So I decided to create one for me. That's how I created this text. So now I'm able to say:"

main :: IO ()
main = fix myPitch >>= print

