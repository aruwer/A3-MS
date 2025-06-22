CREATE TABLE Pessoa (
    id NUMBER(10) NOT NULL,
    nome VARCHAR2(100) NOT NULL,
    contato VARCHAR2(100)
);

CREATE TABLE Visitante (
    id NUMBER(10) NOT NULL,
    preferencia VARCHAR2(100)
);

CREATE TABLE Funcionario (
    id NUMBER(10) NOT NULL,
    cargo VARCHAR2(50)
);

CREATE TABLE Museu (
    id NUMBER(10) NOT NULL,
    nome VARCHAR2(100) NOT NULL,
    local VARCHAR2(100) NOT NULL,
    descricao VARCHAR2(200)
);

CREATE TABLE Artista (
    id NUMBER(10) NOT NULL,
    nome VARCHAR2(100) NOT NULL,
    bio VARCHAR2(4000),
    dataNasc DATE
);

CREATE TABLE Obra (
    id NUMBER(10) NOT NULL,
    titulo VARCHAR2(100) NOT NULL,
    artista_id NUMBER(10) NOT NULL,
    data_criacao DATE,
    descricao VARCHAR2(4000),
    tipo VARCHAR2(50)
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
    valor NUMBER(10, 2) NOT NULL
);

CREATE TABLE Feedback (
    id NUMBER(10) NOT NULL,
    visitante_id NUMBER(10) NOT NULL,
    nota NUMBER(1) NOT NULL,
    comentario VARCHAR2(4000)
);

CREATE TABLE Evento (
    id NUMBER(10) NOT NULL,
    nome VARCHAR2(100) NOT NULL,
    data_evento DATE NOT NULL,
    local_evento VARCHAR2(100),
    museu_id NUMBER(10) NOT NULL
);

CREATE TABLE EventoParticipante (
    evento_id NUMBER(10) NOT NULL,
    visitante_id NUMBER(10) NOT NULL
);


ALTER TABLE Pessoa ADD PRIMARY KEY (id);
ALTER TABLE Visitante ADD PRIMARY KEY (id);
ALTER TABLE Funcionario ADD PRIMARY KEY (id);
ALTER TABLE Museu ADD PRIMARY KEY (id);
ALTER TABLE Artista ADD PRIMARY KEY (id);
ALTER TABLE Obra ADD PRIMARY KEY (id);
ALTER TABLE Ingresso ADD PRIMARY KEY (id);
ALTER TABLE CompraObras ADD PRIMARY KEY (id);
ALTER TABLE Feedback ADD PRIMARY KEY (id);
ALTER TABLE Evento ADD PRIMARY KEY (id);
ALTER TABLE EventoParticipante ADD PRIMARY KEY (evento_id, visitante_id);

ALTER TABLE Visitante ADD FOREIGN KEY (id) REFERENCES Pessoa(id);
ALTER TABLE Funcionario ADD FOREIGN KEY (id) REFERENCES Pessoa(id);
ALTER TABLE Obra ADD FOREIGN KEY (artista_id) REFERENCES Artista(id);
ALTER TABLE Ingresso ADD FOREIGN KEY (visitante_id) REFERENCES Visitante(id);
ALTER TABLE CompraObras ADD FOREIGN KEY (obra_id) REFERENCES Obra(id);
ALTER TABLE CompraObras ADD FOREIGN KEY (comprador_id) REFERENCES Visitante(id);
ALTER TABLE CompraObras ADD FOREIGN KEY (id_vendedor) REFERENCES Funcionario(id);
ALTER TABLE Feedback ADD FOREIGN KEY (visitante_id) REFERENCES Visitante(id);
ALTER TABLE Evento ADD FOREIGN KEY (museu_id) REFERENCES Museu(id);
ALTER TABLE EventoParticipante ADD FOREIGN KEY (evento_id) REFERENCES Evento(id);
ALTER TABLE EventoParticipante ADD FOREIGN KEY (visitante_id) REFERENCES Visitante(id);


CREATE SEQUENCE pessoa_seq
INCREMENT BY 1
START WITH 1
NOMAXVALUE
NOCACHE
NOCYCLE
ORDER;

CREATE TRIGGER pessoa_trig
BEFORE INSERT ON Pessoa FOR EACH ROW
BEGIN
:NEW.id := pessoa_seq.NEXTVAL;
END;
/

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
-- 16. OPERAÇÕES COM MÚLTIPLAS TABELAS (JOIN)

-- Relatório 1.1: Obras e Seus Artistas
-- Objetivo: Listar cada obra com o nome do artista que a criou.
-- Utilidade: Catalogação e exibição rápida das obras por autor.
SELECT o.titulo AS "Título da Obra", a.nome AS "Nome do Artista"
FROM Obra o
JOIN Artista a ON o.artista_id = a.id;

