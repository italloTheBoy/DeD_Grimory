defmodule DedGrimory.Repo.Migrations.CreateBooks do
  use Ecto.Migration

  def change do
    create table(:books) do
      add(:name, :string, null: false)

      timestamps()
    end

    create unique_index(:books, :name)

    create constraint(
             :books,
             :check_name_format,
             check: "name ~ '^[a-z]+[a-z_]+[a-z]+$|^[a-z]+$'"

           )

    alter table(:magics) do
      add(:book_id, references(:books), null: false)
    end

    create index(:magics, :book_id)
  end
end
