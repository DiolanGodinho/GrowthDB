-- =====================================================================
-- Modelo de dados - Teste de Segmentação de Base (Digital Proprietário)
-- Grupo RCB | Acionamento digital via Email, WhatsApp e RCS
-- =====================================================================
-- Convenções: nomes de tabela no plural, chaves primárias id_<tabela>,
-- chaves estrangeiras id_<tabela_referenciada>. Tipos em sintaxe
-- padrão SQL (ajustar para o dialeto do banco de destino).
--
-- Esta versão contém apenas a ESTRUTURA das tabelas (DDL), sem dados.
-- Todas as 7 tabelas abaixo já estão confirmadas.
-- =====================================================================


-- ---------------------------------------------------------------------
-- CLIENTES
-- Base de clientes. Cada linha é um cliente único.
-- ---------------------------------------------------------------------
CREATE TABLE clientes (
    id_cliente   INT PRIMARY KEY,               -- sequencial a partir de 1
    nome         VARCHAR(100) NOT NULL           -- ex: "Fernando H. Cardoso"
);


-- ---------------------------------------------------------------------
-- EMAIL
-- Um email por cliente, para ~60% da base.
-- ---------------------------------------------------------------------
CREATE TABLE email (
    id_email     INT PRIMARY KEY,                -- sequencial a partir de 1
    id_cliente   INT NOT NULL,                    -- FK -> clientes.id_cliente
    email        VARCHAR(150) NOT NULL,
    -- Regras de geração:
    --   * cobertura: ~60% dos clientes, no máximo 1 email por cliente
    --   * local-part: primeironome_ultimosobrenome, sem acentos, minúsculo
    --   * provedores fictícios: x_provider 55% | y_provider 30%
    --                           z_provider 10% | w_provider 5%
    --   * por provedor: 0,5%-1% dos emails sem ".com"
    --   * por provedor: 0,1%-0,5% dos emails sem "@"
    CONSTRAINT fk_email_cliente FOREIGN KEY (id_cliente)
        REFERENCES clientes (id_cliente)
);


-- ---------------------------------------------------------------------
-- TELEFONES
-- Um telefone por cliente, para ~90% da base.
-- ---------------------------------------------------------------------
CREATE TABLE telefones (
    id_telefone  INT PRIMARY KEY,                 -- sequencial a partir de 1
    id_cliente   INT NOT NULL,                     -- FK -> clientes.id_cliente
    -- DDD como VARCHAR (não INT): a regra pede ~0,1%-1% de DDDs "errados"
    -- (1 dígito ou em branco), o que um INT não representaria bem.
    ddd          VARCHAR(2),
    -- lista válida: 11,12,19,21,31,35,41,45,51,55,61,65,81,91
    telefone     VARCHAR(9) NOT NULL,
    -- 90% dos telefones com 9 dígitos, iniciando em 9
    -- 10% dos telefones com 8 dígitos, iniciando em 2, 3, 4 ou 5
    tem_wpp      TINYINT,                          -- 1 / 0 / NULL
    tem_rcs      TINYINT,                          -- 1 / 0 / NULL
    -- tem_wpp e tem_rcs: cada um vale 1 em ~65% dos telefones de 9 dígitos
    -- com DDD válido (2 dígitos), 0 nos outros 35% desse mesmo grupo,
    -- e NULL para telefones de 8 dígitos ou com DDD inválido.
    -- Sorteios de tem_wpp e tem_rcs são independentes entre si.
    CONSTRAINT fk_telefones_cliente FOREIGN KEY (id_cliente)
        REFERENCES clientes (id_cliente)
);


-- ---------------------------------------------------------------------
-- CANAIS
-- Tabela de apoio com os canais de acionamento disponíveis.
-- ---------------------------------------------------------------------
CREATE TABLE canais (
    id_canal     INT PRIMARY KEY,
    nome_canal   VARCHAR(20) NOT NULL              -- 'Email' | 'WhatsApp' | 'RCS'
);


-- ---------------------------------------------------------------------
-- CAMPANHAS
-- Lista fechada de campanhas. Apenas 4 linhas:
--   Ativo, Preventivo, Boas Vindas, Remarketing
-- ---------------------------------------------------------------------
CREATE TABLE campanhas (
    id_campanha    INT PRIMARY KEY,
    nome_campanha  VARCHAR(50) NOT NULL             -- 'Ativo' | 'Preventivo' | 'Boas Vindas' | 'Remarketing'
);


-- ---------------------------------------------------------------------
-- STATUS_ACIONAMENTO
-- Lista fechada de status de um acionamento. Apenas 6 linhas:
--   1 erro | 2 enviado | 3 entregue | 4 lido/aberto | 5 clicado | 6 bloqueio
-- ---------------------------------------------------------------------
CREATE TABLE status_acionamento (
    id_status      INT PRIMARY KEY,
    nome_status    VARCHAR(20) NOT NULL             -- 'erro' | 'enviado' | 'entregue' | 'lido/aberto' | 'clicado' | 'bloqueio'
);


-- ---------------------------------------------------------------------
-- ACIONAMENTOS
-- Fato: um registro por tentativa de acionamento (cliente x campanha x canal).
-- ---------------------------------------------------------------------
CREATE TABLE acionamentos (
    id_acionamento  BIGINT PRIMARY KEY,             -- sequencial a partir de 1
    id_cliente      INT NOT NULL,                   -- FK -> clientes.id_cliente
    id_canal        INT NOT NULL,                   -- FK -> canais.id_canal
    id_campanha     INT NOT NULL,                   -- FK -> campanhas.id_campanha
    data            DATE NOT NULL,                  -- somente dias úteis de agosto/2026
    id_status       INT NOT NULL,                   -- FK -> status_acionamento.id_status
    CONSTRAINT fk_acion_cliente   FOREIGN KEY (id_cliente)   REFERENCES clientes            (id_cliente),
    CONSTRAINT fk_acion_canal     FOREIGN KEY (id_canal)     REFERENCES canais              (id_canal),
    CONSTRAINT fk_acion_campanha  FOREIGN KEY (id_campanha)  REFERENCES campanhas            (id_campanha),
    CONSTRAINT fk_acion_status    FOREIGN KEY (id_status)    REFERENCES status_acionamento  (id_status)
);


-- =====================================================================
-- OBSERVAÇÕES
-- =====================================================================
-- 1) Nenhum dado foi gerado nesta etapa — apenas a estrutura das tabelas.
-- 2) "dias úteis de agosto/2026" = segunda a sexta-feira do mês (feriados
--    não excluídos, salvo indicação em contrário na etapa de geração).
