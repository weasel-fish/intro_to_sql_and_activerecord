# Intro to SQL

# Intro to SQL

### Learning Goals:
- [x] Explain persistence, the need for using SQL, and difference between SQLite3 and SQL
    * Explore provided data through [DB Browser for SQLite](https://sqlitebrowser.org/dl/)
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

# Getting Started

- Clone this repo to your machine 
- open the folder in VSCode.
- Run Shift Command/Ctrl P
- Type in Sqlite: Open Database and select it from the dropdown
- Select db/Chinook_Sqlite.sqlite from the dropdown that appears
- The SQLIITE EXPLORER should appear in the bottom left of the file explorer
- This will allow you to navigate through the tables in your database, see their columns and..
- by pressing the play button that appears when you hover over a table name you can see all of the rows in that table


Making Queries on VSCode Sqlite extension

- Run Shift Command/Ctrl P
- Type Sqlite: Quick Query 
- Select db/Chinook_Sqlite.sqlite from the dropdown that appears
- and an input will appear at the top, where you can type in SQL.
- Hit enter the Query will run against the database and the results will appear in a new window in VSCode in a table 


KEY SQL Clauses to review:

- SELECT - get information from a table in your database. SELECT is passed a comma separated list of the column names that you want values for. (or * if you want all column values)
- AS - Used to change the name of a column in the table that results from a query
- FROM - indicates the table you want data from.
- WHERE - allows you to add conditions to the query. You can only return rows where a certain condition is true. One of the most important use cases for this it getting access to related data in other tables.
- INNER JOIN - allows you to generate a table with information from two tables. If you need to join more than two, you can do multiple INNER JOINS in the same query.
- ON - allows you to describe how the tables are to be joined together. This is where something like a primary key to foreign key relationship might be used.
- GROUP BY - used to combine all of the rows together that share a value for a particular column (GROUP BY CustomerId would give you a row for each group of Invoices that share a CustomerId). GROUP BY is generally used with aggregate functions to do things like COUNT, MIN, MAX, AVG of values for another column in the grouped rows.
- COUNT - an aggregate function that allows you to count the number of rows that are in a group of records. Other aggregate functions are SUM, 
- HAVING - this is like WHERE, but it's used when you have a GROUP BY clause. So, if you have a query that includes GROUP BY and you need a condition, you use HAVING instead of WHERE.
- LIMIT - restrict the number of rows returned from the query.

Relationships within SQL:

Primary Key and Foreign Key.

What is a Primary Key?

Primary key is used to identify a row within a table. By default in sqlite3, a primary key is an integer that increases over time as records are added. It's a unique identifier for a row. Now primary key is used twice within the same table. Database manages primary keys for you. When you do an insert the database assigns the primary key. 

What is a Foreign Key?

Foreign key is used to identify a row within another (foreign) table. The foreign key in one table is a refernce to a primary key in another (foreign) table.

Some Examples:

```sql
SELECT 
	*
FROM Invoice 
WHERE CustomerId = 14;

SELECT *
FROM Customer
WHERE CustomerId = 14;

SELECT 
	Customer.FirstName, 
	Customer.LastName,
	Invoice.*
FROM Invoice
INNER JOIN Customer ON Invoice.CustomerId = Customer.CustomerId
WHERE Invoice.CustomerId = 14;
```

We'll start by working in the [DB Browser for SQLite](https://sqlitebrowser.org/dl/), so make sure you install that if you haven't yet. I'd also grab the VSCode extension

In order to use sqlite3 in our code, we'll want to install the [sqlite3 gem](https://github.com/sparklemotion/sqlite3-ruby). To do that, we can run:

```bash
bundle add sqlite3
```

If you've cloned this repo, the Gemfile already includes sqlite3. After you've done that, you'll want to open up the `bin/console` file to create a `DB` constant that we can use to execute SQL statements within the console.

```rb
#!/usr/bin/env ruby

require "bundler/setup"
require "intro_to_sql"

# You can add fixtures and/or initialization code here to make experimenting
# with your gem easier. You can also use a different console, if you like.

# (If you use this, don't forget to add pry to your Gemfile!)
# require "pry"
# Pry.start

DB = SQLite3::Database.new "db/Chinook_Sqlite.sqlite", results_as_hash: true

require "irb"
IRB.start(__FILE__)

```

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