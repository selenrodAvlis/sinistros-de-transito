# ============================================================
# TABELAS DE CONTINGÊNCIA (cruzamentos 2 a 2)
# ============================================================

cat("\n--- Tabela 5: Fatal x Fase do Dia ---\n")
t1 <- table(dados_analise$fase_dia_dic, dados_analise$fatal)
print(addmargins(t1))
print(round(prop.table(t1, margin = 1) * 100, 2))

cat("\n--- Tabela 6: Fatal x Condição Meteorológica ---\n")
t2 <- table(dados_analise$cond_meteo, dados_analise$fatal)
print(addmargins(t2))
print(round(prop.table(t2, margin = 1) * 100, 2))

cat("\n--- Tabela 7: Fatal x Tipo de Pista ---\n")
t3 <- table(dados_analise$tipo_pista, dados_analise$fatal)
print(addmargins(t3))
print(round(prop.table(t3, margin = 1) * 100, 2))

cat("\n--- Tabela 8: Fatal x Causa do acidente ---\n")
t4 <- table(dados_analise$causa_grupo, dados_analise$fatal)
print(addmargins(t4))
print(round(prop.table(t4, margin = 1) * 100, 2))

cat("\n--- Tabela 9: Fatal x Tipo dia ---\n")
t5 <- table(dados_analise$tipo_dia, dados_analise$fatal)
print(addmargins(t5))
print(round(prop.table(t5, margin = 1) * 100, 2))

cat("\n--- Tabela 9: Fatal x Sexo ---\n")
t6 <- table(dados_analise$sexo, dados_analise$fatal)
print(addmargins(t6))
print(round(prop.table(t6, margin = 1) * 100, 2))

cat("\n--- Tabela 9: Fatal x Tipo de veiculo ---\n")
t7 <- table(dados_analise$tipo_veiculo_grp, dados_analise$fatal)
print(addmargins(t7))
print(round(prop.table(t7, margin = 1) * 100, 2))

# ============================================================
# TESTES DE HIPÓTESE — QUI-QUADRADO / FISHER
# ============================================================

# Função auxiliar: escolhe qui-quadrado ou Fisher
teste_assoc <- function(tab, nome) {
  freq_esp <- chisq.test(tab)$expected
  cat("\n---", nome, "---\n")
  if (any(freq_esp < 5)) {
    cat("Frequências esperadas < 5 detectadas. Usando Teste Exato de Fisher.\n")
    print(fisher.test(tab, simulate.p.value = TRUE, B = 10000))
  } else {
    print(chisq.test(tab))
  }
}

teste_assoc(t1, "Qui-Quadrado: Fatal x Fase do Dia")
teste_assoc(t2, "Qui-Quadrado: Fatal x Condição Meteorológica")
teste_assoc(t3, "Qui-Quadrado: Fatal x Tipo de Pista")
teste_assoc(t4, "Qui-Quadrado: Fatal x Causa do Acidente")
teste_assoc(t5, "Qui-Quadrado: Fatal x Tipo dia")
teste_assoc(t6, "Qui-Quadrado: Fatal x Sexo")
teste_assoc(t7, "Qui-Quadrado: Fatal x Tipo de Veículo")

# ============================================================
# MEDIDAS DE ASSOCIAÇÃO
# Seguindo o método da professora (cálculo manual via matriz)
# ============================================================

alpha <- 0.05
z     <- qnorm(1 - alpha / 2)

## ── 1. FATAL x FASE DO DIA (dicotômica) ────────────────────
# Matriz: linhas = fase_dia (Pleno dia / Outros), colunas = fatal (Não / Sim)
cat("\n========== Fatal x Fase do Dia ==========\n")
M1 <- matrix(c(t1["Pleno dia",    "Não"], t1["Pleno dia",    "Sim"],
               t1["Outros horários", "Não"], t1["Outros horários", "Sim"]),
             nrow = 2, byrow = TRUE)
rownames(M1) <- c("Pleno dia", "Outros horários")
colnames(M1) <- c("Não fatal", "Fatal")
print(M1)

# Incidências (proporção de fatais por grupo)
I_pleno  <- M1[1, 2] / sum(M1[1, ])
I_outros <- M1[2, 2] / sum(M1[2, ])

# Risco Relativo (RR) — ref: Pleno dia
RR1    <- I_outros / I_pleno
f_RR1  <- log(RR1)
VF_RR1 <- (1 - I_outros) / (sum(M1[2, ]) * I_outros) +
           (1 - I_pleno)  / (sum(M1[1, ]) * I_pleno)
