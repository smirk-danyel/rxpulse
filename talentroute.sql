CREATE DATABASE talentroute;
USE talentroute;

CREATE TABLE opportunities(
    id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    description TEXT,
    location VARCHAR(255),
    university VARCHAR(255),
    requirements TEXT,
    application_link VARCHAR(255),
);

CREATE TABLE talents(
    email VARCHAR(255) PRIMARY KEY,
    full_name VARCHAR(255) NOT NULL,
    sports VARCHAR(50),
    dob DATE,
    phone VARCHAR(20),
    highest_achievement TEXT,
    education_level VARCHAR(50),
);

CREATE TABLE wishlist(
    id INT AUTO_INCREMENT PRIMARY KEY,
    talent_email VARCHAR(255),
    opportunity_id INT,
    FOREIGN KEY (talent_email) REFERENCES talents(email),
    FOREIGN KEY (opportunity_id) REFERENCES opportunities(id)
);

CREATE TABLE referrals(
    id INT AUTO_INCREMENT PRIMARY KEY,
    talent_email VARCHAR(255),
    referee_name VARCHAR(255),
    referrer_email VARCHAR(255),
    referee_phone VARCHAR(20),
    relationship VARCHAR(255),
    description TEXT,
    attachment_url VARCHAR(255),
    FOREIGN KEY (talent_email) REFERENCES talents(email)
);










INSERT INTO talents (email, full_name, sports, dob, `education-level`, highesst_achievement, phone) VALUES
('joseph.kiprop@email.com', 'Joseph Kiprop', 'Athletics (Marathon)', '2004-03-12', 'High School', 'Gold Medalist - East Africa Secondary School Games', '+254712345678'),
('mercy.wambui@email.com', 'Mercy Wambui', 'Football', '2003-07-25', 'Undergraduate', 'Top Scorer - Kenya Women Premier League (KWPL)', '+254722111222'),
('brian.otieno@email.com', 'Brian Otieno', 'Rugby', '2002-11-05', 'Undergraduate', 'National Sevens Circuit Rookie of the Year', '+254733444555'),
('sharon.chepngetich@email.com', 'Sharon Chepngetich', 'Athletics (Sprints)', '2005-01-19', 'High School', 'Represented Kenya in World U20 Championships', '+254701987654'),
('emmanuel.omondi@email.com', 'Emmanuel Omondi', 'Basketball', '2001-05-30', 'Diploma', 'MVP - Kenya Basketball Federation (KBF) Division 1', '+254755666777'),
('alice.nduta@email.com', 'Alice Nduta', 'Volleyball', '2003-09-14', 'Undergraduate', 'Best Blocker - National Inter-University Games', '+254788999000'),
('kelvin.mwangi@email.com', 'Kelvin Mwangi', 'Swimming', '2006-02-10', 'High School', '3 Gold Medals - CANA Zone 3 Championships', '+254711223344'),
('faith.atieno@email.com', 'Faith Atieno', 'Hockey', '2002-04-22', 'Undergraduate', 'Captain - University First Team', '+254722334455'),
('david.lemaron@email.com', 'David Lemaron', 'Football', '2004-08-08', 'High School', 'Chapa Dimba na Safaricom Regional MVP', '+254733556677'),
('cynthia.cherotich@email.com', 'Cynthia Cherotich', 'Tennis', '2005-12-01', 'High School', 'Runner-up - ITF Nairobi Junior Circuit', '+254744667788');

INSERT INTO opportunities (title, description, location, university, requirements, application_link) VALUES
('NCAA Track & Field Scholarship', 'Full athletic scholarship for elite long-distance and middle-distance runners.', 'Eugene, Oregon, USA', 'University of Oregon', 'Sub-14:00 for 5000m or sub-4:00 for 1500m. KCSE C+ or above.', 'https://goducks.com/sports/track-and-field'),
('Elite Rugby Development Program', 'Residential rugby academy placement with professional coaching and degree studies.', 'Loughborough, UK', 'Loughborough University', 'Experience in national U20 trials or top-tier local club academy. IELTS 6.5.', 'https://www.lboro.ac.uk/sport/sports/rugby-union/'),
('Strathmore Sports Fee Waiver', 'Partial to full tuition fee waivers for exceptional basketball and football players.', 'Nairobi, Kenya', 'Strathmore University', 'Must pass Strathmore entrance exam. Letters of recommendation from national federations.', 'https://strathmore.edu/sports'),
('Division 1 Basketball Recruitment', 'Full-ride scholarship for high-potential center or power forward players.', 'Durham, North Carolina, USA', 'Duke University', 'Height above 6ft 6in for men / 6ft 0in for women preferred. SAT scores required.', 'https://goduke.com'),
('KCB Football Club Senior Trials', 'Open scouting trials for the senior team competing in the Kenya Premier League (FKF-PL).', 'Nairobi, Kenya', 'None', 'Age 18-23. Proven track record in FKF National Division 1 or NSL.', 'https://kcbbankgroup.com/sports'),
('Japan Corporate Running Team Placement', 'Professional contract with a corporate marathon team including housing and training stipend.', 'Chiba, Japan', 'None', 'Half marathon time sub-1:02:00 (men) or sub-1:10:00 (women).', 'https://japanrunningnews.blogspot.com'),
('Malkia Strikers Academy Pipeline', 'Development pathway program for young female volleyball players targeting the national team.', 'Nairobi, Kenya', 'Kenyatta University', 'Age 16-20. Height above 5ft 10in. High school sports certificate.', 'https://www.kvf.co.ke'),
('European Football Academy Trial', 'Two-week intensive trials with K.V. Kortrijk youth development system.', 'Kortrijk, Belgium', 'None', 'Valid passport, under 19 years old, recommendation from a certified FIFA agent or FKF.', 'https://www.kvk.be'),
('Swim Athletic Scholarship', 'Scholarship covering tuition and training costs for elite competitive swimmers.', 'Austin, Texas, USA', 'University of Texas', 'FINA points greater than 700 in preferred stroke.', 'https://texassports.com'),
('UoN Gladiators Hockey Scholarship', 'Talent sports scheme for the university hockey team competing in the national league.', 'Nairobi, Kenya', 'University of Nairobi', 'Admitted to UoN via KUCCPS. Excellent performance in high school national games.', 'https://uonbi.ac.ke');

