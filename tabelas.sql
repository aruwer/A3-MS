CREATE TABLE Museu (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100),
    local VARCHAR(100),
    descricao VARCHAR(100)
);

CREATE TABLE Artista (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100),
    bio VARCHAR(100),
    dataNasc DATE
);

CREATE TABLE Obra (
    id INT AUTO_INCREMENT PRIMARY KEY,
    titulo VARCHAR(100),
    artista_id INT,
    data DATE,
    descricao VARCHAR(100),
    tipo VARCHAR(50),
    FOREIGN KEY (artista_id) REFERENCES Artista(id)
);

CREATE TABLE Visitante (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100),
    contato VARCHAR(100),
    preferencia VARCHAR(100)
);

CREATE TABLE Funcionario (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100),
    contato VARCHAR(100),
    cargo VARCHAR(50)
);

CREATE TABLE Ingresso (
    id INT AUTO_INCREMENT PRIMARY KEY,
    visitante_id INT,
    FOREIGN KEY (visitante_id) REFERENCES Visitante(id)
);

CREATE TABLE CompraObras (
    id INT AUTO_INCREMENT PRIMARY KEY,
    obra_id INT,
    comprador_id INT,
    id_vendedor INT,
    valor DOUBLE,
    FOREIGN KEY (obra_id) REFERENCES Obra(id),
    FOREIGN KEY (comprador_id) REFERENCES Visitante(id),
    FOREIGN KEY (id_vendedor) REFERENCES Funcionario(id)
);

CREATE TABLE Feedback (
    id INT AUTO_INCREMENT PRIMARY KEY,
    visitante_id INT,
    nota INT,
    comentario VARCHAR(100),
    FOREIGN KEY (visitante_id) REFERENCES Visitante(id)
);

CREATE TABLE Evento (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100),
    data DATE,
    local VARCHAR(100),
    museu_id INT,
    FOREIGN KEY (museu_id) REFERENCES Museu(id)
);

CREATE TABLE EventoParticipante (
    evento_id INT,
    visitante_id INT,
    PRIMARY KEY (evento_id, visitante_id),
    FOREIGN KEY (evento_id) REFERENCES Evento(id),
    FOREIGN KEY (visitante_id) REFERENCES Visitante(id)
);
