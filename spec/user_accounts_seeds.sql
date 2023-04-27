TRUNCATE TABLE user_accounts RESTART IDENTITY; -- replace with your own table name.

-- Below this line there should only be `INSERT` statements.
-- Replace these statements with your own seed data.

INSERT INTO user_accounts (username, email_address) VALUES ('David', 'dave@aol.com');
INSERT INTO user_accounts (username, email_address) VALUES ('Anna', 'anna@aol.com');
INSERT INTO user_accounts (username, email_address) VALUES ('Will', 'will@aol.com');