defmodule DedGrimory.Grimory.Magic do
  # IMPORTANTE
  # * Otimizar a checagem dos livros
  # * Otimizar a checagem do tempo de conjuração

  use Ecto.Schema

  import Ecto.Changeset

  alias DedGrimory.Grimory.Magic

  schema "magics" do
    field :name, :string
    field :level, :integer
    field :description, :string
    field :buff_description, :string
    field :range, :float
    field :components, {:array, :string}
    field :book, :string, default: "Livro do Jogador"
    field :school, :string
    field :casting_time, :string, default: "action"
    field :material, :string
    field :ritual, :boolean, default: false
    field :concentration, :boolean, default: false
  end

  @type t() :: %Magic{
          name: String.t(),
          level: non_neg_integer,
          description: String.t(),
          buff_description: String.t(),
          range: float(),
          components: [String.t(), ...],
          book: String.t(),
          school: String.t(),
          casting_time: String.t(),
          material: String.t(),
          ritual: boolean(),
          concentration: boolean()
        }

  @permitted_columns [
    :name,
    :level,
    :description,
    :range,
    :components,
    :book,
    :school,
    :casting_time,
    :material,
    :buff_description,
    :ritual,
    :concentration
  ]

  @permitted_schools [
    "abjuration",
    "alteration",
    "conjuration",
    "divination",
    "enchantment",
    "illusion",
    "invocation",
    "necromancy"
  ]

  @permitted_components ["M", "V", "S"]

  @spec changeset(
          %Magic{},
          :invalid | %{optional(:__struct__) => none, optional(atom | binary) => any}
        ) :: Ecto.Changeset.t()
  def changeset(magic = %Magic{}, attrs) do
    magic
    |> cast(attrs, @permitted_columns)
    |> validate_name()
    |> validate_level()
    |> validate_description()
    |> validate_range()
    |> validate_components()
    |> validate_book()
    |> validate_school()
    |> validate_casting_time()
  end

  defp validate_name(%Ecto.Changeset{} = changeset) do
    changeset
    |> validate_required([:name], message: "Informe o nome da magia")
    |> unsafe_validate_unique([:name, :company_id], DedMagicsApi.Repo,
      message: "Esta magia ja foi registrada"
    )
    |> unique_constraint([:name, :company_id], message: "Esta magia ja foi registrada")
  end

  defp validate_level(%Ecto.Changeset{} = changeset) do
    changeset
    |> validate_required([:level], message: "Informe o nivel de conjuração desta magia")
    |> validate_inclusion(
      :level,
      0..9,
      message: "O nivel da magia deve estar entre 0 e 9"
    )
  end

  defp validate_description(%Ecto.Changeset{} = changeset) do
    changeset
    |> validate_required([:description], message: "Informe a descrição desta magia")
  end

  defp validate_range(%Ecto.Changeset{} = changeset) do
    changeset
    |> validate_required([:range], message: "Informe o alcançe desta magia")
    |> validate_number(:range,
      greater_than_or_equal_to: 0,
      message: "O alcançe da magia não pode ser inferior a 0"
    )
  end

  defp validate_components(%Ecto.Changeset{} = changeset) do
    changeset
    |> validate_required([:components], message: "Informe a lista de componetes desta magia")
    |> validate_subset(:components, @permitted_components,
      message: "Esta lista de componentes é invalida"
    )
  end

  defp validate_book(%Ecto.Changeset{} = changeset) do
    changeset
    |> validate_required([:book],
      message: "Informe o livro em que esta magia esta registrada"
    )
  end

  defp validate_school(%Ecto.Changeset{} = changeset) do
    changeset
    |> validate_required([:school],
      message: "Informe a escola desta magia"
    )
    |> validate_inclusion(:school, @permitted_schools,
      message: "Esta escola de magia é desconhecida"
    )
  end

  defp validate_casting_time(%Ecto.Changeset{} = changeset) do
    changeset
    |> validate_required([:casting_time],
      message: "Informe o tempo de conjuração desta magia"
    )
  end
end
