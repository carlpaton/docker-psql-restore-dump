This will create 2 containers `postgres-db` and `postgres-copy`, db is the database and copy is a volitile container used to copy your `mydump.sql` file to a volumn, from there the db container will have access to it.

# download latest image and spin up
From powershell `run.ps1`

# create some tables / data
Connect with an editor (PgAdmin, Dbeaver) to `localhost:5432` and add some data to be used with the dump

`
CREATE TABLE public.staff_master (
id serial NOT NULL,
first_name text,
surname text,
email text,
insert_date date,
salary real,  
CONSTRAINT employee_pkey PRIMARY KEY (id));
`

`
INSERT INTO public.staff_master
(first_name, surname, email, insert_date, salary)
VALUES
('carl psql', 'my surname', 'email@domain.com', NOW(), 0);
`

# create interactive session
From powershell `docker exec -it postgres-db bash`

# dump something to test with from 'postgres'
From powershell `pg_dump -U postgres -v -Fc postgres -f /dump/mydump.dump`

# Create 'mydb'
From powershell `psql -U postgres -c "CREATE DATABASE mydb OWNER = postgres TABLESPACE pg_default;"`

# restore dump
From powershell `pg_restore -U postgres -d mydb < /dump/mydump.dump`

# quit
CTRL+C
Exit