li_RR1 <- exp(f_RR1 - z * sqrt(VF_RR1))
ls_RR1 <- exp(f_RR1 + z * sqrt(VF_RR1))
cat("\nRisco Relativo (Outros horários vs. Pleno dia):\n")
print(cbind(RR = round(RR1, 4),
            `IC 95% LI` = round(li_RR1, 4),
            `IC 95% LS` = round(ls_RR1, 4)))

# Risco Atribuível (RA)
RA1    <- I_outros - I_pleno
Vd1    <- (1 - I_outros) * I_outros / (sum(M1[2, ]) - 1) +
           (1 - I_pleno)  * I_pleno  / (sum(M1[1, ]) - 1)
li_RA1 <- RA1 - z * sqrt(Vd1)
ls_RA1 <- RA1 + z * sqrt(Vd1)
cat("\nRisco Atribuível (Outros horários vs. Pleno dia):\n")
print(cbind(RA = round(RA1, 4),
            `IC 95% LI` = round(li_RA1, 4),
            `IC 95% LS` = round(ls_RA1, 4)))

# Odds Ratio (OR)
OR1    <- M1[2, 2] * M1[1, 1] / (M1[2, 1] * M1[1, 2])
f_OR1  <- log(OR1)
VF_OR1 <- 1/M1[1,1] + 1/M1[1,2] + 1/M1[2,1] + 1/M1[2,2]
li_OR1 <- exp(f_OR1 - z * sqrt(VF_OR1))
ls_OR1 <- exp(f_OR1 + z * sqrt(VF_OR1))
cat("\nOdds Ratio (Outros horários vs. Pleno dia):\n")
print(cbind(OR = round(OR1, 4),
            `IC 95% LI` = round(li_OR1, 4),
            `IC 95% LS` = round(ls_OR1, 4)))

## ── 2. FATAL x CONDIÇÃO METEOROLÓGICA (politômica) ─────────
# Para variável politômica: OR de cada categoria vs. referência (Tempo bom)
cat("\n========== Fatal x Condição Meteorológica ==========\n")
cat("Referência: Tempo bom\n")

niveis_meteo <- c("Nublado", "Tempo adverso")
for (niv in niveis_meteo) {
  cat("\n-- Categoria:", niv, "vs. Tempo bom --\n")
  M_sub <- matrix(c(t2["Tempo bom", "Não"], t2["Tempo bom", "Sim"],
                    t2[niv,         "Não"], t2[niv,         "Sim"]),
                  nrow = 2, byrow = TRUE)
  rownames(M_sub) <- c("Tempo bom", niv)
  colnames(M_sub) <- c("Não fatal", "Fatal")

  I_ref <- M_sub[1, 2] / sum(M_sub[1, ])
  I_niv <- M_sub[2, 2] / sum(M_sub[2, ])

  RR_sub    <- I_niv / I_ref
  f_RR_sub  <- log(RR_sub)
  VF_RR_sub <- (1 - I_niv) / (sum(M_sub[2,]) * I_niv) +
               (1 - I_ref) / (sum(M_sub[1,]) * I_ref)
  li_RR_sub <- exp(f_RR_sub - z * sqrt(VF_RR_sub))
  ls_RR_sub <- exp(f_RR_sub + z * sqrt(VF_RR_sub))

  OR_sub    <- M_sub[2,2] * M_sub[1,1] / (M_sub[2,1] * M_sub[1,2])
  f_OR_sub  <- log(OR_sub)
  VF_OR_sub <- 1/M_sub[1,1] + 1/M_sub[1,2] + 1/M_sub[2,1] + 1/M_sub[2,2]
  li_OR_sub <- exp(f_OR_sub - z * sqrt(VF_OR_sub))
  ls_OR_sub <- exp(f_OR_sub + z * sqrt(VF_OR_sub))

  cat("RR:", round(RR_sub, 4),
      "| IC 95%: [", round(li_RR_sub, 4), ";", round(ls_RR_sub, 4), "]\n")
  cat("OR:", round(OR_sub, 4),
      "| IC 95%: [", round(li_OR_sub, 4), ";", round(ls_OR_sub, 4), "]\n")
}

## ── 3. FATAL x TIPO DE PISTA (politômica) ──────────────────
cat("\n========== Fatal x Tipo de Pista ==========\n")
cat("Referência: Dupla\n")

