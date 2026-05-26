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
    FOREIGN KEY (prescription_id) REFERENCES prescription(prescription_id) ON DELETE CASCADE,
    FOREIGN KEY (medicine_id) REFERENCES medicine(medicine_id) ON DELETE CASCADE
);