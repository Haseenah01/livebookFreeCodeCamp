defmodule Discuss.Discussions.Comment do
  use Ecto.Schema
  import Ecto.Changeset

  @derive {Jason.Encoder, only: [:content]}

  schema "comments" do
    field :content, :string
    belongs_to :user, Discuss.Accounts.User
    belongs_to :topic, Discuss.Discussions.Topic

    timestamps()
  end

  def changeset(comment, attrs \\ %{}) do
    comment
    |> cast(attrs, [:content])
    |> validate_required([:content, :topic_id, :user_id])
  end
end
