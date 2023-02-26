# This file is responsible for configuring your application
# and its dependencies with the aid of the Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
import Config

config :undi_online, :env, Mix.env()

config :undi_online,
  ecto_repos: [UndiOnline.Repo],
  generators: [binary_id: true]

config :undi_online, UndiOnline.Repo,
  migration_primary_key: [name: :id, type: :binary_id]

config :undi_online,
  require_user_confirmation: false,
  app_name: "UndiOnline",
  page_url: "undi.online",
  company_name: "UndiOnline Enterprise",
  company_address: "7186 KAW 2",
  company_zip: "24000",
  company_city: "Chukai",
  company_state: "Terengganu",
  company_country: "Malaysia",
  contact_name: "Roslan Ramli",
  contact_phone: "601125771566",
  contact_email: "dev.rroslan@gmail.com",
  from_email: "roslanr@gmail.com"




# Configures the endpoint
config :undi_online, UndiOnlineWeb.Endpoint,
  url: [host: "localhost"],
  render_errors: [
    formats: [html: UndiOnlineWeb.ErrorHTML, json: UndiOnlineWeb.ErrorJSON],
    layout: false
  ],
  pubsub_server: UndiOnline.PubSub,
  live_view: [signing_salt: "wGTUIAA/"]

# Configures the mailer
#
# By default it uses the "Local" adapter which stores the emails
# locally. You can see the emails in your browser, at "/dev/mailbox".
#
# For production it's recommended to configure a different adapter
# at the `config/runtime.exs`.
config :undi_online, UndiOnline.Mailer, adapter: Swoosh.Adapters.Local

# Swoosh API client is needed for adapters other than SMTP.
config :swoosh, :api_client, false

# Configure esbuild (the version is required)
config :esbuild,
  version: "0.14.41",
  default: [
    args:
      ~w(js/app.js --bundle --target=es2017 --outdir=../priv/static/assets --external:/fonts/* --external:/images/*),
    cd: Path.expand("../assets", __DIR__),
    env: %{"NODE_PATH" => Path.expand("../deps", __DIR__)}
  ]

config :tailwind,
  version: "3.2.4",
  default: [
    args: ~w(
      --config=tailwind.config.js
      --input=../priv/static/assets/app.css.tailwind
      --output=../priv/static/assets/app.css
    ),
    cd: Path.expand("../assets", __DIR__)
  ]

config :dart_sass,
  version: "1.54.3",
  default: [
    args: ~w(css/app.scss ../priv/static/assets/app.css.tailwind),
    cd: Path.expand("../assets", __DIR__)]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

config :undi_online, Oban,
  repo: UndiOnline.Repo,
  queues: [default: 10, mailers: 20, high: 50, low: 5],
  plugins: [
    {Oban.Plugins.Pruner, max_age: (3600 * 24)},
    {Oban.Plugins.Cron,
      crontab: [
       # {"0 2 * * *", UndiOnline.Workers.DailyDigestWorker},
       # {"@reboot", UndiOnline.Workers.StripeSyncWorker}
     ]}
  ]



# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{config_env()}.exs"
