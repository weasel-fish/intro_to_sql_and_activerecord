# Intro to SQL & ActiveRecord

### Learning Goals:
- [] Explain persistence, the need for using SQL, and difference between SQLite3 and SQL
  * Install the [Sqlite extension for VSCode](https://marketplace.visualstudio.com/items?itemName=alexcvzz.vscode-sqlite) . It's a good resource for navigating through your DB right within VSCode.
  * You can also explore provided data through [DB Browser for SQLite](https://sqlitebrowser.org/dl/)
- [] Perform CRUD actions on a single table
- [] Explore how to use sqlite3 with a ruby file
- [] Perform CRUD actions using SQL
- [] Perform CRUD actions using ActiveRecord

---

## Important Resources for Today
- [Sqlite tutorial](https://www.sqlitetutorial.net/)
- [Sqlite Cheatsheet]((https://www.sqlitetutorial.net/sqlite-cheat-sheet/))
- [RailsGuides on ActiveRecord](https://guides.rubyonrails.org/v5.2/active_record_basics.html)
- [Rails documentation (section on ActiveRecord)](https://api.rubyonrails.org/v5.2.6/)

## Topics
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
  * **What is an RDBMS good for?** A Relational Database Management System is designed to keep track of related data stored in different tables. It allows us to organize the data in groups while maintaining relationships between particular rows across multiple tables. 
  * **Single Source of Truth for relationships** - If we were to model a has many/belongs to relationship within a database, which table would store the reference? 
    * The one that belongs to a related row in the other 
    * or
    * The one that has many related rows in the other 
* **Technical Terms for the columns that help us establish relationships between rows in separate tables**

# Getting Started

- Clone this repo to your machine 
- open the folder in VSCode.
- Run Shift + Command/Ctrl + P
- Type in Sqlite: Open Database and select it from the dropdown
- Select db/Chinook_Sqlite.sqlite from the dropdown that appears
- The SQLIITE EXPLORER should appear in the bottom left of the file explorer tab within the sidebar.
- This will allow you to navigate through the tables in your database, see their columns and...
- by pressing the play button that appears when you hover over a table name you can see all of the rows in that table. 
- **IMPORTANT NOTE**: If you already have a SQLITE window open that comes from this extension, the query will appear there and it won't be pulled into focus. A new tab doesn't open and the old tab where the results will be visible not pulled into focus. So, you'll need to navigate there manually if it's not already visible to you.


### Making Queries on VSCode Sqlite extension

- Run Shift + Command/Ctrl + P
- Type `Sqlite: Quick Query` 
- Select `db/Chinook_Sqlite.sqlite` from the dropdown that appears
- an input will appear at the top of the window where you can type in SQL.
- Hit enter after you type the Query and it will run against the database and the results will appear in a new window in VSCode in a table. Note, if you want to view multiple tables at once, you can separate queries by a `;` to do so.


### Key SQL Clauses for reference:

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

### You can refer to the [SQLITE cheatsheet](https://www.sqlitetutorial.net/sqlite-cheat-sheet/) as a resource for how to use these queries

## Relationships within SQL

Primary Key and Foreign Key.

### What is a Primary Key?

Primary key is used to identify a row within a table. By default in sqlite3, a primary key is an integer that increases over time as records are added. It's a unique identifier for a row. Now primary key is used twice within the same table. Database manages primary keys for you. When you do an insert the database assigns the primary key. 

### What is a Foreign Key?

Foreign key is used to identify a row within another (foreign) table. The foreign key in one table is a reference to a primary key in another (foreign) table.

Some Examples:

```sql
SELECT *
FROM invoices 
WHERE customer_id = 14;

SELECT *
FROM customers
WHERE id = 14;

SELECT 
	customers.first_name, 
	customers.last_name,
	invoices.*
FROM invoices
INNER JOIN customers ON invoices.customer_id = customers.id
WHERE invoices.customer_id = 14;
```

## Discussion - How would we model our Twitter domain using database tables? What columns would each table have?

users

likes

tweets

We'll start by working in the [VSCode extension for Sqlite](https://marketplace.visualstudio.com/items?itemName=alexcvzz.vscode-sqlite), so make sure you've got it installed. If you're not using VS Code, you can also check out the [DB Browser for SQLite](https://sqlitebrowser.org/dl/), so make sure you install one of those if you haven't yet.

In order to use sqlite3 in our code, we'll need to install the [sqlite3 gem](https://github.com/sparklemotion/sqlite3-ruby). If you've cloned this repo, the Gemfile already includes the correct version of sqlite3. But if you were doing this on your own, you could run:

```bash
bundle add sqlite3 -v "< 1.4"
```

We add the version here because we'll be using a slightly older version of ActiveRecord that doesn't play well with newer versions of the `sqlite` gem.

Now, Let's take a look at the `query.rb` file.

```rb
class Query
  DB = SQLite3::Database.new("db/Chinook_Sqlite.sqlite", results_as_hash: true)

  def self.run(query)
    query_to_execute = query.is_a?(Symbol) ? self.send(query) : query
    if query_to_execute.blank?
      "Please add your SQL query to the appropriate method"
    else
      DB.execute(query_to_execute)
    end
  end
end
```

The class has a constant called `DB` that is an instance of the `Sqlite3::Database` class. We can use this constant to execute SQL queries on the database file passed as an argument. We have a class method called `run` that we can pass either a string or a symbol as an argument. If we pass a symbol it will call the method matching the symbol's name and use its return value as the query. If we pass a string, the string itself will be the query executed.

It's set up this way so that we can test things out in the console by running.

```bash
./bin/console
```

And then:

```rb
Query.run("INSERT SQL HERE")
```

This will allow you to execute SQL statements from ruby code and see the results as an array of hashes.

## Exercise 1

Run the specs using the following command:

```bash
rspec spec/01_query_spec.rb
```

Here are your tasks:

```txt
Query
  .run(query)
    takes a query as an argument and executes the query on the database object (already complete)
  .all_artists_query
    returns the SQL query that retrieves all of the Artists in the DB
  .create_fans
    returns a SQL query that creates the 'fans' table (if it doesn't already exist) that has an autoincrementing id column (integer) as a primary key and a name column (string)
  .add_artist_id_to_fans
    adds an artist_id integer foreign key to the fans table
  .make_yourself_a_fan_of_the_black_eyed_peas
    adds your name to the fans table as a fan of the black eyed peas (artist_id **169**)
  .update_your_fan_to_be_a_fan_of_led_zeppelin
    updates the artist_id of the fan you just created to point to Led Zeppelin
  remove_yourself_as_a_fan
    removes the fan from the fans table
```

All SQL queries are formatted using a [heredoc](https://www.rubyguides.com/2018/11/ruby-heredoc/) to allow us to write multi-line strings without causing issues with escaped new line characters.

Here's some [SQL reference](https://www.sqlitetutorial.net/sqlite-cheat-sheet/) we can use to help construct our queries


## Introducing ActiveRecord

- ActiveRecord is an ORM
  - class <=> table
  - instance <=> row
- ActiveRecord relies on inheritance
  - we tell our models to inherit from an `ActiveRecord::Base` class and they in turn can utilize methods described in the ActiveRecord documentation to interact with our database using generated SQL statements.

Read through the docs linked below as you work through the second exercise:

- [RailsGuides on ActiveRecord](https://guides.rubyonrails.org/v5.2/active_record_basics.html)
- [Rails documentation (section on ActiveRecord)](https://api.rubyonrails.org/v5.2.6/)

## Exercise 2

You'll be coding in 2 files:
- `lib/intro_to_sql/models.rb`
- `lib/intro_to_sql/ar_queries.rb`

You'll run the following command to get test output:

```rb
rspec spec/02_ar_query_spec.rb
```

## Homework

Accomplish the following CRUD tasks using ActiveRecord and describe the SQL generated by your ActiveRecord method calls.

1. Retrieves all of the albums that belong to a particular artist.
2. Create a new Playlist
3. Add a Track to your new Playlist
4. Remove a Track from your new Playlist
5. Update the quantity of an item within an InvoiceLine