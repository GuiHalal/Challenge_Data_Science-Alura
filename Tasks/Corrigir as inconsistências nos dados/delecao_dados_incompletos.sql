-- Corrigir as inconsistências nos dados 
-- **********************************************

DELETE FROM historicos_banco WHERE
 cb_id IN(
 SELECT del FROM
 (SELECT cb_id AS DEL from historicos_banco AS del
	WHERE del.cb_id in(SELECT cb_id FROM ids WHERE
		person_id = '' OR loan_id = '' OR cb_id = '')) as D
);

DELETE FROM emprestimos WHERE
loan_id IN(
	SELECT del FROM
    (SELECT loan_id AS DEL from emprestimos AS del WHERE
		del.loan_id in(SELECT loan_id FROM ids WHERE
		person_id = '' OR loan_id = '' OR cb_id = '')) as D
);

DELETE FROM dados_mutuarios WHERE 
person_id IN(
	SELECT del FROM(
		SELECT person_id AS del FROM
		dados_mutuarios WHERE
			person_id = '' 	OR
			ISNULL(person_id) = TRUE OR
			person_age = '' OR 
			ISNULL(person_age) = TRUE OR
			person_income = '' OR 
			ISNULL(person_income) = TRUE OR
			person_home_ownership = '' OR 
			ISNULL(person_home_ownership) = TRUE OR
			ISNULL(person_emp_length) = TRUE)AS D);

DELETE FROM emprestimos WHERE 
loan_id IN(
	SELECT del FROM(
		SELECT loan_id AS del FROM emprestimos WHERE
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
		ISNULL(loan_percent_income) = TRUE)
        AS D);
        
DELETE FROM historicos_banco WHERE 
cb_id IN(
	SELECT del FROM(
		SELECT cb_id AS del FROM historicos_banco WHERE
		cb_id = '' 	OR
	ISNULL(cb_id) = TRUE OR
    cb_person_default_on_file = '' OR 
    ISNULL(cb_person_default_on_file) = TRUE OR
    ISNULL(cb_person_cred_hist_length) = TRUE)
    AS D);

DELETE FROM ids WHERE 
	person_id = '' OR 
    loan_id = '' OR
    cb_id = '';
    

DELETE FROM dados_mutuarios WHERE 
person_id IN(
	SELECT del FROM(
SELECT person_id AS del FROM dados_mutuarios WHERE 
	person_emp_length > person_age OR person_age > 120)
    AS D);