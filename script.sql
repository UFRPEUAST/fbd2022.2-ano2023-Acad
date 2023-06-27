select * from pg_catalog.pg_tables where schemaname='public';


DROP TABLE IF EXISTS empresa CASCADE;
DROP TABLE IF EXISTS curso CASCADE;
DROP TABLE IF EXISTS disciplina CASCADE;
DROP TABLE IF EXISTS professor CASCADE;
DROP TABLE IF EXISTS aluno CASCADE;
DROP TABLE IF EXISTS turma CASCADE;
DROP TABLE IF EXISTS turma_aluno CASCADE;

CREATE TABLE IF NOT EXISTS empresa
(
	id serial primary key,
	nome varchar(255),
	cnpj varchar(18) unique
);

CREATE TABLE IF NOT EXISTS curso
(
	id serial primary key,
	nome varchar(255),
	carga_horaria int,
	empresa_id int not null references empresa (id)
);

CREATE TABLE IF NOT EXISTS professor
(
	id serial primary key,
	nome varchar(255),
	cpf varchar(14) unique not null,
	curso_id int not null references curso (id)
);

CREATE TABLE IF NOT EXISTS disciplina
(
	id serial primary key,
	nome varchar(255),
	carga_horaria int,
	periodo varchar(255),
	curso_id int not null references curso (id)
);

CREATE TABLE IF NOT EXISTS turma
(
	id serial primary key,
	turno varchar(255),
	disciplina_id int not null references disciplina (id),
	professor int not null references professor (id)
);

create table if not exists aluno
(
	id serial primary key,
	nome varchar(255),
	cpf varchar(14) unique not null
 );

create table if not exists turma_aluno
(
	id serial primary key,
	aluno_id int not null references aluno (id),
	turma_id int not null references turma (id)
);

INSERT INTO empresa (nome, cnpj) VALUES
 ('UFPE', '12.345.678/9012-34'),
 ('UFRGS', '98.765.432/1098-76'),
 ('UFMG', '90.123.456/7890-12');


INSERT INTO empresa (nome, cnpj) VALUES
 ('CAMPINA GRANDE', '1234');

INSERT INTO curso (nome, carga_horaria, empresa_id) VALUES
 ('Sistemas de Informação', 4000, 1),
 ('Administração', 4000, 1),
 ('Letras', 4000, 1),
 ('Economia', 4000, 2),
 ('Química', 4000, 2),
 ('Engenharia Civil', 4000, 2),
 ('Medicina', 4000, 3),
 ('Direito', 4000, 3),
 ('Enfermagem', 4000, 3);

select count(*) from curso;
select count(*) from empresa;
select count(*) from curso as c, empresa as e;

select curso.nome, empresa.nome from empresa, curso
where curso.empresa_id=empresa.id;

select * from curso LEFT JOIN empresa ON curso.empresa_id=empresa.id;



INSERT INTO professor (nome, cpf, curso_id) VALUES
 ('João Silva', '123.456.789-01', 1),
 ('Maria Souza', '987.654.321-02', 1),
 ('Pedro Santos', '456.789.123-03', 1),
 ('Ana Oliveira', '321.654.987-04', 1),
 ('Carlos Rodrigues', '654.321.789-05', 1),
 ('Mariana Costa', '987.123.456-06', 2),
 ('José Pereira', '789.456.321-07', 2),
 ('Amanda Almeida', '654.789.123-08', 2),
 ('Fernando Lima', '321.123.456-09', 2),
 ('Juliana Ferreira', '456.321.789-10', 2),
 ('Ricardo Torres', '789.654.321-11', 3),
 ('Lúcia Mendes', '123.789.456-12', 3),
 ('Gustavo Gomes', '456.123.789-13', 3),
 ('Camila Ribeiro', '789.456.123-14', 3),
 ('Lucas Carvalho', '321.789.456-15', 3),
 ('Fernanda Oliveira', '654.456.789-16', 4),
 ('Gabriel Silva', '987.789.456-17', 4),
 ('Patrícia Costa', '456.987.789-18', 4),
 ('Marcos Santos', '789.321.456-19', 4),
 ('Carolina Souza', '321.456.789-20', 4),
 ('Antônio Pereira', '654.789.321-21', 5),
 ('Vanessa Almeida', '987.321.654-22', 5),
 ('Rafaela Rodrigues', '456.654.789-23', 5),
 ('Bruno Lima', '412.634.635-23', 5),
 ('Letícia Ferreira', '789.987.321-24', 5),
 ('Rodrigo Torres', '123.654.987-25', 6),
 ('Isabela Mendes', '321.987.654-26', 6),
 ('Paulo Gomes', '654.123.987-27', 6),
 ('Laura Ribeiro', '987.654.123-28', 6),
 ('Milton Carvalho', '456.987.654-29', 6),
 ('Júlia Oliveira', '789.456.987-30', 7),
 ('Mário Silva', '123.789.654-31', 7),
 ('Luana Costa', '321.456.987-32', 7),
 ('André Santos', '654.789.456-33', 7),
 ('Tatiana Souza', '987.321.789-34', 7),
 ('Eduardo Pereira', '456.654.321-35', 8),
 ('Felipe Mendonça', '789.987.654-36', 8),
 ('Marina Lima', '123.321.654-37', 8),
 ('Paula Ferreira', '321.123.654-38', 8),
 ('Henrique Alves', '654.321.123-39', 8),
 ('Ana Beatriz', '987.654.321-40', 9),
 ('Pedro Rocha', '456.987.654-41', 9),
 ('Larissa Sousa', '789.456.987-42', 9),
 ('Lucas Santos', '123.789.456-43', 9),
 ('Vanessa Pereira', '321.456.789-44', 9);

