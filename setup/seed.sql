-- Schema
CREATE TABLE IF NOT EXISTS branches (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    city VARCHAR(100) NOT NULL,
    region VARCHAR(50) NOT NULL
);

CREATE TABLE IF NOT EXISTS customers (
    id SERIAL PRIMARY KEY,
    name VARCHAR(200) NOT NULL,
    customer_type VARCHAR(20) NOT NULL, -- individual, corporate
    branch_id INTEGER REFERENCES branches(id),
    created_at DATE NOT NULL
);

CREATE TABLE IF NOT EXISTS accounts (
    id SERIAL PRIMARY KEY,
    customer_id INTEGER REFERENCES customers(id),
    account_type VARCHAR(30) NOT NULL, -- savings, checking, deposit
    balance NUMERIC(15,2) NOT NULL DEFAULT 0,
    currency VARCHAR(3) DEFAULT 'IDR',
    opened_at DATE NOT NULL,
    status VARCHAR(20) DEFAULT 'active'
);

CREATE TABLE IF NOT EXISTS loans (
    id SERIAL PRIMARY KEY,
    customer_id INTEGER REFERENCES customers(id),
    loan_type VARCHAR(30) NOT NULL, -- mortgage, personal, business, auto
    principal NUMERIC(15,2) NOT NULL,
    interest_rate NUMERIC(5,2) NOT NULL,
    term_months INTEGER NOT NULL,
    disbursed_at DATE NOT NULL,
    maturity_date DATE NOT NULL,
    status VARCHAR(20) DEFAULT 'active', -- active, paid, overdue, default
    outstanding_balance NUMERIC(15,2) NOT NULL
);

CREATE TABLE IF NOT EXISTS transactions (
    id SERIAL PRIMARY KEY,
    account_id INTEGER REFERENCES accounts(id),
    txn_date DATE NOT NULL,
    txn_type VARCHAR(20) NOT NULL, -- credit, debit
    amount NUMERIC(15,2) NOT NULL,
    category VARCHAR(50),
    description VARCHAR(200)
);

-- Branches
INSERT INTO branches (name, city, region) VALUES
('Main Branch', 'Jakarta', 'West'),
('North Branch', 'Bandung', 'West'),
('East Branch', 'Surabaya', 'East'),
('South Branch', 'Yogyakarta', 'Central'),
('Central Branch', 'Semarang', 'Central');

-- Customers
INSERT INTO customers (name, customer_type, branch_id, created_at) VALUES
('PT Maju Sejahtera', 'corporate', 1, '2020-03-15'),
('CV Karya Mandiri', 'corporate', 2, '2021-06-01'),
('PT Bumi Perkasa', 'corporate', 3, '2019-11-20'),
('Andi Pratama', 'individual', 1, '2022-01-10'),
('Siti Rahayu', 'individual', 2, '2021-08-05'),
('Budi Santoso', 'individual', 3, '2020-05-22'),
('Dewi Lestari', 'individual', 4, '2023-02-14'),
('Rudi Hermawan', 'individual', 5, '2022-09-30'),
('PT Nusantara Jaya', 'corporate', 4, '2018-07-01'),
('Fitri Handayani', 'individual', 1, '2023-06-18'),
('Ahmad Fauzi', 'individual', 2, '2021-03-25'),
('PT Sentosa Abadi', 'corporate', 5, '2020-12-10'),
('Rina Wulandari', 'individual', 3, '2022-04-07'),
('Hendra Wijaya', 'individual', 4, '2019-09-15'),
('PT Global Makmur', 'corporate', 1, '2021-01-20');

-- Accounts
INSERT INTO accounts (customer_id, account_type, balance, opened_at, status) VALUES
(1, 'checking', 850000000, '2020-03-15', 'active'),
(1, 'deposit', 2000000000, '2020-06-01', 'active'),
(2, 'checking', 320000000, '2021-06-01', 'active'),
(3, 'checking', 1500000000, '2019-11-20', 'active'),
(3, 'savings', 500000000, '2020-01-15', 'active'),
(4, 'savings', 45000000, '2022-01-10', 'active'),
(5, 'savings', 78000000, '2021-08-05', 'active'),
(6, 'checking', 12000000, '2020-05-22', 'active'),
(7, 'savings', 25000000, '2023-02-14', 'active'),
(8, 'savings', 95000000, '2022-09-30', 'active'),
(9, 'checking', 3200000000, '2018-07-01', 'active'),
(9, 'deposit', 5000000000, '2019-01-10', 'active'),
(10, 'savings', 15000000, '2023-06-18', 'active'),
(11, 'savings', 62000000, '2021-03-25', 'active'),
(12, 'checking', 780000000, '2020-12-10', 'active'),
(13, 'savings', 33000000, '2022-04-07', 'active'),
(14, 'checking', 120000000, '2019-09-15', 'active'),
(15, 'checking', 2100000000, '2021-01-20', 'active'),
(15, 'deposit', 1000000000, '2021-06-15', 'active');

