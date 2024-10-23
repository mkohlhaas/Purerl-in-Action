module MyGenServer where

import Prelude
import Data.Maybe (Maybe(..))
import Effect (Effect)
import Erl.Atom (atom)
import Pinto (RegistryName(..), StartLinkResult)
import Pinto.GenServer (InitResult(..), ServerPid, ServerType)
import Pinto.GenServer as GenServer
import Pinto.Types (RegistryReference(..))

type EmptyGenServerStartArgs = {}

type State = {}

serverName :: RegistryName (ServerType Unit Unit Unit State)
serverName = Local $ atom "my_gen_server"

startLink :: EmptyGenServerStartArgs -> Effect (StartLinkResult (ServerPid Unit Unit Unit State))
startLink args = GenServer.startLink $ (GenServer.defaultSpec $ init args) { name = Just serverName }

doSomething :: Effect String
doSomething = GenServer.call (ByName serverName) (\_from state -> pure $ GenServer.reply "Hi" state)

init :: EmptyGenServerStartArgs -> GenServer.InitFn Unit Unit Unit State
init _args = do
  pure $ InitOk {}

