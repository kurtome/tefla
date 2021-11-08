[
  ## don't run tools concurrently
  # parallel: false,

  ## don't print info about skipped tools
  # skipped: false,

  ## always run tools in fix mode (put it in ~/.check.exs locally, not in project config)
  # fix: true,

  ## don't retry automatically even if last run resulted in failures
  # retry: false,

  ## list of tools (see `mix check` docs for a list of default curated tools)
  tools: [
    {:compiler, true},
    {:unused_deps, true},
    {:formatter, true},
    {:ex_unit, true},
    {:credo, [strict: true]},
    {:dialyzer, true},
    {:doctor, true},

    # Disabled
    {:ex_doc, false},
    {:sobelow, false},
    {:npm_test, false}
  ]
]
