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