-- #### EXTRA - Traduzir as colunas
-- ********************************************************

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
