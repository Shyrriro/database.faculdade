-- Listar todos os Alunos matriculados em uma determinada turma:

SELECT tbl_alunos.nome_completo
FROM tbl_alunos
JOIN tbl_matricula ON tbl_alunos.id = tbl_matricula.alunos_id
JOIN tbl_turma ON tbl_matricula.turma_id = tbl_turma.id
WHERE tbl_turma.turma = 'TURMA001';

-- Consulta a nota de um aluno procurando pelo nome do aluno:

SELECT tbl_alunos.nome_completo, tbl_notas.nota_unidade1, tbl_notas.nota_unidade2, tbl_notas.nota_unidade3, tbl_notas.nota_unidade4, tbl_notas.nota_final, tbl_disciplina.nome
FROM tbl_notas
JOIN tbl_alunos ON tbl_alunos.id = tbl_notas.alunos_id
JOIN tbl_disciplina ON tbl_disciplina.id = tbl_notas.disciplina_id
WHERE tbl_alunos.nome_completo = 'Ana Souza Gomes';

-- Consulta a média final de todos alunos em todas as suas disciplinas:

SELECT tbl_alunos.nome_completo, tbl_notas.nota_final, tbl_disciplina.nome
FROM tbl_alunos
JOIN tbl_notas ON tbl_alunos.id = tbl_notas.alunos_id AND tbl_notas.nota_final
JOIN tbl_disciplina ON tbl_disciplina.id = tbl_notas.disciplina_id
GROUP BY tbl_alunos.nome_completo;

-- Consulta somente a média final de um aluno pesquisando pelo nome do aluno:

SELECT tbl_alunos.nome_completo, tbl_notas.nota_final, tbl_disciplina.nome
FROM tbl_notas
JOIN tbl_alunos ON tbl_alunos.id = tbl_notas.alunos_id
JOIN tbl_disciplina ON tbl_disciplina.id = tbl_notas.disciplina_id
WHERE tbl_alunos.nome_completo = 'Fernanda Lima';

-- Consulta a nota de um aluno procurando pela disciplina:

SELECT tbl_alunos.nome_completo, tbl_notas.nota_unidade1, tbl_notas.nota_unidade2, tbl_notas.nota_unidade3, tbl_notas.nota_unidade4, tbl_notas.nota_final, tbl_disciplina.nome
FROM tbl_notas
JOIN tbl_alunos ON tbl_alunos.id = tbl_notas.alunos_id
JOIN tbl_disciplina ON tbl_disciplina.id = tbl_notas.disciplina_id
WHERE tbl_disciplina.nome = 'Física Moderna'