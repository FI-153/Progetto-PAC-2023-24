-- Crea tabella per le escursioni
CREATE TABLE event (
    id INT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    place VARCHAR(255) NOT NULL,
    difficulty VARCHAR(255),
    date TIMESTAMP WITHOUT TIME ZONE,
    description TEXT,
    distance VARCHAR(255),
    height_evel VARCHAR(255),
    min_eight VARCHAR(255),
    tools VARCHAR(255),
    meeting_place VARCHAR(255),
    max_eople INT,
    time VARCHAR(255),
    id_rofile INT
);

-- Crea tabella per il profilo
CREATE TABLE profile(
    id INT PRIMARY KEY,
    first_name VARCHAR(255) NOT NULL,
    last_name VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL,
    phone VARCHAR(255),
    password VARCHAR(255) NOT NULL,
    profile_role VARCHAR(255) NOT NULL
);

-- Crea tabella per le prenotazioni
CREATE TABLE reservation (
    id NUMERIC PRIMARY KEY,
    id_profile INT NOT NULL,
    id_event INT NOT NULL,
    datetime TIMESTAMP WITH TIME ZONE,
    confirmation BOOLEAN
);

-- Inserisce utente admin
INSERT INTO profile(id, first_name, last_name, email, password, phone, profile_role)
VALUES (0, 'admin', 'admin', 'admin@admin.com', 'admin', '123', 'ADMIN');