INSERT INTO disciplina (nome, carga_horaria, periodo, curso_id) VALUES
	('Introdução a Programação', 60, '1º período', 1),
	('Algoritmo e Estrutura de Dados', 60, '2º período', 1),
	('Fundamentos de Banco de Dados', 60, '3º período', 1),
	('Projeto de Banco de Dados', 60, '4º período', 1),
	('Gestão de Pessoas', 50, '2º período', 2),
	('Marketing', 60, '2º período', 2),
	('Contabilidade', 50, '3º período', 2),
	('Gestão Estratégica', 50, '3º período', 2),
	('Literatura Brasileira', 60, '3º período', 3),
	('Gramática e Língua Portuguesa', 60, '2º período', 3),
	('Literatura Comparada', 50, '2º período', 3),
	('Inglês 1', 60, '1º período', 3),
	('Microeconomia', 50, '2º período', 4),
	('Macroeconomia', 50, '2º período', 4),
	('Econometria', 60, '3º período', 4),
	('Finanças Corporativas', 60, '1º período', 4),
	('Química Orgânica', 60, '1º período', 5),
	('Química Inorgânica', 60, '2º período', 5),
	('Físico-Química', 60, '3º período', 5),
	('Química Analítica', 50, '1º período', 5),
	('Resistência dos Materiais', 60, '1º período', 6),
	('Mecânica dos Solos', 50, '2º período', 6),
	('Estruturas de Concreto Armado', 60, '3º período', 6),
	('Hidráulica', 60, '1º período', 6),
	('Anatomia', 60, '2º período', 7),
	('Fisiologia', 60, '3º período', 7),
	('Patologia', 50, '1º período', 7),
	('Farmacologia', 50, '2º período', 7),
	('Direito Civil', 60, '1º período', 8),
	('Direito Constitucional', 50, '2º período', 8),
	('Direito Penal', 60, '7º período', 8),
	('Direito do Trabalho', 60, '4º período', 8),
	('Fundamentos da Enfermagem', 60, '1º período', 9),
	('Semiologia e Semiotécnica', 60, '7º período', 9),
	('Enfermagem em Saúde Coletiva', 50, '1º período', 9),
	('Enfermagem Clínica', 60, '3º período', 9);

select count(*) as total_curso,
       (select count(*) as total_empresa from empresa),
       (select count(*) as total_disciplina from disciplina)
       from curso;

select d.nome, curso.nome from disciplina d, curso, empresa
    where d.curso_id=curso.id and curso.empresa_id=empresa.id;

select disciplina.nome, empresa.nome from disciplina left join curso
    on disciplina.curso_id = curso.id left join empresa
        on curso.empresa_id = empresa.id;

