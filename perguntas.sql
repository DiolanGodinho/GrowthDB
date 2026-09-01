-- =====================================================================
-- Perguntas de análise — Segmentação de Base (Grupo RCB)
-- =====================================================================
-- Tabelas: clientes, email, telefones, canais, campanhas,
--          status_acionamento, acionamentos
--
-- Referência (valores fixos das tabelas de apoio):
--   canais            -> 1 Email | 2 WhatsApp | 3 RCS
--   campanhas         -> 1 Ativo | 2 Preventivo | 3 Boas Vindas | 4 Remarketing
--   status_acionamento -> 1 erro | 2 enviado | 3 entregue | 4 lido/aberto
--                          | 5 clicado | 6 bloqueio
--
-- Sintaxe: SQL Server / T-SQL.
-- =====================================================================


-- ---------------------------------------------------------------------
-- Questão 1
-- Qual percentual da base poderia ser acionado por cada canal?
-- ---------------------------------------------------------------------




-- ---------------------------------------------------------------------
-- Questão 2
-- Por canal, qual a penetração dos já acionados considerando o que é
-- acionável por canal?
-- ---------------------------------------------------------------------




-- ---------------------------------------------------------------------
-- Questão 3
-- Há uma suspeita de que os dados de acionamento do canal Email estão
-- duplicados em alguns dias, ou seja, que foram inseridos, erroneamente,
-- duas vezes na tabela.
-- Verifique se essa suspeita procede e, em caso afirmativo, apague os
-- dados duplicados.
-- ---------------------------------------------------------------------




-- ---------------------------------------------------------------------
-- Questão 4
-- Dos clientes acionados via WhatsApp na campanha de remarketing, qual a
-- distribuição da quantidade de clientes pela quantidade de acionamento
-- nessa campanha e nesse canal?
-- ---------------------------------------------------------------------




-- ---------------------------------------------------------------------
-- Questão 5
-- Precisamos gerar 3 bases, uma para cada canal.
--
-- Email
--   Público: clientes nunca acionados.
--   Campanha: Ativo
--   Volume: mesmo volume do último dia acionado na campanha "Ativo" via
--           email.
--   Layout: email (tudo em minúsculo), primeiro nome do cliente
--           (em maiúsculo).
--
-- RCS
--   Público: clientes que não receberam, não clicaram ou bloquearam o
--            Email da campanha Ativa. Considerar uma janela de 3 dias da
--            data do email. Priorizar clientes que foram acionados há
--            mais tempo.
--   Campanha: Ativo
--   Volume: 1000
--   Layout: DDI + DDD + Telefone, primeiro nome do cliente
--           (em maiúsculo).
--
-- WhatsApp
--   Público: clientes acionados por WhatsApp na campanha de Remarketing
--            entre 5 e 10 vezes. Priorizar clientes com menos
--            acionamento nessa mesma campanha e canal.
--   Campanha: Remarketing
--   Volume: 250
--   Layout: DDI + DDD + Telefone, primeiro nome do cliente
--           (em maiúsculo).
--
-- OBS: todas as bases precisam ser gravadas na tabela de acionamento.
-- ---------------------------------------------------------------------

-- Email




-- RCS




-- WhatsApp

