import Config

config :fayrshare,
  port: 4000

config :fayrshare, Repositories.ExpenseGroupRepository,
  database: "fayrshare",
  username: "myuser",
  password: "mypassword",
  hostname: "localhost"

config :fayrshare, ecto_repos: [Repositories.ExpenseGroupRepository]
