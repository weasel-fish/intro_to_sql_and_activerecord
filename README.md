# Intro to SQL

# Intro to SQL

### Learning Goals:
- [x] Explain persistence, the need for using SQL, and difference between SQLite3 and SQL
    * Explore provided data through [DB Browser for SQLite Browser](https://sqlitebrowser.org/)
    * Also, the [Sqlite extension for VSCode](https://marketplace.visualstudio.com/items?itemName=alexcvzz.vscode-sqlite) is a good resource for navigating through your DB right within VSCode.
- [x] Perform CRUD actions on a single table
- [x] Explore how to use sqlite3 with ruby file
- [x] Perform CRUD actions across related tables

---
* **Explain persistence and the need for using SQL**
    * Persistence
        * Data is there no matter if we closed the program
    * Define SQL
        * SQL stands for Structured Query Language and is a language that allows us to do:
            * Store / persist information
            * Manipulate that information
        * What is sql is for?
            * Information persistence
            * Want stuff to stick around after the program ends
            * Allow our data manipulation code to be programming language agnostic
        * What kind of operations can we do in SQL?
            * CRUD
    * Explain the difference between SQLite and SQL**
        * SQL is a query language. Sqlite is an embeddable open source relational database management system (RDBMS). Other examples include PostgresQL, MySQL, SQLServer, Oracle Database. The first 2 of these are open source, the rest are not and require some sort of account to access. These are sometimes used for internal corporate databases.
 
    * Explore provided data through SQLite Browser**
        * Open ‘chinook.db’ in SQLite Browser
        * How to see the data?
        * How to open sqlite3 in terminal
        * Database schema

In order to use sqlite3 in our code, we'll want to install the [sqlite3 gem](https://github.com/sparklemotion/sqlite3-ruby). To do that, we can run:

```bash
bundle add sqlite3
```

If you've cloned this repo, the Gemfile already includes sqlite3. After you've done that, you can check out the [sample code they offer on their GitHub repo](https://github.com/sparklemotion/sqlite3-ruby). I've included it below for reference:

```rb
require "sqlite3"

# Open a database
db = SQLite3::Database.new "test.db"

# Create a table
rows = db.execute <<-SQL
  create table numbers (
    name varchar(30),
    val int
  );
SQL

# Execute a few inserts
{
  "one" => 1,
  "two" => 2,
}.each do |pair|
  db.execute "insert into numbers values ( ?, ? )", pair
end

# Find a few rows
db.execute( "select * from numbers" ) do |row|
  p row
end

# Create another table with multiple columns

db.execute <<-SQL
  create table students (
    name varchar(50),
    email varchar(50),
    grade varchar(5),
    blog varchar(50)
  );
SQL

# Execute inserts with parameter markers
db.execute("INSERT INTO students (name, email, grade, blog) 
            VALUES (?, ?, ?, ?)", ["Jane", "me@janedoe.com", "A", "http://blog.janedoe.com"])

db.execute( "select * from students" ) do |row|
  p row
end
```
    
If we want to play around with this code, we can copy it into our ./bin/console file and rename `db` to `DB`:

```rb
#!/usr/bin/env ruby

require "bundler/setup"
require "intro_to_sql"

# You can add fixtures and/or initialization code here to make experimenting
# with your gem easier. You can also use a different console, if you like.

# (If you use this, don't forget to add pry to your Gemfile!)
# require "pry"
# Pry.start

require "sqlite3"

# Open a database
DB = SQLite3::Database.new "test.db"

# Create a table
rows = DB.execute <<-SQL
  create table numbers (
    name varchar(30),
    val int
  );
SQL

# Execute a few inserts
{
  "one" => 1,
  "two" => 2,
}.each do |pair|
  DB.execute "insert into numbers values ( ?, ? )", pair
end

# Find a few rows
DB.execute( "select * from numbers" ) do |row|
  p row
end

# Create another table with multiple columns

DB.execute <<-SQL
  create table students (
    name varchar(50),
    email varchar(50),
    grade varchar(5),
    blog varchar(50)
  );
SQL

# Execute inserts with parameter markers
DB.execute("INSERT INTO students (name, email, grade, blog) 
            VALUES (?, ?, ?, ?)", ["Jane", "me@janedoe.com", "A", "http://blog.janedoe.com"])

DB.execute( "select * from students" ) do |row|
  p row
end
require "pry"
Pry.start
```

Now, we can interact with the sqlite database by using the `execute` command on the `DB` object. If we run:

```rb
DB.execute( "select * from students" ) do |row|
  p row
end
```

We'll see something like this:

```rb
["Jane", "me@janedoe.com", "A", "http://blog.janedoe.com"]
```

If you run:

```rb
DB.execute( "select * from numbers" ) do |row|
  p row
end
```
You should see something like this:

```rb
["one", 1]
["two", 2]
```

For our purposes, we'll be working with the Chinook db. To do that, we'll want to open the database and pass the path to chinook instead of test.db. The `open` method and the `new` method will actually do the same thing because they are aliased within the sqlite3 source code. So, to set up our playground in the console, we'll want to remove the other code and just initialize the database using the path to the chinook db.

```rb
#!/usr/bin/env ruby

require "bundler/setup"
require "intro_to_sql"

# You can add fixtures and/or initialization code here to make experimenting
# with your gem easier. You can also use a different console, if you like.

# (If you use this, don't forget to add pry to your Gemfile!)
# require "pry"
# Pry.start

require "sqlite3"

# Open a database
DB = SQLite3::Database.new "db/Chinook_Sqlite.sqlite"


require "pry"
Pry.start


```

Here's some [SQL reference](https://www.sqlitetutorial.net/sqlite-cheat-sheet/) we can use to help construct our queries:


* **Perform CRUD actions on a single table**
1. Write the SQL to return all of the rows in the artists table?

```SQL

```

2. Write the SQL to select the artist with the name "Black Sabbath"

```SQL

```

3. Write the SQL to create a table named 'fans' with an autoincrementing ID that's a primary key and a name field of type text

```sql

```

4. Write the SQL to alter the fans table to have a artist_id column type integer?

```sql

```

5. Write the SQL to add yourself as a fan of the Black Eyed Peas? ArtistId **169**

```sql

```

6. How would you update your name in the fans table to be your new name? Use Ruby file.

   ```sql
    
   ```
* **Explore how to use sqlite3 with ruby file**
    * Gem sqlite3
    * See documentation
    * db = SQLite3::Database.new('chinook.db')
    * How to run SQL query in ruby?
        * `db.execute('UPDATE fans_new SET name = "NICK" WHERE id = 10')`
        * `db.execute(' UPDATE fans SET name = ? WHERE id=?', name, id)`


* **Perform CRUD actions across related tables**
7. Write the SQL to display an artists name next to their album title

```sql

```

8. Write the SQL to display artist name, album name and number of tracks on that album

```sql

```

---
### Tasks:

1. Install the SQLite Browser if you haven't already [here](http://sqlitebrowser.org/)
2. Write the SQL to return fans that are not fans of the black eyed peas. ArtistId **169**

```sql

```
3. Write the SQL to return the name of all of the artists in the 'Pop' Genre

```sql

```