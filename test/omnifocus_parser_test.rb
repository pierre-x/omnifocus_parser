require 'test_helper'
require 'sqlite3'


class OmnifocusParserTest < Minitest::Test
  
  include OmnifocusParser

  def test_that_it_has_a_version_number
    refute_nil ::OmnifocusParser::VERSION
  end

# TODO make better test
# contents.xml is not commited yet, because it contains my personnal TODO list
  def test_show_a_simple_parse
    @rank = 1

    self.xml_file= File.new('test/contents.xml')

    # Open a database
    db = SQLite3::Database.new "life_planner.db"

    db.execute <<-SQL
      DROP TABLE IF EXISTS tasks;
    SQL

    # Create a table
    rows = db.execute <<-SQL
      create table tasks (
        id INTEGER PRIMARY KEY NOT NULL,
        name TEXT NOT NULL,
        note TEXT,
        rank INTEGER,
        parent INTEGER,
        FOREIGN KEY(parent) REFERENCES tasks(id)
      );
    SQL

    @count = 0
    root_node = self.get_root_node
    disp_node root_node, 0

    insert_node_in_db db, root_node, 0

    puts @count
 # FIXME mon dossier TODO list et tout ce qui est dedans n'apparait nulle part!

    # FIXME il manque des noeuds! Car on ne parse pas à l'intérieur des dossiers?
  end

  # recursive function to display the entire graph
  def disp_node(node, depth)
#    mon_string = ''
#    depth.times {mon_string+='  '}
#    mon_string += "- #{node.name}"
#    `echo "#{mon_string}" >> toto.txt`

    # depth.times {print '  '}
   # puts "- #{node.name}"
    self.graph.each_adjacent node do |adj_node|
      disp_node adj_node, depth+1
    end
  end

  def insert_node_in_db(db, node, parent)
    @count = @count + 1
    if self.is_node_a_leaf?(node)
      @rank = @rank+1
      rank  = @rank
    else
      rank  = 0
    end

    db.execute 'INSERT INTO tasks(name, note, rank, parent) VALUES (?,?,?,?)', node.name, node.note, rank, parent
    self.graph.each_adjacent node do |adj_node|
      insert_node_in_db db, adj_node, db.last_insert_row_id
    end
  end

end
