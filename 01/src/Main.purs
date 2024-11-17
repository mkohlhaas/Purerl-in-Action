module Main where

import Prelude

import Data.Time.Duration (Milliseconds(..))
import Effect (Effect, forE)
import Effect.Class (liftEffect)
import Effect.Console (logShow)
import Erl.Kernel.Erlang (sleep)
import Erl.Process (Process, ProcessM, receive, spawn, (!))

data Message = Add Int | Subtract Int | GetTotal (Process Int)

counter ∷ ProcessM Message Unit
counter = counter' 0
  where
  counter' ∷ Int → ProcessM Message Unit
  counter' n = do
    msg ← receive
    case msg of
      Add m → counter' (n + m)
      Subtract m → counter' (n - m)
      GetTotal logger → liftEffect $ logger ! n

logger ∷ ProcessM Int Unit
logger = do
  receive >>= \count → liftEffect $ logShow count

main ∷ Effect Unit
main = do
  logger ← spawn logger
  counter ← spawn counter
  forE 0 100000 \_ → counter ! Add 1
  counter ! Subtract 5
  counter ! GetTotal logger
  sleep $ Milliseconds 15000.0
