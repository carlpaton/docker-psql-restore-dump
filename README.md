This will create 2 containers `postgres-db` and `postgres-copy`, db is the database and copy is a volitile container used to copy your `mydump.sql` file to a volumn, from there the db container will have access to it.

# Download latest image and spin up
From powershell `run.ps1`

# Create some tables / data
_This step is not needed if you already have a dump file_

Connect with any editor (PgAdmin, Dbeaver) to `localhost:5432` with username `postgres` and password `postgres` then add some data to be used with the dump

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

# Create interactive session
From powershell `docker exec -it postgres-db bash`

`cd dump`

`dir`

This should then reflect the file you copied `mydump.sql`

You can also `CAT mydump.sql` but if its large your pc may fall on its head.

# Dump something to test with from 'postgres'
_This step is not needed if you already have a dump file_

From powershell `pg_dump -U postgres -v -Fc postgres -f /dump/mydump.dump`

`dir`

You should now see `mydump.dump` and `mydump.sql` where the dump file is the one you just created

# Create 'mydb'
From powershell `psql -U postgres -c "CREATE DATABASE mydb OWNER = postgres TABLESPACE pg_default;"`

# Restore dump
From powershell `pg_restore -U postgres -d mydb < /dump/mydump.dump`

# Quit
CTRL+C
Exit

# Alternative Copy
If the file is massive you can try this method to copy

`docker cp mydump.sql bd2f2aae3b84:/dump/mydump.sql`

.. where `bd2f2aae3b84` is the name of your container which you can get by running `docker ps --all`

You can then check the files on the container with `ls -l --block-size=M`
