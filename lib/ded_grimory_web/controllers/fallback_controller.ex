defmodule DedGrimoryWeb.FallbackController do
  @moduledoc """
  Translates controller action results into valid `Plug.Conn` responses.

  See `Phoenix.Controller.action_fallback/1` for more details.
  """
  use DedGrimoryWeb, :controller

  # This clause handles errors returned by Ecto's insert/update/delete.
  def call(conn, {:error, %Ecto.Changeset{} = changeset}) do
    conn
    |> put_status(:unprocessable_entity)
    |> put_view(json: DedGrimoryWeb.ChangesetJSON)
    |> render(:error, changeset: changeset)
  end

  def call(conn, {:error, :not_found}) do
    conn
    |> put_status(:not_found)
    |> put_view(html: DedGrimoryWeb.ErrorHTML, json: DedGrimoryWeb.ErrorJSON)
    |> render(:"404")
  end

  def call(conn, {:error, :unprocessable_entity}) do
    conn
    |> put_status(:unprocessable_entity)
    |> put_view(html: DedGrimoryWeb.ErrorHTML, json: DedGrimoryWeb.ErrorJSON)
    |> render(:"422")
  end

  def call(conn, {:error, :internal_server_error}) do
    conn
    |> put_status(:internal_server_error)
    |> put_view(html: DedGrimoryWeb.ErrorHTML, json: DedGrimoryWeb.ErrorJSON)
    |> render(:"500")
  end
end