-- Loans
INSERT INTO loans (customer_id, loan_type, principal, interest_rate, term_months, disbursed_at, maturity_date, status, outstanding_balance) VALUES
(1, 'business', 5000000000, 9.5, 60, '2021-01-15', '2026-01-15', 'active', 3200000000),
(2, 'business', 1000000000, 10.0, 36, '2022-03-01', '2025-03-01', 'active', 450000000),
(3, 'business', 8000000000, 8.75, 84, '2020-06-01', '2027-06-01', 'active', 5600000000),
(4, 'personal', 50000000, 12.0, 24, '2023-01-10', '2025-01-10', 'paid', 0),
(5, 'mortgage', 500000000, 7.5, 240, '2022-01-01', '2042-01-01', 'active', 480000000),
(6, 'personal', 30000000, 13.5, 12, '2024-01-15', '2025-01-15', 'overdue', 12000000),
(7, 'auto', 200000000, 8.0, 48, '2023-06-01', '2027-06-01', 'active', 162000000),
(8, 'mortgage', 750000000, 7.25, 180, '2023-01-01', '2038-01-01', 'active', 720000000),
(9, 'business', 15000000000, 8.5, 120, '2019-06-01', '2029-06-01', 'active', 9500000000),
(10, 'personal', 25000000, 14.0, 12, '2024-03-01', '2025-03-01', 'active', 18000000),
(11, 'auto', 180000000, 8.5, 36, '2022-06-01', '2025-06-01', 'active', 55000000),
(12, 'business', 3000000000, 9.0, 48, '2021-06-01', '2025-06-01', 'active', 800000000),
(13, 'personal', 40000000, 12.5, 24, '2023-09-01', '2025-09-01', 'active', 22000000),
(14, 'mortgage', 600000000, 7.0, 240, '2020-03-01', '2040-03-01', 'active', 560000000),
(15, 'business', 10000000000, 9.25, 60, '2022-01-01', '2027-01-01', 'active', 7000000000);

-- Transactions (recent 3 months sample)
INSERT INTO transactions (account_id, txn_date, txn_type, amount, category, description) VALUES
(1, '2025-03-01', 'credit', 150000000, 'revenue', 'Client payment'),
(1, '2025-03-05', 'debit', 45000000, 'payroll', 'Monthly salary'),
(1, '2025-03-10', 'debit', 12000000, 'utilities', 'Office rent'),
(1, '2025-03-15', 'credit', 200000000, 'revenue', 'Project milestone'),
(1, '2025-04-01', 'credit', 180000000, 'revenue', 'Client payment'),
(1, '2025-04-05', 'debit', 45000000, 'payroll', 'Monthly salary'),
(1, '2025-04-12', 'debit', 8000000, 'utilities', 'Electricity'),
(1, '2025-05-01', 'credit', 160000000, 'revenue', 'Client payment'),
(1, '2025-05-05', 'debit', 47000000, 'payroll', 'Monthly salary'),
(3, '2025-03-02', 'credit', 80000000, 'revenue', 'Sales income'),
(3, '2025-03-10', 'debit', 25000000, 'supplies', 'Raw materials'),
(3, '2025-03-20', 'credit', 55000000, 'revenue', 'Service fee'),
(3, '2025-04-01', 'debit', 30000000, 'payroll', 'Staff salary'),
(3, '2025-04-15', 'credit', 90000000, 'revenue', 'Product sales'),
(3, '2025-05-01', 'debit', 30000000, 'payroll', 'Staff salary'),
(4, '2025-03-03', 'credit', 500000000, 'revenue', 'Contract payment'),
(4, '2025-03-15', 'debit', 120000000, 'payroll', 'Monthly salary'),
(4, '2025-04-01', 'credit', 350000000, 'revenue', 'Service delivery'),
(4, '2025-04-10', 'debit', 80000000, 'equipment', 'Server purchase'),
(4, '2025-05-01', 'credit', 420000000, 'revenue', 'Q2 invoice'),
(6, '2025-03-25', 'credit', 8500000, 'salary', 'Monthly salary'),
(6, '2025-03-26', 'debit', 2500000, 'transfer', 'Rent payment'),
(6, '2025-04-25', 'credit', 8500000, 'salary', 'Monthly salary'),
(6, '2025-04-28', 'debit', 1500000, 'shopping', 'Online purchase'),
(6, '2025-05-25', 'credit', 8500000, 'salary', 'Monthly salary'),
(7, '2025-03-10', 'credit', 12000000, 'salary', 'Monthly salary'),
(7, '2025-03-15', 'debit', 3500000, 'transfer', 'Insurance'),
(7, '2025-04-10', 'credit', 12000000, 'salary', 'Monthly salary'),
(7, '2025-05-10', 'credit', 12000000, 'salary', 'Monthly salary'),
(8, '2025-03-01', 'debit', 5000000, 'loan', 'Loan repayment'),
(8, '2025-04-01', 'debit', 5000000, 'loan', 'Loan repayment'),
(8, '2025-05-01', 'debit', 5000000, 'loan', 'Loan repayment'),
(9, '2025-03-15', 'credit', 5000000, 'salary', 'Freelance income'),
(9, '2025-04-15', 'credit', 6000000, 'salary', 'Freelance income'),
(9, '2025-05-15', 'credit', 5500000, 'salary', 'Freelance income'),
(10, '2025-03-28', 'credit', 15000000, 'salary', 'Monthly salary'),
(10, '2025-04-28', 'credit', 15000000, 'salary', 'Monthly salary'),
(10, '2025-05-28', 'credit', 15000000, 'salary', 'Monthly salary'),
(11, '2025-03-01', 'credit', 1200000000, 'revenue', 'Quarterly revenue'),
(11, '2025-03-15', 'debit', 300000000, 'payroll', 'Staff salary'),
(11, '2025-04-01', 'debit', 150000000, 'operations', 'Operational cost'),
(11, '2025-04-15', 'credit', 800000000, 'revenue', 'Service contract'),
(11, '2025-05-01', 'debit', 300000000, 'payroll', 'Staff salary'),
(11, '2025-05-15', 'credit', 950000000, 'revenue', 'Product delivery');
