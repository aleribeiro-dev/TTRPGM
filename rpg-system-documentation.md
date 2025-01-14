# Sistema de RPG - Documentação Completa

## Índice
1. [Prompt do Sistema](#prompt-do-sistema)
2. [Estrutura do Banco de Dados](#estrutura-do-banco-de-dados)

## Prompt do Sistema

### Visão Geral do Aplicativo
Criar um aplicativo de gerenciamento de RPG com as seguintes características e funcionalidades:

1. Sistema de Usuários:
   - Registro e login de usuários
   - Perfis de usuário com informações básicas
   - Diferenciação entre usuários comuns e administradores
   - Usuários não-administradores podem ser mestres (se criarem aventura) ou jogadores (se forem convidados)

2. Gerenciamento de Aventuras:
   - Criação e edição de aventuras com título, resumo e datas
   - Sistema para ativar ou desativar aventuras
   - O usuário que cria uma aventura automaticamente se torna o mestre dessa aventura
   - Opção para o mestre gerar um link de convite para jogadores

3. Sistema de Participação em Aventuras:
   - Usuários podem participar de aventuras como jogadores de duas formas:
     a) Aceitando um convite via link compartilhado pelo mestre
     b) Buscando aventuras disponíveis na plataforma e solicitando participação
   - Sistema de aprovação para solicitações de participação (gerenciado pelo mestre)

4. Sistema de Journal:
   - Área de fácil acesso para o mestre armazenar conteúdo de mídia (imagens, vídeos, textos)
   - Funcionalidade para o mestre tomar notas rápidas
   - Journal individual para cada personagem
   - Sistema de organização e busca dentro dos journals

5. Tela de Exibição Compartilhada:
   - Implementação de uma tela tipo picture-in-picture
   - Área principal para informações gerais
   - Área secundária (aninhada) para informações específicas por jogador

6. Sistema de Compartilhamento de Sessão:
   - Geração de URL única para cada sessão de jogo
   - Sistema de login para jogadores acessarem a sessão com seus personagens
   - Sincronização em tempo real do conteúdo compartilhado

7. Integração com Discord:
   - Vinculação de contas de usuário com Discord
   - Criação automatizada de servidor Discord para cada aventura
   - Sincronização de convites e participantes
   - Notificações em canais específicos
   - Chat integrado
   - Transmissão de áudio e vídeo
   - Bot com comandos para personagens e dados

8. Sistema de RPG Personalizável:
   - Interface para criação de sistemas próprios
   - Atributos personalizados
   - Cálculos usando atributos como variáveis
   - Regras de pontos customizáveis
   - Opção público/privado para sistemas
   - Mecanismo de busca de sistemas
   - Versionamento de sistemas

9. Gerenciamento de Sistemas de RPG:
   - Painel administrativo para sistemas públicos
   - Sistema de classificação e comentários
   - Ferramentas de clonagem e modificação
   - Exportação e importação de sistemas

10. Segurança e Backup:
    - Autenticação segura
    - Proteção de dados sensíveis
    - Backup automático
    - Controle de acesso por função

## Estrutura do Banco de Dados

