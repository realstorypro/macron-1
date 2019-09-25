class RenameStiKlassForEntries < ActiveRecord::Migration[5.2]
  def up
    tables = %w[Advertisement Discussion Article Event Podcast Product Video]
    tables.each do |tbl|
      execute("update entries set type = 'Entries::#{tbl}' where type = '#{tbl}'")
    end
  end

  def down
    tables = %w[Advertisement Discussion Article Event Podcast Product Video]
    tables.each do |tbl|
      execute("update entries set  type = '#{tbl}' where type = 'Entries::#{tbl}'")
    end
  end
end
