
DROP TABLE if exists users;

CREATE TABLE users (
  id INTEGER PRIMARY KEY,
  fname TEXT NOT NULL,
  lname TEXT NOT NULLs
);

DROP TABLE if exists questions;

CREATE TABLE questions (
  id INTEGER PRIMARY KEY,
  title TEXT NOT NULL,
  body TEXT NOT NULL,
  user_id INTEGER NOT NULL,

  FOREIGN KEY (user_id) REFERENCES users(id)
);

DROP TABLE if exists question_follows;

CREATE TABLE question_follows (
  id INTEGER PRIMARY KEY,
  user_id INTEGER NOT NULL,
  q_id INTEGER NOT NULL,

  FOREIGN KEY (user_id) REFERENCES users(id),
  FOREIGN KEY (q_id) REFERENCES questions(id)
);

DROP TABLE if exists replies;

CREATE TABLE replies (
  id INTEGER PRIMARY KEY,
  body TEXT NOT NULL,
  q_id INTEGER NOT NULL,
  parent_id INTEGER,
  user_id INTEGER NOT NULL,

  FOREIGN KEY (q_id) REFERENCES questions(id),
  FOREIGN KEY (parent_id) REFERENCES replies(id),
  FOREIGN KEY (user_id) REFERENCES users(id)
);

DROP TABLE if exists question_likes;

CREATE TABLE question_likes (
  id INTEGER PRIMARY KEY,
  likes INTEGER,
  q_id INTEGER NOT NULL,
  user_id INTEGER NOT NULL,

  FOREIGN KEY (q_id) REFERENCES questions(id),
  FOREIGN KEY (user_id) REFERENCES users(id)
);


INSERT INTO
  users (fname, lname)
VALUES
  ('Carson', 'Judge'),
  ('Kevin', 'Moore');

INSERT INTO
  questions (title, body, user_id)
VALUES
  ('Time', 'What time is it?', (SELECT id FROM users WHERE fname = 'Carson' AND lname = 'Judge')),
  ('Date', 'What day is it?', (SELECT id FROM users WHERE fname = 'Kevin' AND lname = 'Moore'));

INSERT INTO
  question_follows (user_id, q_id)
VALUES
  ((SELECT id FROM users WHERE fname = 'Carson' AND lname = 'Judge'),
    (SELECT id FROM questions WHERE title = 'Time')),
  ((SELECT id FROM users WHERE fname = 'Kevin' AND lname = 'Moore'),
    (SELECT id FROM questions WHERE title = 'Date')),
  ((SELECT id FROM users WHERE fname = 'Carson' AND lname = 'Judge'),
    (SELECT id FROM questions WHERE title = 'Date'));

INSERT INTO
  replies(body, q_id, parent_id, user_id)
VALUES
  ("Noon", (SELECT id FROM questions WHERE title = 'Time'), NULL,
    (SELECT id FROM users WHERE fname = 'Carson' AND lname = 'Judge')),
  ("Tuesday", (SELECT id FROM questions WHERE title = 'Date'), NULL,
    (SELECT id FROM users WHERE fname = 'Kevin' AND lname = 'Moore')),
  ("No it's Wednesday", (SELECT id FROM questions WHERE title = 'Date'),
    2, (SELECT id FROM users WHERE fname = 'Kevin' AND lname = 'Moore'));

  INSERT INTO
    question_likes (q_id, user_id)
  VALUES
    ((SELECT id FROM questions WHERE title = 'Time'),
      (SELECT id FROM users WHERE fname = 'Kevin' AND lname = 'Moore')),
    ((SELECT id FROM questions WHERE title = 'Date'),
      (SELECT id FROM users WHERE fname = 'Kevin' AND lname = 'Moore'));
