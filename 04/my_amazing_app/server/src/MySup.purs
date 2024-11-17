module MySup where

import Erl.Data.List.Types

import Data.Maybe (Maybe(..))
import Data.Time.Duration (Milliseconds(..), Seconds(..))
import Effect (Effect)
import Erl.Atom (atom)
import MyGenServer as MyGenServer
import Pinto (RegistryName(..), StartLinkResult)
import Pinto.Supervisor (ChildShutdownTimeoutStrategy(..), ChildType(..), RestartStrategy(..), Strategy(..), SupervisorPid, SupervisorSpec, spec)
import Pinto.Supervisor as Sup
import Prelude (pure, ($))

startLink ∷ Effect (StartLinkResult SupervisorPid)
startLink = do
  Sup.startLink (Just $ Local $ atom "my_sup") init

init ∷ Effect SupervisorSpec
init = do
  pure
    { flags:
        { strategy: OneForOne
        , intensity: 1
        , period: Seconds 5.0
        }
    , childSpecs:
        ( spec
            { id: "cool_worker"
            , start: MyGenServer.startLink {}
            , childType: Worker
            , restartStrategy: RestartTransient
            , shutdownStrategy: ShutdownTimeout $ Milliseconds 5000.0
            }
        )
          : nil
    }

