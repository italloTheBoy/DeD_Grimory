defmodule DedGrimory.Grimory.Book do
  use Ecto.Schema

  import Ecto.Changeset

  alias DedGrimory.Grimory.Book
  alias DedGrimory.Grimory.Magic

  @permitted_columns [:name]

  @derive {Jason.Encoder, only: [:id | @permitted_columns]}

  schema "books" do
    field :name, :string

    has_many :magics, Magic

    timestamps()
  end

  @spec changeset(
          %Book{},
          :invalid | %{optional(:__struct__) => none, optional(atom | binary) => any}
        ) :: Ecto.Changeset.t()
  @doc false
  def changeset(book, attrs) do
    book
    |> cast(attrs, @permitted_columns)
    |> format_name()
    |> validate_name()
  end

  defp format_name(%Ecto.Changeset{} = changeset) do
    case get_change(changeset, :name) do
      nil ->
        changeset

      name ->
        formated_name =
          name
          |> String.trim()
          |> String.downcase()
          |> String.replace(" ", "_")

        put_change(changeset, :name, formated_name)
    end
  end

  defp validate_name(%Ecto.Changeset{} = changeset) do
    changeset
    |> validate_required([:name], message: "Informe o nome deste livro")
    |> check_constraint(:name,
      name: :check_name_format,
      message: "O nome deste livro não pode conter caracteres especiais"
    )
    |> unique_constraint(:name, message: "Este livro ja foi")
  end
end
