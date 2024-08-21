-- Initialize the SQLite database schema for Finance Tracker Application

-- Creating the TransactionTypes table
CREATE OR REPLACE TABLE TransactionTypes (
    ID SERIAL PRIMARY KEY,
    Type VARCHAR NOT NULL UNIQUE -- Type of the transaction (Income, Expense)
);

-- Creating the Categories table
CREATE OR REPLACE TABLE Categories (
    ID SERIAL PRIMARY KEY,
    Name VARCHAR UNIQUE -- Category of the transaction (e.g., Income, Necessary, Important, etc.)
);

-- Creating the Frequency table
CREATE OR REPLACE TABLE Frequency (
    ID SERIAL PRIMARY KEY,
    Frequency_Type VARCHAR NOT NULL UNIQUE -- Frequency of the transaction (Monthly, Yearly)
);

-- Creating the Status table
CREATE OR REPLACE TABLE Status (
    ID SERIAL PRIMARY KEY,
    Status_Name VARCHAR NOT NULL UNIQUE -- Status of the transaction (Disabled, Active, Suspended, Cancelled)
);

-- Creating the Transactions table
CREATE OR REPLACE TABLE Transactions (
    ID SERIAL PRIMARY KEY,
    ID_Category INTEGER NOT NULL, -- Foreign key to Categories table
    Title VARCHAR NOT NULL, -- Title of the transaction (e.g., mortgage payment, car installment payment)
    Price NUMERIC NOT NULL, -- Amount of the transaction (Currency in EUR or number between -10,000 and 10,000)
    ID_Frequency INTEGER NOT NULL, -- Foreign key to Frequency table
    ID_Status INTEGER NOT NULL, -- Foreign key to Status table
    Next_Payment DATE, -- Next planned payment date for this transaction
    Commentary VARCHAR, -- Additional commentary, optional
    FOREIGN KEY (ID_Category) REFERENCES Categories(ID),
    FOREIGN KEY (ID_Frequency) REFERENCES Frequency(ID),
    FOREIGN KEY (ID_Status) REFERENCES Status(ID)
);

-- Creating the function for montly price
CREATE OR REPLACE FUNCTION get_adjusted_price(
    p_price NUMERIC,
    p_status TEXT,
	p_frequency TEXT
) 
RETURNS NUMERIC AS $$
BEGIN
	/* Early return when item is not active */
    IF lower(p_status) <> 'active' THEN RETURN ROUND(0, 2); END IF;
    IF lower(p_frequency) = 'yearly' THEN
		RETURN round(p_price / 12, 2);
	ELSE
		RETURN round(p_price, 2);
	END IF;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE VIEW transactionsview AS
	select 
	    tr.id, 
	    tr.title,
	    tr.price,
		get_adjusted_price(tr.price, st.status_name, fr.frequency_type) "monthly_price",
	    ca.name as "category",
	    st.status_name as "status",
	    fr.frequency_type as "frequency",
	    tr.next_payment,
	    tr.commentary as "comment"
	from 
	    transactions tr 
	inner join categories ca on tr.id_category = ca.id
	inner join status st on tr.id_status = st.id
	inner join frequency fr on tr.id_frequency = fr.id;

-- Inserting data

BEGIN TRANSACTION;
-- Inserting default data into the Frequency table
INSERT INTO Frequency (Frequency_Type) VALUES ('Monthly');
INSERT INTO Frequency (Frequency_Type) VALUES ('Yearly');

-- Inserting default data into the TransactionTypes table
INSERT INTO TransactionTypes (Type) VALUES ('Income');
INSERT INTO TransactionTypes (Type) VALUES ('Expense');

-- Inserting default data into the Categories table
INSERT INTO Categories (Name) VALUES ('Income');
INSERT INTO Categories (Name) VALUES ('Necessary');
INSERT INTO Categories (Name) VALUES ('Important');
INSERT INTO Categories (Name) VALUES ('Life');
INSERT INTO Categories (Name) VALUES ('Saving');
INSERT INTO Categories (Name) VALUES ('Personal pleasure');
INSERT INTO Categories (Name) VALUES ('Fetish');
INSERT INTO Categories (Name) VALUES ('Other');

