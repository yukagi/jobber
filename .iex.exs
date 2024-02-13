good_job = fn -> 
  Process.sleep(60_000)
  {:ok, []}
end

bad_job = fn ->
  Process.sleep(5000)
  :error
end

doomed_job = fn ->
  Process.sleep(5000)
  raise "BOOM!"
end

lookup =     Registry.select(Jobber.JobRegistry, [
      {{:"$1", :"$2", :"$3"}, [:==, :"$3", "import"], [%{id: :"$1", pid: :"$2", type: :"$3"}]}
    ])

