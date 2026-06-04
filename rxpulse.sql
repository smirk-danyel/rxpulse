CREATE DATABASE rxpulse;
USE rxpulse;

CREATE TABLE pharmacist(
    pharmacist_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    license_number VARCHAR(30) UNIQUE NOT NULL
);

CREATE TABLE patients(
    patient_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    dob DATE,
    phone VARCHAR(20)
);

CREATE TABLE medicine(
    medicine_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    brand VARCHAR(50),
    stock_quantity INT DEFAULT 0,
    price DECIMAL(10, 2) NOT NULL
);

CREATE TABLE prescription(
    prescription_id INT AUTO_INCREMENT PRIMARY KEY,
    patient_id INT NOT NULL,
    pharmacist_id INT NOT NULL,
    date_issued DATE NOT NULL,
    FOREIGN KEY (patient_id) REFERENCES patients(patient_id) ON DELETE CASCADE,
    FOREIGN KEY (pharmacist_id) REFERENCES pharmacist(pharmacist_id) ON DELETE CASCADE
);

CREATE TABLE prescription_items(
    item_id INT AUTO_INCREMENT PRIMARY KEY,
    prescription_id INT NOT NULL,
    medicine_id INT NOT NULL,
    quantity INT NOT NULL,
    dosage_instructions VARCHAR(255),
    FOREIGN KEY (prescription_id) REFERENCES prescriptions(prescription_id) ON DELETE CASCADE,
    FOREIGN KEY (medicine_id) REFERENCES medicine(medicine_id) ON DELETE CASCADE
);










INSERT INTO pharmacist (first_name, last_name, license_number) VALUES
('Samuel', 'Kamau', 'PPB/1452/2018'),
('Grace', 'Wanjiku', 'PPB/2034/2020'),
('David', 'Omondi', 'PPB/0891/2015'),
('Chebet', 'Kipkorir', 'PPB/3120/2022'),
('Amina', 'Hassan', 'PPB/1984/2019');

INSERT INTO patients (first_name, last_name, dob, phone) VALUES
('Brian', 'Otieno', '1990-05-14', '+254711223344'),
('Mercy', 'Njeri', '1985-11-22', '+254722334455'),
('Ali', 'Abdi', '2000-01-30', '+254733445566'),
('Faith', 'Mutuku', '1995-08-10', '+254700112233'),
('John', 'Kiprop', '1988-12-05', '+254799887766');

INSERT INTO medicine (name, brand, stock_quantity, price) VALUES
('Paracetamol 500mg', 'Panadol', 500, 10.00),
('Amoxicillin 500mg', 'Amoxil', 200, 50.00),
('Paracetamol/Aspirin/Caffeine', 'Mara Moja', 300, 15.00),
('Artemether/Lumefantrine', 'Coartem', 100, 150.00),
('Chlorpheniramine 4mg', 'Piriton', 400, 5.00);

INSERT INTO prescriptions (patient_id, pharmacist_id, date_issued) VALUES
(1, 2, '2023-10-01'), -- Brian treated by Grace
(2, 1, '2023-10-02'), -- Mercy treated by Samuel
(3, 4, '2023-10-05'), -- Ali treated by Chebet
(4, 3, '2023-10-06'), -- Faith treated by David
(5, 5, '2023-10-10'); -- John treated by Amina

INSERT INTO prescription_items (prescription_id, medicine_id, quantity, dosage_instructions) VALUES
(1, 4, 24, 'Take 4 tablets initially, then 4 tablets after 8 hours, then 4 tablets twice daily for 2 days.'), 
(1, 1, 10, 'Take 2 tablets 3 times a day after meals for 3 days.'), 
(2, 2, 15, 'Take 1 capsule 3 times a day for 5 days.'), 
(3, 3, 6, 'Take 2 tablets when necessary. Do not exceed 8 tablets in 24 hours.'), 
(4, 5, 10, 'Take 1 tablet every 8 hours for allergies.'), 
(5, 2, 15, 'Take 1 capsule 3 times a day for 5 days.');





-- QUERIES

-- Query 1: The Single-Table Warmup (No Joins)
-- Scenario: Show all medicines that cost less than 20 KES.

SELECT name, price 
FROM medicine 
WHERE price < 20;


-- Query 2: Connecting Patient to Prescription (1 Join)
-- Scenario: List all prescription dates alongside the first name of the patient who received them.

SELECT p.first_name, rx.date_issued
FROM patients p
JOIN prescriptions rx ON p.patient_id = rx.patient_id;

-- Query 3: Connecting Pharmacist to Prescription (1 Join)
-- Scenario: List all prescription IDs alongside the first name of the pharmacist who authorized them.

SELECT ph.first_name, rx.prescription_id
FROM pharmacist ph
JOIN prescriptions rx ON ph.pharmacist_id = rx.pharmacist_id;

-- Query 4: Connecting the Basket to the Inventory (1 Join)
-- Scenario: Show the actual medicine name and the quantity ordered for every item inside the prescription baskets.

SELECT m.name, pi.quantity
FROM medicine m
JOIN prescription_items pi ON m.medicine_id = pi.medicine_id;

-- Query 5: The "Who Served Who" Triad (2 Joins)
-- Scenario: Show a list of prescription IDs, the patient's name, and the pharmacist's name for every transaction.

SELECT rx.prescription_id, 
       p.first_name AS patient, 
       ph.first_name AS pharmacist
FROM prescriptions rx
JOIN patients p ON rx.patient_id = p.patient_id
JOIN pharmacist ph ON rx.pharmacist_id = ph.pharmacist_id;