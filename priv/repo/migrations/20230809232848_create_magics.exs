defmodule DedGrimory.Repo.Migrations.CreateMagics do
  use Ecto.Migration

  alias DedGrimory.Type

  def change do
    create table(:magics) do
      add(:name, :varchar, null: false)
      add(:school, :varchar, null: false)
      add(:casting_time, :varchar, null: false)
      add(:material, :text)
      add(:buff_description, :text)
      add(:description, :text, null: false)
      add(:level, :integer, null: false)
      add(:range, Type.Range, null: false)
      add(:components, {:array, :text}, null: false)
      add(:ritual, :boolean, default: false)
      add(:concentration, :boolean, default: false)
    end

    create unique_index(:magics, :name)
    create index(:magics, :school)
    create index(:magics, :casting_time)
    create index(:magics, :material)
    create index(:magics, :buff_description)
    create index(:magics, :description)
    create index(:magics, :level)
    create index(:magics, :range)
    create index(:magics, :components)
    create index(:magics, :ritual)
    create index(:magics, :concentration)

    create constraint(
             :magics,
             :check_name_format,
             check: "name ~ '^[a-z]+[a-z_]+[a-z]+$|^[a-z]+$'"
           )

    create constraint(
             :magics,
             :check_casting_time_format,
             check: "casting_time IN (
                      '1 action',
                      '1 reaction',
                      '1 bonus action',
                      '1 minute',
                      '10 minutes',
                      '1 hour'
                    )"
           )

    create constraint(
             :magics,
             :check_range_format,
             check: "range IN (
                      'self',
                      'touch',
                      'sight',
                      )
                    OR range ~ '^1 meter$'
                    OR range ~ '^[0-9]+ meters$'
                    OR range ~ '^[0-9].[0-9]+ meters'"
           )

    create constraint(
             :magics,
             :check_level_range,
             check: "level >= 0 AND level <= 9"
           )

    create constraint(
             :magics,
             :check_components_types,
             check: "
                      ARRAY_LENGTH(components, 1) >= 1
                      and ARRAY_LENGTH(components, 1) <= 3
                      and components <@ ARRAY['M', 'V', 'S']
                    "
           )

    create constraint(
             :magics,
             :check_school_types,
             check: "school IN (
                      'abjuration',
                      'alteration',
                      'conjuration',
                      'divination',
                      'enchantment',
                      'illusion',
                      'invocation',
                      'necromancy'
                    )"
           )
  end
end
