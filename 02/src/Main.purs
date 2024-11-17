module Main where

import Prelude

import Data.Time.Duration (Milliseconds(..))
import Effect (Effect)
import Effect.Class (liftEffect)
import Effect.Console (log)
import Erl.Kernel.Erlang (sleep)
import Erl.Process (Process, ProcessM, receive, self, spawnLink, (!))
import Pinto.Timer (sendEveryTo)

data Msg = Tick | Stop

startWorker ∷ ProcessM Msg Unit
startWorker = do
  me ∷ Process Msg ← self
  void $ liftEffect $ sendEveryTo (Milliseconds 500.0) Tick me
  workerLoop

workerLoop ∷ ProcessM Msg Unit
workerLoop = do
  msg ← receive
  case msg of
    Stop → pure unit
    Tick → do
      liftEffect $ log "Tick"
      workerLoop

main ∷ Effect Unit
main = do
  pid ← spawnLink startWorker
  sleep (Milliseconds 5000.0)
  pid ! Stop
