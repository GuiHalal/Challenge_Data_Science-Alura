SELECT * FROM dados_mutuarios;
	/* Tabela contendo os dados pessoais de cada solicitante
    	person_id				varchar(16)
		person_age				int
		person_income			int
		person_home_ownership	varchar(8)
		person_emp_length		double
	*/
SELECT * FROM emprestimos;
	/* Tabela contendo as informações do empréstimo solicitado
		loan_id					varchar(16)
		loan_intent				varchar(32)
		loan_grade				varchar(1)
		loan_amnt				int
		loan_int_rate			double
		loan_status				int
		loan_percent_income		double
	*/
SELECT * FROM historicos_banco;
	/* Histório de emprétimos de cada cliente
		cb_id	varchar(16)
        cb_person_default_on_file	varchar(1)
        cb_person_cred_hist_length	int
    */

SELECT * FROM ids;
/* Tabela que relaciona os IDs de cada informação da pessoa solicitant
	person_id	varchar(16)
	loan_id	varchar(16)
	cb_id	varchar(16)
*/