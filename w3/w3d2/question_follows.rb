require_relative 'questions'

class QuestionFollow
  attr_accessor :user_id, :q_id, :id

  def self.followers_for_question_id(question_id)
    f = QuestionsDB.instance.execute(<<-SQL, question_id)
    SELECT
      *
    FROM
      users
    JOIN question_follows
      ON users.id = question_follows.user_id
    WHERE
      question_follows.q_id = ?
    SQL
    return nil if f.empty?
    f.map { |follow| User.new(follow) }
  end

  def self.followed_questions_for_user_id(user_id)
    f = QuestionsDB.instance.execute(<<-SQL, user_id)
    SELECT
      *
    FROM
      questions
    JOIN question_follows
      ON question_follows.q_id = questions.id
    WHERE
      question_follows.user_id = ?
    SQL
    f.map { |follow| Question.new(follow) }
  end

  def initialize(options = {})
    @id = options['id']
    @user_id = options['user_id']
    @q_id = options['q_id']
  end

  def self.most_followed_questions(n)
    most = QuestionsDB.instance.execute(<<-SQL)
    SELECT
      questions.*
    FROM
      question_follows
    JOIN
      questions ON question_follows.q_id = questions.id
    GROUP BY
      questions.id
    ORDER BY
      COUNT(*) DESC
    SQL
    most[0...n].map { |question| Question.new(question) }
  end

end
