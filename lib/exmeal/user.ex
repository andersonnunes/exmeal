defmodule Exmeal.User do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  @required_params [:name, :email, :cpf]

  @derive {Jason.Encoder, only: [:name, :email, :cpf, :id]}

  schema "users" do
    field :cpf, :string
    field :email, :string
    field :name, :string

    timestamps()
  end

  def changeset(struct \\ %__MODULE__{}, params) do
    struct
    |> cast(params, @required_params)
    |> validate_required(@required_params)
  end
end
