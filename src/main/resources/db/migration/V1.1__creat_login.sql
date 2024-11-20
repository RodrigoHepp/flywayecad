-- Tabela para cadastro de usuários
CREATE TABLE usuarios (
    id SERIAL PRIMARY KEY,               
    nome VARCHAR(100) NOT NULL,            
    email VARCHAR(255) UNIQUE NOT NULL,    
    senha_hash TEXT NOT NULL,              
    data_criacao TIMESTAMP DEFAULT NOW(),  
    ativo BOOLEAN DEFAULT TRUE            
);

-- Tabela para rastrear logins
CREATE TABLE logins (
    id SERIAL PRIMARY KEY,               
    usuario_id INT REFERENCES usuarios(id), 
    ip VARCHAR(45),                        
    data_login TIMESTAMP DEFAULT NOW(), 
    sucesso BOOLEAN DEFAULT TRUE           
);

-- Tabela para log de alterações nos usuários
CREATE TABLE log_alteracoes_usuarios (
    id SERIAL PRIMARY KEY,                     
    usuario_id INT REFERENCES usuarios(id),
    usuario_responsavel_id INT,               
    campo_alterado VARCHAR(100) NOT NULL,                        
    data_alteracao TIMESTAMP DEFAULT NOW(),             
    descricao TEXT                 
);
