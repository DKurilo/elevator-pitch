# Elevator pitch.

I start working on it and end up with:  
```haskell
myPitch = "Hi, my name is Dima and I've never had an elevator pitch, but everyone is talking about it. It's important to have one if you want to find new opportunities. So I decided to create one for me. That's how I created this text. So now I'm able to say:" ++ myPitch
```

You know, this is just voices in my head. To say it out loud I need to use monad IO. So I had to rewrite it as:  

```haskell
module Main where

import Somewhere.IO

myPitch = "Hi, my name is Dima and I've never had an elevator pitch, but everyone is talking about it. It's important to have one if you want to find new opportunities. So I decided to create one for me. That's how I created this text. So now I'm able to say:" ++ myPitch
main :: IO ()
main = sayOutLoud myPitch
```

Now I have a problem. I will mumble it all the time. I need to stop somewhere. So I need to add a fixed point. To do it, I need to decide what it is. If as a result of my pitch I want to have a job offer, the fixed point is a job offer. But the job offer is a function with IO side effect. It means, my pitch should be inside IO. So now I have to write:  

```haskell
{-# LANGUAGE LambdaCase #-}
module Main where

import Somewhere.IO

newtype Offer = Offer String

myPitch :: IO Offer
myPitch =  sayOutLoud speach >> haveOffer >>=
           (\case {Just offer -> return offer; _ -> myPitch})
    where speach = "Hi, my name is Dima and I've never had an elevator pitch, but everyone is talking about it. It's important to have one if you want to find new opportunities. So I decided to create one for me. That's how I created this text. So now I'm able to say:"

main :: IO ()
main = myPitch >>= doMyBest
```

I still have recursion. And you know, recursion is not the best thing for an elevator pitch. Nobody wants to experience multiple déjà vu. The best way to fix it, as everyone knows, is a fix function. So I added this:  

```haskell
{-# LANGUAGE LambdaCase #-}
module Main where

import Somewhere.IO
import Control.Monad.Fix

newtype Offer = Offer String

myPitch :: IO Offer -> IO Offer
myPitch rec = sayOutLoud speach >> haveOffer >>=
              (\case {Just offer -> return offer; _ -> rec})
    where speach = "Hi, my name is Dima and I've never had an elevator pitch, but everyone is talking about it. It's important to have one if you want to find new opportunities. So I decided to create one for me. That's how I created this text. So now I'm able to say:"

main :: IO ()
main = fix myPitch >>= doMyBest
```
Great! Now it should work.  
I just need to lift some great company into my IO. Because you know, what has happened inside IO will be in IO forever. There is no exit from IO.  
And I still don't know how to solve this problem. But I'm working on it.  

