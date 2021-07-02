-- rename tables
ALTER TABLE Artist RENAME TO artists;
ALTER TABLE Album RENAME TO albums;
ALTER TABLE Artist RENAME TO artists;
ALTER TABLE Customer RENAME TO customers;
ALTER TABLE Employee RENAME TO employees;
ALTER TABLE Genre RENAME TO genres;
ALTER TABLE InvoiceLine RENAME TO invoice_lines;
ALTER TABLE Invoice RENAME TO invoices;
ALTER TABLE MediaType RENAME TO media_types;
ALTER TABLE PlaylistTrack RENAME TO playlist_tracks;
ALTER TABLE Playlist RENAME TO playlists;
ALTER TABLE Track RENAME TO tracks;

-- rename primary keys
ALTER TABLE albums RENAME COLUMN AlbumId TO id;
ALTER TABLE artists RENAME COLUMN ArtistId TO id;
ALTER TABLE customers RENAME COLUMN CustomerId TO id;
ALTER TABLE employees RENAME COLUMN EmployeeId TO id;
ALTER TABLE genres RENAME COLUMN GenreId TO id;
ALTER TABLE invoice_lines RENAME COLUMN InvoiceLineId TO id;
ALTER TABLE invoices RENAME COLUMN InvoiceId TO id;
ALTER TABLE media_types RENAME COLUMN MediaTypeId TO id;
ALTER TABLE playlists RENAME COLUMN PlaylistId TO id;
ALTER TABLE tracks RENAME COLUMN TrackId TO id;

-- rename columns (snake case)
ALTER TABLE albums RENAME COLUMN Title TO title;
ALTER TABLE albums RENAME COLUMN ArtistId TO artist_id;

ALTER TABLE artists RENAME COLUMN Name TO name;

ALTER TABLE customers RENAME COLUMN FirstName TO first_name;
ALTER TABLE customers RENAME COLUMN LastName TO last_name;
ALTER TABLE customers RENAME COLUMN Company TO company;
ALTER TABLE customers RENAME COLUMN Address TO address;
ALTER TABLE customers RENAME COLUMN City TO city;
ALTER TABLE customers RENAME COLUMN State TO state;
ALTER TABLE customers RENAME COLUMN Country TO country;
ALTER TABLE customers RENAME COLUMN PostalCode TO postal_code;
ALTER TABLE customers RENAME COLUMN Phone TO phone;
ALTER TABLE customers RENAME COLUMN Fax TO fax;
ALTER TABLE customers RENAME COLUMN Email TO email;
ALTER TABLE customers RENAME COLUMN SupportRepId TO support_rep_id;

ALTER TABLE employees RENAME COLUMN LastName TO last_name;
ALTER TABLE employees RENAME COLUMN FirstName TO first_name;
ALTER TABLE employees RENAME COLUMN Title TO title;
ALTER TABLE employees RENAME COLUMN ReportsTo TO reports_to;
ALTER TABLE employees RENAME COLUMN BirthDate TO birth_date;
ALTER TABLE employees RENAME COLUMN HireDate TO hire_date;
ALTER TABLE employees RENAME COLUMN Address TO address;
ALTER TABLE employees RENAME COLUMN City TO city;
ALTER TABLE employees RENAME COLUMN State TO state;
ALTER TABLE employees RENAME COLUMN Country TO country;
ALTER TABLE employees RENAME COLUMN PostalCode TO postal_code;
ALTER TABLE employees RENAME COLUMN Phone TO phone;
ALTER TABLE employees RENAME COLUMN Fax TO fax;
ALTER TABLE employees RENAME COLUMN Email TO email;

ALTER TABLE genres RENAME COLUMN Name TO name;

ALTER TABLE invoice_lines RENAME COLUMN InvoiceId TO invoice_id;
ALTER TABLE invoice_lines RENAME COLUMN TrackId TO track_id;
ALTER TABLE invoice_lines RENAME COLUMN UnitPrice TO unit_price;
ALTER TABLE invoice_lines RENAME COLUMN Quantity TO quantity;

ALTER TABLE invoices RENAME COLUMN CustomerId TO customer_id;
ALTER TABLE invoices RENAME COLUMN InvoiceDate TO invoice_date;
ALTER TABLE invoices RENAME COLUMN BillingAddress TO billing_address;
ALTER TABLE invoices RENAME COLUMN BillingCity TO billing_city;
ALTER TABLE invoices RENAME COLUMN BillingState TO billing_state;
ALTER TABLE invoices RENAME COLUMN BillingCountry TO billing_country;
ALTER TABLE invoices RENAME COLUMN BillingPostalCode TO billing_postal_code;
ALTER TABLE invoices RENAME COLUMN Total TO total;

ALTER TABLE media_types RENAME COLUMN Name TO name;

ALTER TABLE playlist_tracks RENAME COLUMN PlaylistId TO playlist_id;
ALTER TABLE playlist_tracks RENAME COLUMN TrackId TO track_id;

ALTER TABLE playlists RENAME COLUMN Name TO name;

ALTER TABLE tracks RENAME COLUMN Name TO name;
ALTER TABLE tracks RENAME COLUMN AlbumId TO album_id;
ALTER TABLE tracks RENAME COLUMN MediaTypeId TO media_type_id;
ALTER TABLE tracks RENAME COLUMN GenreId TO genre_id;
ALTER TABLE tracks RENAME COLUMN Composer TO composer;
ALTER TABLE tracks RENAME COLUMN Milliseconds TO milliseconds;
ALTER TABLE tracks RENAME COLUMN Bytes TO bytes;
ALTER TABLE tracks RENAME COLUMN UnitPrice TO unit_price;
-- sql = [
--   Album,
--   Artist,
--   Customer,
--   Employee,
--   Genre,
--   InvoiceLine,
--   Invoice,
--   MediaType,
--   PlaylistTrack,
--   Playlist,
--   Track
-- ].map do |klass|
--  sql = klass.column_names.map do |name|
--    "ALTER TABLE #{ActiveSupport::Inflector.tableize(klass.name)} RENAME COLUMN #{name} TO #{ActiveSupport::Inflector.underscore(name)};"
--  end
-- end
