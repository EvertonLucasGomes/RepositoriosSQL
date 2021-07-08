-- Autores: Gabriel Vasconcelos e Everton Gomes

-- Cria��o de tabela tomada como base para resolu��o dos exerc�cios
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

-- C�digo para visualiza��o da tabela
SELECT * FROM professor;

-- Cria��o de SEQUENCE para gerar a matr�cula, conforme solicitado na primeira quest�o
CREATE SEQUENCE matricula_seq
    MINVALUE 1
    MAXVALUE 999999999999
    START WITH 1
    INCREMENT BY 1;
    
-- Inserindo 8 tuplas na tabela professor
-- estados sendo diversos e alguns repetidos
-- dois sobrenomes silva (Asdr�bal e Clodoaldo)
-- dois com admiss�o em 2020 (gabriel, everton e clodoaldo)
-- dois de belo jardim (clodoaldo, mariana)

INSERT INTO professor (matricula, nome, sexo, estado, cidade, whatsapp, data_admissao, idade, salario)
VALUES (matricula_seq.nextval, 'Gabriel Vasconcelos', 'M', 'PE', 'Olinda', '81-98320.6942', TO_DATE('13.09.2020','DD.MM.YYYY'), 25, 5000);

INSERT INTO professor (matricula, nome, sexo, estado, cidade, whatsapp, data_admissao, idade, salario)
VALUES (matricula_seq.nextval, 'Everton Lucas', 'M', 'BA', 'Salvador', '71-98841.6010', TO_DATE('10.11.2020','DD.MM.YYYY'), 21, 5000);

INSERT INTO professor (matricula, nome, sexo, estado, cidade, whatsapp, data_admissao, idade, salario)
VALUES (matricula_seq.nextval, 'Asdr�bal Silva', 'M', 'PE', 'Recife', '81-99317.4144', TO_DATE('03.01.2010','DD.MM.YYYY'), 40, 7000);

INSERT INTO professor (matricula, nome, sexo, estado, cidade, whatsapp, data_admissao, idade, salario)
VALUES (matricula_seq.nextval, 'Maria do Ros�rio', 'F', 'MG', 'Uberl�ndia', '34-99563.0101', TO_DATE('21.10.2014','DD.MM.YYYY'), 37, 8500);

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

-- Quest�o 01
/* Criar uma view que exiba em ordem alfab�tica os professores com sal�rio abaixo da m�dia, e cujo whatsapp n�o seja do DDD 81 */
CREATE OR REPLACE VIEW vProfessoresAbaixoMediaNao81 AS
SELECT nome, whatsapp, salario
FROM professor
WHERE salario < (SELECT AVG(salario) FROM professor) and whatsapp NOT LIKE '81%'
ORDER BY nome ASC;

/* C�digo sql para visualizar a view acima */
SELECT * FROM vProfessoresAbaixoMediaNao81;

/* C�digo sql para remover a view acima */
DROP VIEW vProfessoresAbaixoMediaNao81;

-- Quest�o 02
/* Criar uma view que exiba o maior sal�rio dos professores por estado */
CREATE OR REPLACE VIEW vMaiorSalarioPorEstado AS
SELECT MAX(salario) "Maior sal�rio", estado 
FROM professor
GROUP BY estado;

/* C�digo sql para visualizar a view acima */
SELECT * FROM vMaiorSalarioPorEstado;

/* C�digo sql para remover a view acima */
DROP VIEW vMaiorSalarioPorEstado;

-- Quest�o 03
/* Exibir os professores com idade entre a menor idade e 28, em ordem decrescente de idade */
SELECT nome, idade
FROM professor
WHERE idade BETWEEN (SELECT MIN(idade) FROM professor) and 28
ORDER BY idade DESC;

-- Quest�o 04
/* Atualizar o sal�rio do professor com a maior idade para que tenha tamb�m o maior sal�rio */
UPDATE professor
SET salario = (SELECT MAX(salario) FROM professor)
WHERE idade = (SELECT MAX(idade) FROM professor); --Joana karla com 55 anos, salario atualizado para 8500

-- Quest�o 05
/* Criar uma tabela na qual constem os professores cujo sal�rio seja menor que a m�dia */
CREATE TABLE menoresSalariosProf AS
SELECT * 
FROM professor
WHERE salario < (SELECT AVG(salario) FROM professor);

-- Para visualizar a tabela
SELECT * FROM menoresSalariosProf;

-- Para excluir a tabela
DROP TABLE menoresSalariosProf;

-- Quest�o 06
/* Mostrar os professores que t�m a mesma idade de qualquer um da cidade de Belo Jardim */
SELECT nome, idade, cidade
FROM professor
WHERE idade IN (SELECT idade FROM professor WHERE cidade = 'Belo Jardim') and cidade <>  'Belo Jardim';

-- Quest�o 07
/* Mostrar os professores em ordem alfab�tica, bem como os seus sal�rios arredondados com apenas uma casa decimal. 
Outrossim, na exibi��o desta consulta, dever-se-� converter o nome do professor, de forma que o primeiro caractere
de cada palavra esteja em mai�scula, e o restante em min�scula*/

SELECT initcap(nome) "Nome Captalizado", round(salario, 1) "Sal�rio arredondado"
FROM professor
ORDER BY nome ASC;

-- Quest�o 08
/* Mostrar os professores, e suas respectivas datas de admiss�o, mas apenas dos docentes cujo ano
de admiss�o � diferente de 2020*/
SELECT nome, data_admissao
FROM professor
WHERE data_admissao NOT LIKE '%20';

-- Quest�o 09
/* Criar uma function que retorne o valor em euro de forma arredondada em duas
casas deciamsi, dada a cota��o do euro e o valor em reais*/
CREATE OR REPLACE FUNCTION real_para_euro(reais in number, cotacao in number)
RETURN number
IS
BEGIN
    return round((reais/cotacao), 2);
END;

-- realizando o teste
SELECT real_para_euro(110, 6.10) FROM dual;

-- para excluir a fun��o
DROP FUNCTION real_para_euro;

-- Quest�o 10
/* Criar uma procedure para aumentar o sal�rio dos professores, dado um percentual de aumento */
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
EXEC atualizaCidadeEEstado(3, 'S�o Paulo', 'SP');

-- Visualizar tabela
SELECT * FROM professor;

-- para excluir a procedure
DROP PROCEDURE atualizaCidadeEEstado;




