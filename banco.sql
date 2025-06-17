-- Tabelas
CREATE TABLE Museu (
    id NUMBER(10) NOT NULL,
    nome VARCHAR2(100) NOT NULL,
    local VARCHAR2(100) NOT NULL,
    descricao VARCHAR2(200)
);

CREATE TABLE Artista (
    id NUMBER(10) NOT NULL,
    nome VARCHAR2(100) NOT NULL,
    bio VARCHAR2(4000), -- Aumentei para permitir biografias mais longas
    dataNasc DATE
);

CREATE TABLE Obra (
    id NUMBER(10) NOT NULL,
    titulo VARCHAR2(100) NOT NULL,
    artista_id NUMBER(10) NOT NULL,
    data_criacao DATE, -- Renomeado para evitar conflito com palavra reservada
    descricao VARCHAR2(4000), -- Aumentei para descrições mais longas
    tipo VARCHAR2(50)
);

CREATE TABLE Visitante (
    id NUMBER(10) NOT NULL,
    nome VARCHAR2(100) NOT NULL,
    contato VARCHAR2(100),
    preferencia VARCHAR2(100)
);

CREATE TABLE Funcionario (
    id NUMBER(10) NOT NULL,
    nome VARCHAR2(100) NOT NULL,
    contato VARCHAR2(100),
    cargo VARCHAR2(50)
);

CREATE TABLE Ingresso (
    id NUMBER(10) NOT NULL,
    visitante_id NUMBER(10) NOT NULL
);

CREATE TABLE CompraObras (
    id NUMBER(10) NOT NULL,
    obra_id NUMBER(10) NOT NULL,
    comprador_id NUMBER(10) NOT NULL,
    id_vendedor NUMBER(10) NOT NULL,
    valor NUMBER(10, 2) NOT NULL -- Usei NUMBER(10, 2) para valores monetários
);

CREATE TABLE Feedback (
    id NUMBER(10) NOT NULL,
    visitante_id NUMBER(10) NOT NULL,
    nota NUMBER(1) NOT NULL, -- Nota de 1 a 5, por exemplo
    comentario VARCHAR2(4000) -- Aumentei para comentários mais longos
);

CREATE TABLE Evento (
    id NUMBER(10) NOT NULL,
    nome VARCHAR2(100) NOT NULL,
    data_evento DATE NOT NULL, -- Renomeado para evitar conflito com palavra reservada
    local_evento VARCHAR2(100), -- Renomeado
    museu_id NUMBER(10) NOT NULL
);

CREATE TABLE EventoParticipante (
    evento_id NUMBER(10) NOT NULL,
    visitante_id NUMBER(10) NOT NULL
);

---

-- Chaves Primárias
ALTER TABLE Museu ADD PRIMARY KEY (id);
ALTER TABLE Artista ADD PRIMARY KEY (id);
ALTER TABLE Obra ADD PRIMARY KEY (id);
ALTER TABLE Visitante ADD PRIMARY KEY (id);
ALTER TABLE Funcionario ADD PRIMARY KEY (id);
ALTER TABLE Ingresso ADD PRIMARY KEY (id);
ALTER TABLE CompraObras ADD PRIMARY KEY (id);
ALTER TABLE Feedback ADD PRIMARY KEY (id);
ALTER TABLE Evento ADD PRIMARY KEY (id);
ALTER TABLE EventoParticipante ADD PRIMARY KEY (evento_id, visitante_id);

---

