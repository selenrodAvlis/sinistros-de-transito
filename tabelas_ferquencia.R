# ============================================================
# TABELAS DE FREQUÊNCIA INDIVIDUAIS
# ============================================================

# Desfecho: Acidente Fatal
cat("\n--- Tabela 1: Acidente Fatal ---\n")
tab_fatal <- table(dados_analise$fatal)
prop_fatal <- prop.table(tab_fatal) * 100
print(cbind(n = tab_fatal, `%` = round(prop_fatal, 2)))

# Fator 1: Fase do dia
cat("\n--- Tabela 2: Fase do Dia ---\n")
tab_fase <- table(dados_analise$fase_dia_dic)
prop_fase <- prop.table(tab_fase) * 100
print(cbind(n = tab_fase, `%` = round(prop_fase, 2)))

# Fator 2: Condição meteorológica
cat("\n--- Tabela 3: Condição Meteorológica ---\n")
tab_meteo <- table(dados_analise$cond_meteo)
prop_meteo <- prop.table(tab_meteo) * 100
print(cbind(n = tab_meteo, `%` = round(prop_meteo, 2)))

# Fator 3: Tipo de pista
cat("\n--- Tabela 4: Tipo de Pista ---\n")
tab_pista <- table(dados_analise$tipo_pista)
prop_pista <- prop.table(tab_pista) * 100
print(cbind(n = tab_pista, `%` = round(prop_pista, 2)))

# Fator 4: Causa do acidente
cat("\n--- Tabela 5: Causa do acidente ---\n")
tab_causa_grupo <- table(dados_analise$causa_grupo)
prop_causa_grupo <- prop.table(tab_causa_grupo) * 100
print(cbind(n = tab_causa_grupo, `%` = round(prop_causa_grupo, 2)))

# Fator 5: Tipo dia
cat("\n--- Tabela 6: Tipo dia ---\n")
tab_tipo_dia <- table(dados_analise$tipo_dia)
prop_tipo_dia <- prop.table(tab_tipo_dia) * 100
print(cbind(n = tab_tipo_dia, `%` = round(prop_tipo_dia, 2)))

# Fator 6: Sexo
cat("\n--- Tabela 7: Sexo ---\n")
tab_sexo <- table(dados_analise$sexo)
prop_sexo <- prop.table(tab_sexo) * 100
print(cbind(n = tab_sexo, `%` = round(prop_sexo, 2)))

# Fator 7: Tipo de veiculo
cat("\n--- Tabela 8: Tipo de veiculo ---\n")
tab_tipo_veiculo <- table(dados_analise$tipo_veiculo_grp)
prop_tipo_veiculo <- prop.table(tab_tipo_veiculo) * 100
print(cbind(n = tab_tipo_veiculo, `%` = round(prop_tipo_veiculo, 2)))
