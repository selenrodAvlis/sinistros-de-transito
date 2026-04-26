# ============================================================
# ANÁLISE DE SINISTROS DE TRÂNSITO — PRF 2025
# Disciplina: Bioestatística
# ============================================================

# PACOTES ----------------------------------------------------------------
pacotes <- c("dplyr", "ggplot2", "knitr", "kableExtra",
             "scales", "readxl", "stringr", "epitools",
             "readr")
for (p in pacotes) {
  if (!require(p, character.only = TRUE, quietly = TRUE)) {
    install.packages(p, quiet = TRUE)
    library(p, character.only = TRUE)
  }
}

# DADOS ------------------------------------------------------------------

dados_bruto <- read_delim("por_pessoa_acidentes2025.csv", 
                          delim = ";", escape_double = FALSE,
                          locale = locale(encoding = "ISO-8859-1"), 
                          trim_ws = TRUE)
glimpse(dados_bruto)

# ORGANIZAR E PADRONIZAR -------------------------------------------------


# DESFECHO: VITIMAS FATAIS ------------------------------------------------

dados <- dados_bruto %>%
  mutate(
    fatal = case_when(
      str_trim(classificacao_acidente) == "Com Vítimas Fatais"  ~ "Sim",
      str_trim(classificacao_acidente) %in% c("Com Vítimas Feridas",
                                              "Sem Vítimas")   ~ "Não",
      TRUE ~ NA_character_
    ),
    fatal = factor(fatal, levels = c("Não", "Sim"))
  )


# FATOR: FASE DO DIA (DICOTOMICA) -----------------------------------------

dados <- dados %>%
  mutate(
    fase_dia_dic = case_when(
      str_trim(fase_dia) == "Pleno dia" ~ "Pleno dia",
      str_trim(fase_dia) %in% c("(null)", "N/D", NA) ~ NA_character_,
      TRUE ~ "Outros horários"
    ),
    fase_dia_dic = factor(fase_dia_dic,
                          levels = c("Pleno dia", "Outros horários"))
  )

# FATOR: CONDICAO METEREOLOGICA (POLITOMICA) ------------------------------

dados <- dados %>%
  mutate(
    cond_meteo = case_when(
      str_trim(condicao_metereologica) %in% c("Céu Claro", "Sol") ~ "Tempo bom",
      str_trim(condicao_metereologica) %in% c("Nublado")          ~ "Nublado",
      str_trim(condicao_metereologica) %in% c("Chuva", "Garoa/Chuvisco",
                                              "Neve", "Granizo",
                                              "Neblina/Névoa",
                                              "Vento")           ~ "Tempo adverso",
      str_trim(condicao_metereologica) %in% c("Ignorado",
                                              "(null)", NA)      ~ NA_character_,
      TRUE ~ NA_character_
    )
  )

# FATOR: TIPO DE PISTA (POLITOMICA) ---------------------------------------

dados <- dados %>%
  mutate(
    tipo_pista = case_when(
      str_trim(tipo_pista) %in% c("(null)", "N/D", NA) ~ NA_character_,
      TRUE ~ str_trim(tipo_pista)
    ),
    tipo_pista = factor(tipo_pista,
                        levels = c("Dupla", "Múltipla", "Simples"))
  )

# FATOR: CAUSA DO ACIDENTE (POLITOMICO) -----------------------------------

dados <- dados %>%
  mutate(
    causa_grupo = case_when(
      causa_acidente %in% c(
        "Reação tardia ou ineficiente do condutor",
        "Ausência de reação do condutor",
        "Velocidade Incompatível",
        "Transitar na contramão",
        "Manobra de mudança de faixa",
        "Ultrapassagem Indevida",
        "Condutor deixou de manter distância do veículo da frente",
        "Condutor usando celular",
        "Ingestão de álcool pelo condutor",
        "Ingestão de substâncias psicoativas pelo condutor",
        "Condutor Dormindo",
        "Mal súbito do condutor",
        "Participar de racha",
        "Conversão proibida",
        "Retorno proibido",
        "Frear bruscamente",
        "Transitar no Acostamento",
        "Condutor desrespeitou a iluminação vermelha do semáforo",
        "Trafegar com motocicleta (ou similar) entre as faixas",
        "Acessar a via sem observar a presença dos outros veículos",
        "Deixar de acionar o farol da motocicleta (ou similar)"
      ) ~ "Falha humana do condutor",
      
      causa_acidente %in% c(
        "Pista esburacada",
        "Acumulo de água sobre o pavimento",
        "Acumulo de óleo sobre o pavimento",
        "Acumulo de areia ou detritos sobre o pavimento",
        "Pista Escorregadia",
        "Afundamento ou ondulação no pavimento",
        "Acostamento em desnível",
        "Falta de acostamento",
        "Faixas de trânsito com largura insuficiente",
        "Ausência de sinalização",
        "Sinalização mal posicionada",
        "Sinalização encoberta",
        "Iluminação deficiente",
        "Deficiência do Sistema de Iluminação/Sinalização",
        "Sistema de drenagem ineficiente",
        "Desvio temporário",
        "Redutor de velocidade em desacordo",
        "Acesso irregular",
        "Falta de elemento de contenção que evite a saída do leito carroçável",
        "Semáforo com defeito",
        "Demais falhas na via",
        "Área urbana sem a presença de local apropriado para a travessia de pedestres"
      ) ~ "Falha na via / infraestrutura",
      
      causa_acidente %in% c(
        "Demais falhas mecânicas ou elétricas",
        "Problema com o freio",
        "Avarias e/ou desgaste excessivo no pneu",
        "Problema na suspensão",
        "Faróis desregulados",
        "Modificação proibida",
        "Carga excessiva e/ou mal acondicionada"
      ) ~ "Falha mecânica do veículo",
      
      causa_acidente %in% c(
        "Chuva",
        "Neblina",
        "Fumaça",
        "Demais Fenômenos da natureza",
        "Curva acentuada",
        "Declive acentuado",
        "Restrição de visibilidade em curvas horizontais",
        "Restrição de visibilidade em curvas verticais"
      ) ~ "Fatores ambientais",
      
      causa_acidente %in% c(
        "Pedestre andava na pista",
        "Pedestre cruzava a pista fora da faixa",
        "Pedestre - Ingestão de álcool/ substâncias psicoativas",
        "Entrada inopinada do pedestre",
        "Animais na Pista",
        "Estacionar ou parar em local proibido",
        "Objeto estático sobre o leito carroçável",
        "Transitar na calçada",
        "Desrespeitar a preferência no cruzamento"
      ) ~ "Pedestre / terceiros",
      
      causa_acidente %in% c(
        "Suicídio (presumido)",
        "Transtornos Mentais (exceto suicidio)"
      ) ~ "Outros",
      
      TRUE ~ NA_character_
    ),
    causa_grupo = factor(causa_grupo, levels = c(
      "Falha humana do condutor",
      "Falha na via / infraestrutura",
      "Falha mecânica do veículo",
      "Fatores ambientais",
      "Pedestre / terceiros",
      "Outros"
    ))
  )


