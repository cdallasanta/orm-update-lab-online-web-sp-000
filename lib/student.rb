require_relative "../config/environment.rb"

class Student
  # Remember, you can access your database connection anywhere in this class
  #  with DB[:conn]
  attr_accessor :id, :name, :grade

  def initialize(id = nil, name, grade)
    self.name = name
    self.grade = grade
  end

  def save
    if self.id
      self.update
    else
      sql = <<-SQL
        INSERT INTO students (name, grade)
        VALUES (?, ?);
      SQL

      DB[:conn].execute(sql, self.name, self.grade)
      self.id = DB[:conn].execute('SELECT last_insert_rowid() FROM students;')[0][0]
    end
  end

  def create(:name, :grade)
    new_student = Student.new(name, grade)
    new_student.save
  end

  def update
    sql = <<-SQL
      UPDATE students
      SET
  end

  def self.create_table
    sql = <<-SQL
      CREATE TABLE IF NOT EXISTS students(
        id INTEGER PRIMARY KEY,
        name TEXT,
        grade INTEGER
      );
    SQL

    DB[:conn].execute(sql)
  end
end
