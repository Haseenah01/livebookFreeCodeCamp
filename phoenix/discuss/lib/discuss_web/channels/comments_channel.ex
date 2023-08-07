defmodule DiscussWeb.CommentsChannel do
  use DiscussWeb, :channel
  #alias Discuss.Discussions
  alias Discuss.Discussions.Topic
  alias Discuss.Discussions.Comment
  alias Discuss.Repo

  def join("comments:" <> topic_id, _params, socket) do
    #IO.puts("+++++++++")
    #IO.puts(name)
    topic_id = String.to_integer(topic_id)
    topic = Topic
      |> Repo.get(topic_id)
      |> Repo.preload(:comments)

    #{:ok, %{hey: "there"}, socket}
    {:ok, %{comments: topic.comments}, assign(socket, :topic, topic)}
  end

  def handle_in(name, %{"content" => content}, socket) do
    #IO.puts("+++++++++")
    #IO.puts(name)
    #IO.inspect(message)
    topic = socket.assigns.topic
    user_id = socket.assigns.user_id

    changeset = topic
    |> Ecto.build_assoc(:comments, user_id: user_id)
    |> Topics.Comment.changeset(%{content: content})

    case Repo.insert(changeset) do
      {:ok, comment} ->
        #DiscussWeb.Endpoint.
        broadcast!(socket, "comments:#{socket.assigns.topic.id}:new",
        %{comment: comment})

        {:reply, :ok, socket}
      {:error, _reason} ->
        {:reply, {:error, %{errors: changeset}}, socket}
    end
  end
end
