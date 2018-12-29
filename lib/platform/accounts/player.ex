defmodule Platform.Accounts.Player do
  use Ecto.Schema
  import Ecto.Changeset
  alias Platform.Products.{Game, Gameplay}

  schema "players" do
    many_to_many(:games, Game, join_through: Gameplay)

    field(:display_name, :string)
    field(:password, :string, virtual: true)
    field(:password_digest, :string)
    field(:score, :integer, default: 0)
    field(:username, :string, unique: true)

    timestamps()
  end

  @doc false
  def changeset(player, attrs) do
    player
    |> cast(attrs, [:display_name, :password, :username, :score])
    |> validate_required([:username])
    |> unique_constraint(:username)
    |> validate_password()
  end

  def registration_changeset(player, attrs) do
    player
    |> cast(attrs, [:password, :username])
    |> validate_required([:username, :password])
    |> unique_constraint(:username)
    |> validate_password()
  end

  defp validate_password(changeset) do
    changeset
    |> validate_length(:username, min: 2, max: 100)
    |> validate_length(:password, min: 2, max: 100)
    |> put_pass_digest()
  end

  defp put_pass_digest(%Ecto.Changeset{valid?: true, changes: %{password: pass}} = changeset) do
    changeset
    |> put_change(:password_digest, Comeonin.Bcrypt.hashpwsalt(pass))
  end

  defp put_pass_digest(changeset), do: changeset
end
