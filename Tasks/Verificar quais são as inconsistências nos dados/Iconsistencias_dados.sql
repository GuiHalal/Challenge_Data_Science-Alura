
--  VERIFICAR QUAIS SÃO AS INCONSISTÊNCIAS NOS DADOS 
-- ********************************************************

-- ###Identificar valores faltantes nas tabelas:

SELECT * FROM dados_mutuarios WHERE
	person_id = '' 	OR
	ISNULL(person_id) = TRUE OR
    person_age = '' OR 
    ISNULL(person_age) = TRUE OR
    person_income = '' OR 
    ISNULL(person_income) = TRUE OR
    person_home_ownership = '' OR 
    ISNULL(person_home_ownership) = TRUE OR
    ISNULL(person_emp_length) = TRUE
    ;
    
SELECT COUNT(*) FROM(
	SELECT * FROM dados_mutuarios WHERE
		person_id = '' 	OR
		ISNULL(person_id) = TRUE OR
		person_age = '' OR 
		ISNULL(person_age) = TRUE OR
		person_income = '' OR 
		ISNULL(person_income) = TRUE OR
		person_home_ownership = '' OR 
		ISNULL(person_home_ownership) = TRUE OR
		ISNULL(person_emp_length) = TRUE
) A;

-- ### Identificados 2046 registros  incompletos em dados_mutuarios

SELECT * FROM emprestimos WHERE
	loan_id = '' 	OR
	ISNULL(loan_id) = TRUE OR
    loan_intent = '' OR 
    ISNULL(loan_intent) = TRUE OR
    loan_grade = '' OR 
    ISNULL(loan_grade) = TRUE OR
    loan_amnt = '' OR 
    ISNULL(loan_int_rate) = TRUE OR
    ISNULL(loan_status) = TRUE OR
    ISNULL(loan_percent_income) = TRUE;
    
SELECT COUNT(*) FROM( 
	SELECT * FROM emprestimos WHERE
		loan_id = '' 	OR
		ISNULL(loan_id) = TRUE OR
		loan_intent = '' OR 
		ISNULL(loan_intent) = TRUE OR
		loan_grade = '' OR 
		ISNULL(loan_grade) = TRUE OR
		loan_amnt = '' OR 
        ISNULL(loan_amnt) = TRUE OR
		ISNULL(loan_int_rate) = TRUE OR
		ISNULL(loan_status) = TRUE OR
		ISNULL(loan_percent_income) = TRUE
    ) A;
-- ### Identificados 4654 registros incompletos em emprestimos

SELECT COUNT(*) FROM( 
SELECT * FROM historicos_banco WHERE 
	cb_id = '' 	OR
	ISNULL(cb_id) = TRUE OR
    cb_person_default_on_file = '' OR 
    ISNULL(cb_person_default_on_file) = TRUE OR
    ISNULL(cb_person_cred_hist_length) = TRUE
    )A;

-- ### Identificados 368 registros incompletos em historicos_banco

SELECT * FROM ids WHERE 
	person_id = '' OR 
    loan_id = '' OR
    cb_id = '';
    
-- ### Identificados 4 registros incompletos em ids

-- ### Verificando se existem dados fora das margens de intervalo normal:
	-- ### dados_mutuarios
SELECT * FROM dados_mutuarios WHERE 
	person_emp_length > person_age; 
-- pessoas com tempo de trabalho maior que a própria idade
    
SELECT * FROM dados_mutuarios WHERE 
	person_age > 120; 
-- pessoas mais velhas que a pessoa mais velha viva no mundo
    
SELECT DISTINCT person_home_ownership FROM dados_mutuarios
	where person_home_ownership not in ('Rent', 'Own', 'Mortgage', '', 'Other'); 
-- Dados com campos fora do padão * não localizado nenhum *

	-- ### emprestimos

SELECT distinct loan_intent FROM emprestimos
	WHERE loan_intent not in ('Homeimprovement', 'Venture', 
    'Personal', 'Medical', 'Education','Debtconsolidation', '');
-- Dados com campos fora do padão * não localizado nenhum *


SELECT distinct loan_grade FROM emprestimos 
	WHERE loan_grade NOT IN ('A', 'B', 'C', 'D', 'E', 'G', 'F', '');
-- Dados com campos fora do padão * não localizado nenhum *

select * FROM emprestimos
	WHERE sign(loan_int_rate) < 0;
-- Verificando se existe taxa de juro negativa * não localizado nenhum *

select distinct loan_status FROM emprestimos
	WHERE loan_status not in ('0', '1', NULL);
-- Dados com campos fora do padão * não localizado nenhum *

	-- ### historicos_banco
SELECT DISTINCT cb_person_default_on_file FROM historicos_banco;

SELECT MAX(cb_person_cred_hist_length) AS MAXIMO, MIN(cb_person_cred_hist_length) AS MINIMO 
FROM historicos_banco;