INSERT INTO turma (turno, disciplina_id, professor) VALUES
 ('Matutino', 1, 1),
 ('Vespertino', 2, 2),
 ('Noturno', 3, 3),
 ('Noturno', 4, 4),
 ('Matutino', 5, 5),
 ('Matutino', 6, 6),
 ('Vespertino', 7, 7),
 ('Matutino', 8, 8),
 ('Noturno', 9, 9),
 ('Noturno', 10, 10),
 ('Matutino', 11, 11),
 ('Matutino', 12, 12),
 ('Noturno', 13, 13),
 ('Noturno', 14, 14),
 ('Matutino', 15, 15),
 ('Noturno', 16, 16),
 ('Noturno', 17, 17),
 ('Matutino', 18, 18),
 ('Noturno', 19, 19),
 ('Vespertino', 20, 20),
 ('Matutino', 21, 21),
 ('Noturno', 22, 22),
 ('Matutino', 23, 23),
 ('Noturno', 24, 24),
 ('Matutino', 25, 25),
 ('Noturno', 26, 26),
 ('Noturno', 27, 27),
 ('Noturno', 28, 28),
 ('Matutino', 29, 29),
 ('Matutino', 30, 30),
 ('Noturno', 31, 31),
 ('Noturno', 32, 32),
 ('Noturno', 33, 33),
 ('Vespertino', 34, 34),
 ('Matutino', 35, 35),
 ('Noturno', 36, 36);

