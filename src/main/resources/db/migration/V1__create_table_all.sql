-- Definindo o tipo ENUM para tipo_componente
CREATE TYPE tipo_componente_enum AS ENUM ('EAD', 'MIX', 'PRESENCIAL', 'ESTAGIO', 'TCC', 'AULA_EXPERIMENTAL');

-- Definindo o tipo ENUM para periodicidade
CREATE TYPE periodicidade_enum AS ENUM ('Semanal', 'Quinzenal', 'Mensal', 'naoseaplica');

CREATE TYPE dia_semana_enum AS ENUM ('Segunda-Feira', 'Terça-Feira', 'Quarta-Feira', 'Quinta-Feira' , 'Sexta-Feira', 'Sábado', 'Domingo');

-- Tabela de Horários (crie esta tabela primeiro)
CREATE TABLE horarios (
    id SERIAL PRIMARY KEY,
    dia_semana dia_semana_enum NOT NULL,
    hora_inicio TIME NOT NULL,
    hora_fim TIME NOT NULL
);

-- Tabela de Calendários Acadêmicos (crie esta tabela antes de componentes)
CREATE TABLE calendarios_academicos (
    id SERIAL PRIMARY KEY,
    ano INT NOT NULL,
    semestre INT NOT NULL,
    descricao VARCHAR(250)
);

-- Tabela de Professores
CREATE TABLE professores (
    id SERIAL PRIMARY KEY,
    nome_professor VARCHAR(250) NOT NULL,
    ativo_professor BOOLEAN NOT NULL DEFAULT TRUE
);

-- Tabela de Componentes
CREATE TABLE componentes (
    id SERIAL PRIMARY KEY,
    nome_componente VARCHAR(250) NOT NULL,
    carga_horaria INT,
    ativo_componente BOOLEAN NOT NULL DEFAULT TRUE,
    tipo_componente tipo_componente_enum, 
    previsao_estudantes INT,
    periodicidade periodicidade_enum, 
    id_horarios_fk INT REFERENCES horarios(id),
    id_calendarios_academicos_fk INT REFERENCES calendarios_academicos(id)
);

-- Tabela de Salas
CREATE TABLE salas (
    id SERIAL PRIMARY KEY,
    capacidade INT NOT NULL,
    descricao_sala TEXT
);

-- Tabela de Cursos
CREATE TABLE cursos (
    id SERIAL PRIMARY KEY,
    nome_curso VARCHAR(45) NOT NULL
);

-- Tabela Curso_Componente (Relacionamento entre Cursos e Componentes)
CREATE TABLE curso_componente (
    id SERIAL PRIMARY KEY,
    fase INT NOT NULL,
    id_componentes_fk INT REFERENCES componentes(id),
    id_cursos_fk INT REFERENCES cursos(id)
);

-- Tabela de Turmas
CREATE TABLE turmas (
    id SERIAL PRIMARY KEY,
    nome_turma VARCHAR(20) NOT NULL,
    id_professores_fk INT REFERENCES professores(id),
    id_salas_fk INT REFERENCES salas(id),
    id_componentes_fk INT REFERENCES componentes(id),
    dia_semana dia_semana_enum
);
