defmodule DiscussWeb.TopicController do
  use DiscussWeb, :controller

  alias Discuss.Discussions
  alias Discuss.Discussions.Topic
  #alias Discuss.Accounts
  #alias Discuss.Accounts.User
  alias Discuss.Auth.Authorizer

  plug DiscussWeb.Plugs.RequireAuth when action in [:new, :create, :edit, :update, :delete]
  plug :check_topic_owner when action in [:update, :edit, :delete]

  def index(conn, _params) do
    topics = Discussions.list_topics()
    render(conn, :index, topics: topics)
  end

  def new(conn, _params) do
    changeset = Discussions.change_topic(%Topic{})
    render(conn, :new, changeset: changeset)
  end

  def create(conn, %{"topic" => topic_params}) do
    #user_id = topic_params["user_id"]
    #user = Accounts.get_user!(user_id)
    #topic_params = Map.put(topic_params, "user_id", user.id)
    changeset = conn.assigns.user
      |> Ecto.build_assoc(:topics)
      |> Topic.changeset(topic_params)

    case Discuss.Repo.insert(changeset) do
      {:ok, topic} ->
        conn
        |> put_flash(:info, "Topic created successfully.")
        |> redirect(to: ~p"/topics/#{topic}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :new, changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    topic = Discussions.get_topic!(id)
    render(conn, :show, topic: topic)
  end

  def edit(conn, %{"id" => id}) do
    topic = Discussions.get_topic!(id)
    changeset = Discussions.change_topic(topic)
    render(conn, :edit, topic: topic, changeset: changeset)
  end

  def update(conn, %{"id" => id, "topic" => topic_params}) do
    topic = Discussions.get_topic!(id)

    case Discussions.update_topic(topic, topic_params) do
      {:ok, topic} ->
        conn
        |> put_flash(:info, "Topic updated successfully.")
        |> redirect(to: ~p"/topics/#{topic}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :edit, topic: topic, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    topic = Discussions.get_topic!(id)
    {:ok, _topic} = Discussions.delete_topic(topic)

    conn
    |> put_flash(:info, "Topic deleted successfully.")
    |> redirect(to: ~p"/topics")
  end

  defp check_topic_owner(conn, _params) do
    %{params: %{"id" => topic_id}} = conn
    topic = Discussions.get_topic!(topic_id)

    if Authorizer.can_manage?(conn.assigns.user, topic) do
     conn

    else
      conn
      |> put_flash(:error, "You cannot edit that")
      |> redirect(to: ~p"/topics")
      |> halt()
    end

    #def check_topic_owner(conn, _params) do
      #%{params: %{"id" => topic_id}} = conn

      #if Discussions.get_topic!(topic_id).user_id == conn.assigns.user.id do
       # conn
      #else
       # conn
        #|> put_flash(:error, "You cannot edit that")
        #|> redirect(to: ~p"/topics")
        #|> halt()
      #end
  end
end
