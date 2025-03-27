CREATE TABLE messages (
    id int,
    user_name varchar(50),
    user_message varchar(100)
);

INSERT INTO messages (id,user_name,user_message) VALUES (1, 'Carlos da Silva', 'Hello World!!');

SELECT * FROM messages;