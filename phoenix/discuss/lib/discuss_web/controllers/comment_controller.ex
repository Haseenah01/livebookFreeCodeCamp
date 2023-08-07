defmodule DiscussWeb.CommentController do
  use DiscussWeb, :controller

  alias Discuss.Discussions
  alias Discuss.Discussions.Comment

  def index(conn, _params) do
    comments = Discussions.list_comments()
    render(conn, :index, comments: comments)
  end

  def new(conn, _params) do
    changeset = Discussions.change_comment(%Comment{})
    render(conn, :new, changeset: changeset)
  end

  def create(conn, %{"comment" => comment_params}) do
    case Discussions.create_comment(comment_params) do
      {:ok, comment} ->
        conn
        |> put_flash(:info, "Comment created successfully.")
        |> redirect(to: ~p"/comments/#{comment}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :new, changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    comment = Discussions.get_comment!(id)
    render(conn, :show, comment: comment)
  end

  def edit(conn, %{"id" => id}) do
    comment = Discussions.get_comment!(id)
    changeset = Discussions.change_comment(comment)
    render(conn, :edit, comment: comment, changeset: changeset)
  end

  def update(conn, %{"id" => id, "comment" => comment_params}) do
    comment = Discussions.get_comment!(id)

    case Discussions.update_comment(comment, comment_params) do
      {:ok, comment} ->
        conn
        |> put_flash(:info, "Comment updated successfully.")
        |> redirect(to: ~p"/comments/#{comment}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :edit, comment: comment, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    comment = Discussions.get_comment!(id)
    {:ok, _comment} = Discussions.delete_comment(comment)

    conn
    |> put_flash(:info, "Comment deleted successfully.")
    |> redirect(to: ~p"/comments")
  end
end