-- Relatório 1.2: Participantes em Eventos do Museu
-- Objetivo: Listar todos os eventos e os nomes dos visitantes que participarão.
-- Utilidade: Gestão de público, planejamento de recursos para eventos.
SELECT e.nome AS "Nome do Evento", p.nome AS "Nome do Participante", e.data_evento AS "Data do Evento"
FROM Evento e
JOIN EventoParticipante ep ON e.id = ep.evento_id
JOIN Visitante v ON ep.visitante_id = v.id
JOIN Pessoa p ON v.id = p.id;

-- Relatório 1.3: Compras de Obras Detalhadas (Comprador e Vendedor)
-- Objetivo: Apresentar todas as vendas de obras, incluindo título, valor, comprador e vendedor.
-- Utilidade: Controle financeiro, análise de desempenho de vendas.
SELECT o.titulo AS "Obra Vendida", cb.valor AS "Valor da Compra", pv.nome AS "Nome do Comprador", pf.nome AS "Nome do Vendedor"
FROM CompraObras cb
JOIN Obra o ON cb.obra_id = o.id
JOIN Visitante v ON cb.comprador_id = v.id
JOIN Pessoa pv ON v.id = pv.id
JOIN Funcionario f ON cb.id_vendedor = f.id
JOIN Pessoa pf ON f.id = pf.id;

-- 18. FUNÇÕES DE GRUPO GROUP BY E HAVING

-- Relatório 2.1: Contagem de Obras por Artista
-- Objetivo: Mostrar quantas obras cada artista possui no acervo do museu.
-- Utilidade: Identificar artistas com maior representatividade no acervo.
SELECT a.nome AS "Artista", COUNT(o.id) AS "Total de Obras"
FROM Artista a
JOIN Obra o ON a.id = o.artista_id
GROUP BY a.nome
ORDER BY "Total de Obras" DESC;

-- Relatório 2.2: Média de Notas de Feedback por Visitante (com múltiplos feedbacks)
-- Objetivo: Calcular a nota média dos feedbacks de visitantes que deram mais de um feedback.
-- Utilidade: Avaliar a satisfação de visitantes mais engajados e identificar tendências.
SELECT p.nome AS "Visitante", AVG(f.nota) AS "Nota Média de Feedback", COUNT(f.id) AS "Total de Feedbacks"
FROM Feedback f
JOIN Visitante v ON f.visitante_id = v.id
JOIN Pessoa p ON v.id = p.id
GROUP BY p.nome
HAVING COUNT(f.id) > 1
ORDER BY "Nota Média de Feedback" DESC;

-- Relatório 2.3: Total de Vendas por Funcionário (Vendedor)
-- Objetivo: Somar o valor total das obras vendidas por cada funcionário.
-- Utilidade: Avaliar o desempenho individual da equipe de vendas.
SELECT p.nome AS "Nome do Vendedor", SUM(cb.valor) AS "Total Vendido"
FROM CompraObras cb
JOIN Funcionario f ON cb.id_vendedor = f.id
JOIN Pessoa p ON f.id = p.id
GROUP BY p.nome
HAVING SUM(cb.valor) > 0
ORDER BY "Total Vendido" DESC;

---

-- 19. SUB-CONSULTAS SELECT

-- Relatório 3.1: Obras Vendidas Acima da Média Geral de Vendas
-- Objetivo: Listar obras que foram vendidas por um valor superior à média de todas as vendas.
-- Utilidade: Identificar obras de alto valor e tendências de mercado.
SELECT o.titulo AS "Título da Obra", cb.valor AS "Valor de Venda"
FROM Obra o
JOIN CompraObras cb ON o.id = cb.obra_id
WHERE cb.valor > (SELECT AVG(valor) FROM CompraObras);

-- Relatório 3.2: Visitantes que Participaram de Eventos de um Museu Específico
-- Objetivo: Mostrar os nomes dos visitantes que estiveram em eventos de um museu nomeado.
-- Utilidade: Análise de público por museu, campanhas de marketing direcionadas.
SELECT p.nome AS "Nome do Visitante", p.contato AS "Contato do Visitante"
FROM Pessoa p
JOIN Visitante v ON p.id = v.id
WHERE v.id IN (
        SELECT ep.visitante_id
        FROM EventoParticipante ep
        JOIN Evento e ON ep.evento_id = e.id
        JOIN Museu m ON e.museu_id = m.id
        WHERE m.nome = 'Museu de Arte Moderna' 
    );

