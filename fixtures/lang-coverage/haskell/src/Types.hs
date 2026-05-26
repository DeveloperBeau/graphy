module Types where

-- feature: type alias, newtype, data, class, instance

type Id = Int
type Name = String

newtype ServiceName = ServiceName { unServiceName :: String }

data State = Idle | Running | Done
  deriving (Show, Eq)

class Greet a where
  greeting :: a -> String

data Service = Service { serviceId :: Id, serviceName :: Name }
  deriving (Show)

instance Greet Service where
  greeting svc = "hello from " ++ serviceName svc
