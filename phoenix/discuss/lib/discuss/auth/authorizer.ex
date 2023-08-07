defmodule Discuss.Auth.Authorizer do
  def can_manage?(user, topic) do
    user && user.id == topic.user_id
  end
end
