# Perguntas de Análise — Sinistros de Trânsito (PRF 2025)

Este documento reúne questões em aberto para orientar a análise dos dados e estimular discussões sobre os fatores associados à ocorrência de óbito.

---

## 🚧 Perguntas em aberto

### 🧭 1. Compreensão geral do desfecho

- Por que a proporção de sinistros fatais (~10%) é relativamente baixa, mesmo com grande número absoluto de óbitos?
- A distribuição do desfecho (óbito) é balanceada o suficiente para modelagem logística ou pode afetar a interpretação dos resultados?

---

### 🌙 2. Fase do dia

- A maior ocorrência de acidentes durante o dia está relacionada ao volume de tráfego ou ao risco real?
- O período noturno aumenta a **chance de óbito**, mesmo com menor número de acidentes?
- Existe interação entre fase do dia e tipo de pista ou tipo de veículo?

---

### 🌧️ 3. Condição meteorológica

- Por que a maioria dos acidentes ocorre em “tempo bom”? Isso reflete exposição ou risco?
- Condições adversas aumentam a gravidade (óbito) ou apenas reduzem a frequência de acidentes?
- Existe confusão entre condição meteorológica e fase do dia?

---

### 🛣️ 4. Tipo de pista

- Por que pistas simples apresentam maior proporção de óbitos?
- Esse efeito permanece após ajuste no modelo multivariado?
- O tipo de pista pode estar associado a outros fatores (ex: velocidade, localização rural)?

---

### ⚠️ 5. Causa do acidente

- Por que “falha humana” é tão predominante — isso reflete realidade ou limitação de classificação?
- A categoria “Outros” apresenta proporção extremamente alta de óbitos — isso pode indicar problema de categorização?
- Acidentes envolvendo pedestres apresentam maior risco de morte independentemente de outros fatores?

---

### 📅 6. Tipo de dia

- Finais de semana apresentam maior risco de óbito ou isso é efeito de comportamento (álcool, velocidade)?
- O efeito do tipo de dia permanece significativo após ajuste por outras variáveis?
- Existe interação entre tipo de dia e tipo de veículo?

---

### 👤 7. Sexo

- Homens apresentam maior risco de óbito ou apenas maior exposição ao trânsito?
- A categoria “Ignorado” pode estar enviesando os resultados?
- O sexo permanece significativo no modelo ajustado?

---

### 🚗 8. Tipo de veículo

- Por que transporte coletivo apresenta maior risco relativo de óbito?
- Motocicletas têm menor risco relativo no modelo — isso é esperado ou contraintuitivo?
- O tipo de veículo interage com tipo de pista ou causa do acidente?

---

### 📊 9. Análises bivariadas vs multivariadas

- Quais variáveis mudam de efeito após ajuste (possível confusão)?
- Alguma variável perde significância no modelo ajustado?
- Existem sinais de multicolinearidade entre os fatores?

---

### 📈 10. Modelo de regressão logística

- O modelo final selecionado por AIC é o mais interpretável ou apenas o mais parcimonioso?
- Todas as variáveis têm relevância prática ou apenas estatística?
- Os Odds Ratios são clinicamente/operacionalmente relevantes ou apenas estatisticamente significativos?

---

### 🔍 11. Interpretação dos resultados

- Com um n muito grande (~195 mil), os p-valores são confiáveis como critério principal?
- As medidas de efeito (RR, OR) são mais informativas que os testes de hipótese?
- Existe diferença entre significância estatística e relevância prática neste estudo?

---

### ⚠️ 12. Limitações do estudo

- O delineamento transversal impede inferência causal — quais interpretações devem ser evitadas?
- A ausência de variáveis como velocidade, álcool e uso de cinto pode enviesar os resultados?
- O fato dos dados serem por pessoa (e não por acidente) afeta a análise?

---

### 💡 13. Extensões possíveis

- Um modelo com interações (ex: tipo de pista × tipo de veículo) melhoraria a explicação?
- Seria útil testar modelos alternativos (ex: árvore de decisão, random forest)?
- Como incorporar variáveis espaciais (região, estado, rodovia)?

---

## 🧪 Hipóteses (para investigação)

- Acidentes em pistas simples têm maior risco de óbito.
- Finais de semana aumentam a probabilidade de morte.
- Acidentes com pedestres têm maior gravidade.
- Veículos pesados e transporte coletivo aumentam o risco de óbito.

---

## 🎯 Próximos passos sugeridos

- Testar interações no modelo logístico
- Avaliar qualidade do ajuste (ROC, AUC)
- Explorar variáveis adicionais (se disponíveis)
