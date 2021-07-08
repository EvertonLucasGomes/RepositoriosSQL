-- Autores: Gabriel Vasconcelos e Everton Gomes

-- Criação de tabela tomada como base para resolução dos exercícios
CREATE TABLE professor
(
matricula number(5),
nome varchar(70) NOT NULL,
sexo char(1),
estado char(2),
cidade varchar2(40),
whatsapp varchar2(15),
data_admissao date default sysdate,
idade number(3),
salario number(7, 2),
    PRIMARY KEY(matricula)
);

-- Código para visualização da tabela
SELECT * FROM professor;

-- Criação de SEQUENCE para gerar a matrícula, conforme solicitado na primeira questão
CREATE SEQUENCE matricula_seq
    MINVALUE 1
    MAXVALUE 999999999999
    START WITH 1
    INCREMENT BY 1;
    
-- Inserindo 8 tuplas na tabela professor
-- estados sendo diversos e alguns repetidos
-- dois sobrenomes silva (Asdrúbal e Clodoaldo)
-- dois com admissão em 2020 (gabriel, everton e clodoaldo)
-- dois de belo jardim (clodoaldo, mariana)

INSERT INTO professor (matricula, nome, sexo, estado, cidade, whatsapp, data_admissao, idade, salario)
VALUES (matricula_seq.nextval, 'Gabriel Vasconcelos', 'M', 'PE', 'Olinda', '81-98320.6942', TO_DATE('13.09.2020','DD.MM.YYYY'), 25, 5000);

INSERT INTO professor (matricula, nome, sexo, estado, cidade, whatsapp, data_admissao, idade, salario)
VALUES (matricula_seq.nextval, 'Everton Lucas', 'M', 'BA', 'Salvador', '71-98841.6010', TO_DATE('10.11.2020','DD.MM.YYYY'), 21, 5000);

INSERT INTO professor (matricula, nome, sexo, estado, cidade, whatsapp, data_admissao, idade, salario)
VALUES (matricula_seq.nextval, 'Asdrúbal Silva', 'M', 'PE', 'Recife', '81-99317.4144', TO_DATE('03.01.2010','DD.MM.YYYY'), 40, 7000);

INSERT INTO professor (matricula, nome, sexo, estado, cidade, whatsapp, data_admissao, idade, salario)
VALUES (matricula_seq.nextval, 'Maria do Rosário', 'F', 'MG', 'Uberlândia', '34-99563.0101', TO_DATE('21.10.2014','DD.MM.YYYY'), 37, 8500);

INSERT INTO professor (matricula, nome, sexo, estado, cidade, whatsapp, data_admissao, idade, salario)
VALUES (matricula_seq.nextval, 'Rafaella Weiss', 'F', 'MG', 'Belo Horizonte', '31-98520.4236', TO_DATE('07.01.2019','DD.MM.YYYY'), 27, 6800);

INSERT INTO professor (matricula, nome, sexo, estado, cidade, whatsapp, data_admissao, idade, salario)
VALUES (matricula_seq.nextval, 'Clodoaldo Silva', 'M', 'PE', 'Belo Jardim', '81-98777.6595', TO_DATE('13.09.2020','DD.MM.YYYY'), 30, 4000);

INSERT INTO professor (matricula, nome, sexo, estado, cidade, whatsapp, data_admissao, idade, salario)
VALUES (matricula_seq.nextval, 'Mariana Costa', 'F', 'PE', 'Belo Jardim', '81-98626.6510', TO_DATE('05.12.2013','DD.MM.YYYY'), 37, 5000);

INSERT INTO professor (matricula, nome, sexo, estado, cidade, whatsapp, data_admissao, idade, salario)
VALUES (matricula_seq.nextval, 'Joana Karla', 'F', 'RJ', 'Rio de Janeiro', '21-94632.6555', TO_DATE('10.10.2018','DD.MM.YYYY'), 55, 3000);

INSERT INTO professor (matricula, nome, sexo, estado, cidade, whatsapp, data_admissao, idade, salario)
VALUES (matricula_seq.nextval, 'KARLA MONTEIRO', 'F', 'RJ', 'Rio de Janeiro', '21-94632.6555', TO_DATE('10.10.2018','DD.MM.YYYY'), 45, 3000.99);

INSERT INTO professor (matricula, nome, sexo, estado, cidade, whatsapp, data_admissao, idade, salario)
VALUES (matricula_seq.nextval, 'ASTROGILDO MONTEIRO', 'M', 'BA', 'Feira de Santana', '75-9210.6512', TO_DATE('04.08.2018','DD.MM.YYYY'), 36, 4500.38);

INSERT INTO professor (matricula, nome, sexo, estado, cidade, whatsapp, data_admissao, idade, salario)
VALUES (matricula_seq.nextval, 'Eduardo Brito', 'M', 'BA', 'Feira de Santana', '75-9111.1010', TO_DATE('11.04.2018','DD.MM.YYYY'), 30, 3700.38);