-- Chaves Estrangeiras
ALTER TABLE Obra ADD FOREIGN KEY (artista_id) REFERENCES Artista(id);
ALTER TABLE Ingresso ADD FOREIGN KEY (visitante_id) REFERENCES Visitante(id);
ALTER TABLE CompraObras ADD FOREIGN KEY (obra_id) REFERENCES Obra(id);
ALTER TABLE CompraObras ADD FOREIGN KEY (comprador_id) REFERENCES Visitante(id);
ALTER TABLE CompraObras ADD FOREIGN KEY (id_vendedor) REFERENCES Funcionario(id);
ALTER TABLE Feedback ADD FOREIGN KEY (visitante_id) REFERENCES Visitante(id);
ALTER TABLE Evento ADD FOREIGN KEY (museu_id) REFERENCES Museu(id);
ALTER TABLE EventoParticipante ADD FOREIGN KEY (evento_id) REFERENCES Evento(id);
ALTER TABLE EventoParticipante ADD FOREIGN KEY (visitante_id) REFERENCES Visitante(id);

---

-- Sequências para Auto-Incremento
CREATE SEQUENCE museu_seq
INCREMENT BY 1
START WITH 1
NOMAXVALUE
NOCACHE
NOCYCLE
ORDER;

CREATE TRIGGER museu_trig
BEFORE INSERT ON Museu FOR EACH ROW
BEGIN
:NEW.id := museu_seq.NEXTVAL;
END;
/

CREATE SEQUENCE artista_seq
INCREMENT BY 1
START WITH 1
NOMAXVALUE
NOCACHE
NOCYCLE
ORDER;

CREATE TRIGGER artista_trig
BEFORE INSERT ON Artista FOR EACH ROW
BEGIN
:NEW.id := artista_seq.NEXTVAL;
END;
/

CREATE SEQUENCE obra_seq
INCREMENT BY 1
START WITH 1
NOMAXVALUE
NOCACHE
NOCYCLE
ORDER;

CREATE TRIGGER obra_trig
BEFORE INSERT ON Obra FOR EACH ROW
BEGIN
:NEW.id := obra_seq.NEXTVAL;
END;
/

CREATE SEQUENCE visitante_seq
INCREMENT BY 1
START WITH 1
NOMAXVALUE
NOCACHE
NOCYCLE
ORDER;

CREATE TRIGGER visitante_trig
BEFORE INSERT ON Visitante FOR EACH ROW
BEGIN
:NEW.id := visitante_seq.NEXTVAL;
END;
/

CREATE SEQUENCE funcionario_seq
INCREMENT BY 1
START WITH 1
NOMAXVALUE
NOCACHE
NOCYCLE
ORDER;

CREATE TRIGGER funcionario_trig
BEFORE INSERT ON Funcionario FOR EACH ROW
BEGIN
:NEW.id := funcionario_seq.NEXTVAL;
END;
/

CREATE SEQUENCE ingresso_seq
INCREMENT BY 1
START WITH 1
NOMAXVALUE
NOCACHE
NOCYCLE
ORDER;

CREATE TRIGGER ingresso_trig
BEFORE INSERT ON Ingresso FOR EACH ROW
BEGIN
:NEW.id := ingresso_seq.NEXTVAL;
END;
/

CREATE SEQUENCE compraobras_seq
INCREMENT BY 1
START WITH 1
NOMAXVALUE
NOCACHE
NOCYCLE
ORDER;

CREATE TRIGGER compraobras_trig
BEFORE INSERT ON CompraObras FOR EACH ROW
BEGIN
:NEW.id := compraobras_seq.NEXTVAL;
END;
/

CREATE SEQUENCE feedback_seq
INCREMENT BY 1
START WITH 1
NOMAXVALUE
NOCACHE
NOCYCLE
ORDER;

CREATE TRIGGER feedback_trig
BEFORE INSERT ON Feedback FOR EACH ROW
BEGIN
:NEW.id := feedback_seq.NEXTVAL;
END;
/

CREATE SEQUENCE evento_seq
INCREMENT BY 1
START WITH 1
NOMAXVALUE
NOCACHE
NOCYCLE
ORDER;

CREATE TRIGGER evento_trig
BEFORE INSERT ON Evento FOR EACH ROW
BEGIN
:NEW.id := evento_seq.NEXTVAL;
END;
/
