########### TESTES

# Fisher: 
# H0: P(A)=P(B) H1: P(A) != P(B)
# Verifica se as proporções são iguais ou se há diferença
# fisher.test(tabela)

# Qui-Quadrado:
# Detecta significância estatística da diferença entre dois grupos independentes.
# H0: não há diferença entre os grupos H1: há diferença
# Se alguma frequência esperada for menor que 5, utilizar Fisher
# chisq.test(tabela)

# Teste da Mediana:
# Testa se duas amostras provém de populações com mesma mediana
# H0: provém de populações com mesma mediana H1: caso contrário
# Quando a amostra é pequena (n<20), utiliza-se o teste de fisher
# DescTools:MedianTest(dados, grupos)

# Mann Whitney:
# Verifica se dois grupos provém ou não de mesma população 
# Baseia-se principalmente na mediana
# H0: igualdade H1: caso contrário (unilateral ou bilateral a depender)
# wilcoxon.test(dados_grupo1, dados_grupos2, alternative = "two.sided)

# Kolmogorov-Smirnov:
# Verifica concordância entre duas distribuições acumuladas, ou seja
# se duas amostras vem de uma mesma população (verifica a distribuição de forma geral)
# H0: não há diferença significativa H1: caso contrário
# ks.test(dados_grupo1, dados_grupo2)



############ QUESTÃO 1

### Teste exato de Fisher

tabela1 <- matrix(c(6, 4, 2, 8), nrow = 2, byrow = TRUE)
colnames(tabela1) <- c("Amigável", "Não_Amigável")
rownames(tabela1) <- c("Alta", "Média")

tabela1

fisher.test(tabela1)
# baixo valor-p: rejeita hipótese nula de odds ratio igual a 1

########### QUESTÃO 2

######## Teste qui-quadrado
tabela2 <- matrix(c(34, 16, 12, 4, 2,
                    12, 6, 6, 4, 0), 
                  nrow = 2, byrow = TRUE)
colnames(tabela2) <- c("D1", "D2", "D3", "D4", "D5")
rownames(tabela2) <- c("Hospital1", "Hospital2")

tabela2

# teste qui-quadrado
teste_qui2 <- chisq.test(tabela2)
# baixo valor-p: rejeita a hipótese nula de

# tabela com as frequências esperadas
teste_qui2$expected # se alguma frequência esperada for menor que 5, usamos fisher

fisher.test(tabela2)


####### QUESTÃO 3

# Teste da Mediana
library(agricolae)

# Dados
x <- c(4, 3, 8, 3, 5, 7, 2, 11, 10, 7, 6, 5, 8, 9, 10)
grupo <- c(rep("rh", 7), rep("cq", 8))

# Teste da mediana
Median.test(x, grupo)