-- Questão 01
/* Criar uma view que exiba em ordem alfabética os professores com salário abaixo da média, e cujo whatsapp não seja do DDD 81 */
CREATE OR REPLACE VIEW vProfessoresAbaixoMediaNao81 AS
SELECT nome, whatsapp, salario
FROM professor
WHERE salario < (SELECT AVG(salario) FROM professor) and whatsapp NOT LIKE '81%'
ORDER BY nome ASC;

/* Código sql para visualizar a view acima */
SELECT * FROM vProfessoresAbaixoMediaNao81;

/* Código sql para remover a view acima */
DROP VIEW vProfessoresAbaixoMediaNao81;

-- Questão 02
/* Criar uma view que exiba o maior salário dos professores por estado */
CREATE OR REPLACE VIEW vMaiorSalarioPorEstado AS
SELECT MAX(salario) "Maior salário", estado 
FROM professor
GROUP BY estado;

/* Código sql para visualizar a view acima */
SELECT * FROM vMaiorSalarioPorEstado;

/* Código sql para remover a view acima */
DROP VIEW vMaiorSalarioPorEstado;

-- Questão 03
/* Exibir os professores com idade entre a menor idade e 28, em ordem decrescente de idade */
SELECT nome, idade
FROM professor
WHERE idade BETWEEN (SELECT MIN(idade) FROM professor) and 28
ORDER BY idade DESC;

-- Questão 04
/* Atualizar o salário do professor com a maior idade para que tenha também o maior salário */
UPDATE professor
SET salario = (SELECT MAX(salario) FROM professor)
WHERE idade = (SELECT MAX(idade) FROM professor); --Joana karla com 55 anos, salario atualizado para 8500

-- Questão 05
/* Criar uma tabela na qual constem os professores cujo salário seja menor que a média */
CREATE TABLE menoresSalariosProf AS
SELECT * 
FROM professor
WHERE salario < (SELECT AVG(salario) FROM professor);

-- Para visualizar a tabela
SELECT * FROM menoresSalariosProf;

-- Para excluir a tabela
DROP TABLE menoresSalariosProf;

-- Questão 06
/* Mostrar os professores que têm a mesma idade de qualquer um da cidade de Belo Jardim */
SELECT nome, idade, cidade
FROM professor
WHERE idade IN (SELECT idade FROM professor WHERE cidade = 'Belo Jardim') and cidade <>  'Belo Jardim';

-- Questão 07
/* Mostrar os professores em ordem alfabética, bem como os seus salários arredondados com apenas uma casa decimal. 
Outrossim, na exibição desta consulta, dever-se-á converter o nome do professor, de forma que o primeiro caractere
de cada palavra esteja em maiúscula, e o restante em minúscula*/

SELECT initcap(nome) "Nome Captalizado", round(salario, 1) "Salário arredondado"
FROM professor
ORDER BY nome ASC;

-- Questão 08
/* Mostrar os professores, e suas respectivas datas de admissão, mas apenas dos docentes cujo ano
de admissão é diferente de 2020*/
SELECT nome, data_admissao
FROM professor
WHERE data_admissao NOT LIKE '%20';

-- Questão 09
/* Criar uma function que retorne o valor em euro de forma arredondada em duas
casas deciamsi, dada a cotação do euro e o valor em reais*/
CREATE OR REPLACE FUNCTION real_para_euro(reais in number, cotacao in number)
RETURN number
IS
BEGIN
    return round((reais/cotacao), 2);
END;

-- realizando o teste
SELECT real_para_euro(110, 6.10) FROM dual;

-- para excluir a função
DROP FUNCTION real_para_euro;

-- Questão 10
/* Criar uma procedure para aumentar o salário dos professores, dado um percentual de aumento */
CREATE OR REPLACE procedure aumentoDeSalario(percentual number)
IS
BEGIN
    UPDATE professor SET salario = salario*(1+(percentual/100));
END;

-- Para executar a procedure
EXEC aumentoDeSalario(10);

-- para excluir a procedure
DROP PROCEDURE aumentoDeSalario;

-- Visualizar tabela
SELECT * FROM professor;

/* Criar uma procedure para atualizar cidade e estado dos professores */
CREATE OR REPLACE procedure atualizaCidadeEEstado(vMatricula NUMBER, vCidade VARCHAR2, vEstado CHAR)
IS
BEGIN
    UPDATE professor SET CIDADE = vCidade, ESTADO = vEstado WHERE MATRICULA = vMatricula;
END;

-- Para executar a procedure
EXEC atualizaCidadeEEstado(3, 'São Paulo', 'SP');

-- Visualizar tabela
SELECT * FROM professor;

-- para excluir a procedure
DROP PROCEDURE atualizaCidadeEEstado;




