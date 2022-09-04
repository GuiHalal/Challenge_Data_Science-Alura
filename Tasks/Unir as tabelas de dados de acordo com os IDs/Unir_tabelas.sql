-- #### Unir as tabelas de dados de acordo com os IDs
-- ********************************************************

select * from ids;
select * from historicos_banco;
select * from dados_mutuarios;
select * from emprestimos;

select * from ids A
inner join dados_mutuarios B 
on A.person_id = B.person_id 
inner join emprestimos C 
on A.loan_id = C.loan_id
inner join historicos_banco D 
on A.cb_id = D.cb_id;
 
drop table consolidada;
    
CREATE TABLE consolidada(
	ID VARCHAR (48) NOT NULL, -- CONCAT person_id+loan_id+cb_id
    IDADE INT NOT NULL, -- person_age
    SALARIO_ANUAL INT NOT NULL, -- person_income
    SITUCAO_MORADIA ENUM 
		('Alugada', 'Própria', 'Hipotecada', 'Outros') NOT NULL, -- person_home_ownership
    ANOS_EMPREGO INT NOT NULL, -- person_emp_length
    MOTIVO_EMPRESTIMO 
		ENUM ('Pessoal', 'Educativo', 'Médico', 'Empreendimento',
		'Melhora do lar', 'Pagamento de débitos') NOT NULL, -- loan_intent
	RANKING_EMPRESTIMO ENUM 
		('A', 'B', 'C', 'D', 'E', 'F', 'G') NOT NULL, -- loan_grade
    VALOR_SOLICITADO FLOAT NOT NULL, -- loan_amnt
    TAXA_DE_JURO FLOAT NOT NULL, -- loan_int_rate
    RISCO_INADIMP INT (1) NOT NULL, -- loan_status
    EMP_VS_RENDA FLOAT NOT NULL, -- loan_percent_income
    HISTORICO_INADIMP CHAR(1) NOT NULL, -- cb_person_default_on_file
    ANOS_DE_CREDITO INT NOT NULL, -- cb_person_cred_hist_length    
    PRIMARY KEY (ID)
    );
    
SELECT * FROM consolidada;


-- traduzindo os dados de dados_mutuarios.person_home_ownership 	
UPDATE dados_mutuarios SET person_home_ownership = 'Alugada'
WHERE person_home_ownership = 'Rent'; 
UPDATE dados_mutuarios SET person_home_ownership = 'Própria'
WHERE person_home_ownership = 'Own';
UPDATE dados_mutuarios SET person_home_ownership = 'Hipotecada'
WHERE person_home_ownership = 'Mortgage';
UPDATE dados_mutuarios SET person_home_ownership = 'Outros'
WHERE person_home_ownership = 'Other';
SELECT distinct person_home_ownership FROM dados_mutuarios;

-- traduzindo os dados de emprestimos.loan_intent	
UPDATE emprestimos SET loan_intent = 'Pessoal'
WHERE loan_intent = 'Personal'; 
UPDATE emprestimos SET loan_intent = 'Educativo'
WHERE loan_intent = 'Education';
UPDATE emprestimos SET loan_intent = 'Médico'
WHERE loan_intent = 'Medical';
UPDATE emprestimos SET loan_intent = 'Empreendimento'
WHERE loan_intent = 'Venture';
UPDATE emprestimos SET loan_intent = 'Melhora do lar'
WHERE loan_intent = 'Homeimprovement';
UPDATE emprestimos SET loan_intent = 'Pagamento de débitos'
WHERE loan_intent = 'Debtconsolidation';

SELECT DISTINCT loan_intent FROM emprestimos;


-- CRIAÇÃO DA TABELA UNIFICADA
INSERT INTO consolidada SELECT 
	concat(K.person_id, K.loan_id, K.cb_id) AS ID,
    K.person_age AS IDADE,
    K.person_income AS SALARIO_ANUAL,
    K.person_home_ownership AS SITUCAO_MORADIA,
    K.person_emp_length AS ANOS_EMPREGO,
    K.loan_intent AS MOTIVO_EMPRESTIMO,
    K.loan_grade AS RANKING_EMPRESTIMO,
    K.loan_amnt AS VALOR_SOLICITADO,
    K.loan_int_rate AS TAXA_DE_JURO,
    K.loan_status AS RISCO_INADIMP,
    K.loan_percent_income AS EMP_VS_RENDA,
    K.cb_person_default_on_file AS HISTORICO_INADIMP,
    K.cb_person_cred_hist_length AS ANOS_DE_CREDITO
from (
select 	A.person_id,
		A.loan_id, 
        A.cb_id, 
        B.person_age,
        B.person_income,
        B.person_home_ownership,
        B.person_emp_length,
        C.loan_intent,
        C.loan_grade,
        C.loan_amnt,
        C.loan_int_rate,
        C.loan_status,
        C.loan_percent_income,
        D.cb_person_default_on_file,
        D.cb_person_cred_hist_length 
from ids A
inner join dados_mutuarios B 
on A.person_id = B.person_id 
inner join emprestimos C 
on A.loan_id = C.loan_id
inner join historicos_banco D 
on A.cb_id = D.cb_id) K
where K.person_id IN 
(select A.person_id from ids A
inner join dados_mutuarios B 
on A.person_id = B.person_id 
inner join emprestimos C 
on A.loan_id = C.loan_id
inner join historicos_banco D 
on A.cb_id = D.cb_id); -- ID + IDADE + SALARIO_ANUAL + SITUCAO_MORADIA + ANOS_EMPREGO + RANKING_EMPRESTIMO +  VALOR_SOLICITADO

SELECT * FROM consolidada; 
