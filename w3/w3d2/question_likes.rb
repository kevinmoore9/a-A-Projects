require_relative 'questions'
require_relative 'users'
class QuestionLike
  attr_accessor :likes, :q_id, :user_id, :id

  def self.find_by_id(id)
    id_hash = QuestionsDB.instance.execute(<<-SQL, id)
    SELECT
      *
    FROM
      question_likes
    WHERE
      id = ?
    SQL
    return nil if id_hash.empty?
    QuestionLike.new(id_hash.first)
  end

  def initialize(options = {})
    @id = options['id']
    @likes = options['likes']
    @q_id = options['q_id']
    @user_id = options['user_id']
  end

  def self.likers_for_question(question_id)
    likers = QuestionsDB.instance.execute(<<-SQL, question_id)
      SELECT
        *
      FROM
        users
      JOIN
        question_likes ON question_likes.user_id = users.id
      WHERE
        question_likes.q_id = ?
    SQL
    return nil if likers.empty?
    likers.map { |liker| User.new(liker) }
  end

  def self.num_likes_for_question_id(question_id)
    likers = QuestionsDB.instance.execute(<<-SQL, question_id)
      SELECT
        COUNT(*)
      FROM
        users
      JOIN question_likes
        ON question_likes.user_id = users.id
      GROUP BY
        question_likes.q_id
      HAVING
        question_likes.q_id = ?
    SQL
    likers.first.values.first
  end

  def self.liked_questions_for_user_id(user_id)
    questions = QuestionsDB.instance.execute(<<-SQL, user_id)
      SELECT
        questions.*
      FROM
        questions
      JOIN question_likes
        ON questions.id = question_likes.q_id
      JOIN users
        ON users.id = question_likes.user_id
      WHERE
        users.id = ?
    SQL
    return nil if questions.empty?
    questions.map { |q| Question.new(q) }
  end

  def self.most_liked_questions(n)
    liked = QuestionsDB.instance.execute(<<-SQL)
      SELECT
        questions.*
      FROM
        questions
      JOIN
        question_likes ON questions.id = question_likes.q_id
      GROUP BY
        questions.id
      ORDER BY
        COUNT(questions.id) DESC
    SQL
    return nil if liked.empty?
    liked[0...n].map { |question| Question.new(question) }
  end
end
