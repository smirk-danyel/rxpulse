const express = require('express');
const mysql = require('mysql2');
const path = require('path');

const app = express();

app.use(express.urlencoded({ extended: true }));
app.use(express.static(path.join(__dirname, 'public')));
app.set('view engine', 'ejs');

// Database Driver Setup
const db = mysql.createConnection({
    host: 'localhost',
    user: 'root',
    password: 'D@nyel20010606', // Update this with your actual local MySQL password
    database: 'rxpulse'
});

db.connect((err) => {
    if (err) throw err;
    console.log('RxPulse securely connected to MySQL server.');
});

// --- CORE ANALYTICAL DASHBOARD ---
app.get('/dashboard', async (req, res) => {
    try {
        const [patients] = await db.promise().query('SELECT COUNT(*) as count FROM patients');
        const [medicines] = await db.promise().query('SELECT COUNT(*) as count FROM medicine');
        const [prescriptions] = await db.promise().query('SELECT COUNT(*) as count FROM prescriptions');

        const [activity] = await db.promise().query(`
            SELECT rx.prescription_id, rx.date_issued,
                   p.first_name AS patient_first, p.last_name AS patient_last,
                   ph.first_name AS pharmacist_first, ph.last_name AS pharmacist_last
            FROM prescriptions rx
            JOIN patients p ON rx.patient_id = p.patient_id
            JOIN pharmacist ph ON rx.pharmacist_id = ph.pharmacist_id
            ORDER BY rx.date_issued DESC LIMIT 10
        `);

        res.render('dashboard', {
            totalPatients: patients[0].count,
            totalMedicines: medicines[0].count,
            totalPrescriptions: prescriptions[0].count,
            recentActivity: activity
        });
    } catch (err) {
        res.status(500).send("Dashboard query failure: " + err.message);
    }
});

// --- DYNAMIC PATIENT REGISTRY (WITH CRUD MANIPULATION ENGINE) ---
app.get('/patients', async (req, res) => {
    try {
        const [rows] = await db.promise().query('SELECT * FROM patients ORDER BY patient_id DESC');
        res.render('patients', { patients: rows, editingPatient: null });
    } catch (err) { res.status(500).send(err.message); }
});

app.get('/patients/edit/:id', async (req, res) => {
    try {
        const [patients] = await db.promise().query('SELECT * FROM patients ORDER BY patient_id DESC');
        const [target] = await db.promise().query('SELECT * FROM patients WHERE patient_id = ?', [req.params.id]);
        res.render('patients', { patients: patients, editingPatient: target[0] });
    } catch (err) { res.status(500).send(err.message); }
});

app.post('/patients/add', async (req, res) => {
    const { first_name, last_name, dob, phone } = req.body;
    try {
        await db.promise().query('INSERT INTO patients (first_name, last_name, dob, phone) VALUES (?, ?, ?, ?)', 
        [first_name, last_name, dob || null, phone || null]);
        res.redirect('/patients');
    } catch (err) { res.status(500).send(err.message); }
});

app.post('/patients/update/:id', async (req, res) => {
    const { first_name, last_name, dob, phone } = req.body;
    try {
        await db.promise().query('UPDATE patients SET first_name = ?, last_name = ?, dob = ?, phone = ? WHERE patient_id = ?',
        [first_name, last_name, dob || null, phone || null, req.params.id]);
        res.redirect('/patients');
    } catch (err) { res.status(500).send(err.message); }
});

app.get('/patients/delete/:id', async (req, res) => {
    try {
        await db.promise().query('DELETE FROM patients WHERE patient_id = ?', [req.params.id]);
        res.redirect('/patients');
    } catch (err) { res.status(500).send(err.message); }
});

// --- PHARMACISTS STAFF DIRECTORY ---
app.get('/pharmacists', async (req, res) => {
    try {
        const [rows] = await db.promise().query('SELECT * FROM pharmacist');
        res.render('pharmacists', { pharmacists: rows });
    } catch (err) { res.status(500).send(err.message); }
});

// --- MEDICINE INVENTORY TRACKER ---
app.get('/medicine', async (req, res) => {
    try {
        const [rows] = await db.promise().query('SELECT * FROM medicine');
        res.render('medicine', { medicines: rows });
    } catch (err) { res.status(500).send(err.message); }
});

// --- HISTORIC TRANSCRIPTS LOG ---
app.get('/prescriptions', async (req, res) => {
    try {
        const [rows] = await db.promise().query(`
            SELECT rx.prescription_id, rx.date_issued,
                   p.first_name AS patient_first, p.last_name AS patient_last,
                   ph.first_name AS pharmacist_first, ph.last_name AS pharmacist_last
            FROM prescriptions rx
            JOIN patients p ON rx.patient_id = p.patient_id
            JOIN pharmacist ph ON rx.pharmacist_id = ph.pharmacist_id
        `);
        res.render('prescriptions', { prescriptions: rows });
    } catch (err) { res.status(500).send(err.message); }
});

// --- DISPENSED BASKET ITEMIZATION DETAILS ---
app.get('/prescription-items', async (req, res) => {
    try {
        const [rows] = await db.promise().query(`
            SELECT pi.item_id, pi.prescription_id, pi.quantity, pi.dosage_instructions,
                   m.name AS medicine_name, m.brand AS medicine_brand,
                   p.first_name AS patient_first, p.last_name AS patient_last
            FROM prescription_items pi
            JOIN medicine m ON pi.medicine_id = m.medicine_id
            JOIN prescriptions rx ON pi.prescription_id = rx.prescription_id
            JOIN patients p ON rx.patient_id = p.patient_id
        `);
        res.render('prescription-items', { items: rows });
    } catch (err) { res.status(500).send(err.message); }
});

// Redirect root to dashboard view
app.get('/', (req, res) => res.redirect('/dashboard'));

app.listen(3000, () => {
    console.log('RxPulse Server operational on http://localhost:3000');
});