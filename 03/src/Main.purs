module Main where

import Prelude

import Effect (Effect)
import Effect.Class (liftEffect)
import Effect.Console (log)
import Erl.Process (ProcessM, receive, spawn, (!))

data Msg = Pong

-- ping ∷ ProcessM Msg Unit
-- ping = receive >>= \_ → liftEffect $ log $ "Received pong."

ping ∷ ProcessM Msg Unit
ping = do
  msg ← receive
  case msg of
    Pong → liftEffect $ log $ "Ping"

main ∷ Effect Unit
main = do
  pPing ← spawn ping
  pPing ! Pong