-- Relatório 3.3: Funcionários que Venderam Obras de Artistas Específicos
-- Objetivo: Listar funcionários que atuaram como vendedores de obras de um artista particular.
-- Utilidade: Rastreamento de vendas, identificação de especialistas em certos tipos de arte.
SELECT p.nome AS "Nome do Vendedor", p.contato AS "Contato do Vendedor"
FROM Pessoa p
JOIN Funcionario f ON p.id = f.id
WHERE f.id IN (
        SELECT cb.id_vendedor
        FROM CompraObras cb
        JOIN Obra o ON cb.obra_id = o.id
        JOIN Artista a ON o.artista_id = a.id
        WHERE a.nome = 'Leonardo da Vinci'
    );

---

-- 20. SUB-CONSULTAS INSERT, UPDATE E DELETE

-- Operação 4.1: INSERT - Inserir um novo visitante (e sua pessoa correspondente).
-- Objetivo: Demonstrar a inserção de um novo visitante usando a lógica de herança.
-- Utilidade: Cadastro de novos usuários que se tornam visitantes.
-- NOTA: O ID da Pessoa é gerado automaticamente e reusado para o Visitante.
-- Este exemplo simula uma inserção completa de uma nova pessoa que é um visitante.
INSERT INTO Pessoa (nome, contato) VALUES ('Novo Cliente Potencial', 'cliente.potencial@email.com');
INSERT INTO Visitante (id, preferencia)
SELECT pessoa_seq.CURRVAL, 'Arte Contemporânea' FROM DUAL; -- Usa o ID da Pessoa recém-inserida

-- Operação 4.2: UPDATE - Atualizar o cargo de funcionários com alto volume de vendas.
-- Objetivo: Promover ou reclassificar funcionários que realizaram vendas significativas.
-- Utilidade: Gestão de equipe e reconhecimento de desempenho.
UPDATE Funcionario f
SET f.cargo = 'Especialista em Vendas de Arte'
WHERE f.id IN (
    SELECT cb.id_vendedor
    FROM CompraObras cb
    GROUP BY cb.id_vendedor
    HAVING SUM(cb.valor) > 75000 -- Exemplo: funcionários que venderam mais de 75 mil
);

-- Operação 4.3: DELETE - Remover feedbacks de visitantes inativos (que não interagiram além do feedback).
-- Objetivo: Limpar dados de feedbacks de visitantes que talvez não sejam mais ativos.
-- Utilidade: Manutenção do banco de dados, foco em dados de usuários engajados.
-- ATENÇÃO: Esta operação remove dados. Faça backup ou teste em ambiente de desenvolvimento.
DELETE FROM Feedback
WHERE visitante_id IN (
    SELECT v.id
    FROM Visitante v
    LEFT JOIN Ingresso i ON v.id = i.visitante_id
    LEFT JOIN CompraObras cb ON v.id = cb.comprador_id
    LEFT JOIN EventoParticipante ep ON v.id = ep.visitante_id
    WHERE i.id IS NULL AND cb.id IS NULL AND ep.evento_id IS NULL -- Visitantes que não têm ingressos, compras ou participações em eventos
);

---

-- 21. OPERADORES SET (UNION, INTERSECT E MINUS)

-- Relatório 5.1: Lista Consolidada de Nomes de Visitantes e Funcionários
-- Objetivo: Obter uma lista única de todas as pessoas (visitantes e funcionários) por nome.
-- Utilidade: Diretório geral de contatos, lista de stakeholders.
SELECT p.nome AS "Nome da Pessoa", 'Visitante' AS "Tipo"
FROM Pessoa p
JOIN Visitante v ON p.id = v.id
UNION
SELECT p.nome AS "Nome da Pessoa", 'Funcionário' AS "Tipo"
FROM Pessoa p
JOIN Funcionario f ON p.id = f.id
ORDER BY "Nome da Pessoa";

-- Relatório 5.2: Visitantes que deram Feedback E Compraram Obras
-- Objetivo: Identificar visitantes que são engajados (dão feedback) e também compradores.
-- Utilidade: Segmentação de público para marketing, programas de fidelidade.
SELECT visitante_id AS "ID do Visitante"
FROM Feedback
INTERSECT
SELECT comprador_id AS "ID do Visitante"
FROM CompraObras;

-- Relatório 5.3: Artistas com Obras no Museu MAS que Não São Antigos (nascidos após 1900)
-- Objetivo: Listar artistas que possuem obras no acervo, mas não se enquadram como artistas históricos muito antigos.
-- Utilidade: Foco em coleções mais recentes, pesquisa de artistas contemporâneos.
SELECT id, nome AS "Nome do Artista"
FROM Artista
WHERE id IN (SELECT artista_id FROM Obra) -- Artistas que têm obras
MINUS
SELECT id, nome
FROM Artista
WHERE dataNasc < TO_DATE('01-01-1900', 'DD-MM-YYYY'); -- Artistas nascidos antes de 1900
