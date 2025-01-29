-- Inserir dados na tabela Departamento
INSERT INTO tbl_departamento (nome, sigla)
VALUES 
('Departamento de Engenharia', 'ENG'),
('Departamento de Ciências', 'CIE'),
('Departamento de Humanas', 'HUM');

-- Inserir dados na tabela Curso
INSERT INTO tbl_curso (nome, codigo, duracao_em_semestre, departamento_id)
VALUES
('Engenharia de Software', 'ENG001', 8, 1),
('Física', 'CIE002', 8, 2),
('História', 'HUM003', 8, 3);

-- Inserir dados na tabela Professor
INSERT INTO tbl_professor (Nome_completo, cpf, rg, email, telefone, area_especializacao, data_contratacao, status, salario, carga_horaria, departamento_id)
VALUES
('Alexandre Amorim de Jesus', '123.456.789-01', '28.547.545-X', 'alexandre@gmail.com', '11975998298','Desenvolvimento de Software', '2020-02-01', 'ativo', 6595.70, '42', 1),
('Juliana Alves', '987.654.321-09', '10.967.565-X', 'juliana@gmail.com', '11944997533','Física Quântica', '2018-08-15', 'ativo', 10595.65, '42', 2),
('Maria Olivera', '456.789.123-00', '45.618.735-X', 'maria@hotmail.com.com', '11961818256', 'História do Brasil', '2019-01-20', 'ativo', 5595.43, '42', 3);

-- Inserir dados na tabela Disciplina
INSERT INTO tbl_disciplina (nome, carga_horaria, curso_id)
VALUES
('Programação', '72', 1),
('Física Moderna', '72', 2),
('História Antiga', '75', 3);

-- Inserir dados na tabela Turma
INSERT INTO tbl_turma (turma, semestre, ano, departamento_id, professor_id, disciplina_id)
VALUES
('TURMA001', '1', '2024', 1, 1, 1),
('TURMA002', '1', '2024', 2, 2, 2),
('TURMA003', '1', '2024', 3, 3, 3);

-- Inserir dados na tabela Aluno
INSERT INTO tbl_alunos (nome_completo, data_nascimento, rg, cpf, genero, email, telefone, ra, endereco, status, nacionalidade, mensalidade, curso_id)
VALUES
('Carlos Andrade', '2000-05-20', '11.235.732-X', '456.284.527-73', 'Masculino', 'carlos@yahoo.com', '1165998174', '152015', 'Rua A, 123', 'ativo', 'brasileiro', 545.99, 1),
('Ana Souza Gomes', '2001-05-20', '55.122.696-X', '618.384.154-91', 'Feminino', 'ana@gmail.com', '1165698874', '138071', 'Rua A, 456', 'ativo', 'brasileira', 845.99, 2),
('Fernanda Lima', '2001-03-15', '99.900.515-X', '788.233.632-12', 'Feminino', 'fernanda@hotmail.com', '1133758885', '127093', 'Rua C, 789', 'ativo', 'brasileira', 615.99, 3);

-- Inserir dados na tabela Matricula
INSERT INTO tbl_matricula (data, alunos_id, turma_id)
VALUES
('2024-02-01', 1, 1),
('2024-02-02', 2, 2),
('2024-02-03', 3, 3);

-- Inserir Alunos e sua Disciplina na tabela Notas, esta tabela terá 4 campos vazios nota_unidade1, nota_unidade2, nota_unidade3, nota_unidade4 e nota_final.
INSERT INTO tbl_notas (disciplina_id, alunos_id)
VALUES (1, 1), (2, 2), (3, 3);

-- Atualizando as notas pelo RA do aluno de acordo com oque vão saindo.
UPDATE tbl_notas n
JOIN tbl_alunos a ON n.alunos_id = a.id
JOIN tbl_disciplina d ON n.disciplina_id = d.id
SET n.nota_unidade1 = 8.5
WHERE a.ra = '152015';

-- Atualizando a nota final pelo RA do aluno somando as 4 unidade dividindo por 4.
UPDATE tbl_notas n
JOIN tbl_alunos a ON n.alunos_id = a.id
JOIN tbl_disciplina d ON n.disciplina_id = d.id
SET n.nota_final = (COALESCE(nota_unidade1, 0) + COALESCE(nota_unidade2, 0) + COALESCE(nota_unidade3, 0) + COALESCE(nota_unidade4, 0)) / 4
WHERE a.ra = '152015';