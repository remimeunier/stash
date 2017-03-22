alias StashIt.Accounts.User
defimpl Canada.Can, for: User do

	#alias StashIt.Repo

  def can?(user, :show, %User{id: user_id }) do
  	user.id == user_id
  end

  def can?(user, :index, %User{id: user_id }) do
    user.id == user_id
  end

  def can?(%User{}, action, %User{}), do: false
  def can?(_, action, _), do: false

end

