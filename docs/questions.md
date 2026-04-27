# Perguntas de Análise — Sinistros de Trânsito (PRF 2025)

Este documento reúne questões em aberto para orientar a análise dos dados
e estimular discussões sobre os fatores associados à ocorrência de óbito.

Última atualização: inclusão de observações sobre suicídio/transtornos
mentais na causa do acidente e refinamento das extensões possíveis.

---

## 🚧 Perguntas em aberto

### 🧭 1. Compreensão geral do desfecho

- Por que a proporção de sinistros fatais (~10%) é relativamente baixa,
  mesmo com grande número absoluto de óbitos?
- A distribuição do desfecho (óbito) é balanceada o suficiente para
  modelagem logística ou pode afetar a interpretação dos resultados?

---

### 🌙 2. Tipo de dia

- Finais de semana apresentam maior risco de óbito ou isso é efeito de
  comportamento (álcool, velocidade)?
- O efeito do tipo de dia permanece significativo após ajuste por outras
  variáveis no modelo logístico?
- Existe interação entre tipo de dia e tipo de veículo?

---

### 🌧️ 3. Condição meteorológica

- Por que a maioria dos acidentes ocorre em "tempo bom"? Isso reflete
  exposição ou risco?
- Condições adversas aumentam a gravidade (óbito) ou apenas reduzem a
  frequência de acidentes?
- O resultado contraintuitivo (tempo adverso com menor proporção de óbitos)
  pode ser explicado por adaptação comportamental dos condutores?

---

### 🛣️ 4. Tipo de pista

- Por que pistas simples apresentam maior proporção de óbitos?
- Esse efeito permanece após ajuste no modelo multivariado?
- O tipo de pista pode estar associado a outros fatores não mensurados
  (ex.: velocidade, localização rural, tempo de resposta do socorro)?

---

### ⚠️ 5. Causa do acidente

- Por que "falha humana" é tão predominante — isso reflete realidade
  ou limitação de classificação pelo agente da PRF no local?

- [RESOLVIDO] A categoria "Suicídio (presumido)" e "Transtornos Mentais"
  apresentou proporção de óbitos próxima de 100%, gerando associação
  altamente significativa e OR extremamente elevado no modelo.
  DECISÃO: esses registros foram EXCLUÍDOS da análise por se tratarem
  de eventos de natureza intencional, não comparáveis aos demais sinistros
  de trânsito. O critério de exclusão foi incorporado à descrição do estudo.
  Justificativa: incluí-los distorceria as medidas de associação e
  desviaria o foco do objetivo do estudo.

- Acidentes envolvendo pedestres apresentam maior risco de morte
  independentemente de outros fatores? Verificar a proporção de óbitos
  na categoria "Pedestre / terceiros" nas tabelas de contingência.

---

### 👤 6. Sexo

- Homens apresentam maior risco de óbito ou apenas maior exposição
  ao trânsito nas rodovias federais?
- A categoria "Ignorado/Outro" pode estar enviesando os resultados?
  Qual a proporção de registros nessa categoria?
- O sexo permanece significativo no modelo ajustado após o stepwise?

---

### 🚗 7. Tipo de veículo

- Por que transporte coletivo apresenta maior risco relativo de óbito?
  Pode ser efeito da estrutura dos dados (por pessoa, não por acidente)?
- Motocicletas com menor risco relativo — como explicar esse resultado
  contraintuitivo dado que motociclistas são reconhecidamente vulneráveis?
- O tipo de veículo interage com tipo de pista ou causa do acidente?

---

### 📊 8. Análises bivariadas vs. multivariadas

- Quais variáveis mudam de efeito após ajuste (possível confundimento)?
- Alguma variável perde significância no modelo ajustado pelo stepwise?
- Existem sinais de correlação entre causa do acidente e tipo de veículo
  (ex.: falha mecânica mais associada a veículos pesados)?

---

### 📈 9. Modelo de regressão logística

- O modelo final selecionado por AIC é o mais interpretável ou apenas
  o mais parcimonioso?
- Todas as variáveis mantidas têm relevância prática ou apenas estatística?
- Os Odds Ratios são operacionalmente relevantes para políticas de
  segurança viária?

---

### 🔍 10. Interpretação dos resultados

- Com n muito grande (~195 mil), os p-valores são confiáveis como
  critério principal de decisão?
- As medidas de efeito (RR, OR, RA) são mais informativas que os
  testes de hipótese neste contexto?
- Existe diferença entre significância estatística e relevância prática
  neste estudo? Quais variáveis ilustram melhor essa distinção?

---

### ⚠️ 11. Limitações do estudo

- O delineamento transversal impede inferência causal — quais
  interpretações devem ser evitadas?
- A ausência de variáveis como velocidade, álcool e uso de cinto pode
  gerar confundimento residual nos resultados?
- O fato dos dados serem por pessoa (e não por acidente) viola o
  pressuposto de independência da regressão logística — como discutir
  essa limitação?
- O recorte temporal (ano de 2025) limita a generalização dos resultados
  para outros períodos?

---

### 💡 12. Extensões possíveis (fora do escopo atual)

- Testar interações no modelo logístico (ex.: tipo de pista × tipo de
  veículo) poderia melhorar o poder explicativo?
- Como incorporar variáveis espaciais (região, estado, rodovia específica)
  para identificar trechos críticos?
- O uso de modelos com efeitos mistos (clustering por acidente) seria
  mais adequado dada a estrutura dos dados por pessoa?

---

## 🧪 Hipóteses e status

| Hipótese | Status |
|---|---|
| Acidentes em pistas simples têm maior risco de óbito | CONFIRMADA (RR = 2,12; OR = 2,29) |
| Finais de semana aumentam a probabilidade de morte | VERIFICAR no modelo ajustado |
| Acidentes com pedestres têm maior gravidade | VERIFICAR na tabela de contingência |
| Veículos pesados e transporte coletivo aumentam o risco de óbito | PARCIALMENTE CONFIRMADA |
| Suicídio/transtornos mentais distorcem a análise de causa | CONFIRMADA — registros excluídos |

---

## ✅ Decisões metodológicas tomadas

1. Fase do dia substituída por tipo de dia (dia útil vs. final de semana/
   feriado) — captura efeito comportamental mais relevante.

2. Registros com causa "Suicídio (presumido)" e "Transtornos Mentais
   (exceto suicídio)" excluídos da análise por serem eventos intencionais,
   não comparáveis aos demais sinistros de trânsito.

3. Condição meteorológica agrupada em três categorias (Tempo bom, Nublado,
   Tempo adverso) para evitar células esparsas nas tabelas de contingência.

4. Tipo de veículo agrupado em cinco categorias para reduzir o número de
   comparações e garantir frequências adequadas por célula.

5. Seleção de variáveis no modelo logístico por critério AIC (stepwise)
   com modelo completo como ponto de partida.

---

## 🎯 Próximos passos

- [ ] Excluir registros de suicídio/transtornos do pipeline e rerrodar
      toda a análise
- [ ] Verificar proporção de óbitos na categoria "Pedestre / terceiros"
- [ ] Confirmar se tipo_dia permanece no modelo após stepwise
- [ ] Verificar OR ajustado de veículos pesados vs. automóveis
- [ ] Atualizar critérios de exclusão no RMarkdown
- [ ] Redigir discussão com base nas respostas do respostas_questions.txt