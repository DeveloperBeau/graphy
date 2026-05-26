unit Types;

interface

const
  MAX_RETRIES = 3;
  SERVICE_NAME = 'graphy-pascal-fixture';

type
  TState = (Idle, Running, Done);

  TService = record
    Name: string;
    State: TState;
  end;

implementation

end.
