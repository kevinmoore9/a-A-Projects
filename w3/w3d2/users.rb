require_relative 'questions'

class User < ModelBase

  attr_accessor :fname, :lname, :id

  def self.find_by_name(fname, lname)
    name = QuestionsDB.instance.execute(<<-SQL, fname, lname)
    SELECT
      *
    FROM
      users
    WHERE
      fname = ? AND lname = ?
    SQL
    return nil if name.empty?
    name.map { |n| User.new(n) }
  end

  def initialize(options = {})
    @id = options['id']
    @fname, @lname = options['fname'], options['lname']
  end

  def update
    raise "#{self} does not exist" unless @id
    QuestionsDB.instance.execute(<<-SQL, @fname, @lname, @id)
      UPDATE
        users
      SET
        fname = ?, lname = ?
      WHERE
        id = ?
    SQL
  end

  def create
    raise "#{self} already exists" if @id
    QuestionsDB.instance.execute(<<-SQL, @fname, @lname)
      INSERT INTO
        users (fname, lname)
      VALUES
        (?, ?)
    SQL
    @id = QuestionsDB.instance.last_insert_row_id
  end

  def authored_questions
    Question.find_by_author_id(@id)
  end

  def authored_replies
    Reply.find_by_user_id(@id)
  end

  def followed_questions
    QuestionFollow.followed_questions_for_user_id(@id)
  end

  def liked_questions
    QuestionLike.liked_questions_for_user_id(@id)
  end

  def average_karma
    karma = QuestionsDB.instance.execute(<<-SQL, @id)
      SELECT
        CAST(COUNT(question_likes.id) AS FLOAT) / COUNT(DISTINCT(questions.id)) AS karma
      FROM
        questions
      LEFT OUTER JOIN question_likes
        ON question_likes.q_id = questions.id
      WHERE questions.user_id = ?
    SQL
    karma.first.values.first
  end

end
