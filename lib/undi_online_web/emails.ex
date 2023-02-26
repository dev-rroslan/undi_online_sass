defmodule UndiOnlineWeb.Emails do
  @moduledoc """
  This viewmodule is responsible for rendering the emails and the layouts
  for emails using the Phoenix.Swoosh library

  Can be used in the notifier by adding:

      use Phoenix.Swoosh, view: UndiOnlineWeb.Emails, layout: {UndiOnlineWeb.Emails, :layout}

  """
  use Phoenix.View,
    root: "lib/undi_online_web",
    namespace: UndiOnlineWeb

  use Phoenix.Component

  import UndiOnlineWeb.AppInfo
end
