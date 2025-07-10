import Config

config :fayrshare,
  port: 4000

config :fayrshare, Repositories.ExpenseGroupRepository,
  database: "fayrshare_test",
  username: "myuser",
  password: "mypassword",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox

config :fayrshare, ecto_repos: [Repositories.ExpenseGroupRepository]