niveis_pista <- c("Múltipla", "Simples")
for (niv in niveis_pista) {
  cat("\n-- Categoria:", niv, "vs. Dupla --\n")
  M_sub <- matrix(c(t3["Dupla", "Não"], t3["Dupla", "Sim"],
                    t3[niv,     "Não"], t3[niv,     "Sim"]),
                  nrow = 2, byrow = TRUE)
  rownames(M_sub) <- c("Dupla", niv)
  colnames(M_sub) <- c("Não fatal", "Fatal")

  I_ref <- M_sub[1, 2] / sum(M_sub[1, ])
  I_niv <- M_sub[2, 2] / sum(M_sub[2, ])

  RR_sub    <- I_niv / I_ref
  f_RR_sub  <- log(RR_sub)
  VF_RR_sub <- (1 - I_niv) / (sum(M_sub[2,]) * I_niv) +
               (1 - I_ref) / (sum(M_sub[1,]) * I_ref)
  li_RR_sub <- exp(f_RR_sub - z * sqrt(VF_RR_sub))
  ls_RR_sub <- exp(f_RR_sub + z * sqrt(VF_RR_sub))

  OR_sub    <- M_sub[2,2] * M_sub[1,1] / (M_sub[2,1] * M_sub[1,2])
  f_OR_sub  <- log(OR_sub)
  VF_OR_sub <- 1/M_sub[1,1] + 1/M_sub[1,2] + 1/M_sub[2,1] + 1/M_sub[2,2]
  li_OR_sub <- exp(f_OR_sub - z * sqrt(VF_OR_sub))
  ls_OR_sub <- exp(f_OR_sub + z * sqrt(VF_OR_sub))

  cat("RR:", round(RR_sub, 4),
      "| IC 95%: [", round(li_RR_sub, 4), ";", round(ls_RR_sub, 4), "]\n")
  cat("OR:", round(OR_sub, 4),
      "| IC 95%: [", round(li_OR_sub, 4), ";", round(ls_OR_sub, 4), "]\n")
}

# ============================================================
# REGRESSÃO LOGÍSTICA
# Seguindo o método da professora (glm + step + diagnóstico)
# ============================================================

# Prepara dados sem NA para a regressão
dados_reg <- dados_analise %>%
  filter(!is.na(fase_dia_dic),
         !is.na(cond_meteo),
         !is.na(tipo_pista),
         !is.na(causa_grupo),
         !is.na(tipo_dia),
         !is.na(sexo),
         !is.na(tipo_veiculo_grp))

cat("\n========== Regressão Logística ==========\n")

# Modelo completo (todos os fatores)
ajust <- glm(fatal ~ fase_dia_dic + cond_meteo + tipo_pista + causa_grupo + tipo_dia + sexo + tipo_veiculo_grp,
             family = binomial(link = "logit"),
             data   = dados_reg)
cat("\n--- Modelo Completo ---\n")
summary(ajust)

# Seleção automática por AIC (stepwise)
cat("\n--- Seleção Stepwise ---\n")
ajust_step <- step(ajust)
summary(ajust_step)
anova(ajust_step, test = "Chisq")

# ── Diagnóstico do modelo final ──────────────────────────────
cat("\n--- Diagnóstico de Resíduos ---\n")

# Resíduos deviance
dev <- residuals(ajust_step, type = "deviance")
QL  <- sum(dev^2)
gl  <- ajust_step$df.residual
p1  <- 1 - pchisq(QL, gl)
cat("Qui-quadrado deviance:", round(QL, 4),
    "| gl:", gl,
    "| p-valor:", round(p1, 4), "\n")

# Resíduos Pearson
rpears <- residuals(ajust_step, type = "pearson")
QP     <- sum(rpears^2)
p2     <- 1 - pchisq(QP, gl)
cat("Qui-quadrado Pearson:", round(QP, 4),
    "| gl:", gl,
    "| p-valor:", round(p2, 4), "\n")

# Gráficos de resíduos
par(mfrow = c(1, 2))

plot(rpears,
     ylab = "Resíduos Pearson",
     pch  = 16, ylim = c(-4, 4),
     main = "Resíduos de Pearson")
abline(h =  0,   lty = 3)
abline(h =  2.5, lty = 3, col = "red")
abline(h = -2.5, lty = 3, col = "red")

plot(dev,
     ylab = "Resíduos Deviance",
     pch  = 16, ylim = c(-4, 4),
     main = "Resíduos Deviance")
abline(h =  0,   lty = 3)
abline(h =  2.5, lty = 3, col = "red")
abline(h = -2.5, lty = 3, col = "red")

par(mfrow = c(1, 1))

# ── OR do modelo logístico com IC 95% ───────────────────────
cat("\n--- Odds Ratio do Modelo Final (com IC 95%) ---\n")
coef_mod <- coef(ajust_step)
ic_mod   <- confint.default(ajust_step)
OR_mod   <- exp(coef_mod)
IC_OR    <- exp(ic_mod)
print(round(cbind(`OR` = OR_mod,
                  `IC 95% LI` = IC_OR[, 1],
                  `IC 95% LS` = IC_OR[, 2]), 4))
