CREATE TABLE especialidad (
    id_especialidad INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(50) NOT NULL,
    descripcion TEXT
);

CREATE TABLE medico (
    id_medico INT PRIMARY KEY AUTO_INCREMENT,
    nombres VARCHAR(50) NOT NULL,
    apellidos VARCHAR(50) NOT NULL,
    id_especialidad INT NOT NULL,
    consultorio VARCHAR(10),
    horario VARCHAR(100),
    FOREIGN KEY (id_especialidad) REFERENCES especialidad(id_especialidad)
);

CREATE TABLE paciente (
    id_paciente INT PRIMARY KEY AUTO_INCREMENT,
    nombres VARCHAR(50) NOT NULL,
    apellidos VARCHAR(50) NOT NULL,
    telefono VARCHAR(20),
    correo VARCHAR(100) UNIQUE,
    fecha_nacimiento DATE
);

CREATE TABLE cita (
    id_cita INT PRIMARY KEY AUTO_INCREMENT,
    id_paciente INT NOT NULL,
    id_medico INT NOT NULL,
    fecha DATE NOT NULL,
    hora TIME NOT NULL,
    estado VARCHAR(20) DEFAULT 'Programada',
    FOREIGN KEY (id_paciente) REFERENCES paciente(id_paciente),
    FOREIGN KEY (id_medico) REFERENCES medico(id_medico)
);


INSERT INTO especialidad (nombre, descripcion) VALUES 
('Pediatría', 'Atención médica a niños y adolescentes'),
('Neurología', 'Diagnóstico y tratamiento del sistema nervioso'),
('Ginecología', 'Atención médica especializada para mujeres'),
('Cardiología', 'Diagnóstico y tratamiento de enfermedades del corazón'), 
('Dermatología', 'Cuidado y tratamiento de la piel');


INSERT INTO medico (nombres, apellidos, id_especialidad, consultorio, horario) VALUES 
('Laura', 'Martínez', 1, '302A', 'Lunes a Viernes 8am - 4pm'),
('Carlos', 'Sanchez', 2, '100A', 'Lunes a Viernes 12am – 8am'),
('Maria', 'Gonzales', 3, '102A', 'Lunes a Viernes 4pm – 12am'),
('Fernando', 'Estrada', 4, '204B', 'Sábados y Domingos 8am - 4pm'),
('Juancho', 'Sáchica', 5, '202B', 'Sábados y Domingos 8pm – 4am');


INSERT INTO paciente (nombres, apellidos, telefono, correo, fecha_nacimiento) VALUES 
('Carlos', 'Ramos', '3124567890', 'carlos@example.com', '1990-05-20'),
('Julian', 'Estrada', '3108496582', 'juliancho@example.com', '1998-11-28'),
('Camila', 'Suarez', '3210987654', 'camis@example.com', '2009-04-21'),
('Jhon', 'Arroyo', '3029384756', 'jhonhenry@example.com', '2000-05-21'),
('Sergio', 'Yara', '3053219489', 'yara_sergio@example.com', '2007-09-05');


INSERT INTO cita (id_paciente, id_medico, fecha, hora, estado) VALUES 
(1, 3, '2025-07-18', '10:00:00', 'Programada'),
(2, 2, '2025-07-20', '12:30:00', 'Programada'),
(3, 5, '2025-07-22', '18:00:00', 'Programada'),
(4, 1, '2025-07-24', '20:00:00', 'Programada'),
(5, 4, '2025-07-26', '5:00:00', 'Programada');


SELECT 
    c.id_cita,
    CONCAT(p.nombres, ' ', p.apellidos) AS paciente,
    CONCAT(m.nombres, ' ', m.apellidos) AS medico,
    e.nombre AS especialidad,
    c.fecha,
    c.hora,
    c.estado

FROM cita c
JOIN paciente p ON c.id_paciente = p.id_paciente
JOIN medico m ON c.id_medico = m.id_medico
JOIN especialidad e ON m.id_especialidad = e.id_especialidad
ORDER BY c.fecha, c.hora;


SELECT 
    e.nombre AS especialidad,
    CONCAT(m.nombres, ' ', m.apellidos) AS medico,
    m.consultorio,
    m.horario
FROM medico m
JOIN especialidad e ON m.id_especialidad = e.id_especialidad
ORDER BY e.nombre;


SELECT 
    CONCAT(p.nombres, ' ', p.apellidos) AS paciente,
    COUNT(c.id_cita) AS total_citas
FROM paciente p
LEFT JOIN cita c ON p.id_paciente = c.id_paciente
GROUP BY p.id_paciente, p.nombres, p.apellidos
ORDER BY total_citas DESC;


SELECT 
    CONCAT(p.nombres, ' ', p.apellidos) AS paciente,
    CONCAT(m.nombres, ' ', m.apellidos) AS medico,
    c.hora,
    c.estado
FROM cita c
JOIN paciente p ON c.id_paciente = p.id_paciente
JOIN medico m ON c.id_medico = m.id_medico
WHERE c.fecha = '2025-07-18'
ORDER BY c.hora;


SELECT 
    CONCAT(m.nombres, ' ', m.apellidos) AS medico,
    e.nombre AS especialidad,
    COUNT(c.id_cita) AS total_citas
FROM medico m
JOIN especialidad e ON m.id_especialidad = e.id_especialidad
LEFT JOIN cita c ON m.id_medico = c.id_medico
GROUP BY m.id_medico, m.nombres, m.apellidos, e.nombre
ORDER BY total_citas DESC;


CREATE VIEW vista_citas_completas AS
SELECT 
    c.id_cita,
    CONCAT(p.nombres, ' ', p.apellidos) AS paciente,
    p.telefono AS telefono_paciente,
    CONCAT(m.nombres, ' ', m.apellidos) AS medico,
    e.nombre AS especialidad,
    m.consultorio,
    c.fecha,
    c.hora,
    c.estado
FROM cita c
JOIN paciente p ON c.id_paciente = p.id_paciente
JOIN medico m ON c.id_medico = m.id_medico
JOIN especialidad e ON m.id_especialidad = e.id_especialidad;


SELECT * FROM vista_citas_completas WHERE fecha = '2025-07-18';


