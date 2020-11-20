-- Referencia:   https://www.realsystems.com.mx/blog/postgresql-13/post/consultas-utiles-en-postgresql-296
sudo su postgres
psql

CREATE USER capitulo_8_user WITH PASSWORD 'patata';

CREATE DATABASE capitulo_8_db;

-- ALTER ROLE capitulo_8_user SET client_encoding TO 'utf8';
-- ALTER ROLE capitulo_8_user SET default_transaction_isolation TO 'read committed';
-- ALTER ROLE capitulo_8_user SET timezone TO 'UTC';

GRANT ALL PRIVILEGES ON DATABASE capitulo_8_db TO capitulo_8_user;

\c capitulo_8_db;

set session authorization capitulo_8_user;  -- CAMBIAR EL USUARIO DENTRO DE LA CONSOLA DEL POSTGRES
select current_user, session_user;          -- DADOS DEL USUARIO ACTUAL

-- Falta executar:
-- REFERENCIA BIGSERIAL: https://www.youtube.com/watch?v=ZSzErySj3cI
DROP TABLE IF EXISTS usuarios;
CREATE TABLE usuarios(
                      id BIGSERIAL PRIMARY KEY,
                      usuario VARCHAR(20) NOT NULL UNIQUE,
                      contrasena VARCHAR(40) NOT NULL
                      );

DROP TABLE IF EXISTS notas;
CREATE TABLE notas (
                    id SERIAL PRIMARY KEY,
                    prioridad VARCHAR(10),
                    titulo VARCHAR(100),
                    contenido VARCHAR(200),
                    id_usuarios BIGINT REFERENCES usuarios (id)
                    );

-- ALTER TABLE notas OWNER TO capitulo_8_user;

psql -U capitulo_8_user capitulo_8_db
