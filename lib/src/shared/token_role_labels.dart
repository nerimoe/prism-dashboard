String tokenRoleLabel(String role) => switch (role) {
  'integration' => '机器人/店内入口',
  'machine' => '机器软件接入',
  'player_session' => '玩家登录',
  _ => '外部接入',
};
