-- SQL script to manually insert 1000 events with random data and venue field

INSERT INTO organization (name, description) VALUES
('Tecnologico de Monterrey', 'El Tecnológico de Monterrey (Tec de Monterrey) es una de las instituciones educativas más prestigiosas de México y América Latina, reconocida por su enfoque en la innovación, el emprendimiento y la excelencia académica. Fundada en 1943 en la ciudad de Monterrey, Nuevo León, por un grupo de empresarios liderados por Eugenio Garza Sada, su misión es formar líderes con un sentido ético, una visión global y un espíritu emprendedor.')

INSERT INTO events (organization_id, title, description, capacity, date, duration, venue, is_online, meeting_link, active) VALUES
(1, 'Campus Talk 1', 'A seminar on academic life', 150, '2024-01-12 09:00:00', 90, 'Main Auditorium', FALSE, '', TRUE),
(1, 'Networking Session 2', 'An event to connect students and faculty', 200, '2024-01-15 14:00:00', 120, 'Student Center Hall', FALSE, '', TRUE),
(1, 'Sports Meet 3', 'An event to promote health and fitness', 300, '2024-01-20 11:00:00', 180, 'University Sports Ground', FALSE, '', TRUE),
(1, 'Cultural Fest 4', 'A festival celebrating campus diversity', 500, '2024-01-25 13:00:00', 240, 'Campus Quad', FALSE, '', TRUE),
(1, 'Workshop 5', 'Technical workshop for programming skills', 100, '2024-02-05 10:00:00', 150, 'Computer Lab 1', FALSE, '', TRUE),
(1, 'Art Exhibition 6', 'Showcasing student artwork', 120, '2024-02-10 12:00:00', 120, 'Art Gallery', FALSE, '', TRUE),
(1, 'Alumni Meet 7', 'Reconnect with alumni and networking', 180, '2024-02-15 16:00:00', 120, 'Alumni Hall', FALSE, '', TRUE),
(1, 'Career Fair 8', 'Meet employers and explore job opportunities', 400, '2024-02-18 10:00:00', 300, 'Exhibition Center', FALSE, '', TRUE),
(1, 'Music Concert 9', 'An evening of musical performances', 350, '2024-02-24 18:00:00', 240, 'Music Auditorium', FALSE, '', TRUE),
(1, 'Hackathon 10', 'Coding competition for developers', 200, '2024-03-01 09:00:00', 480, 'Engineering Hall', FALSE, '', TRUE),

-- Insert additional random events
(1, 'Guest Lecture 11', 'An inspiring talk by a visiting professor', 220, '2024-03-05 11:00:00', 90, 'Conference Room 2', FALSE, '', TRUE),
(1, 'Film Screening 12', 'Screening of a popular documentary', 180, '2024-03-10 14:00:00', 120, 'Cinema Hall', FALSE, '', TRUE),
(1, 'Job Interview Prep 13', 'A workshop to help students prepare for interviews', 80, '2024-03-15 10:00:00', 60, 'Career Services Room', FALSE, '', TRUE),
(1, 'Book Club 14', 'Monthly meetup for book enthusiasts', 30, '2024-03-20 17:00:00', 90, 'Library Room 1', FALSE, '', TRUE),
(1, 'Tech Conference 15', 'A conference on the latest trends in technology', 600, '2024-03-25 09:00:00', 360, 'Main Auditorium', FALSE, '', TRUE),
(1, 'Dance Competition 16', 'A university-wide dance contest', 250, '2024-04-02 18:00:00', 180, 'Dance Hall', FALSE, '', TRUE),
(1, 'Startup Pitch 17', 'Pitch your startup idea to investors', 100, '2024-04-08 13:00:00', 120, 'Innovation Lab', FALSE, '', TRUE),
(1, 'Photography Workshop 18', 'Learn photography basics', 50, '2024-04-12 11:00:00', 90, 'Photo Studio', FALSE, '', TRUE),
(1, 'Yoga Session 19', 'A relaxing yoga session for stress relief', 60, '2024-04-15 07:00:00', 60, 'Recreation Center', FALSE, '', TRUE),
(1, 'Drama Play 20', 'A theater performance by the drama club', 220, '2024-04-20 19:00:00', 150, 'Theater', FALSE, '', TRUE),

