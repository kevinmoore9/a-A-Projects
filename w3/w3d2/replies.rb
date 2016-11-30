require_relative 'questions'

class Reply
  attr_accessor :body, :q_id, :user_id, :parent_id, :id


  def initialize(options = {})
    @id = options['id']
    @body = options['body']
    @q_id = options['q_id']
    @user_id = options['user_id']
    @parent_id = options['parent_id']
  end

  def update
    raise "#{self} does not exist" unless @id
    QuestionsDB.instance.execute(<<-SQL, @body, @q_id, @user_id, @parent_id, @id)
      UPDATE
        replies
      SET
        @body = ?, @q_id = ?, @user_id = ?, @parent_id = ?
      WHERE
        @id = ?
    SQL
  end

  def create
    raise "#{self} already exists" if @id
    QuestionsDB.instance.execute(<<-SQL, @body, @q_id, @user_id, @parent_id)
      INSERT INTO
        replies (body, q_id, user_id, parent_id)
      VALUES
        (?, ?, ?, ?)
    SQL
    @id = QuestionsDB.instance.last_insert_row_id
  end

  def self.find_by_user_id(user_id)
    user = QuestionsDB.instance.execute(<<-SQL, user_id)
    SELECT
      *
    FROM
      replies
    WHERE
      user_id = ?
    SQL
    return nil if user.empty?
    user.map { |u| Reply.new(u) }
  end

  def self.find_by_question_id(q_id)
    q = QuestionsDB.instance.execute(<<-SQL, q_id)
    SELECT
      *
    FROM
      replies
    WHERE
      q_id = ?
    SQL
    return nil if q.empty?
    q.map { |question| Reply.new(question) }
  end

  def author
    a = QuestionsDB.instance.execute(<<-SQL, @user_id)
      SELECT
        fname,
        lname
      FROM
        users
      WHERE
        users.id = ?
    SQL
    return nil if a.empty?
    "#{a.first.values.first} #{a.first.values.last}"
  end

  def question
    q = QuestionsDB.instance.execute(<<-SQL, @q_id)
      SELECT
        *
      FROM
        questions
      WHERE
        questions.id = ?
    SQL
    return nil if q.empty?
    Question.new(q.first)
  end

  def parent_reply
    parent = QuestionsDB.instance.execute(<<-SQL, @parent_id)
      SELECT
        *
      FROM
        replies
      WHERE
        replies.id = ?
    SQL
    return nil if parent.empty?
    Reply.new(parent.first)
  end

  def child_replies
    child = QuestionsDB.instance.execute(<<-SQL, @id)
      SELECT
        *
      FROM
        replies
      WHERE
        parent_id = ?
    SQL
    return nil if child.empty?
    child.map { |c| Reply.new(c) }
  end

end
