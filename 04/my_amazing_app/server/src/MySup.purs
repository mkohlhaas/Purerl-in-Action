module MySup where

import Prelude (pure, ($))
import Data.Maybe (Maybe(..))
import Erl.Data.List.Types
import Effect (Effect)
import Erl.Atom (atom)
import Pinto (RegistryName(..), StartLinkResult)
import Pinto.Supervisor (SupervisorPid, SupervisorSpec, Strategy(..), spec, ChildType(..), RestartStrategy(..), ChildShutdownTimeoutStrategy(..))
import Pinto.Supervisor as Sup
import Data.Time.Duration (Seconds(..), Milliseconds(..))
import MyGenServer as MyGenServer

startLink :: Effect (StartLinkResult SupervisorPid)
startLink = do
  Sup.startLink (Just $ Local $ atom "my_sup") init

init :: Effect SupervisorSpec
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

