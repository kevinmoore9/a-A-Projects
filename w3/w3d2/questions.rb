require 'sqlite3'
require 'singleton'
require_relative 'baseclass.rb'

class QuestionsDB < SQLite3::Database
  include Singleton

  def initialize
    super('questions.db')
    self.type_translation = true
    self.results_as_hash = true
  end
end


class Question < ModelBase
  attr_accessor :title, :body, :user_id, :id

  def self.find_by_author_id(author_id)
    author = QuestionsDB.instance.execute(<<-SQL, author_id)
      SELECT
        *
      FROM
        questions
      WHERE
        user_id = ?
    SQL
    return nil if author.empty?
    author.map { |question| Question.new(question) }
  end

  def initialize(options = {})
    @id = options['id']
    @title = options['title']
    @body = options['body']
    @user_id = options['user_id']
  end

  def update
    raise "#{self} does not exist" unless @id
    QuestionsDB.instance.execute(<<-SQL, @title, @body, @user_id, @id)
      UPDATE
        questions
      SET
        @title = ?, @body = ?, @user_id = ?
      WHERE
        @id = ?
    SQL
  end

  def create
    raise "#{self} already exists" if @id
    QuestionsDB.instance.execute(<<-SQL, @title, @body, @user_id)
      INSERT INTO
        questions (title, body, user_id)
      VALUES
        (?, ?, ?)
    SQL
    @id = QuestionsDB.instance.last_insert_row_id
  end

  def author
    a = QuestionsDB.instance.execute(<<-SQL, @user_id)
    SELECT
      fname,
      lname
    FROM
      users
    WHERE
      id = ?
    SQL
    return nil if a.empty?
    "#{a.first.values.first} #{a.first.values.last}"
  end

  def replies
    Reply.find_by_question_id(@id)
  end

  def followers
    QuestionFollow.followers_for_question_id(@id)
  end

  def self.most_followed(n)
    QuestionFollow.most_followed_questions(n)
  end

  def likers
    QuestionLike.likers_for_question_id(@id)
  end

  def num_likes
    QuestionLike.num_likes_for_question_id(@id)
  end

  def self.most_liked(n)
    QuestionLike.most_liked_questions(n)
  end

end
