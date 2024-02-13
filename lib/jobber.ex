defmodule Jobber do
  @moduledoc """
  Documentation for `Jobber`.
  """

  alias Jobber.JobRunner
  alias Jobber.JobSupervisor

  def start_job(args) do
    DynamicSupervisor.start_child(JobRunner, {JobSupervisor, args})
  end

  # TODO:  Something about this is fucked and I don't know why.
  # If I send in an empty list for the guards attr,  I get all the registry entries,
  # but it isn't filtered. It all looks right, the third item in the returned list does
  # indeed say "import", but it doesn't match the guard.
  # - the formatter removes the quotes around :"==", but that doesn't seem to matter. I tried manually pasting it in the iex session
  # - this all seems to match the spec proposed by the Registry docs...
  # - LS is telling me this function has no local return, wtf? 
  def running_imports() do
    # match_all = {:"$1", :"$2", :"$3"}
    # guards = [{:==, :"$3", "import"}]
    # map_result = %{id: :"$1", pid: :"$2", type: :"$3"}

    # Registry.select(Jobber.Registry, [{match_all, guards, map_result}])
    Registry.select(Jobber.JobRegistry, [
      {{:"$1", :"$2", :"$3"}, [:==, :"$3", "import"], [%{id: :"$1", pid: :"$2", type: :"$3"}]}
    ])
  end
end