# FATOR: DIA DA SEMANA (DICOTOMICO) ---------------------------------------

# Feriados nacionais de verão 2025 (jan e fev)
feriados <- as.Date(c(
  "2025-01-01",  # Confraternização Universal
  "2025-03-03",  # Carnaval (ponto facultativo)
  "2025-03-04",  # Carnaval
  "2025-03-05",   # Quarta de cinzas (meio período)
  "2025-12-24",  # Véspera de Natal (ponto facultativo)
  "2025-12-25",   # Natal
  "2025-12-31"   # Véspera de Ano Novo (ponto facultativo)
))

dados <- dados %>%
  mutate(
    tipo_dia = case_when(
      data_inversa %in% feriados                          ~ "Final de semana / feriado",
      dia_semana %in% c("sábado", "domingo")              ~ "Final de semana / feriado",
      dia_semana %in% c("segunda-feira", "terça-feira",
                        "quarta-feira", "quinta-feira",
                        "sexta-feira")                    ~ "Dia útil",
      TRUE ~ NA_character_
    ),
    tipo_dia = factor(tipo_dia,
                      levels = c("Dia útil",
                                 "Final de semana / feriado"))
  )

# FATOR: SEXO (POLITOMICA) ------------------------------------------------

dados <- dados %>% 
  mutate(
    sexo = case_when(
      str_trim(sexo) == "Masculino" ~ "Masculino",
      str_trim(sexo) == "Feminino"  ~ "Feminino",
      TRUE ~ 'Outro / Ignorado'
    ),
    sexo = factor(sexo, levels = c("Masculino", "Feminino", "Outro / Ignorado"))
  )



# FATOR: TIPO DE VEICULO (POLITOMICA) -------------------------------------

dados <- dados %>%
  mutate(
    tipo_veiculo_grp = case_when(
      tipo_veiculo %in% c("Automóvel", "Caminhonete",
                          "Camioneta", "Utilitário",
                          "Motor-casa")                  ~ "Automóvel / utilitário leve",
      
      tipo_veiculo %in% c("Motocicleta", "Motoneta",
                          "Ciclomotor", "Triciclo",
                          "Quadriciclo")                 ~ "Motocicleta / similar",
      
      tipo_veiculo %in% c("Caminhão", "Caminhão-trator",
                          "Semireboque", "Reboque",
                          "Chassi-plataforma")           ~ "Veículo pesado",
      
      tipo_veiculo %in% c("Ônibus", "Micro-ônibus")     ~ "Transporte coletivo",
      
      tipo_veiculo %in% c("Bicicleta", "Carroça-charrete",
                          "Carro de mão", "Trem-bonde",
                          "Trator de rodas",
                          "Trator de esteira",
                          "Trator misto")                ~ "Não motorizado / especial",
      
      is.na(tipo_veiculo) |
        tipo_veiculo == "Outros"                         ~ NA_character_
    ),
    tipo_veiculo_grp = factor(tipo_veiculo_grp,
                              levels = c(
                                "Automóvel / utilitário leve",
                                "Motocicleta / similar",
                                "Veículo pesado",
                                "Transporte coletivo",
                                "Não motorizado / especial"
                              ))
  )



# TRATAMENTO FINAL --------------------------------------------------------

dados <- dados %>%
  select(fatal,
         fase_dia_dic,
         cond_meteo,
         tipo_pista,
         causa_grupo,
         tipo_dia,
         sexo,
         tipo_veiculo_grp)

# Remove registros com NA no desfecho
dados_analise <- dados %>% filter(!is.na(fatal))

readr::write_csv(dados_analise, "dados_analise.csv")
