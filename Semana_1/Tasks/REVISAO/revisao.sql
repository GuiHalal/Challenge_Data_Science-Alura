-- Corrigir as inconsistências nos dados 
-- **********************************************

DELETE FROM ids WHERE 
	person_id = '' OR 
    loan_id = '' OR
    cb_id = '';
    
-- Criar tabela unificada
-- **********************************************
create table dados_juntos as select 

dm.person_age AS IDADE,
dm.person_income AS SALARIO_ANUAL,
dm.person_home_ownership AS SITUCAO_MORADIA,
dm.person_emp_length AS ANOS_EMPREGO,
e.loan_intent AS MOTIVO_EMPRESTIMO,
e.loan_grade AS RANKING_EMPRESTIMO,
e.loan_amnt AS VALOR_SOLICITADO,
e.loan_int_rate AS TAXA_DE_JURO,
e.loan_status AS RISCO_INADIMP,
e.loan_percent_income AS EMP_VS_RENDA,
hb.cb_person_default_on_file AS HISTORICO_INADIMP,
hb.cb_person_cred_hist_length AS ANOS_DE_CREDITO 

from ids i

join dados_mutuarios dm on dm.person_id = i.person_id 

join emprestimos e on e.loan_id = i.loan_id 

join historicos_banco hb on hb.cb_id = i.cb_id;


-- traduzindo os dados da coluna SITUCAO_MORADIA
-- **********************************************

ALTER TABLE `analise_risco`.`dados_juntos` 
CHANGE COLUMN `SITUCAO_MORADIA` `SITUCAO_MORADIA` VARCHAR(16) CHARACTER SET 'utf8mb3' NULL DEFAULT NULL ;

UPDATE dados_juntos SET SITUCAO_MORADIA = 'Alugada'
WHERE SITUCAO_MORADIA = 'Rent'; 
UPDATE dados_juntos SET SITUCAO_MORADIA = 'Própria'
WHERE SITUCAO_MORADIA = 'Own';
UPDATE dados_juntos SET SITUCAO_MORADIA = 'Hipotecada'
WHERE SITUCAO_MORADIA = 'Mortgage';
UPDATE dados_juntos SET SITUCAO_MORADIA = 'Outros'
WHERE SITUCAO_MORADIA = 'Other';

select distinct SITUCAO_MORADIA from dados_juntos;



-- traduzindo os dados da coluna MOTIVO_EMPRESTIMO
-- **********************************************

UPDATE dados_juntos SET MOTIVO_EMPRESTIMO = 'Pessoal'
WHERE MOTIVO_EMPRESTIMO = 'Personal'; 
UPDATE dados_juntos SET MOTIVO_EMPRESTIMO = 'Educativo'
WHERE MOTIVO_EMPRESTIMO = 'Education';
UPDATE dados_juntos SET MOTIVO_EMPRESTIMO = 'Médico'
WHERE MOTIVO_EMPRESTIMO = 'Medical';
UPDATE dados_juntos SET MOTIVO_EMPRESTIMO = 'Empreendimento'
WHERE MOTIVO_EMPRESTIMO = 'Venture';
UPDATE dados_juntos SET MOTIVO_EMPRESTIMO = 'Melhora do lar'
WHERE MOTIVO_EMPRESTIMO = 'Homeimprovement';
UPDATE dados_juntos SET MOTIVO_EMPRESTIMO = 'Pagamento de débitos'
WHERE MOTIVO_EMPRESTIMO = 'Debtconsolidation';

select distinct MOTIVO_EMPRESTIMO from dados_juntos;