INSERT INTO wishlist (talent_email, opportunity_id) VALUES
('joseph.kiprop@email.com', 1), -- Kiprop wants the Oregon track scholarship
('joseph.kiprop@email.com', 6), -- Kiprop also wants the Japan corporate running placement
('mercy.wambui@email.com', 3),  -- Mercy wants the Strathmore fee waiver
('mercy.wambui@email.com', 8),  -- Mercy wants the Belgium trials
('brian.otieno@email.com', 2),   -- Brian wants the UK Rugby program
('sharon.chepngetich@email.com', 1), -- Sharon wants the Oregon track scholarship
('emmanuel.omondi@email.com', 4), -- Emmanuel wants the Duke basketball scholarship
('alice.nduta@email.com', 7),    -- Alice wants the Malkia Strikers pipeline
('kelvin.mwangi@email.com', 9),  -- Kelvin wants the Texas swimming scholarship
('david.lemaron@email.com', 5);  -- David wants the KCB trials

INSERT INTO referrals (talent_email, referee_name, referrer_email, referee_phone, relationship, description, attachment_url) VALUES
('joseph.kiprop@email.com', 'Coach Colm OConnell', 'colm.ocool@email.com', '+254711999888', 'High School Coach', 'Joseph has exceptional aerobic capacity and structural discipline perfect for marathon translation.', 'https://talentroute.com/docs/kiprop_times.pdf'),
('mercy.wambui@email.com', 'Beldine Odemba', 'beldine.o@fkf.co.ke', '+254722888777', 'National Team Coach', 'Mercy is a clinical finisher with great spatial awareness. Star player in the making.', 'https://talentroute.com/docs/wambui_scouting.pdf'),
('brian.otieno@email.com', 'Benjamin Ayimba Jnr', 'ayimbab@rugby.ke', '+254733777666', 'Club Coach', 'Incredible pace on the wing and solid defensive work rate. Highly recommended for elite academies.', 'https://talentroute.com/docs/otieno_stats.pdf'),
('sharon.chepngetich@email.com', 'Julius Kirwa', 'kirwaj@athletics.or.ke', '+254701222333', 'Federation Scout', 'Sharon has explosive block clearance. Broke the regional junior record this year.', 'https://talentroute.com/docs/sharon_timing.pdf'),
('emmanuel.omondi@email.com', 'Peter Ouma', 'ouma.bball@gmail.com', '+254755111222', 'Academy Coach', 'Emmanuel commands the paint well. Needs strength training but raw defensive instincts are elite.', 'https://talentroute.com/docs/omondi_highlights.mp4'),
('alice.nduta@email.com', 'Paul Bitok', 'bitok.p@kvf.co.ke', '+254788333444', 'Technical Director', 'Alice possesses a rare vertical reach and high volleyball IQ for her age bracket.', 'https://talentroute.com/docs/nduta_jump_test.pdf'),
('kelvin.mwangi@email.com', 'Coach Dunford', 'dunford.swim@club.co.ke', '+254711444555', 'Private Coach', 'Kelvin dominates local short course events. Ready for international training exposure.', 'https://talentroute.com/docs/mwangi_fina.pdf'),
('faith.atieno@email.com', 'Meshack Senge', 'senge.m@hockey.ke', '+254722555666', 'University Coach', 'Faith is a natural leader on the pitch with superb tactical distribution skills.', 'https://talentroute.com/docs/atieno_review.pdf'),
('david.lemaron@email.com', 'Stanley Okumbi', 'okumbis@academy.co.ke', '+254733999000', 'Youth Academy Coach', 'David was the standout winger during the youth tour. Highly disciplined off the ball.', 'https://talentroute.com/docs/lemaron_chapa.pdf'),
('cynthia.cherotich@email.com', 'Wanjiru Mbugua', 'wanjiru.m@tennis.or.ke', '+254744111222', 'Tournament Director', 'Cynthia has a heavy baseline game and strong mental resilience during match points.', 'https://talentroute.com/docs/cherotich_itf.pdf');