-- Inserting default data into the Status table
INSERT INTO Status (Status_Name) VALUES ('Disabled');
INSERT INTO Status (Status_Name) VALUES ('Active');
INSERT INTO Status (Status_Name) VALUES ('Suspended');
INSERT INTO Status (Status_Name) VALUES ('Cancelled');
COMMIT;

/*
-- Inserting records into Transactions table
BEGIN TRANSACTION;

-- Format: (ID_Category, Title, Price, ID_Frequency, ID_Status, Next_Payment, Commentary)
INSERT INTO Transactions (ID_Category, Title, Price, ID_Frequency, ID_Status, Next_Payment, Commentary) VALUES
-- Income
((SELECT ID FROM Categories WHERE Name = 'Income'), 'Median Salary', 1880, (SELECT ID FROM Frequency WHERE Frequency_Type = 'Monthly'), (SELECT ID FROM Status WHERE Status_Name = 'Suspended'), '2024-09-16', 'Starting from 1.9, it will not come'),
((SELECT ID FROM Categories WHERE Name = 'Income'), 'Social Security', 1422, (SELECT ID FROM Frequency WHERE Frequency_Type = 'Monthly'), (SELECT ID FROM Status WHERE Status_Name = 'Active'), '2024-09-04', NULL),
((SELECT ID FROM Categories WHERE Name = 'Income'), 'TV allowance from wife', 7, (SELECT ID FROM Frequency WHERE Frequency_Type = 'Monthly'), (SELECT ID FROM Status WHERE Status_Name = 'Active'), '2024-09-15', NULL),

-- Important
((SELECT ID FROM Categories WHERE Name = 'Important'), 'iCloud 200GB', -2.99, (SELECT ID FROM Frequency WHERE Frequency_Type = 'Monthly'), (SELECT ID FROM Status WHERE Status_Name = 'Suspended'), '2024-09-03', NULL),
((SELECT ID FROM Categories WHERE Name = 'Important'), 'GitHub', -10, (SELECT ID FROM Frequency WHERE Frequency_Type = 'Monthly'), (SELECT ID FROM Status WHERE Status_Name = 'Active'), '2024-09-14', 'Do I need this?'),
((SELECT ID FROM Categories WHERE Name = 'Important'), 'Google Workspace', -12.71, (SELECT ID FROM Frequency WHERE Frequency_Type = 'Monthly'), (SELECT ID FROM Status WHERE Status_Name = 'Active'), '2024-09-01', NULL),
((SELECT ID FROM Categories WHERE Name = 'Important'), 'iCloud 2TB', -9.99, (SELECT ID FROM Frequency WHERE Frequency_Type = 'Monthly'), (SELECT ID FROM Status WHERE Status_Name = 'Active'), '2024-08-30', 'This would be nice to reduce or cancel'),
((SELECT ID FROM Categories WHERE Name = 'Important'), 'Credit Card Payment', -15, (SELECT ID FROM Frequency WHERE Frequency_Type = 'Monthly'), (SELECT ID FROM Status WHERE Status_Name = 'Active'), '2024-08-31', 'This is the minimum payment.'),
((SELECT ID FROM Categories WHERE Name = 'Important'), 'YouTube Premium', -7.49, (SELECT ID FROM Frequency WHERE Frequency_Type = 'Monthly'), (SELECT ID FROM Status WHERE Status_Name = 'Active'), '2024-09-16', 'Primary platform for TV.'),
((SELECT ID FROM Categories WHERE Name = 'Important'), 'Internet and Mobile', -45, (SELECT ID FROM Frequency WHERE Frequency_Type = 'Monthly'), (SELECT ID FROM Status WHERE Status_Name = 'Active'), '2024-09-20', NULL),
((SELECT ID FROM Categories WHERE Name = 'Important'), 'Car Payment', -282.12, (SELECT ID FROM Frequency WHERE Frequency_Type = 'Monthly'), (SELECT ID FROM Status WHERE Status_Name = 'Active'), '2024-09-09', NULL),
((SELECT ID FROM Categories WHERE Name = 'Important'), 'Mortgage Payment', -598.17, (SELECT ID FROM Frequency WHERE Frequency_Type = 'Monthly'), (SELECT ID FROM Status WHERE Status_Name = 'Active'), '2024-08-19', NULL),
((SELECT ID FROM Categories WHERE Name = 'Important'), 'Lifeplus Accident Insurance', -23.99, (SELECT ID FROM Frequency WHERE Frequency_Type = 'Monthly'), (SELECT ID FROM Status WHERE Status_Name = 'Active'), '2024-09-15', 'This was mainly for horses'),

-- Saving
((SELECT ID FROM Categories WHERE Name = 'Saving'), 'Contribution to "Joint" savings', -50, (SELECT ID FROM Frequency WHERE Frequency_Type = 'Monthly'), (SELECT ID FROM Status WHERE Status_Name = 'Active'), '2024-09-08', 'Savings for joint account'),
((SELECT ID FROM Categories WHERE Name = 'Saving'), 'Saving for Personal Pleasure', -20, (SELECT ID FROM Frequency WHERE Frequency_Type = 'Monthly'), (SELECT ID FROM Status WHERE Status_Name = 'Disabled'), '2024-09-16', 'Its questionable whether I need this'),

-- Personal Pleasure
((SELECT ID FROM Categories WHERE Name = 'Personal pleasure'), 'YouTube Music', -9.49, (SELECT ID FROM Frequency WHERE Frequency_Type = 'Monthly'), (SELECT ID FROM Status WHERE Status_Name = 'Suspended'), '2024-09-16', NULL),
((SELECT ID FROM Categories WHERE Name = 'Personal pleasure'), 'Spendee Money & Budget Tracker', -13.49, (SELECT ID FROM Frequency WHERE Frequency_Type = 'Yearly'), (SELECT ID FROM Status WHERE Status_Name = 'Suspended'), '2024-10-25', NULL),
((SELECT ID FROM Categories WHERE Name = 'Personal pleasure'), 'InShot Video Editor', -17.99, (SELECT ID FROM Frequency WHERE Frequency_Type = 'Yearly'), (SELECT ID FROM Status WHERE Status_Name = 'Suspended'), '2024-09-21', NULL),
((SELECT ID FROM Categories WHERE Name = 'Personal pleasure'), 'Duolingo', -47.99, (SELECT ID FROM Frequency WHERE Frequency_Type = 'Yearly'), (SELECT ID FROM Status WHERE Status_Name = 'Active'), '2025-07-20', NULL),
((SELECT ID FROM Categories WHERE Name = 'Personal pleasure'), 'Pillov Sleep Tracker', -29.99, (SELECT ID FROM Frequency WHERE Frequency_Type = 'Yearly'), (SELECT ID FROM Status WHERE Status_Name = 'Active'), '2024-11-23', 'Expires on 23.11. Would be good to stop this'),
((SELECT ID FROM Categories WHERE Name = 'Personal pleasure'), 'Dolingo', -47.99, (SELECT ID FROM Frequency WHERE Frequency_Type = 'Yearly'), (SELECT ID FROM Status WHERE Status_Name = 'Active'), '2025-07-20', 'Will renew in June 2025'),
((SELECT ID FROM Categories WHERE Name = 'Personal pleasure'), 'Cartoon Weather', -14.99, (SELECT ID FROM Frequency WHERE Frequency_Type = 'Yearly'), (SELECT ID FROM Status WHERE Status_Name = 'Active'), '2025-07-13', 'Will renew in June 2025'),
((SELECT ID FROM Categories WHERE Name = 'Personal pleasure'), 'Podcasty sme.sk', -2.99, (SELECT ID FROM Frequency WHERE Frequency_Type = 'Monthly'), (SELECT ID FROM Status WHERE Status_Name = 'Suspended'), '2024-09-04', 'Expires on 4.9'),
((SELECT ID FROM Categories WHERE Name = 'Personal pleasure'), 'Strop Packages', -300, (SELECT ID FROM Frequency WHERE Frequency_Type = 'Monthly'), (SELECT ID FROM Status WHERE Status_Name = 'Suspended'), NULL, 'I stopped fetish'),
((SELECT ID FROM Categories WHERE Name = 'Personal pleasure'), 'Voyo', -5.99, (SELECT ID FROM Frequency WHERE Frequency_Type = 'Monthly'), (SELECT ID FROM Status WHERE Status_Name = 'Suspended'), NULL, 'Ended on 9.12'),
((SELECT ID FROM Categories WHERE Name = 'Personal pleasure'), 'ChatGPT Plus', -22.99, (SELECT ID FROM Frequency WHERE Frequency_Type = 'Monthly'), (SELECT ID FROM Status WHERE Status_Name = 'Active'), '2024-08-19', NULL),
((SELECT ID FROM Categories WHERE Name = 'Personal pleasure'), 'YouTube Vortex', -7.99, (SELECT ID FROM Frequency WHERE Frequency_Type = 'Monthly'), (SELECT ID FROM Status WHERE Status_Name = 'Active'), '2024-09-03', NULL),
((SELECT ID FROM Categories WHERE Name = 'Personal pleasure'), 'YouTube Molda22', -1.99, (SELECT ID FROM Frequency WHERE Frequency_Type = 'Monthly'), (SELECT ID FROM Status WHERE Status_Name = 'Suspended'), NULL, 'Expires on 20.11.2023'),
((SELECT ID FROM Categories WHERE Name = 'Personal pleasure'), 'Wallet: Budget Expense Tracker', -19.99, (SELECT ID FROM Frequency WHERE Frequency_Type = 'Yearly'), (SELECT ID FROM Status WHERE Status_Name = 'Suspended'), NULL, 'Probably to cancel on 15.11.2023'),
((SELECT ID FROM Categories WHERE Name = 'Personal pleasure'), 'Disney+', -70, (SELECT ID FROM Frequency WHERE Frequency_Type = 'Yearly'), (SELECT ID FROM Status WHERE Status_Name = 'Suspended'), NULL, 'Expired on 16.6.2023'),
((SELECT ID FROM Categories WHERE Name = 'Personal pleasure'), 'Sky Showtime', -5.99, (SELECT ID FROM Frequency WHERE Frequency_Type = 'Monthly'), (SELECT ID FROM Status WHERE Status_Name = 'Suspended'), NULL, 'Subscription cancelled on 2.11.2023'),
((SELECT ID FROM Categories WHERE Name = 'Personal pleasure'), 'Playstation Plus', -151.99, (SELECT ID FROM Frequency WHERE Frequency_Type = 'Yearly'), (SELECT ID FROM Status WHERE Status_Name = 'Active'), '2025-07-31', 'Valid until 2025'),
((SELECT ID FROM Categories WHERE Name = 'Personal pleasure'), 'Gamepass Ultimate', -151.6, (SELECT ID FROM Frequency WHERE Frequency_Type = 'Yearly'), (SELECT ID FROM Status WHERE Status_Name = 'Suspended'), NULL, 'I wont pay for this anymore'),
((SELECT ID FROM Categories WHERE Name = 'Personal pleasure'), 'Telly', -8.96, (SELECT ID FROM Frequency WHERE Frequency_Type = 'Monthly'), (SELECT ID FROM Status WHERE Status_Name = 'Active'), '2024-09-01', 'Telly.cz. For July (paid in August), there was a double payment'),

-- Fetish
((SELECT ID FROM Categories WHERE Name = 'Other'), 'Packages', -200, (SELECT ID FROM Frequency WHERE Frequency_Type = 'Monthly'), (SELECT ID FROM Status WHERE Status_Name = 'Suspended'), NULL, 'I stopped fetish'),
((SELECT ID FROM Categories WHERE Name = 'Other'), 'Chat+', -3.99, (SELECT ID FROM Frequency WHERE Frequency_Type = 'Monthly'), (SELECT ID FROM Status WHERE Status_Name = 'Active'), '2024-09-14', NULL),

-- Uncategorized (empty category in CSV)
((SELECT ID FROM Categories WHERE Name = 'Other'), 'Typewise Custom Keyboard', -8.49, (SELECT ID FROM Frequency WHERE Frequency_Type = 'Yearly'), (SELECT ID FROM Status WHERE Status_Name = 'Suspended'), '2024-11-06', NULL);
COMMIT;
*/