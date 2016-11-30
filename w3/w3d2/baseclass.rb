require 'byebug'

class ModelBase
  TABLES = {
    'Question' => 'questions',
    'User' => 'users',
    'Reply' => 'replies',
    'QuestionLike' => 'question_likes',
    'QuestionFollow' => 'question_follows',
  }.freeze

  def self.find_by_id(id)
    id_hash = QuestionsDB.instance.execute(<<-SQL, id)
      SELECT
        *
      FROM
        #{TABLES[self.to_s]}
      WHERE
        id = ?
    SQL
    return nil if id_hash.empty?
    self.new(id_hash.first)
  end

  def self.all
    all = QuestionsDB.instance.execute(<<-SQL)
      SELECT
        *
      FROM
        #{TABLES[self.to_s]}
    SQL
    all.map { |el| self.new(el) }
  end

  def save
    update if @id
    create unless @id
  end
end
