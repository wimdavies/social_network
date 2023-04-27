-- First, you'd need to truncate the table - this is so our table is emptied between each test run,
-- so we can start with a fresh state.
-- (RESTART IDENTITY resets the primary key)

TRUNCATE TABLE posts RESTART IDENTITY; -- replace with your own table name.

-- Below this line there should only be `INSERT` statements.
-- Replace these statements with your own seed data.

INSERT INTO posts (title, content, number_of_views, user_account_id) VALUES ('Birthday', '30 today!', 15, 1);
INSERT INTO posts (title, content, number_of_views, user_account_id) VALUES ('Funeral', 'Dead today!', 30, 1);
INSERT INTO posts (title, content, number_of_views, user_account_id) VALUES ('Off to the shops', 'Got some beans', 500, 2);