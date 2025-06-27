########### TESTES PARA DUAS AMOSTRAS INDEPENDENTES

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
# wilcox.test(dados_grupo1, dados_grupos2, alternative = "two.sided)

# Kolmogorov-Smirnov:
# Verifica concordância entre duas distribuições acumuladas, ou seja
# se duas amostras vem de uma mesma população (verifica a distribuição de forma geral)
# H0: não há diferença significativa H1: caso contrário
# ks.test(acumulada_grupo1, acumulada_grupo2)

########### TESTES PARA K AMOSTRAS RELACIONADAS (PAREADAS)

# Q Cochran:
# determinar se há diferenças nas proporções de três ou mais grupos pareados
# variável resposta binária
# # extensão do teste de mcnemar para mais de dois grupos
# H0: As proporções de sucesso são iguais em todos os grupos H1: pelo menos um difere
# DescTools::CochranQTest(as.matrix(dataframe_com_dados)) (cada coluna um grupo pareado)

# Friedman
# alternativa não paramétrica para ANOVA de medidas pareadas
# testa se há diferenças entre três ou mais grupos pareados
# H0: As distribuições das ranks são iguais entre os grupos H1: pelo menos um difere
# variável resposta ordinal / contínua não normal
# tidyr::friedman.test(as.matrix(dataframe_com_dados)) (cada coluna um grupo pareado)

# Comparações múltiplas
# saber quais grupos diferem entre si após o teste de Friedman
# testes post-hoc de Wilcoxon pareados com correção de Bonferroni
# # pairwise.wilcox.test(dados_long$medidas, dados_long$grupo_pareado, p.adjust.method = "bonferroni", paired = TRUE)

# Page
#alternativa ao teste de Friedman para quando há uma hipótese sobre a ordem dos tratamentos 
#(por exemplo, espera-se que as médias aumentem em uma ordem específica)
# variável resposta Ordinal/contínuo não normal 
# H0:: As distribuições das ranks são iguais entre os grupos
# H1: Há uma tendência ordenada (crescente ou decrescente) nos grupos
#crank::page.test(as.matrix(dados))




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

###### QUESTÃO 4

# Mann-Whitney

varA <- c(4.3, 3.8, 5.2, 2.5, 3.5, 4.1, 5.1, 4.0, 2.2, 1.8, 4.5, 1.7, 3.6, 4.5, 5.0)
varB <- c(4.2, 6.2, 4.8, 6.8, 4.7, 6.5, 6.3, 5.9, 7.2, 5.1)

wilcox.test(varA, varB, alternative = "two.sided")
# baixo p-valor: não têm a mesma produtividade

####### QUESTÃO 5

# kolmogorov-smirnov
# distribuições acumuladas
S_A <- c(1/15, 3/15, 3/15, 7/15, 12/15, 14/15, 15/15, 1, 1, 1)
S_B <- c(0, 0, 0, 0, 1/10, 4/10, 4/10, 7/10, 9/10, 1)
ks.test(S_A, S_B, alternative = "two.sided")
# não há diferença significativa

###### QUESTÃO 6

# Dados
amostra <- 1:8
EDTA <- c(7.2, 6.1, 5.2, 5.9, 9.0, 8.5, 6.6, 4.4)
Espectrometria <- c(7.6, 6.8, 4.6, 5.7, 9.7, 8.7, 7.0, 4.7)

# Criar data.frame
dados <- data.frame(amostra, EDTA, Espectrometria)

wilcox.test(dados$Espectrometria, dados$EDTA, paired = TRUE, alternative = "two.sided")
# não são significativamente independentes
