# RxPulse

A pharmacy management system for tracking patients, medicine stock, and prescriptions.

## Features

- Patient records
- Medicine inventory
- Prescriptions & prescription items
- Pharmacist accounts
- Dashboard overview

## Tech Stack

- Node.js + Express
- EJS templating
- MySQL

## Getting Started

1. **Clone the repo**

   ```bash
   git clone https://github.com/smirk-danyel/rxpulse.git
   cd rxpulse

   ```

2. **Install dependancies**
   npm install

3. **Set up the database**
   Create a MYSQL database
   Import schema:
   mysql -u your_user -p your_database < rxpulse.sql

4. **Configure environment variables**
   Create a .env file in the root folder:
   DB_HOST=localhost
   DB_USER=your_user
   DB_PASSWORD=your_password
   DB_NAME=your_database
   PORT=3000

5. **Run the app**
   node app.js
   Visit http://localhost3000 in your browser.

**Project Structure**
rxpulse/
├── public/ # CSS and static assets
├── views/ # EJS templates (dashboard, patients, medicine, etc.)
├── app.js # Main Express app
└── rxpulse.sql # Database schema