```dbml
// Use DBML to define your database structure
// Docs: https://dbml.dbdiagram.io/docs

// User Management
Note: 'User Management' {
  bgcolor: "#f0f7ff"
}

Table users {
  id_users int [pk]
  first_name varchar[30]
  last_name varchar[30]
  user_name varchar
  email email
  password password
  is_adm boolean[0]
  active boolean[1]
  created_at timestamp
}

// Adventure Management
Note: 'Adventure Management' {
  bgcolor: "#fff0f0"
}

Table adventures {
  id_adventures int [pk]
  title text
  summary text
  starts_at date
  ends_at date
  active boolean[1]
  created_at timestamp
  master_id int [ref: > users.id_users]
  rpg_system_id int [ref: > rpg_systems.id_rpg_systems]
}

Table adventure_invitations {
  id_adventure_invitations int [pk]
  adventure_id int [ref: > adventures.id_adventures]
  invitation_link varchar[255]
  expires_at timestamp
}

Table adventure_participants {
  id_adventure_participants int [pk]
  adventure_id int [ref: > adventures.id_adventures]
  user_id int [ref: > users.id_users]
  role varchar[20]
  join_date timestamp
}

Table participation_requests {
  id_participation_requests int [pk]
  adventure_id int [ref: > adventures.id_adventures]
  user_id int [ref: > users.id_users]
  request_date timestamp
  status varchar[20]
}

// Character Management
Note: 'Character Management' {
  bgcolor: "#f0fff0"
}

Table heroes {
  id_heroes int [pk]
  user_id int [ref: > users.id_users]
  adventure_id int [ref: > adventures.id_adventures]
  name varchar[60]
  class varchar[30]
  race varchar[30]
  age integer
  background text
  active boolean[1]
  created_at timestamp
  rpg_system_id int [ref: > rpg_systems.id_rpg_systems]
}

Table traits {
  id_traits int [pk]
  name varchar[40]
  description text
}

Table heroes_traits {
  id_heroes_traits int [pk]
  hero_id int [ref: > heroes.id_heroes]
  traits_id int [ref: > traits.id_traits]
  value integer
}

Table skills {
  id_skills int [pk]
  name varchar[30]
  description text
  cost int
  level int
  bonus int
}

Table heroes_skills {
  id_heroes_skills int [pk]
  skill_id int [ref: > skills.id_skills]
  hero_id int [ref: > heroes.id_heroes]
  hero_level int
}

Table advantages {
  id_advantages int [pk]
  name varchar[30]
  description text
  cost int
  level int
  bonus int
}

Table heroes_advantages {
  id_heroes_advantages int [pk]
  advantages_id int [ref: > advantages.id_advantages]
  hero_id int [ref: > heroes.id_heroes]
  hero_level int
}

Table disadvantages {
  id_disadvantages int [pk]
  name varchar[30]
  description text
  cost int
  level int
  bonus int
}

Table heroes_disadvantages {
  id_heroes_disadvantages int [pk]
  disadvantages_id int [ref: > disadvantages.id_disadvantages]
  heroes_id int [ref: > heroes.id_heroes]
  hero_level int
}

// Inventory Management
Note: 'Inventory Management' {
  bgcolor: "#fff0ff"
}

Table bags {
  id_bags int [pk]
  hero_id int [ref: > heroes.id_heroes]
  description text
  capacity_vu int
}

Table items {
  id_items int [pk]
  name varchar[60]
  description text
  cost int
  bonus int
  ability text
  created_at timestamp
}

Table bags_items {
  id_bags_items int [pk]
  bags_id int [ref: > bags.id_bags]
  items_id int [ref: > items.id_items]
}

// Game Session Management
Note: 'Game Session Management' {
  bgcolor: "#fffff0"
}

Table game_sessions {
  id_game_sessions int [pk]
  adventure_id int [ref: > adventures.id_adventures]
  start_time timestamp
  end_time timestamp
  share_url varchar[255]
  discord_voice_channel_id varchar[20]
}

Table shared_content {
  id_shared_content int [pk]
  game_session_id int [ref: > game_sessions.id_game_sessions]
  content_type varchar[10]
  file_path varchar[255]
  description text
  is_public boolean
  hero_id int [ref: > heroes.id_heroes]
  discord_message_id varchar[20]
}

// Journal System
Note: 'Journal System' {
  bgcolor: "#f0ffff"
}

Table journals {
  id_journals int [pk]
  user_id int [ref: > users.id_users]
  hero_id int [ref: > heroes.id_heroes]
  title text
  content text
  created_at timestamp
  updated_at timestamp
}

Table journal_media {
  id_journal_media int [pk]
  journal_id int [ref: > journals.id_journals]
  media_type varchar[10]
  file_path varchar[255]
  description text
  uploaded_at timestamp
}

// Notification System
Note: 'Notification System' {
  bgcolor: "#fff8f0"
}

Table notifications {
  id_notifications int [pk]
  user_id int [ref: > users.id_users]
  adventure_id int [ref: > adventures.id_adventures]
  title text
  content_text text
  content_image image
  shared_at timestamp
  active boolean[1]
  created_at timestamp
}

// Discord Integration
Note: 'Discord Integration' {
  bgcolor: "#f8f0ff"
}

Table discord_integrations {
  id_discord_integrations int [pk]
  user_id int [ref: > users.id_users]
  discord_user_id varchar[20]
  discord_username varchar[50]
  access_token varchar[100]
  refresh_token varchar[100]
  token_expires_at timestamp
}

Table adventure_discord_servers {
  id_adventure_discord_servers int [pk]
  adventure_id int [ref: > adventures.id_adventures]
  discord_server_id varchar[20]
  invite_link varchar[100]
}

Table discord_channel_mappings {
  id_discord_channel_mappings int [pk]
  adventure_discord_server_id int [ref: > adventure_discord_servers.id_adventure_discord_servers]
  channel_type varchar[20]
  discord_channel_id varchar[20]
}

Table discord_message_logs {
  id_discord_message_logs int [pk]
  adventure_id int [ref: > adventures.id_adventures]
  user_id int [ref: > users.id_users]
  discord_channel_id varchar[20]
  message_content text
  timestamp timestamp
}

Table discord_command_configs {
  id_discord_command_configs int [pk]
  adventure_id int [ref: > adventures.id_adventures]
  command_name varchar[50]
  command_description text
  is_enabled boolean
}

// RPG System Management
Note: 'RPG System Management' {
  bgcolor: "#e6f2ff"
}

Table rpg_systems {
  id_rpg_systems int [pk]
  name varchar[100]
  description text
  creator_id int [ref: > users.id_users]
  is_public boolean
  created_at timestamp
  updated_at timestamp
}

Table system_attributes {
  id_system_attributes int [pk]
  rpg_system_id int [ref: > rpg_systems.id_rpg_systems]
  name varchar[50]
  description text
  data_type varchar[20]
  default_value varchar[100]
}

Table system_calculations {
  id_system_calculations int [pk]
  rpg_system_id int [ref: > rpg_systems.id_rpg_systems]
  name varchar[50]
  description text
  formula text
}

Table system_point_rules {
  id_system_point_rules int [pk]
  rpg_system_id int [ref: > rpg_systems.id_rpg_systems]
  rule_type varchar[50]
  points_available int
  calculation_formula text
}

Table hero_attributes {
  id_hero_attributes int [pk]
  hero_id int [ref: > heroes.id_heroes]
  system_attribute_id int [ref: > system_attributes.id_system_attributes]
  value varchar[100]
}

Table hero_calculations {
  id_hero_calculations int [pk]
  hero_id int [ref: > heroes.id_heroes]
  system_calculation_id int [ref: > system_calculations.id_system_calculations]
  result varchar[100]
}

Table hero_points {
  id_hero_points int [pk]
  hero_id int [ref: > heroes.id_heroes]
  point_rule_id int [ref: > system_point_rules.id_system_point_rules]
  points_spent int
  points_available int
}
```
