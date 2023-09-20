defmodule DedGrimory.Grimory.Magic do
  # IMPORTANTE
  # * Implemetar os campos relevantes que ainda não estão na tabela
  # * Implemetar o campo "effect area"
  # * Revisar os campos da tabela de magias
  # * Otimizar o campo "range"

  use Ecto.Schema

  import Ecto.Changeset

  alias DedGrimory.Grimory.Book
  alias DedGrimory.Grimory.Magic
  alias DedGrimory.Type

  @permitted_columns [
    :name,
    :level,
    :description,
    :range,
    :components,
    :book_id,
    :school,
    :casting_time,
    :material,
    :buff_description,
    :ritual,
    :concentration
  ]

  @derive {Jason.Encoder, only: [:id | @permitted_columns]}

  schema "magics" do
    field :name, :string
    field :level, :integer
    field :description, :string
    field :buff_description, :string
    field :range, Type.Range
    field :components, {:array, :string}
    field :school, :string
    field :casting_time, :string
    field :material, :string
    field :ritual, :boolean, default: false
    field :concentration, :boolean, default: false

    belongs_to :book, Book
  end

  @type t() :: %Magic{
          name: String.t(),
          level: non_neg_integer,
          description: String.t(),
          buff_description: String.t(),
          range: float(),
          components: [String.t(), ...],
          book_id: non_neg_integer(),
          school: String.t(),
          casting_time: String.t(),
          material: String.t(),
          ritual: boolean(),
          concentration: boolean()
        }

  @spec changeset(
          %Magic{},
          :invalid | %{optional(:__struct__) => none, optional(atom | binary) => any}
        ) :: Ecto.Changeset.t()
  @doc false
  def changeset(magic = %Magic{}, attrs) do
    magic
    |> cast(attrs, @permitted_columns)
    |> format_name()
    |> format_description()
    |> validate_name()
    |> validate_level()
    |> validate_description()
    |> validate_range()
    |> validate_components()
    |> validate_book()
    |> validate_school()
    |> validate_casting_time()
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

  defp format_description(%Ecto.Changeset{} = changeset) do
    case get_change(changeset, :description) do
      nil ->
        changeset

      description ->
        formated_description = String.trim(description)

        put_change(changeset, :description, formated_description)
    end
  end

  # Se "1 meters" -> "1 meter"
  # Se "2 meter" -> "1 meters"
  # Se "," -> "."
  # Se "1.8" -> "1.5"
  defp format_range(%Ecto.Changeset{} = changeset) do
    range =
      changeset
      |> get_change(:range)
      |> String.trim()

    cond do
      range == "1 meters" ->
        changeset
        |> put_change(:range, "1 meter")
        |> format_range()

      range =~ ~r/^[0-9.]+ meter$/ ->
        changeset
        |> put_change(:range, range <> "s")
        |> format_range()

      range =~ ~r/,/ ->
        formated_range = String.replace(range, ",", ".")

        changeset
        |> put_change(:range, formated_range)
        |> format_range()
    end
  end

  defp validate_name(%Ecto.Changeset{} = changeset) do
    changeset
    |> validate_required([:name], message: "Informe o nome desta magia")
    |> check_constraint(:name,
      name: :check_name_format,
      message: "O nome desta magia não pode conter caracteres especiais"
    )
    |> unique_constraint(:name, message: "Esta magia ja foi registrada")
  end

  defp validate_level(%Ecto.Changeset{} = changeset) do
    changeset
    |> validate_required([:level], message: "Informe o nivel de conjuração desta magia")
    |> check_constraint(:level,
      name: :check_level_range,
      message: "O nivel da magia deve estar entre 0 e 9"
    )
  end

  defp validate_description(%Ecto.Changeset{} = changeset) do
    changeset
    |> validate_required([:description], message: "Informe a descrição desta magia")
  end

  defp validate_range(%Ecto.Changeset{} = changeset) do
    changeset
    |> validate_required([:range], message: "Informe o alcançe da magia")
    |> check_constraint(:range,
      name: :check_range_format,
      message: "Tempo de conjuração informado invalido"
    )
  end

  defp validate_components(%Ecto.Changeset{} = changeset) do
    changeset
    |> validate_required([:components], message: "Informe a lista de componetes desta magia")
    |> check_constraint(:components,
      name: :check_components_types,
      message: "Esta lista de componentes é invalida"
    )
  end

  defp validate_book(%Ecto.Changeset{} = changeset) do
    changeset
    |> validate_required([:book_id], message: "Informe o livro em que esta magia esta registrada")
    |> assoc_constraint(:book, message: "Esta magia esta sendo inserida em um livro invalido")
  end

  defp validate_school(%Ecto.Changeset{} = changeset) do
    changeset
    |> validate_required([:school],
      message: "Informe a escola desta magia"
    )
    |> check_constraint(:school,
      name: :check_school_types,
      message: "Esta escola de magia é desconhecida"
    )
  end

  defp validate_casting_time(%Ecto.Changeset{} = changeset) do
    changeset
    |> validate_required([:casting_time],
      message: "Informe o tempo de conjuração da magia"
    )
    |> check_constraint(:casting_time,
      name: :check_casting_time_format,
      message: "O tempo de conjuração informado é invalido"
    )
  end
end