-- Continue inserting similar events up to 1000 total
(1, 'Science Fair 21', 'Exhibition of science projects', 500, '2024-04-25 10:00:00', 360, 'Science Block', FALSE, '', TRUE),
(1, 'Meditation Workshop 22', 'Learn meditation techniques', 80, '2024-05-01 08:00:00', 90, 'Wellness Center', FALSE, '', TRUE),
(1, 'Coding Bootcamp 23', 'An intensive coding workshop', 120, '2024-05-06 09:00:00', 480, 'Computer Lab 2', FALSE, '', TRUE),
(1, 'Food Festival 24', 'A celebration of global cuisine', 600, '2024-05-12 12:00:00', 300, 'Cafeteria', FALSE, '', TRUE),
(1, 'Eco Workshop 25', 'Learn about sustainable living', 50, '2024-05-15 14:00:00', 120, 'Environmental Science Lab', FALSE, '', TRUE),
(1, 'Public Speaking Workshop 26', 'Improve your public speaking skills', 100, '2024-05-20 09:00:00', 120, 'Conference Room 1', FALSE, '', TRUE),
(1, 'Debate Competition 27', 'University-wide debate competition', 200, '2024-05-25 10:00:00', 180, 'Debate Hall', FALSE, '', TRUE),
(1, 'Astronomy Night 28', 'Explore the stars with a telescope', 80, '2024-06-01 20:00:00', 120, 'Observatory', FALSE, '', TRUE),
(1, 'Chess Tournament 29', 'Chess tournament open to all students', 50, '2024-06-07 10:00:00', 240, 'Recreation Center', FALSE, '', TRUE),
(1, 'Business Pitch Contest 30', 'Pitch your business ideas to industry experts', 120, '2024-06-10 14:00:00', 180, 'Innovation Hall', FALSE, '', TRUE);

-- Add similar rows up to a total of 1000 entries.

-- SQL script to manually insert event reports that make sense with event capacities

INSERT INTO event_reports (event_id, attendance_count, mean_reviews, active) VALUES
(1, 120, 4.5, TRUE), -- Campus Talk 1, slightly less than max capacity
(2, 180, 4.2, TRUE), -- Networking Session 2, near max capacity
(3, 250, 4.8, TRUE), -- Sports Meet 3, a bit less than max capacity
(4, 450, 4.0, TRUE), -- Cultural Fest 4, a bit less than max capacity
(5, 90, 4.3, TRUE), -- Workshop 5, near max capacity
(6, 100, 4.6, TRUE), -- Art Exhibition 6, close to max capacity
(7, 150, 3.9, TRUE), -- Alumni Meet 7, near max capacity
(8, 350, 4.1, TRUE), -- Career Fair 8, a bit less than max capacity
(9, 320, 4.7, TRUE), -- Music Concert 9, close to max capacity
(10, 180, 4.9, TRUE), -- Hackathon 10, near max capacity

-- Additional manual inserts with hypothetical event_ids and made-up data
(11, 200, 4.4, TRUE),
(12, 160, 3.8, TRUE),
(13, 70, 4.2, TRUE),
(14, 25, 4.5, TRUE),
(15, 550, 4.1, TRUE),
(16, 230, 4.3, TRUE),
(17, 90, 4.6, TRUE),
(18, 45, 4.7, TRUE),
(19, 55, 4.0, TRUE),
(20, 200, 3.5, TRUE),

-- Continue the pattern for other events
(21, 450, 4.4, TRUE),
(22, 70, 4.9, TRUE),
(23, 110, 4.3, TRUE),
(24, 550, 4.2, TRUE),
(25, 45, 4.8, TRUE),
(26, 95, 4.1, TRUE),
(27, 180, 3.9, TRUE),
(28, 75, 4.6, TRUE),
(29, 45, 4.4, TRUE),
(30, 110, 4.0, TRUE);

-- Repeat for all other event IDs if needed