INSERT INTO aluno (nome, cpf) VALUES
 ('Maria da Silva','123.456.789-10'),
 ('Ana Souza','973.624.321-23'),
 ('João Santos','246.789.123-45'),
 ('Pedro Oliveira','231.654.987-32'),
 ('Luana Pereira','357.321.563-90'),
 ('Lucas Mendes','22.321.314-98'),
 ('Fernanda Costa','231.533.414-45'),
 ('Gustavo Rodrigues','231.123.533-78'),
 ('Amanda Almeida', '231.789.222-53'),
 ('Gabriel Lima', '987.456.321-65'),
 ('Isabela Ferreira', '743.523.654-32'),
 ('Matheus Gomes', '643.321.987-23'),
 ('Sofia Rocha', '231.654.321-44'),
 ('Thiago Martins', '237.657.589-55'),
 ('Laura Castro', '231.654.523-82'),
 ('Rafaela Barbosa', '231.414.987-23'),
 ('Samuel Alves', '231.452.654-63'),
 ('Beatriz Ribeiro', '231.437.565-45'),
 ('Carlos Nascimento', '131.231.321-45'),
 ('Júlia Fernandes', '231.342.413-08'),
 ('Daniel Cardoso', '242.456.232-78'),
 ('Melissa Carvalho','231.134.353-32'),
 ('Diego Sousa', '654.231.987-31'),
 ('Juliana Teixeira', '345.654.321-22'),
 ('Victor Santos', '456.789.223-45'),
 ('Letícia Cunha', '321.267.987-32'),
 ('Bruno Costa', '231.876.231-65'),
 ('Mariana Alencar', '256.132.756-42'),
 ('André Miranda', '856.987.321-45'),
 ('Sophia Camargo', '789.654.909-78'),
 ('Vinicius Freitas', '654.745.231-42'),
 ('Natália Lima', '987.231.321-65'),
 ('Igor Oliveira', '321.455.231-32'),
 ('Larissa Rodrigues', '233.764.987-67'),
 ('José Pereira', '987.231.321-98'),
 ('Carolina Monteiro', '452.789.231-45'),
 ('Eduardo Castro', '321.869.987-32'),
 ('Gabriela Vieira', '975.321.987-65'),
 ('Matias Rodrigues', '987.425.823-98'),
 ('Alice Almeida', '456.987.321-22'),
 ('Felipe Cardoso', '789.223.321-78'),
 ('Manuela Fernandes', '131.789.654-32'),
 ('Raul Souza', '987.321.321-44'),
 ('Helena Carvalho', '321.231.654-32'),
 ('Henrique Mendes', '654.436.345-23'),
 ('Catarina Ferreira', '276.654.231-98'),
 ('Miguel Costa', '654.231.123-45'),
 ('Mariane Santos', '234.231.877-23'),
 ('Maria da Silva','647.456.311-10'),
 ('Ana Souza','633.624.856-98'),
 ('João Santos','864.555.563-23'),
 ('Pedro Oliveira','532.654.987-32'),
 ('Luana Pereira','421.321.234-43'),
 ('Lucas Mendes','987.232.111-13'),
 ('Fernanda Costa','888.987.645-22'),
 ('Gustavo Rodrigues','231.123.421-78'),
 ('Amanda Almeida', '654.432.776-45'),
 ('Gabriel Lima', '231.456.532-65'),
 ('Isabela Ferreira', '452.321.654-23'),
 ('Matheus Gomes', '446.452.845-45'),
 ('Sofia Rocha', '242.784.834-98'),
 ('Thiago Martins', '132.789.743-64'),
 ('Laura Castro', '231.232.987-63'),
 ('Rafaela Barbosa', '138.452.687-65'),
 ('Samuel Alves', '987.231.353-98'),
 ('Beatriz Ribeiro', '231.345.574-45'),
 ('Carlos Nascimento', '682.353.345-78'),
 ('Júlia Fernandes', '231.342.456-08'),
 ('Daniel Cardoso', '987.231.444-65'),
 ('Melissa Carvalho', '123.421.654-32'),
 ('Diego Sousa', '654.261.987-44'),
 ('Juliana Teixeira', '345.654.441-98'),
 ('Victor Santos', '456.222.543-45'),
 ('Letícia Cunha', '321.221.987-33'),
 ('Bruno Costa', '654.312.222-65'),
 ('Mariana Alencar', '987.445.231-98'),
 ('André Miranda', '856.231.321-44'),
 ('Sophia Camargo', '789.654.441-78'),
 ('Vinicius Freitas', '654.899.654-32'),
 ('Natália Lima', '987.454.321-44'),
 ('Igor Oliveira', '312.455.654-42'),
 ('Larissa Rodrigues', '458.353.435-65'),
 ('José Pereira', '987.654.123-42'),
 ('Carolina Monteiro', '452.876.223-45'),
 ('Eduardo Castro', '321.421.987-55'),
 ('Gabriela Vieira', '467.321.312-65'),
 ('Matias Rodrigues', '987.321.823-23'),
 ('Alice Almeida', '312.231.321-56'),
 ('Felipe Cardoso', '789.654.321-44'),
 ('Manuela Fernandes', '333.789.654-32'),
 ('Raul Souza', '987.234.321-65'),
 ('Helena Carvalho', '321.876.231-42'),
 ('Henrique Mendes', '654.231.987-64'),
 ('Catarina Ferreira', '276.654.444-98'),
 ('Miguel Costa', '654.789.352-45'),
 ('Mariane Santos', '234.645.877-44'),
 ('Maria da Silva','123.523.754-20'),
 ('Ana Souza','987.578.321-98'),
 ('João Santos','456.789.123-45'),
 ('Pedro Oliveira','321.654.987-32'),
 ('Luana Pereira','654.321.987-90'),
 ('Lucas Mendes','987.321.111-98'),
 ('Fernanda Costa','156.987.321-45'),
 ('Gustavo Rodrigues','789.123.321-78'),
 ('Amanda Almeida', '654.789.654-32'),
 ('Gabriel Lima', '442.231.321-65'),
 ('Isabela Ferreira', '321.523.654-32'),
 ('Matheus Gomes', '654.321.987-65'),
 ('Sofia Rocha', '333.654.321-98'),
 ('Thiago Martins', '231.789.222-45'),
 ('Laura Castro', '874.654.987-32'),
 ('Rafaela Barbosa', '654.123.987-65'),
 ('Samuel Alves', '232.321.654-98'),
 ('Beatriz Ribeiro', '456.437.321-45'),
 ('Carlos Nascimento', '789.753.321-78'),
 ('Júlia Fernandes', '654.342.654-08'),
 ('Daniel Cardoso', '987.456.123-65'),
 ('Melissa Carvalho', '231.987.654-32'),
 ('Diego Sousa', '654.321.987-33'),
 ('Juliana Teixeira', '345.654.321-98'),
 ('Victor Santos', '456.789.543-45'),
 ('Letícia Cunha', '321.267.223-32'),
 ('Bruno Costa', '654.876.987-65'),
 ('Mariana Alencar', '987.525.756-98'),
 ('André Miranda', '575.987.665-76'),
 ('Sophia Camargo', '789.231.909-78'),
 ('Vinicius Freitas', '654.745.654-32'),
 ('Natália Lima', '987.454.321-65'),
 ('Larissa Rodrigues', '233.752.987-65'),
 ('José Pereira', '987.654.321-98'),
 ('Carolina Monteiro', '452.789.123-45'),
 ('Eduardo Castro', '321.869.231-32'),
 ('Gabriela Vieira', '975.321.222-65'),
 ('Matias Rodrigues', '987.321.823-98'),
 ('Alice Almeida', '456.987.351-56'),
 ('Felipe Cardoso', '789.654.321-78'),
 ('Manuela Fernandes', '131.789.654-21'),
 ('Raul Souza', '087.234.234-65'),
 ('Helena Carvalho', '321.876.654-32'),
 ('Henrique Mendes', '654.534.987-65'),
 ('Catarina Ferreira', '276.654.321-98'),
 ('Miguel Costa', '654.789.123-45'),
 ('Mariane Santos', '234.645.877-23'),
 ('Laura Santos','789.654.321-12'),
 ('Rafael Souza','321.987.654-23'),
 ('Larissa Carvalho','654.123.789-34'),
 ('Gabriel Lima','987.321.456-45'),
 ('Mariana Ferreira','234.567.890-56'),
 ('Pedro Almeida','456.789.012-67'),
 ('Isabela Oliveira','890.123.456-78'),
 ('Thiago Costa','321.654.789-89'),
 ('Letícia Fernandes','654.987.012-90'),
 ('Lucas Santos','987.012.345-01'),
 ('Carolina Souza','123.456.789-02'),
 ('Bruno Pereira','456.789.012-03'),
 ('Helena Mendes','789.012.345-04'),
 ('Matheus Castro','012.232.678-05'),
 ('Júlia Rodrigues','345.231.901-16'),
 ('Diego Alves','678.901.22-27'),
 ('Natália Ribeiro','901.231.567-38'),
 ('André Nascimento','234.567.231-49'),
 ('Mariana Ferreira','567.890.531-50'),
 ('José Oliveira','890.231.456-23'),
 ('Melissa Lima','123.333.789-72'),
 ('Gustavo Santos','456.789.441-83'),
 ('Sophia Almeida','789.012.345-94'),
 ('Daniel Costa','012.345.345-21'),
 ('Luana Mendes','345.678.334-16'),
 ('Gabriela Carvalho','678.231.312-27'),
 ('Matias Lima','901.234.442-38'),
 ('Felipe Souza','234.567.666-49'),
 ('Laura Pereira','567.573.123-50'),
 ('Igor Fernandes','890.123.351-61'),
 ('Amanda Oliveira','123.456.123-72'),
 ('Lucas Almeida','456.231.012-83'),
 ('Isabela Costa','789.222.345-94'),
 ('Henrique Rodrigues','012.345.345-05'),
 ('Rafaela Nascimento','345.678.344-16'),
 ('Carlos Ferreira','222.901.234-27'),
 ('Manuela Alves','901.234.123-38'),
 ('João Lima','234.567.754-49'),
 ('Ana Souza','567.890.221-50'),
 ('Pedro Oliveira','890.123.456-43'),
 ('Larissa Mendes','123.456.789-44'),
 ('Gabriel Carvalho','456.789.012-23'),
 ('Mariana Santos','333.012.345-94'),
 ('Thiago Fernandes','012.444.678-05'),
 ('Laura Rodrigues','555.314.901-16'),
 ('Bruno Nascimento','678.901.425-27'),
 ('Helena Ferreira','901.234.552-38'),
 ('Matheus Lima','234.457.890-49'),
 ('Carolina Almeida','567.890.123-31'),
 ('André Costa','890.231.456-61'),
 ('Juliana Oliveira','123.456.552-72'),
 ('Diego Almeida','456.753.012-83'),
 ('Isabela Santos','789.012.552-94'),
 ('Lucas Carvalho','012.345.543-05'),
 ('Mariana Mendes','345.678.444-16'),
 ('Pedro Rodrigues','678.901.234-66'),
 ('Larissa Nascimento','901.123.567-38'),
 ('Gabriel Ferreira','234.567.555-49'),
 ('Mariana Lima','567.890.123-22'),
 ('Thiago Fernandes','890.232.456-61'),
 ('Laura Santos','757.456.789-72'),
 ('Rafael Souza','456.789.342-83'),
 ('Larissa Carvalho','789.012.231-94'),
 ('Gabriel Lima','012.345.354-05'),
 ('Mariana Ferreira','345.231.901-22'),
 ('Pedro Almeida','678.231.234-45'),
 ('Isabela Oliveira','901.333.567-38'),
 ('Thiago Costa','234.567.645-49'),
 ('Letícia Fernandes','567.421.123-50'),
 ('Lucas Santos','890.123.442-61'),
 ('Carolina Souza','123.565.789-72'),
 ('Bruno Pereira','456.789.012-83'),
 ('Helena Mendes','222.012.345-23'),
 ('Matheus Castro','012.343.678-05'),
 ('Júlia Rodrigues','345.678.331-16'),
 ('Diego Alves','678.901.526-27'),
 ('Natália Ribeiro','901.234.888-38'),
 ('André Nascimento','234.343.890-49'),
 ('Mariana Ferreira','567.890.331-50'),
 ('José Oliveira','890.111.232-61'),
 ('Melissa Lima','123.357.789-72'),
 ('Gustavo Santos','456.789.442-83'),
 ('Sophia Almeida','245.313.345-94'),
 ('Daniel Costa','012.345.443-22'),
 ('Luana Mendes','345.678.553-16'),
 ('Gabriela Carvalho','678.111.234-27'),
 ('Matias Lima','901.234.567-33'),
 ('Felipe Souza','234.567.777-49'),
 ('Laura Pereira','567.222.123-50'),
 ('Igor Fernandes','890.105.456-61'),
 ('Amanda Oliveira','453.456.789-72'),
 ('Lucas Almeida','456.789.012-22'),
 ('Isabela Costa','789.345-94'),
 ('Henrique Rodrigues','012.345-05'),
 ('Rafaela Nascimento','345.901-16'),
 ('Carlos Ferreira','678.277.234-27'),
 ('Manuela Alves','901.567-38'),
 ('João Lima','234.890-49'),
 ('Ana Souza','567.123-50'),
 ('Pedro Oliveira','890.123.863-61'),
 ('Larissa Mendes','123.456.643-72'),
 ('Gabriel Carvalho','456.313.012-83'),
 ('Mariana Santos','789.012.532-94'),
 ('Thiago Fernandes','012.345.678-05'),
 ('Laura Rodrigues','345.678.888-16'),
 ('Bruno Nascimento','678.901.454-27'),
 ('Pedro Rodrigues','678.901.233-27'),
 ('Larissa Nascimento','901.234.567-38'),
 ('Gabriel Ferreira','234.567.890-49');

