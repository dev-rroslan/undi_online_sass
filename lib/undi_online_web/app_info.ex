defmodule UndiOnlineWeb.AppInfo do
  @moduledoc """
  Convenience functions for displaying company info.
  """
  use Ecto.Schema

  embedded_schema do
    field :app_name, :string, default: Application.compile_env(:undi_online, :app_name)
    field :page_url, :string, default: Application.compile_env(:undi_online, :page_url)
    field :company_name, :string, default: Application.compile_env(:undi_online, :company_name)
    field :company_address, :string, default: Application.compile_env(:undi_online, :company_address)
    field :company_zip, :string, default: Application.compile_env(:undi_online, :company_zip)
    field :company_city, :string, default: Application.compile_env(:undi_online, :company_city)
    field :company_state, :string, default: Application.compile_env(:undi_online, :company_state)
    field :company_country, :string, default: Application.compile_env(:undi_online, :company_country)
    field :contact_name, :string, default: Application.compile_env(:undi_online, :contact_name)
    field :contact_phone, :string, default: Application.compile_env(:undi_online, :contact_phone)
    field :contact_email, :string, default: Application.compile_env(:undi_online, :contact_email)
  end

  def info do
    %__MODULE__{}
  end

  def app_name, do: info().app_name

  def page_url, do: info().page_url

  def company_name, do: info().company_name

  def address, do: info().company_address

  def zip, do: info().company_zip

  def city, do: info().company_city
end
