import Config

config :fayrshare, :environment, config_env()

import_config "#{config_env()}.exs"