select * from turma;

-- TURNO - NOME DA DISCIPLINA - NOME DO PROFESSOR




select count(turma_aluno.id) from turma_aluno
           where turma_aluno.turma_id=1;

select t.turno, d.nome, p.nome, c.nome from turma as t
    left join disciplina d on t.disciplina_id=d.id
    left join professor p on t.professor=p.id
    left join curso c on d.curso_id=c.id;

INSERT INTO turma_aluno (aluno_id, turma_id) VALUES
  (8, 2);

INSERT INTO turma_aluno (aluno_id, turma_id) VALUES
 (1, 1),
 (2, 1),
 (3, 1),
 (4, 1),
 (5, 1),
 (6, 1),
 (7, 1),
 (8, 2),
 (9, 2),
 (10, 2),
 (11, 2),
 (12, 2),
 (13, 2),
 (14, 2),
 (15, 3),
 (16, 3),
 (17, 3),
 (18, 3),
 (19, 3),
 (20, 3),
 (21, 3),
 (22, 4),
 (23, 4),
 (24, 4),
 (25, 4),
 (26, 4),
 (27, 4),
 (28, 4),
 (29, 5),
 (30, 5),
 (31, 5),
 (32, 5),
 (33, 5),
 (34, 5),
 (35, 5),
 (36, 6),
 (37, 6),
 (38, 6),
 (39, 6),
 (40, 6),
 (41, 6),
 (42, 6),
 (43, 7),
 (44, 7),
 (45, 7),
 (46, 7),
 (47, 7),
 (48, 7),
 (49, 7),
 (50, 8),
 (51, 8),
 (52, 8),
 (53, 8),
 (54, 8),
 (55, 8),
 (56, 8),
 (57, 9),
 (58, 9),
 (59, 9),
 (60, 9),
 (61, 9),
 (62, 9),
 (63, 9),
 (64, 10),
 (65, 10),
 (66, 10),
 (67, 10),
 (68, 10),
 (69, 10),
 (70, 10),
 (71, 11),
 (72, 11),
 (73, 11),
 (74, 11),
 (75, 11),
 (76, 11),
 (77, 11),
 (78, 12),
 (79, 12),
 (80, 12),
 (81, 12),
 (82, 12),
 (83, 12),
 (84, 12),
 (85, 13),
 (86, 13),
 (87, 13),
 (88, 13),
 (89, 13),
 (90, 13),
 (91, 13),
 (92, 14),
 (93, 14),
 (94, 14),
 (95, 14),
 (96, 14),
 (97, 14),
 (98, 14),
 (99, 15),
 (100, 15),
 (101, 15),
 (102, 15),
 (103, 15),
 (104, 15),
 (105, 15),
 (106, 16),
 (107, 16),
 (108, 16),
 (109, 16),
 (110, 16),
 (111, 16),
 (112, 16),
 (113, 17),
 (114, 17),
 (115, 17),
 (116, 17),
 (117, 17),
 (118, 17),
 (119, 17),
 (120, 18),
 (121, 18),
 (122, 18),
 (123, 18),
 (124, 18),
 (125, 18),
 (126, 18),
 (127, 19),
 (128, 19),
 (129, 19),
 (130, 19),
 (131, 19),
 (132, 19),
 (133, 19),
 (134, 20),
 (135, 20),
 (136, 20),
 (137, 20),
 (138, 20),
 (139, 20),
 (140, 20),
 (141, 21),
 (142, 21),
 (143, 21),
 (144, 21),
 (145, 21),
 (146, 21),
 (147, 21),
 (148, 22),
 (149, 22),
 (150, 22),
 (151, 22),
 (152, 22),
 (153, 22),
 (154, 22),
 (155, 23),
 (156, 23),
 (157, 23),
 (158, 23),
 (159, 23),
 (160, 23),
 (161, 23),
 (162, 24),
 (163, 24),
 (164, 24),
 (165, 24),
 (166, 24),
 (167, 24),
 (168, 24),
 (169, 25),
 (170, 25),
 (171, 25),
 (172, 25),
 (173, 25),
 (174, 25),
 (175, 25),
 (176, 26),
 (177, 26),
 (178, 26),
 (179, 26),
 (180, 26),
 (181, 26),
 (182, 26),
 (183, 27),
 (184, 27),
 (185, 27),
 (186, 27),
 (187, 27),
 (188, 27),
 (189, 27),
 (190, 28),
 (191, 28),
 (192, 28),
 (193, 28),
 (194, 28),
 (195, 28),
 (196, 28),
 (197, 29),
 (198, 29),
 (199, 29),
 (200, 29),
 (201, 29),
 (202, 29),
 (203, 29),
 (204, 30),
 (205, 30),
 (206, 30),
 (207, 30),
 (208, 30),
 (209, 30),
 (210, 30),
 (211, 31),
 (212, 31),
 (213, 31),
 (214, 31),
 (215, 31),
 (216, 31),
 (217, 31),
 (218, 32),
 (219, 32),
 (220, 32),
 (221, 32),
 (222, 32),
 (223, 32),
 (224, 32),
 (225, 33),
 (226, 33),
 (227, 33),
 (228, 33),
 (229, 33),
 (230, 33),
 (231, 33),
 (232, 34),
 (233, 34),
 (234, 34),
 (235, 34),
 (236, 34),
 (237, 34),
 (238, 34),
 (239, 35),
 (240, 35),
 (241, 35),
 (242, 35),
 (243, 35),
 (244, 35),
 (245, 35),
 (246, 36),
 (247, 36),
 (248, 36),
 (249, 36),
 (250, 36),
 (251, 36),
 (252, 36);

select count(*) from turma_aluno


select t.turno, d.nome as disciplina,
       p.nome as professor, c.nome as curso,
       (select count(*) from turma_aluno
           where t.id=turma_aluno.turma_id)
from turma t, disciplina d, professor p, curso c
    where t.disciplina_id=d.id
      and t.professor = p.id and d.curso_id=c.id;

-- select a.nome, count() as quant_disc
-- from aluno a, disciplina d, turma_aluno ta, turma t
-- where a.id=ta.aluno_id and () d.id=ta.turma_id;

select string_agg(nome, ', ') from disciplina;

select aluno.nome, (select count(*) as quant_disciplinas from turma_aluno
where turma_aluno.aluno_id=aluno.id),
       (select string_agg(nome, ' - ') as disciplinas
       from disciplina, turma_aluno, turma
       where turma_aluno.turma_id=turma.id
         and turma.disciplina_id=disciplina.id
         and turma_aluno.aluno_id=aluno.id)
from aluno
order by quant_disciplinas DESC;

